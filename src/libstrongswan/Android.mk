LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# copy-n-paste from Makefile.am
libstrongswan_la_SOURCES = \
library.c \
asn1/asn1.c asn1/asn1_parser.c asn1/oid.c bio/bio_reader.c bio/bio_writer.c \
collections/blocking_queue.c collections/enumerator.c collections/hashtable.c \
collections/array.c \
collections/linked_list.c crypto/crypters/crypter.c crypto/hashers/hasher.c \
crypto/proposal/proposal_keywords.c crypto/proposal/proposal_keywords_static.c \
crypto/prfs/prf.c crypto/prfs/mac_prf.c crypto/pkcs5.c \
crypto/rngs/rng.c crypto/prf_plus.c crypto/signers/signer.c \
crypto/signers/mac_signer.c crypto/crypto_factory.c crypto/crypto_tester.c \
crypto/diffie_hellman.c crypto/aead.c crypto/transform.c \
crypto/iv/iv_gen_rand.c crypto/iv/iv_gen_seq.c \
credentials/credential_factory.c credentials/builder.c \
credentials/cred_encoding.c credentials/keys/private_key.c \
credentials/keys/public_key.c credentials/keys/shared_key.c \
credentials/certificates/certificate.c credentials/certificates/crl.c \
credentials/certificates/ocsp_response.c \
credentials/containers/container.c credentials/containers/pkcs12.c \
credentials/credential_manager.c \
credentials/sets/auth_cfg_wrapper.c credentials/sets/ocsp_response_wrapper.c \
credentials/sets/cert_cache.c credentials/sets/mem_cred.c \
credentials/sets/callback_cred.c credentials/auth_cfg.c database/database.c \
database/database_factory.c fetcher/fetcher.c fetcher/fetcher_manager.c eap/eap.c \
ipsec/ipsec_types.c \
networking/host.c networking/host_resolver.c networking/packet.c \
networking/tun_device.c networking/streams/stream_manager.c \
networking/streams/stream.c networking/streams/stream_service.c \
networking/streams/stream_tcp.c networking/streams/stream_service_tcp.c \
pen/pen.c plugins/plugin_loader.c plugins/plugin_feature.c processing/jobs/job.c \
processing/jobs/callback_job.c processing/processor.c processing/scheduler.c \
processing/watcher.c resolver/resolver_manager.c resolver/rr_set.c \
selectors/traffic_selector.c settings/settings.c settings/settings_types.c \
settings/settings_parser.c settings/settings_lexer.c \
utils/utils.c utils/chunk.c utils/debug.c utils/enum.c utils/identification.c \
utils/lexparser.c utils/optionsfrom.c utils/capabilities.c utils/backtrace.c \
utils/parser_helper.c utils/test.c utils/utils/strerror.c 

libstrongswan_la_SOURCES += \
    threading/thread.c \
    threading/thread_value.c \
    threading/mutex.c \
    threading/rwlock.c \
    threading/spinlock.c \
    threading/semaphore.c \
    networking/streams/stream_unix.c \
    networking/streams/stream_service_unix.c

libstrongswan_la_SOURCES += utils/printf_hook/printf_hook_builtin.c

LOCAL_SRC_FILES := $(libstrongswan_la_SOURCES)

# adding the plugin source files

LOCAL_SRC_FILES += $(call add_plugin, aes)

LOCAL_SRC_FILES += $(call add_plugin, curl)
ifneq ($(call plugin_enabled, curl),)
LOCAL_C_INCLUDES += $(libcurl_PATH)
LOCAL_SHARED_LIBRARIES += libcurl
endif

LOCAL_SRC_FILES += $(call add_plugin, des)

LOCAL_SRC_FILES += $(call add_plugin, fips-prf)

LOCAL_SRC_FILES += $(call add_plugin, gmp)
ifneq ($(call plugin_enabled, gmp),)
LOCAL_C_INCLUDES += $(libgmp_PATH)
LOCAL_SHARED_LIBRARIES += libgmp
endif

LOCAL_SRC_FILES += $(call add_plugin, hmac)

LOCAL_SRC_FILES += $(call add_plugin, md4)

LOCAL_SRC_FILES += $(call add_plugin, md5)

LOCAL_SRC_FILES += $(call add_plugin, nonce)

LOCAL_SRC_FILES += $(call add_plugin, openssl)
ifneq ($(call plugin_enabled, openssl),)
LOCAL_C_INCLUDES += $(openssl_PATH)
LOCAL_STATIC_LIBRARIES += libcrypto_static
endif

LOCAL_SRC_FILES += $(call add_plugin, pem)

LOCAL_SRC_FILES += $(call add_plugin, pkcs1)

LOCAL_SRC_FILES += $(call add_plugin, pkcs7)

LOCAL_SRC_FILES += $(call add_plugin, pkcs8)

LOCAL_SRC_FILES += $(call add_plugin, crypto)

LOCAL_SRC_FILES += $(call add_plugin, pkcs11)

LOCAL_SRC_FILES += $(call add_plugin, pubkey)

LOCAL_SRC_FILES += $(call add_plugin, random)
ifneq ($(call plugin_enabled, random),)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/plugins/random 
endif



LOCAL_SRC_FILES += $(call add_plugin, sha1)

LOCAL_SRC_FILES += $(call add_plugin, sha2)

LOCAL_SRC_FILES += $(call add_plugin, x509)

LOCAL_SRC_FILES += $(call add_plugin, xcbc)

LOCAL_SRC_FILES += $(call add_plugin, rdrand)


#inizio aggiunte mie
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
CROSSCOMPILANDI := $(LOCAL_PATH)/../../NewPlugins/CrossCompilandiv7
endif

ifeq ($(TARGET_ARCH_ABI),armeabi)
CROSSCOMPILANDI := $(LOCAL_PATH)/../../NewPlugins/CrossCompilandi
endif

GLIB_TOP := $(CROSSCOMPILANDI)/../glib-2.35.8-for-android-a72902db379d92b3f2fc6069acb4f3f931eba17e/glib-2.35.8

LOCAL_SRC_FILES += $(call add_plugin, soup)
ifneq ($(call plugin_enabled, soup),)
LOCAL_C_INCLUDES += $(GLIB_TOP)/../libsoup \
	$(GLIB_TOP)/../libsoup/libsoup \
	$(GLIB_TOP)/../icu4c/common \
	$(GLIB_TOP)/../glib-2.35.8 \
	$(GLIB_TOP)/../glib-2.35.8/android \
	$(GLIB_TOP)/../glib-2.35.8/glib \
	$(GLIB_TOP)/../glib-2.35.8/gmodule \
	$(GLIB_TOP)/../glib-2.35.8/gobject \
	$(GLIB_TOP)/../glib-2.35.8/gio \
	$(GLIB_TOP)/../libxml2/include \
	$(GLIB_TOP)/../libxml2/include/libxml \
	$(GLIB_TOP)/../sqlite3
	
LOCAL_SHARED_LIBRARIES += libsoup-shared
endif
#fine aggiunte mie

# build libstrongswan ----------------------------------------------------------

LOCAL_CFLAGS := $(strongswan_CFLAGS) \
	-include $(LOCAL_PATH)/AndroidConfigLocal.h 

LOCAL_MODULE := libstrongswan

LOCAL_MODULE_TAGS := optional

LOCAL_ARM_MODE := arm

LOCAL_PRELINK_MODULE := false

LOCAL_SHARED_LIBRARIES += libdl

include $(BUILD_SHARED_LIBRARY)




#inizio aggiunte mie



#includo anche sqlite
include $(GLIB_TOP)/../sqlite3/jni/Android.mk



#includo anche libxml
include $(GLIB_TOP)/../libxml2/jni/Android.mk

#includo anche pcre (necessario a glib)
include $(GLIB_TOP)/../pcre-0.30/jni/Android.mk

#includo anche ffi, necessario per gobject
include $(GLIB_TOP)/../libffi-3.0.12/jni/Android.mk

#includo anche i moduli di glib




include $(GLIB_TOP)/glib/Android.mk
include $(GLIB_TOP)/gmodule/Android.mk
include $(GLIB_TOP)/gthread/Android.mk
include $(GLIB_TOP)/gobject/Android.mk
include $(GLIB_TOP)/gio/Android.mk
#include $(GLIB_TOP)/tests/Android.mk

#includo anche libsoup
include $(GLIB_TOP)/../libsoup/jni/Android.mk


#iniziano le inclusioni per gnutls e giognutls
include $(CLEAR_VARS)
LOCAL_MODULE := libgmp
LOCAL_SRC_FILES := $(CROSSCOMPILANDI)/GeneratiDaGmp-5.0.5/Eprefix/lib/libgmp.so
LOCAL_EXPORT_C_INCLUDES := $(CROSSCOMPILANDI)/GeneratiDaGmp-5.0.5/Eprefix/include
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libnettle
LOCAL_SRC_FILES := $(CROSSCOMPILANDI)/GeneratiDaNettle-2.7.1/Eprefix/lib/libnettle.so
LOCAL_EXPORT_C_INCLUDES := $(CROSSCOMPILANDI)/GeneratiDaNettle-2.7.1/Prefix/include
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libhogweed
LOCAL_SRC_FILES := $(CROSSCOMPILANDI)/GeneratiDaNettle-2.7.1/Eprefix/lib/libhogweed.so
LOCAL_EXPORT_C_INCLUDES := $(CROSSCOMPILANDI)/GeneratiDaNettle-2.7.1/Prefix/include
LOCAL_SHARED_LIBRARIES := libgmp libnettle
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libgnutls
LOCAL_SRC_FILES := $(CROSSCOMPILANDI)/GeneratiDaGnutls-3.3.9/Eprefix/lib/libgnutls.so
LOCAL_EXPORT_C_INCLUDES := $(CROSSCOMPILANDI)/GeneratiDaGnutls-3.3.9/Prefix/include
LOCAL_SHARED_LIBRARIES := libhogweed
include $(PREBUILT_SHARED_LIBRARY)




include $(CLEAR_VARS)
LOCAL_MODULE := libgiognutls
SRC_FOLDER := $(GLIB_TOP)/../glib-networking-2.37.2/tls/gnutls
LOCAL_C_INCLUDES := $(SRC_FOLDER)	\
		    $(SRC_FOLDER)/../..	\
	$(GLIB_TOP)/../libsoup \
	$(GLIB_TOP)/../libsoup/libsoup \
	$(GLIB_TOP)/../icu4c/common \
	$(GLIB_TOP)/../glib-2.35.8 \
	$(GLIB_TOP)/../glib-2.35.8/android \
	$(GLIB_TOP)/../glib-2.35.8/glib \
	$(GLIB_TOP)/../glib-2.35.8/gmodule \
	$(GLIB_TOP)/../glib-2.35.8/gobject \
	$(GLIB_TOP)/../glib-2.35.8/gio \
	$(GLIB_TOP)/../libxml2/include \
	$(GLIB_TOP)/../libxml2/include/libxml \
	$(GLIB_TOP)/../sqlite3
LOCAL_SRC_FILES := \
	$(SRC_FOLDER)/gnutls-module.c			\
	$(SRC_FOLDER)/gtlsbackend-gnutls.c		\
	$(SRC_FOLDER)/gtlsbackend-gnutls.h		\
	$(SRC_FOLDER)/gtlscertificate-gnutls.c	\
	$(SRC_FOLDER)/gtlscertificate-gnutls.h	\
	$(SRC_FOLDER)/gtlsclientconnection-gnutls.c	\
	$(SRC_FOLDER)/gtlsclientconnection-gnutls.h	\
	$(SRC_FOLDER)/gtlsconnection-gnutls.c		\
	$(SRC_FOLDER)/gtlsconnection-gnutls.h		\
	$(SRC_FOLDER)/gtlsdatabase-gnutls.c		\
	$(SRC_FOLDER)/gtlsdatabase-gnutls.h		\
	$(SRC_FOLDER)/gtlsfiledatabase-gnutls.c	\
	$(SRC_FOLDER)/gtlsfiledatabase-gnutls.h	\
	$(SRC_FOLDER)/gtlsinputstream-gnutls.c	\
	$(SRC_FOLDER)/gtlsinputstream-gnutls.h	\
	$(SRC_FOLDER)/gtlsoutputstream-gnutls.c	\
	$(SRC_FOLDER)/gtlsoutputstream-gnutls.h	\
	$(SRC_FOLDER)/gtlsserverconnection-gnutls.c	\
	$(SRC_FOLDER)/gtlsserverconnection-gnutls.h
	#gtlsbackend-gnutls-pkcs11.c gtlsbackend-gnutls-pkcs11.h gtlscertificate-gnutls-pkcs11.c gtlscertificate-gnutls-pkcs11.h gtlsdatabase-gnutls-pkcs11.c gtlsdatabase-gnutls-pkcs11.h

#LOCAL_CFLAGS := \
	#-I$(SRC_FOLDER)/../
	#-I/usr/include/p11-kit-1


#LOCAL_LDLIBS := -export_dynamic -avoid-version -module -no-undefined -export-symbols-regex '^g_io_module_(load|unload|query)'

#libgiognutls_la_LIBADD =		\
#	../../tls/pkcs11/libgiopkcs11.la -lp11-kit 			\
#	-L/usr/local/lib -lgio-2.0 -lgobject-2.0 -lglib-2.0
#	-L$(CROSSCOMPILANDI)/GeneratiDaGnutls-3.3.9/Eprefix/lib
LOCAL_SHARED_LIBRARIES := libgnutls libsoup-shared
LOCAL_LDLIBS    := -lz -llog
LOCAL_LDFLAGS := -export-dynamic -export_dynamic
include $(BUILD_SHARED_LIBRARY)
#fine aggiunte mie
