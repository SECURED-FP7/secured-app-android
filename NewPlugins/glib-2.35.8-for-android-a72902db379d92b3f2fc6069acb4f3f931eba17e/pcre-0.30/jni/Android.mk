# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := libpcre
LOCAL_CFLAGS	:= -I. -DHAVE_CONFIG_H
LOCAL_C_INCLUDES := \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/.. \
	
#aggiungo gli headers di glib perchè ho aggiunto alcuni file .c che stavano solo dentro glib
	LOCAL_C_INCLUDES += 			\
	$(GLIB_TOP)/../glib-2.35.8			\
	$(GLIB_TOP)/../glib-2.35.8/android/		\
	$(GLIB_TOP)/../glib-2.35.8/glib/		\
	$(GLIB_TOP)/../glib-2.35.8/glib/libcharset        \
	$(GLIB_TOP)/../glib-2.35.8/glib/gnulib            \
	$(GLIB_TOP)/../glib-2.35.8/glib/pcre \
	$(GLIB_TOP)/../zlib

LOCAL_SRC_FILES := \
	$(GLIB_TOP)/../glib-2.35.8/glib/pcre/pcre_byte_order.c\
	$(GLIB_TOP)/../glib-2.35.8/glib/pcre/pcre_jit_compile.c\
	$(GLIB_TOP)/../glib-2.35.8/glib/pcre/pcre_string_utils.c\
	$(LOCAL_PATH)/../pcre_compile.c\
	$(LOCAL_PATH)/../pcre_config.c\
	$(LOCAL_PATH)/../pcre_dfa_exec.c\
	$(LOCAL_PATH)/../pcre_exec.c\
	$(LOCAL_PATH)/../pcre_fullinfo.c\
	$(LOCAL_PATH)/../pcre_get.c\
	$(LOCAL_PATH)/../pcre_globals.c\
	$(LOCAL_PATH)/../pcre_maketables.c\
	$(LOCAL_PATH)/../pcre_newline.c\
	$(LOCAL_PATH)/../pcre_ord2utf8.c\
	$(LOCAL_PATH)/../pcre_refcount.c\
	$(LOCAL_PATH)/../pcre_study.c\
	$(LOCAL_PATH)/../pcre_tables.c\
	$(LOCAL_PATH)/../pcre_try_flipped.c\
	$(LOCAL_PATH)/../pcre_ucd.c\
	$(LOCAL_PATH)/../pcre_valid_utf8.c\
	$(LOCAL_PATH)/../pcre_version.c\
	$(LOCAL_PATH)/../pcre_xclass.c\
	$(LOCAL_PATH)/../pcre_chartables.c
##inizialmente era solo pcre_chartables.c, ma io ho messo questa versione crosscompilata che non dà problemi

include $(BUILD_STATIC_LIBRARY)

##

include $(CLEAR_VARS)
LOCAL_MODULE    := libpcreposix
LOCAL_CFLAGS	:= -I. -DHAVE_CONFIG_H
LOCAL_SRC_FILES := $(GLIB_TOP)/../pcre-0.30/pcreposix.c\
	$(GLIB_TOP)/../pcre-0.30/pcre_info.c\
	$(GLIB_TOP)/../pcre-0.30/pcre_try_flipped.c
LOCAL_WHOLE_STATIC_LIBRARIES	:= libpcre
include $(BUILD_STATIC_LIBRARY)

##

# LOCAL_PATH := $(call my-dir)
# include $(CLEAR_VARS)
# LOCAL_MODULE := libpcre-shared
# LOCAL_WHOLE_STATIC_LIBRARIES := libpcre libpcreposix
# 
# include $(BUILD_SHARED_LIBRARY)
