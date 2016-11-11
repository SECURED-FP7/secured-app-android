# Copyright (C) 2008 The Android Open Source Project
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


LOCAL_PATH:= $(call my-dir)

#
# Common definitions.
#

src_files := \
	$(LOCAL_PATH)/cmemory.c          $(LOCAL_PATH)/cstring.c          \
	$(LOCAL_PATH)/cwchar.c           $(LOCAL_PATH)/locmap.c           \
	$(LOCAL_PATH)/lrucache.cpp \
	$(LOCAL_PATH)/punycode.cpp       $(LOCAL_PATH)/putil.cpp          \
	$(LOCAL_PATH)/sharedobject.cpp \
	$(LOCAL_PATH)/simplepatternformatter.cpp \
	$(LOCAL_PATH)/uarrsort.c         $(LOCAL_PATH)/ubidi.c            \
	$(LOCAL_PATH)/ubidiln.c          $(LOCAL_PATH)/ubidi_props.c      \
	$(LOCAL_PATH)/ubidiwrt.c         $(LOCAL_PATH)/ucase.cpp          \
	$(LOCAL_PATH)/ucasemap.cpp       $(LOCAL_PATH)/ucat.c             \
	$(LOCAL_PATH)/uchar.c            $(LOCAL_PATH)/ucln_cmn.c         \
	$(LOCAL_PATH)/ucmndata.c                            \
	$(LOCAL_PATH)/ucnv2022.cpp       $(LOCAL_PATH)/ucnv_bld.cpp       \
	$(LOCAL_PATH)/ucnvbocu.cpp       $(LOCAL_PATH)/ucnv.c             \
	$(LOCAL_PATH)/ucnv_cb.c          $(LOCAL_PATH)/ucnv_cnv.c         \
	$(LOCAL_PATH)/ucnvdisp.c         $(LOCAL_PATH)/ucnv_err.c         \
	$(LOCAL_PATH)/ucnv_ext.cpp       $(LOCAL_PATH)/ucnvhz.c           \
	$(LOCAL_PATH)/ucnv_io.cpp        $(LOCAL_PATH)/ucnvisci.c         \
	$(LOCAL_PATH)/ucnvlat1.c         $(LOCAL_PATH)/ucnv_lmb.c         \
	$(LOCAL_PATH)/ucnvmbcs.c         $(LOCAL_PATH)/ucnvscsu.c         \
	$(LOCAL_PATH)/ucnv_set.c         $(LOCAL_PATH)/ucnv_u16.c         \
	$(LOCAL_PATH)/ucnv_u32.c         $(LOCAL_PATH)/ucnv_u7.c          \
	$(LOCAL_PATH)/ucnv_u8.c                             \
	$(LOCAL_PATH)/udatamem.c         \
	$(LOCAL_PATH)/udataswp.c         $(LOCAL_PATH)/uenum.c            \
	$(LOCAL_PATH)/uhash.c            $(LOCAL_PATH)/uinit.cpp          \
	$(LOCAL_PATH)/uinvchar.c         $(LOCAL_PATH)/uloc.cpp           \
	$(LOCAL_PATH)/umapfile.c         $(LOCAL_PATH)/umath.c            \
	$(LOCAL_PATH)/umutex.cpp         $(LOCAL_PATH)/unames.cpp         \
	$(LOCAL_PATH)/uresbund.cpp       \
	$(LOCAL_PATH)/ures_cnv.c         $(LOCAL_PATH)/uresdata.c         \
	$(LOCAL_PATH)/usc_impl.c         $(LOCAL_PATH)/uscript.c          \
	$(LOCAL_PATH)/uscript_props.cpp  \
	$(LOCAL_PATH)/ushape.cpp         $(LOCAL_PATH)/ustrcase.cpp       \
	$(LOCAL_PATH)/ustr_cnv.c         $(LOCAL_PATH)/ustrfmt.c          \
	$(LOCAL_PATH)/ustring.cpp        $(LOCAL_PATH)/ustrtrns.cpp       \
	$(LOCAL_PATH)/ustr_wcs.cpp       $(LOCAL_PATH)/utf_impl.c         \
	$(LOCAL_PATH)/utrace.c           $(LOCAL_PATH)/utrie.cpp          \
	$(LOCAL_PATH)/utypes.c           $(LOCAL_PATH)/wintz.c            \
	$(LOCAL_PATH)/utrie2_builder.cpp $(LOCAL_PATH)/icuplug.c          \
	$(LOCAL_PATH)/propsvec.c         $(LOCAL_PATH)/ulist.c            \
	$(LOCAL_PATH)/uloc_tag.c         $(LOCAL_PATH)/ucnv_ct.c

src_files += \
        $(LOCAL_PATH)/bmpset.cpp      $(LOCAL_PATH)/unisetspan.cpp   \
	$(LOCAL_PATH)/brkeng.cpp      $(LOCAL_PATH)/brkiter.cpp      \
	$(LOCAL_PATH)/caniter.cpp     $(LOCAL_PATH)/chariter.cpp     \
	$(LOCAL_PATH)/dictbe.cpp	$(LOCAL_PATH)/locbased.cpp     \
	$(LOCAL_PATH)/locid.cpp       $(LOCAL_PATH)/locutil.cpp      \
	$(LOCAL_PATH)/normlzr.cpp     $(LOCAL_PATH)/parsepos.cpp     \
	$(LOCAL_PATH)/propname.cpp    $(LOCAL_PATH)/rbbi.cpp         \
	$(LOCAL_PATH)/rbbidata.cpp    $(LOCAL_PATH)/rbbinode.cpp     \
	$(LOCAL_PATH)/rbbirb.cpp      $(LOCAL_PATH)/rbbiscan.cpp     \
	$(LOCAL_PATH)/rbbisetb.cpp    $(LOCAL_PATH)/rbbistbl.cpp     \
	$(LOCAL_PATH)/rbbitblb.cpp    $(LOCAL_PATH)/resbund_cnv.cpp  \
	$(LOCAL_PATH)/resbund.cpp     $(LOCAL_PATH)/ruleiter.cpp     \
	$(LOCAL_PATH)/schriter.cpp    $(LOCAL_PATH)/serv.cpp         \
	$(LOCAL_PATH)/servlk.cpp      $(LOCAL_PATH)/servlkf.cpp      \
	$(LOCAL_PATH)/servls.cpp      $(LOCAL_PATH)/servnotf.cpp     \
	$(LOCAL_PATH)/servrbf.cpp     $(LOCAL_PATH)/servslkf.cpp     \
	$(LOCAL_PATH)/ubrk.cpp         \
	$(LOCAL_PATH)/uchriter.cpp    $(LOCAL_PATH)/uhash_us.cpp     \
	$(LOCAL_PATH)/uidna.cpp       $(LOCAL_PATH)/uiter.cpp        \
	$(LOCAL_PATH)/unifilt.cpp     $(LOCAL_PATH)/unifunct.cpp     \
	$(LOCAL_PATH)/uniset.cpp      $(LOCAL_PATH)/uniset_props.cpp \
	$(LOCAL_PATH)/unistr_case.cpp $(LOCAL_PATH)/unistr_cnv.cpp   \
	$(LOCAL_PATH)/unistr.cpp      $(LOCAL_PATH)/unistr_props.cpp \
	$(LOCAL_PATH)/unormcmp.cpp    $(LOCAL_PATH)/unorm.cpp        \
	$(LOCAL_PATH)/uobject.cpp     $(LOCAL_PATH)/uset.cpp         \
	$(LOCAL_PATH)/usetiter.cpp    $(LOCAL_PATH)/uset_props.cpp   \
	$(LOCAL_PATH)/usprep.cpp      $(LOCAL_PATH)/ustack.cpp       \
	$(LOCAL_PATH)/ustrenum.cpp    $(LOCAL_PATH)/utext.cpp        \
	$(LOCAL_PATH)/util.cpp        $(LOCAL_PATH)/util_props.cpp   \
	$(LOCAL_PATH)/uvector.cpp     $(LOCAL_PATH)/uvectr32.cpp     \
	$(LOCAL_PATH)/errorcode.cpp                    \
	$(LOCAL_PATH)/bytestream.cpp  $(LOCAL_PATH)/stringpiece.cpp  \
	$(LOCAL_PATH)/dtintrv.cpp      \
	$(LOCAL_PATH)/ucnvsel.cpp     $(LOCAL_PATH)/uvectr64.cpp     \
	$(LOCAL_PATH)/locavailable.cpp         $(LOCAL_PATH)/locdispnames.cpp   \
	$(LOCAL_PATH)/loclikely.cpp            $(LOCAL_PATH)/locresdata.cpp     \
	$(LOCAL_PATH)/normalizer2impl.cpp      $(LOCAL_PATH)/normalizer2.cpp    \
	$(LOCAL_PATH)/filterednormalizer2.cpp  $(LOCAL_PATH)/ucol_swp.cpp       \
	$(LOCAL_PATH)/uprops.cpp      $(LOCAL_PATH)/utrie2.cpp \
        $(LOCAL_PATH)/charstr.cpp     $(LOCAL_PATH)/uts46.cpp \
        $(LOCAL_PATH)/udata.cpp   $(LOCAL_PATH)/appendable.cpp  $(LOCAL_PATH)/bytestrie.cpp \
        $(LOCAL_PATH)/bytestriebuilder.cpp  $(LOCAL_PATH)/bytestrieiterator.cpp \
        $(LOCAL_PATH)/messagepattern.cpp $(LOCAL_PATH)/patternprops.cpp $(LOCAL_PATH)/stringtriebuilder.cpp \
        $(LOCAL_PATH)/ucharstrie.cpp $(LOCAL_PATH)/ucharstriebuilder.cpp $(LOCAL_PATH)/ucharstrieiterator.cpp \
	$(LOCAL_PATH)/dictionarydata.cpp \
	$(LOCAL_PATH)/ustrcase_locale.cpp $(LOCAL_PATH)/unistr_titlecase_brkiter.cpp \
	$(LOCAL_PATH)/uniset_closure.cpp $(LOCAL_PATH)/ucasemap_titlecase_brkiter.cpp \
	$(LOCAL_PATH)/ustr_titlecase_brkiter.cpp $(LOCAL_PATH)/unistr_case_locale.cpp \
	$(LOCAL_PATH)/listformatter.cpp


# This is the empty compiled-in icu data structure
# that we need to satisfy the linker.
src_files += $(LOCAL_PATH)/../stubdata/stubdata.c

c_includes := \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/../i18n

# We make the ICU data directory relative to $ANDROID_ROOT on Android, so both
# device and sim builds can use the same codepath, and it's hard to break one
# without noticing because the other still works.
local_cflags := '-DICU_DATA_DIR_PREFIX_ENV_VAR="ANDROID_ROOT"'
local_cflags += '-DICU_DATA_DIR="/usr/icu"'

# bionic doesn't have <langinfo.h>.
local_cflags += -DU_HAVE_NL_LANGINFO_CODESET=0

local_cflags += -D_REENTRANT
local_cflags += -DU_COMMON_IMPLEMENTATION

local_cflags += -O3 -fvisibility=hidden

#
# Build for the target (device).
#

include $(CLEAR_VARS)
LOCAL_SRC_FILES += $(src_files)
LOCAL_C_INCLUDES += $(c_includes) $(optional_android_logging_includes)
LOCAL_CFLAGS += $(local_cflags) -DPIC -fPIC
LOCAL_SHARED_LIBRARIES += libdl $(optional_android_logging_libraries)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libicuuc
LOCAL_ADDITIONAL_DEPENDENCIES += $(LOCAL_PATH)/Android.mk
LOCAL_REQUIRED_MODULES += icu-data
# Use "-include" to not fail apps_only build.
-include abi/cpp/use_rtti.mk
-include external/stlport/libstlport.mk
include $(BUILD_SHARED_LIBRARY)

#
# Build for the host.
#

include $(CLEAR_VARS)
LOCAL_SRC_FILES += $(src_files)
LOCAL_C_INCLUDES += $(c_includes) $(optional_android_logging_includes)
LOCAL_CFLAGS += $(local_cflags)
LOCAL_SHARED_LIBRARIES += $(optional_android_logging_libraries)
LOCAL_LDLIBS += -ldl -lm -lpthread
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libicuuc-host
LOCAL_ADDITIONAL_DEPENDENCIES += $(LOCAL_PATH)/Android.mk
LOCAL_REQUIRED_MODULES += icu-data-host
LOCAL_MULTILIB := both
include $(BUILD_HOST_SHARED_LIBRARY)

#
# Build as a static library against the NDK
#

include $(CLEAR_VARS)
LOCAL_SDK_VERSION := 9
LOCAL_NDK_STL_VARIANT := stlport_static
LOCAL_C_INCLUDES += $(c_includes)
LOCAL_EXPORT_C_INCLUDES += $(LOCAL_PATH)
LOCAL_CPP_FEATURES := rtti
LOCAL_CFLAGS += $(local_cflags) -DPIC -fPIC -frtti
# Using -Os over -O3 actually cuts down the final executable size by a few dozen kilobytes
LOCAL_CFLAGS += -Os
LOCAL_EXPORT_CFLAGS += -DU_STATIC_IMPLEMENTATION=1
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libicuuc_static
LOCAL_SRC_FILES += $(src_files)
LOCAL_REQUIRED_MODULES += icu-data
include $(BUILD_STATIC_LIBRARY)
