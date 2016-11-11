# Android.mk di libxml2
#

LOCAL_PATH:= $(call my-dir)

#includo anche iq4c per supportare unicode, necessario per libxml
include $(GLIB_TOP)/../icu4c/Android.mk


# We need to build this for both the device (as a shared library)
# and the host (as a static library for tools to use).

common_SRC_FILES := \
	SAX.c \
	entities.c \
	encoding.c \
	error.c \
	parserInternals.c \
	parser.c \
	tree.c \
	hash.c \
	list.c \
	xmlIO.c \
	xmlmemory.c \
	uri.c \
	valid.c \
	xlink.c \
	HTMLparser.c \
	HTMLtree.c \
	debugXML.c \
	xpath.c \
	xpointer.c \
	xinclude.c \
	nanohttp.c \
	nanoftp.c \
	DOCBparser.c \
	catalog.c \
	globals.c \
	threads.c \
	c14n.c \
	xmlstring.c \
	xmlregexp.c \
	xmlschemas.c \
	xmlschemastypes.c \
	xmlunicode.c \
	xmlreader.c \
	relaxng.c \
	dict.c \
	SAX2.c \
	legacy.c \
	chvalid.c \
	pattern.c \
	xmlsave.c \
	xmlmodule.c \
	xmlwriter.c \
	schematron.c

include $(CLEAR_VARS)

LOCAL_MODULE:= libxml2

LOCAL_SRC_FILES := \
	$(addprefix $(GLIB_TOP)/../libxml2/, $(common_SRC_FILES))

LOCAL_C_INCLUDES := \
	$(GLIB_TOP)/../libxml2/include \
	$(GLIB_TOP)/../icu4c/common
	
LOCAL_SHARED_LIBRARIES := libicuuc
LOCAL_STATIC_LIBRARIES := libicuuc_static

LOCAL_CFLAGS := -fvisibility=hidden

include $(BUILD_STATIC_LIBRARY)

#
# DUMY
#

# include $(CLEAR_VARS)
# LOCAL_MODULE:= libxml2-shared
# LOCAL_WHOLE_STATIC_LIBRARIES := libxml2
# include $(BUILD_SHARED_LIBRARY)

