LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
    $(LOCAL_PATH)/gmodule.c

LOCAL_STATIC_LIBRARIES := 	\
    libglib-2.0

LOCAL_MODULE:= libgmodule-2.0

LOCAL_C_INCLUDES := \
	$(GLIB_TOP)		\
	$(GLIB_TOP)/android	\
	$(GLIB_TOP)/glib	\
	$(GLIB_TOP)/gmodule	\
	$(LOCAL_PATH)/android

LOCAL_CFLAGS := \
    -DG_LOG_DOMAIN=\"GModule\"      \
    -DG_DISABLE_DEPRECATED \
	-DGLIB_COMPILATION=1

LOCAL_LDLIBS := \
	-ldl

#LOCAL_PRELINK_MODULE := false
include $(BUILD_STATIC_LIBRARY)

#
# DUMY
#

# LOCAL_PATH:= $(call my-dir)
# include $(CLEAR_VARS)
# 
# LOCAL_MODULE:= libgmodule-2.0-shared
# LOCAL_WHOLE_STATIC_LIBRARIES := \
# 	libgmodule-2.0
# 
# include $(BUILD_SHARED_LIBRARY)

