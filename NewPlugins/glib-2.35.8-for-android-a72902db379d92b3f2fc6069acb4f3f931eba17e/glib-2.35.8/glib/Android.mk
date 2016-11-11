#Android.mk di glib
LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

#remove, burke
#gcache.c        \
#gcompletion.c   \
#    grel.c          \
#gbuffer.c \


LOCAL_SRC_FILES:= \
    $(LOCAL_PATH)/libcharset/localcharset.c \
    $(LOCAL_PATH)/deprecated/gthread-deprecated.c \
    $(LOCAL_PATH)/gdatetime.c     \
    $(LOCAL_PATH)/gtimezone.c     \
    $(LOCAL_PATH)/gurifuncs.c     \
    $(LOCAL_PATH)/ghostutils.c    \
    $(LOCAL_PATH)/garray.c        \
    $(LOCAL_PATH)/gchecksum.c     \
    $(LOCAL_PATH)/gbitlock.c      \
    $(LOCAL_PATH)/gtestutils.c    \
    $(LOCAL_PATH)/gpoll.c         \
    $(LOCAL_PATH)/gasyncqueue.c   \
    $(LOCAL_PATH)/gatomic.c       \
    $(LOCAL_PATH)/gbacktrace.c    \
    $(LOCAL_PATH)/gbase64.c       \
    $(LOCAL_PATH)/gbookmarkfile.c \
	\
    $(LOCAL_PATH)/gconvert.c      \
    $(LOCAL_PATH)/gdataset.c      \
    $(LOCAL_PATH)/gdate.c         \
    $(LOCAL_PATH)/gdir.c          \
    $(LOCAL_PATH)/gerror.c        \
    $(LOCAL_PATH)/gfileutils.c    \
    $(LOCAL_PATH)/ghash.c         \
    $(LOCAL_PATH)/ghook.c         \
    $(LOCAL_PATH)/giochannel.c    \
    $(LOCAL_PATH)/gkeyfile.c      \
    $(LOCAL_PATH)/glist.c         \
    $(LOCAL_PATH)/gmain.c         \
    $(LOCAL_PATH)/gmappedfile.c   \
    $(LOCAL_PATH)/gmarkup.c       \
    $(LOCAL_PATH)/gmem.c          \
    $(LOCAL_PATH)/gmessages.c     \
    $(LOCAL_PATH)/gnode.c         \
    $(LOCAL_PATH)/goption.c       \
    $(LOCAL_PATH)/gpattern.c      \
    $(LOCAL_PATH)/gprimes.c       \
    $(LOCAL_PATH)/gqsort.c        \
    $(LOCAL_PATH)/gqueue.c        \
	\
    $(LOCAL_PATH)/grand.c         \
    $(LOCAL_PATH)/gscanner.c      \
    $(LOCAL_PATH)/gsequence.c     \
    $(LOCAL_PATH)/gshell.c        \
    $(LOCAL_PATH)/gslice.c        \
    $(LOCAL_PATH)/gslist.c        \
    $(LOCAL_PATH)/gstdio.c        \
    $(LOCAL_PATH)/gstrfuncs.c     \
    $(LOCAL_PATH)/gstring.c       \
    $(LOCAL_PATH)/gthread.c       \
    $(LOCAL_PATH)/gthreadpool.c   \
    $(LOCAL_PATH)/gtimer.c        \
    $(LOCAL_PATH)/gtree.c         \
    $(LOCAL_PATH)/guniprop.c      \
    $(LOCAL_PATH)/gutf8.c         \
    $(LOCAL_PATH)/gunibreak.c     \
    $(LOCAL_PATH)/gunicollate.c   \
    $(LOCAL_PATH)/gunidecomp.c    \
    $(LOCAL_PATH)/gutils.c        \
    $(LOCAL_PATH)/gprintf.c       \
    $(LOCAL_PATH)/giounix.c       \
    $(LOCAL_PATH)/gvariant.c      \
    $(LOCAL_PATH)/gvariant-core.c \
    $(LOCAL_PATH)/gvariant-parser.c \
    $(LOCAL_PATH)/gvariant-serialiser.c \
    $(LOCAL_PATH)/gvarianttype.c \
    $(LOCAL_PATH)/gvarianttypeinfo.c \
    \
    $(LOCAL_PATH)/gspawn.c \
	\
	$(LOCAL_PATH)/gthread-posix.c \
	$(LOCAL_PATH)/gwakeup.c \
	$(LOCAL_PATH)/gcharset.c \
	$(LOCAL_PATH)/glib-init.c \
	$(LOCAL_PATH)/gquark.c \
	$(LOCAL_PATH)/genviron.c \
	$(LOCAL_PATH)/glib-unix.c \
	$(LOCAL_PATH)/gregex.c \
	$(LOCAL_PATH)/glib-private.c \
	$(LOCAL_PATH)/ggettext.c \
	$(LOCAL_PATH)/gbytes.c

LOCAL_MODULE:= libglib-2.0

LOCAL_C_INCLUDES := 			\
	$(GLIB_TOP)			\
	$(GLIB_TOP)/android/		\
	$(GLIB_TOP)/glib/		\
	$(LOCAL_PATH)/libcharset        \
	$(LOCAL_PATH)/gnulib            \
	$(LOCAL_PATH)/pcre \
	$(LOCAL_PATH)/../../zlib




# ./glib private macros, copy from Makefile.am
LOCAL_CFLAGS := \
    -DLIBDIR=\"$(libdir)\"          \
    -DHAVE_CONFIG_H                 \
    \
    -DG_LOG_DOMAIN=\"GLib-GRegex\" \
    -DSUPPORT_UCP \
    -DSUPPORT_UTF8 \
    -DNEWLINE=-1 \
    -DMATCH_LIMIT=10000000 \
    -DMATCH_LIMIT_RECURSION=10000000 \
    -DMAX_NAME_SIZE=32 \
    -DMAX_NAME_COUNT=10000 \
    -DMAX_DUPLENGTH=30000 \
    -DLINK_SIZE=2 \
    -DEBCDIC=0 \
    -DPOSIX_MALLOC_THRESHOLD=10 \
    -DG_DISABLE_DEPRECATED \
    -DGLIB_COMPILATION

LOCAL_STATIC_LIBRARIES := libpcre
    
include $(BUILD_STATIC_LIBRARY)

#################
# DUMY
#################

# LOCAL_PATH:= $(call my-dir)
# include $(CLEAR_VARS)
# 
# LOCAL_MODULE:= libglib-2.0-shared
# LOCAL_LDLIBS := -llog \
# 	-lz
# LOCAL_WHOLE_STATIC_LIBRARIES := libglib-2.0
# 
# include $(BUILD_SHARED_LIBRARY)
