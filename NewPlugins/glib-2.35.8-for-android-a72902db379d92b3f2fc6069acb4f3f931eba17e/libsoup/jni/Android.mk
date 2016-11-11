#Android.mk di libsoup
LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := libsoup
LOCAL_C_INCLUDES := $(GLIB_TOP)/../libsoup \
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


LOCAL_CFLAGS := \
	-DHAVE_CONFIG_H \
	-Wall \
	-Wstrict-prototypes \
	-Werror=missing-prototypes \
	-Werror=implicit-function-declaration \
	-Werror=pointer-arith \
	-Werror=init-self \
	-Werror=format=2 \
	-Werror=missing-include-dirs \
	-Werror=aggregate-return \
	-Werror=declaration-after-statement

local_src_files:= \
	soup-address.c			\
	soup-auth.c			\
	soup-auth-basic.c		\
	soup-auth-digest.c		\
	soup-auth-ntlm.c		\
	soup-auth-domain.c		\
	soup-auth-domain-basic.c	\
	soup-auth-domain-digest.c	\
	soup-auth-manager.c		\
	soup-body-input-stream.c	\
	soup-body-output-stream.c	\
	soup-cache.c			\
	soup-cache-input-stream.c	\
	soup-client-input-stream.c	\
	soup-connection.c		\
	soup-connection-auth.c		\
	soup-content-decoder.c		\
	soup-content-processor.c	\
	soup-content-sniffer.c		\
	soup-content-sniffer-stream.c	\
	soup-converter-wrapper.c	\
	soup-cookie.c			\
	soup-cookie-jar.c		\
	soup-cookie-jar-db.c		\
	soup-cookie-jar-text.c		\
	soup-date.c			\
	soup-directory-input-stream.c	\
	soup-enum-types.c		\
	soup-filter-input-stream.c	\
	soup-form.c			\
	soup-headers.c			\
	soup-io-stream.c		\
	soup-logger.c			\
	soup-marshal.c			\
	soup-message.c			\
	soup-message-body.c		\
	soup-message-client-io.c	\
	soup-message-headers.c		\
	soup-message-io.c		\
	soup-message-queue.c		\
	soup-message-server-io.c	\
	soup-method.c     		\
	soup-misc.c     		\
	soup-multipart.c	     	\
	soup-multipart-input-stream.c	\
	soup-password-manager.c		\
	soup-path-map.c     		\
	soup-proxy-resolver.c		\
	soup-proxy-resolver-default.c	\
	soup-proxy-resolver-static.c	\
	soup-proxy-uri-resolver.c	\
	soup-request.c			\
	soup-request-data.c		\
	soup-request-file.c		\
	soup-request-http.c		\
	soup-requester.c		\
	soup-server.c			\
	soup-session.c			\
	soup-session-async.c		\
	soup-session-feature.c		\
	soup-session-sync.c		\
	soup-socket.c			\
	soup-status.c			\
	soup-tld.c			\
	soup-uri.c			\
	soup-value-utils.c		\
	soup-version.c			\
	soup-xmlrpc.c

LOCAL_SRC_FILES := \
	$(addprefix $(LOCAL_PATH)/../libsoup/, $(local_src_files))
	
LOCAL_STATIC_LIBRARIES := libsqlite libxml2  libglib-2.0  libgmodule-2.0 libgthread-2.0 libgobject-2.0 libgio-2.0 libintl
LOCAL_REQUIRED_MODULES := libsqlite libxml2  libglib-2.0  libgmodule-2.0 libgthread-2.0 libgobject-2.0 libgio-2.0 libintl
include $(BUILD_STATIC_LIBRARY)

#
# DUMY
#

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE:= libsoup-shared
LOCAL_WHOLE_STATIC_LIBRARIES := \
     libsoup libglib-2.0 libgthread-2.0
LOCAL_LDLIBS := -lz -ldl -llog
include $(BUILD_SHARED_LIBRARY)
