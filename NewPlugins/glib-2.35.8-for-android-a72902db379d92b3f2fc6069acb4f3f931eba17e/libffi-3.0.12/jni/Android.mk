LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libffi
LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/../include \
	$(LOCAL_PATH)/../linux-arm

LOCAL_SRC_FILES := \
	$(GLIB_TOP)/../libffi-3.0.12/src/arm/sysv.S \
	$(GLIB_TOP)/../libffi-3.0.12/src/arm/ffi.c \
	$(GLIB_TOP)/../libffi-3.0.12/src/debug.c \
	$(GLIB_TOP)/../libffi-3.0.12/src/java_raw_api.c \
	$(GLIB_TOP)/../libffi-3.0.12/src/prep_cif.c \
	$(GLIB_TOP)/../libffi-3.0.12/src/raw_api.c \
	$(GLIB_TOP)/../libffi-3.0.12/src/types.c

include $(BUILD_STATIC_LIBRARY)

#
# DUMY
#

# LOCAL_PATH:= $(call my-dir)
# include $(CLEAR_VARS)
# LOCAL_MODULE := libffi-shared
# LOCAL_WHOLE_STATIC_LIBRARIES := libffi
# include $(BUILD_SHARED_LIBRARY)
