#Android.mk di gobject
LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
    $(LOCAL_PATH)/gboxed.c                \
    $(LOCAL_PATH)/genums.c                \
    $(LOCAL_PATH)/gparam.c                \
    $(LOCAL_PATH)/gsignal.c               \
    $(LOCAL_PATH)/gtypemodule.c           \
    $(LOCAL_PATH)/gtypeplugin.c           \
    $(LOCAL_PATH)/gvalue.c                \
    $(LOCAL_PATH)/gvaluetypes.c           \
    $(LOCAL_PATH)/gclosure.c              \
    $(LOCAL_PATH)/gobject.c               \
    $(LOCAL_PATH)/gparamspecs.c           \
    $(LOCAL_PATH)/gtype.c                 \
    $(LOCAL_PATH)/gvaluearray.c           \
    $(LOCAL_PATH)/gvaluetransform.c       \
    $(LOCAL_PATH)/gatomicarray.c          \
    $(LOCAL_PATH)/gsourceclosure.c	  \
    $(LOCAL_PATH)/gmarshal.c

LOCAL_STATIC_LIBRARIES := \
	libglib-2.0 \
	libgthread-2.0 \
	libffi

LOCAL_MODULE:= libgobject-2.0

LOCAL_C_INCLUDES := 		\
	$(LOCAL_PATH)		\
	$(GLIB_TOP)		\
	$(GLIB_TOP)/android	\
	$(GLIB_TOP)/glib \
	$(GLIB_TOP)/../libffi-android/include \
	$(GLIB_TOP)/../libffi-android/linux-arm \
	$(LOCAL_PATH)/../../zlib \
	$(GLIB_TOP)/../libffi-3.0.12/include\
	$(GLIB_TOP)/../libffi-3.0.12/linux-arm

LOCAL_CFLAGS := \
    -DG_LOG_DOMAIN=\"GLib-GObject\" \
    -DGOBJECT_COMPILATION           \
    -DG_DISABLE_CONST_RETURNS       \
    -DG_DISABLE_DEPRECATED \
	-DGLIB_COMPILATION=1

include $(BUILD_STATIC_LIBRARY)

#################
# DUMY
#################

# LOCAL_PATH:= $(call my-dir)
# include $(CLEAR_VARS)
# 
# LOCAL_MODULE:= libgobject-2.0-shared
# LOCAL_LDLIBS := -lz -ldl -llog
# LOCAL_SHARED_LIBRARIES := libffi-shared
# LOCAL_WHOLE_STATIC_LIBRARIES := libgobject-2.0
# 
# include $(BUILD_SHARED_LIBRARY)
