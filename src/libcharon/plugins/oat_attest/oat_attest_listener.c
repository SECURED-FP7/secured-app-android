/*
 * Copyright (C) 2011 Martin Willi
 * Copyright (C) 2011 revosec AG
 * Copyright (C) 2014 Politecnico di Torino, Italy
 *                    TORSEC group -- http://security.polito.it
 *
 * Author: Roberto Sassu <roberto.sassu@polito.it>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * for more details.
 */

#include "oat_attest_listener.h"

#include <daemon.h>
#include <json.h>
#include <processing/jobs/callback_job.h>

#include <unistd.h>
#include <utils/chunk.h>
#include <stdio.h>

#define MAX_BUF_LEN 256
#define COLOR_NORMAL  "\x1B[0m"
#define COLOR_RED  "\x1B[31m"
#define COLOR_GREEN  "\x1B[32m"
//#define POLLHOST_URL "https://%s:8899/mach/status"
#define POLLHOST_URL "https://%s/OAT/attest.php"
#define QVERIFIER_URL "https://%s:8899/verifiers"
#define POSTHOST_URL "https://%s:8443/AttestationService/resources/PostHosts?requestId=%s"

typedef struct private_oat_attest_listener_t private_oat_attest_listener_t;

/**
 * Private data of an oat_attest_listener_t object.
 */
struct private_oat_attest_listener_t {

	/**
	 * Public oat_attest_listener_t interface.
	 */
	oat_attest_listener_t public;

};

typedef struct attest_data {
// 	certificate_t *cert;

	char *host_name;
	char *cert_digest;

	u_int32_t attest_interval;
	u_int32_t *ike_sa_id;
} attest_data_t;

void update_cert_info(char *common_name, char cert_digest[41])
{
	FILE *fp;
	char *ima_level;



	fp=fopen("/data/data/org.strongswan.android/cache/oat-attest.data", "w");
	if (fp == NULL)
	      exit(1);

	ima_level = lib->settings->get_str(lib->settings,
						   "%s.plugins.oat-attest.ima_level",
						   NULL, lib->ns);

	fprintf(fp, "%s = %s \n","CN", common_name);
	fprintf(fp, "%s = %s \n","DGST", cert_digest);
	fprintf(fp, "%s = %s \n","LEVEL", ima_level);

	fclose(fp);
}

char* getVerfier(char* nedip)
{
	chunk_t data, response = chunk_empty;
	char uri[MAX_BUF_LEN] = { 0 };
	status_t status;
	char *msg;
	json_object *jrequest = json_object_new_object();
	json_object *jstring_reqs;

	struct json_tokener *tokener;
	json_object *jresponse, *response_array;
	char *ip_addr = NULL;


	/* build question request to the ned, asking the verifier list it has */
	jstring_reqs = json_object_new_string("verifiers");
	json_object_object_add(jrequest, "question", jstring_reqs);
	data = chunk_from_str((char*)json_object_to_json_string(jrequest));

	snprintf(uri, MAX_BUF_LEN, QVERIFIER_URL, nedip);
	status = lib->fetcher->fetch(lib->fetcher, uri, &response,
				FETCH_TIMEOUT, 120,
				FETCH_REQUEST_TYPE, "application/json",
				FETCH_REQUEST_DATA, data,
				FETCH_END);

	msg = strndup(response.ptr, response.len);
	DBG0(DBG_LIB, "\nVerifier list:\n%s\n", msg);
	free(msg);

	/* parse the NED's response of all verifiers */
	tokener = json_tokener_new();
	jresponse = json_tokener_parse_ex(tokener, response.ptr, response.len);
	json_object_object_get_ex(jresponse, "verifiers", &response_array);
	int i, count = json_object_array_length(response_array);

	for (i = 0; i < count; i++) {
		json_object *jvalue = json_object_array_get_idx(response_array, i);
		json_object *ip;
		json_object *name;

		json_object_object_get_ex(jvalue, "name", &name);
		json_object_object_get_ex(jvalue, "ip", &ip);
		ip_addr = strdup(json_object_get_string(ip));
	}

	json_tokener_free(tokener);
	free(response.ptr);
	json_object_put(jresponse);
	json_object_put(response_array);

	json_object_put(jstring_reqs);
	json_object_put(jrequest);

	return ip_addr;
}


int oat_attest_request(char *peer_hostname, char *peer_cert_digest)
{
	struct json_tokener *tokener;
	chunk_t data, response = chunk_empty;
	json_object *jresponse, *response_array;
	status_t status;
	char uri[MAX_BUF_LEN] = { 0 };
	char user_reqs[MAX_BUF_LEN] = { 0 };
	char *oat_server, *request_id, *ima_level, *msg;
	char *peer_trust_level = NULL;
	int attest_result = 0;
	bool use_local_verifier;
	char* nedip;

	/* build the OAT request */
	json_object *jrequest = json_object_new_object();
	json_object *jarray = json_object_new_array();
	json_object *jstring_host = json_object_new_string(peer_hostname);
	json_object *jstring_reqs;

	ima_level = lib->settings->get_str(lib->settings,
					   "%s.plugins.oat-attest.ima_level",
					   NULL, lib->ns);
	if (!ima_level)
		ima_level = "l4_ima_all_ok";

	snprintf(user_reqs, MAX_BUF_LEN,
		 "load-time+check-cert,l_req=%s|>=,cert_digest=%s", ima_level,
		 peer_cert_digest);

	jstring_reqs = json_object_new_string(user_reqs);
	json_object_array_add(jarray, jstring_host);
	json_object_object_add(jrequest, "hosts", jarray);
	json_object_object_add(jrequest, "analysisType", jstring_reqs);
	data = chunk_from_str((char*)json_object_to_json_string(jrequest));

	/* get the oat server from REST API from the ned or from local config file*/
	use_local_verifier = lib->settings->get_bool(lib->settings,
							"%s.plugins.oat-attest.use_local_verifier",
							TRUE, lib->ns);

	nedip = lib->settings->get_str(lib->settings,"%s.plugins.oat-attest.NEDIP","130.192.1.1", lib->ns);

	/* if use ned's verifier: */
	if (use_local_verifier) {
		oat_server = lib->settings->get_str(lib->settings,
						    "%s.plugins.oat-attest.oat_server",
						    NULL, lib->ns);
		if (!oat_server) {
			DBG0(DBG_LIB, "Error: the oat_server parameter must be set");
			goto out;
		}
	} else {
		oat_server = getVerfier(nedip);
	}


	/* send the request to OAT */
	request_id = lib->settings->get_str(lib->settings,
					    "%s.plugins.oat-attest.request_id",
					    NULL, lib->ns);

	DBG0(DBG_LIB, "\n\n---------- Remote Attestation begins ----------\n");

	DBG0(DBG_LIB, "\nUser terminal -> verifier:\nrequest: %s", data.ptr, data.len);

	if (request_id) {
		snprintf(uri, MAX_BUF_LEN, POSTHOST_URL, oat_server, request_id);
		status = lib->fetcher->fetch(lib->fetcher, uri, &response,
					FETCH_TIMEOUT, 120,
					FETCH_REQUEST_TYPE, "application/json",
					FETCH_END);
	} else {
		snprintf(uri, MAX_BUF_LEN, POLLHOST_URL, oat_server);
		status = lib->fetcher->fetch(lib->fetcher, uri, &response,
					FETCH_TIMEOUT, 120,
					FETCH_REQUEST_TYPE, "application/json",
					FETCH_REQUEST_DATA, data,
					FETCH_END);
	}

	msg = strndup(response.ptr, response.len);
	DBG0(DBG_LIB, "\nVerifier -> user terminal:\nresponse: %s\n", msg);
	free(msg);

	if (status != SUCCESS)
		goto out;

	/* parse the OAT response */
	tokener = json_tokener_new();
	jresponse = json_tokener_parse_ex(tokener, response.ptr, response.len);
	json_object_object_get_ex(jresponse, "results", &response_array);
	int i, count = json_object_array_length(response_array);
	for (i = 0; i < count; i++) {
		json_object *jvalue = json_object_array_get_idx(response_array, i);
		json_object *host_name;
		json_object *trust_lvl;

		json_object_object_get_ex(jvalue, "host_name", &host_name);
		if (strcmp(json_object_get_string(host_name), peer_hostname) == 0) {
			json_object_object_get_ex(jvalue, "trust_lvl", &trust_lvl);
			peer_trust_level = strdup(json_object_get_string(trust_lvl));
			if (strcmp(peer_trust_level,"trusted") == 0){
				attest_result = 1;
				break;
			} else if (strcmp(peer_trust_level, "untrusted") == 0){
				attest_result = -1;
				break;
			} else {
				attest_result = 0;
				break;
			}

			//attest_result = strcmp(peer_trust_level, "trusted") == 0;


		}
	}

	json_tokener_free(tokener);
	free(response.ptr);
	json_object_put(jresponse);
	json_object_put(response_array);

out:
	json_object_put(jstring_host);
	json_object_put(jstring_reqs);
	json_object_put(jarray);
	json_object_put(jrequest);

	if (attest_result == 1) {
		DBG0(DBG_LIB, "%sHost: %s, status: %s%s", COLOR_GREEN,
		     peer_hostname, peer_trust_level, COLOR_NORMAL);

		lib->settings->set_str(lib->settings,
					   "%s.plugins.oat-attest.known_cert_digest",
					   peer_cert_digest, lib->ns);

	} else {
		char *trust_level = peer_trust_level ? peer_trust_level : "unknown";
		DBG0(DBG_LIB, "%sWARNING! WARNING! WARNING! Host: %s, status: %s%s",
		     COLOR_RED, peer_hostname, trust_level, COLOR_NORMAL);
	}

	free(peer_trust_level);
	DBG0(DBG_LIB, "\n---------- Remote Attestation ends ----------\n\n");
	return attest_result;
}

static void destroy_hostdata(attest_data_t *this)
{
	free(this->host_name);
	free(this->cert_digest);
	free(this->ike_sa_id);
	free(this);
}

static job_requeue_t attest_request(attest_data_t *this)
{

	int attest_result = 0;
	int count = 0;
	char ans[MAX_BUF_LEN +1]={0};

	while((attest_result !=-1) && (count<3) ){
		sleep(this->attest_interval);
		DBG0(DBG_LIB, "Running IKE_SA unique ID is %d", *(this->ike_sa_id));
 		attest_result = oat_attest_request(this->host_name, this->cert_digest);
		if (attest_result == 0) {
			count++;
		} else{
			count = 0;
		}
	}


	DBG0(DBG_LIB, "NED is compromised, close the connection???\nYes or No\n");
	fgets(ans, MAX_BUF_LEN, stdin);

	if (strstr(ans,"y") !=NULL || strstr(ans,"Y") !=NULL ){
		charon->controller->terminate_ike(charon->controller, *(this->ike_sa_id),
					NULL, NULL, 0);
	}

	return JOB_REQUEUE_NONE;
}

METHOD(listener_t, authorize, bool,
	private_oat_attest_listener_t *this, ike_sa_t *ike_sa,
	bool final, bool *success)
{
	enumerator_t *rounds;
	certificate_t *cert;
	auth_cfg_t *auth;
	bool attest_peer;
	u_int32_t attest_interval;
	char* known_cert_digest;
	attest_data_t *hostdata;

	/* Check all rounds in final hook, as local authentication data are
	 * not completely available after round-invocation. */
	if (!final)
	{
		return TRUE;
	}

	attest_peer = lib->settings->get_bool(lib->settings, "%s.plugins.oat-attest.attest_peer", FALSE, lib->ns);
	known_cert_digest = lib->settings->get_str(lib->settings, "%s.plugins.oat-attest.known_cert_digest", "0000000", lib->ns);
	attest_interval = lib->settings->get_int(lib->settings, "%s.plugins.oat-attest.attest_interval", 30, lib->ns);

	if (!attest_peer){
		return TRUE;
	}

	/* collect remote certificates */
	rounds = ike_sa->create_auth_cfg_enumerator(ike_sa, FALSE);
	while (rounds->enumerate(rounds, &auth))
	{
		cert = auth->get(auth, AUTH_RULE_SUBJECT_CERT);

		if (cert)
		{
			enumerator_t *parts;
			id_part_t part;
			chunk_t data;
			identification_t *id;
			hasher_t *hasher;
			chunk_t encoded;
			chunk_t cert_digest;
			static u_int32_t current_id;

			/* extract common name for OAT query */
			id = cert->get_subject(cert);
			parts = id->create_part_enumerator(id);
			while (parts->enumerate(parts, &part, &data))
			{
				if (part == ID_PART_RDN_CN) {
					DBG0(DBG_LIB, "Extracted Common Name from peer certificate: %s", data.ptr);
					break;
				}
			}
			parts->destroy(parts);

			/* calculate and display the digest of the peer cert */
			if (cert->get_encoding(cert, CERT_ASN1_DER, &encoded)) {
				char digest_str[41];
				char *hostname;
				int rc;

				hasher = lib->crypto->create_hasher(lib->crypto, HASH_SHA1);
				rc = hasher->allocate_hash(hasher, encoded, &cert_digest);

				chunk_to_hex(cert_digest, digest_str, false);
				DBG0(DBG_LIB, "SHA1 of the peer certificate: %s", digest_str);
				hostname = strndup(data.ptr, data.len);

				current_id = ike_sa->get_unique_id(ike_sa);


				if (strcmp(digest_str, known_cert_digest) == 0) {
					DBG0(DBG_LIB, "Cerficate is known, issue attestation request of %s", hostname);
				} else {
					INIT(hostdata,
					     .host_name = strdup(hostname),
					     .cert_digest = strndup(digest_str, 41),
					     .attest_interval = attest_interval,
					     .ike_sa_id = &current_id,
					);

					update_cert_info(hostname, digest_str);
					if (oat_attest_request(hostname, digest_str) == 1){
						*success = true;
						lib->processor->queue_job(lib->processor, (job_t*)callback_job_create((callback_job_cb_t)attest_request, hostdata, (void*)destroy_hostdata, NULL));

						FILE* file = fopen("/data/data/org.strongswan.android/cache/resultOAT.txt","w");

 						if (file != NULL) {
 						fputs("s", file);
 						fflush(file);
 						fclose(file);
 						}

					} else {
						*success = false;

						FILE* file = fopen("/data/data/org.strongswan.android/cache/resultOAT.txt", "w");

 						if (file != NULL) {
 						fputs("f", file);
 						fflush(file);
 						fclose(file);
 						}

					}
					/*
					*success = oat_attest_request(hostname, digest_str);
					if (*success) {
						lib->processor->queue_job(lib->processor, (job_t*)callback_job_create((callback_job_cb_t)attest_request, hostdata, (void*)destroy_hostdata, NULL));
					}
					*/
				}

 				free(hostname);
 				chunk_clear(&cert_digest);
				chunk_clear(&encoded);
				DESTROY_IF(hasher);
			}
			chunk_clear(&data);
		}
	}
	rounds->destroy(rounds);

	return TRUE;
}



METHOD(oat_attest_listener_t, destroy, void,
	private_oat_attest_listener_t *this)
{
	free(this);
}

/**
 * See header
 */
oat_attest_listener_t *oat_attest_listener_create()
{
	private_oat_attest_listener_t *this;

	INIT(this,
		.public = {
			.listener = {
			  .authorize = _authorize,
			},
			.destroy = _destroy,
		},
	);

	return &this->public;
}
