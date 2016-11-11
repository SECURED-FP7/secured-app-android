
LOCAL_PATH:= $(call my-dir)



include $(CLEAR_VARS)
settings_sources := \
	$(LOCAL_PATH)/gvdb/gvdb-format.h		\
	$(LOCAL_PATH)/gvdb/gvdb-reader.h		\
	$(LOCAL_PATH)/gvdb/gvdb-reader.c		\
	$(LOCAL_PATH)/gdelayedsettingsbackend.h	\
	$(LOCAL_PATH)/gdelayedsettingsbackend.c	\
	$(LOCAL_PATH)/gkeyfilesettingsbackend.c	\
	$(LOCAL_PATH)/gmemorysettingsbackend.h	\
	$(LOCAL_PATH)/gmemorysettingsbackend.c	\
	$(LOCAL_PATH)/gnullsettingsbackend.h		\
	$(LOCAL_PATH)/gnullsettingsbackend.c		\
	$(LOCAL_PATH)/gsettingsbackendinternal.h	\
	$(LOCAL_PATH)/gsettingsbackend.c		\
	$(LOCAL_PATH)/gsettingsschema.h		\
	$(LOCAL_PATH)/gsettingsschema.c		\
	$(LOCAL_PATH)/gsettings-mapping.h		\
	$(LOCAL_PATH)/gsettings-mapping.c		\
	$(LOCAL_PATH)/gsettings.c

# remove burke
#marshal_sources := \
#        gio-marshal.h	\
#        gio-marshal.c	\


gdbus_sources := \
	$(LOCAL_PATH)/gdbusutils.h			$(LOCAL_PATH)/gdbusutils.c			\
	$(LOCAL_PATH)/gdbusaddress.h			$(LOCAL_PATH)/gdbusaddress.c			\
	$(LOCAL_PATH)/gdbusauthobserver.h		$(LOCAL_PATH)/gdbusauthobserver.c		\
	$(LOCAL_PATH)/gdbusauth.h			$(LOCAL_PATH)/gdbusauth.c			\
	$(LOCAL_PATH)/gdbusauthmechanism.h		$(LOCAL_PATH)/gdbusauthmechanism.c		\
	$(LOCAL_PATH)/gdbusauthmechanismanon.h	$(LOCAL_PATH)/gdbusauthmechanismanon.c	\
	$(LOCAL_PATH)/gdbusauthmechanismexternal.h	$(LOCAL_PATH)/gdbusauthmechanismexternal.c	\
	$(LOCAL_PATH)/gdbusauthmechanismsha1.h	$(LOCAL_PATH)/gdbusauthmechanismsha1.c	\
	$(LOCAL_PATH)/gdbuserror.h			$(LOCAL_PATH)/gdbuserror.c			\
	$(LOCAL_PATH)/gdbusconnection.h		$(LOCAL_PATH)/gdbusconnection.c		\
	$(LOCAL_PATH)/gdbusmessage.h			$(LOCAL_PATH)/gdbusmessage.c			\
	$(LOCAL_PATH)/gdbusnameowning.h		$(LOCAL_PATH)/gdbusnameowning.c		\
	$(LOCAL_PATH)/gdbusnamewatching.h		$(LOCAL_PATH)/gdbusnamewatching.c		\
	$(LOCAL_PATH)/gdbusproxy.h			$(LOCAL_PATH)/gdbusproxy.c			\
	$(LOCAL_PATH)/gdbusprivate.h			$(LOCAL_PATH)/gdbusprivate.c			\
	$(LOCAL_PATH)/gdbusintrospection.h		$(LOCAL_PATH)/gdbusintrospection.c		\
	$(LOCAL_PATH)/gdbusmethodinvocation.h		$(LOCAL_PATH)/gdbusmethodinvocation.c		\
	$(LOCAL_PATH)/gdbusserver.h			$(LOCAL_PATH)/gdbusserver.c			\

local_sources := \
	$(LOCAL_PATH)/gproxyaddress.h			\
	$(LOCAL_PATH)/glocaldirectorymonitor.c 	\
	$(LOCAL_PATH)/glocaldirectorymonitor.h 	\
	$(LOCAL_PATH)/glocalfile.c 			\
	$(LOCAL_PATH)/glocalfile.h 			\
	$(LOCAL_PATH)/glocalfileenumerator.c 		\
	$(LOCAL_PATH)/glocalfileenumerator.h 		\
	$(LOCAL_PATH)/glocalfileinfo.c 		\
	$(LOCAL_PATH)/glocalfileinfo.h 		\
	$(LOCAL_PATH)/glocalfileinputstream.c 	\
	$(LOCAL_PATH)/glocalfileinputstream.h 	\
	$(LOCAL_PATH)/glocalfilemonitor.c 		\
	$(LOCAL_PATH)/glocalfilemonitor.h 		\
	$(LOCAL_PATH)/glocalfileoutputstream.c 	\
	$(LOCAL_PATH)/glocalfileoutputstream.h 	\
	$(LOCAL_PATH)/glocalfileiostream.c		\
	$(LOCAL_PATH)/glocalfileiostream.h		\
	$(LOCAL_PATH)/glocalvfs.c 			\
	$(LOCAL_PATH)/glocalvfs.h 			\
	$(LOCAL_PATH)/gsocks4proxy.c			\
	$(LOCAL_PATH)/gsocks4proxy.h			\
	$(LOCAL_PATH)/gsocks4aproxy.c			\
	$(LOCAL_PATH)/gsocks4aproxy.h			\
	$(LOCAL_PATH)/gsocks5proxy.c			\
	$(LOCAL_PATH)/gsocks5proxy.h			\

# burke
# gunixresolver.c		\
# gunixresolver.h		\
# gio-marshal.c	\


unix_sources := \
	$(LOCAL_PATH)/gfiledescriptorbased.c  \
	$(LOCAL_PATH)/gunixconnection.c	\
	$(LOCAL_PATH)/gunixcredentialsmessage.c	\
	$(LOCAL_PATH)/gunixfdlist.c		\
	$(LOCAL_PATH)/gunixfdmessage.c	\
	$(LOCAL_PATH)/gunixmount.c		\
	$(LOCAL_PATH)/gunixmounts.c		\
	\
	$(LOCAL_PATH)/gunixsocketaddress.c	\
	$(LOCAL_PATH)/gunixvolume.c 		\
	$(LOCAL_PATH)/gunixvolume.h 		\
	$(LOCAL_PATH)/gunixvolumemonitor.c 	\
	$(LOCAL_PATH)/gunixvolumemonitor.h 	\
	$(LOCAL_PATH)/gunixinputstream.c 	\
	$(LOCAL_PATH)/gunixoutputstream.c 	\



# remove, burke
#gproxyconnection.c \
#	$(marshal_sources) 	\


LOCAL_SRC_FILES:= \
	$(LOCAL_PATH)/gproxy.c $(LOCAL_PATH)/gproxyaddress.c \
	$(LOCAL_PATH)/gproxyaddressenumerator.c \
	$(LOCAL_PATH)/gproxyresolver.c	\
	$(LOCAL_PATH)/gdummyproxyresolver.c	\
	$(LOCAL_PATH)/xdgmime/xdgmimealias.c	\
	$(LOCAL_PATH)/xdgmime/xdgmime.c	\
	$(LOCAL_PATH)/xdgmime/xdgmimecache.c	\
	$(LOCAL_PATH)/xdgmime/xdgmimeglob.c	\
	$(LOCAL_PATH)/xdgmime/xdgmimeicon.c	\
	$(LOCAL_PATH)/xdgmime/xdgmimeint.c	\
	$(LOCAL_PATH)/xdgmime/xdgmimemagic.c	\
	$(LOCAL_PATH)/xdgmime/xdgmimeparent.c	\
	$(LOCAL_PATH)/libasyncns/asyncns.c	\
	$(LOCAL_PATH)/gappinfo.c 		\
	$(LOCAL_PATH)/gasynchelper.c 		\
	$(LOCAL_PATH)/gasynchelper.h 		\
	$(LOCAL_PATH)/gasyncinitable.c	\
	$(LOCAL_PATH)/gasyncresult.c 		\
	$(LOCAL_PATH)/gbufferedinputstream.c 	\
	$(LOCAL_PATH)/gbufferedoutputstream.c \
	$(LOCAL_PATH)/gcancellable.c 		\
	$(LOCAL_PATH)/gcontenttype.c 		\
	$(LOCAL_PATH)/gcontenttypeprivate.h 	\
	$(LOCAL_PATH)/gcharsetconverter.c	\
	$(LOCAL_PATH)/gconverter.c		\
	$(LOCAL_PATH)/gconverterinputstream.c	\
	$(LOCAL_PATH)/gconverteroutputstream.c	\
	$(LOCAL_PATH)/gcredentials.c		\
	$(LOCAL_PATH)/gdatainputstream.c 	\
	$(LOCAL_PATH)/gdataoutputstream.c 	\
	$(LOCAL_PATH)/gdrive.c 		\
	$(LOCAL_PATH)/gdummyfile.c 		\
	$(LOCAL_PATH)/gemblem.h 		\
	$(LOCAL_PATH)/gemblem.c 		\
	$(LOCAL_PATH)/gemblemedicon.h		\
	$(LOCAL_PATH)/gemblemedicon.c		\
	$(LOCAL_PATH)/gfile.c 		\
	$(LOCAL_PATH)/gfileattribute.c 	\
	$(LOCAL_PATH)/gfileattribute-priv.h 	\
	$(LOCAL_PATH)/gfileenumerator.c 	\
	$(LOCAL_PATH)/gfileicon.c 		\
	$(LOCAL_PATH)/gfileinfo.c 		\
	$(LOCAL_PATH)/gfileinfo-priv.h 	\
	$(LOCAL_PATH)/gfileinputstream.c 	\
	$(LOCAL_PATH)/gfilemonitor.c 		\
	$(LOCAL_PATH)/gfilenamecompleter.c 	\
	$(LOCAL_PATH)/gfileoutputstream.c 	\
	$(LOCAL_PATH)/gfileiostream.c		\
	$(LOCAL_PATH)/gfilterinputstream.c 	\
	$(LOCAL_PATH)/gfilteroutputstream.c 	\
	$(LOCAL_PATH)/gicon.c 		\
	$(LOCAL_PATH)/ginetaddress.c		\
	$(LOCAL_PATH)/ginetsocketaddress.c	\
	$(LOCAL_PATH)/ginitable.c		\
	$(LOCAL_PATH)/ginputstream.c 		\
	$(LOCAL_PATH)/gioenums.h		\
	$(LOCAL_PATH)/gioerror.c 		\
	$(LOCAL_PATH)/giomodule.c 		\
	$(LOCAL_PATH)/giomodule-priv.h	\
	$(LOCAL_PATH)/gioscheduler.c 		\
	$(LOCAL_PATH)/giostream.c		\
	$(LOCAL_PATH)/gloadableicon.c 	\
	$(LOCAL_PATH)/gmount.c 		\
	$(LOCAL_PATH)/gmemoryinputstream.c 	\
	$(LOCAL_PATH)/gmemoryoutputstream.c 	\
	$(LOCAL_PATH)/gmountoperation.c 	\
	$(LOCAL_PATH)/gnativevolumemonitor.c 	\
	$(LOCAL_PATH)/gnativevolumemonitor.h 	\
	$(LOCAL_PATH)/gnetworkaddress.c	\
	$(LOCAL_PATH)/gnetworkingprivate.h	\
	$(LOCAL_PATH)/gnetworkservice.c	\
	$(LOCAL_PATH)/goutputstream.c 	\
	$(LOCAL_PATH)/gpermission.c 		\
	$(LOCAL_PATH)/gpollfilemonitor.c 	\
	$(LOCAL_PATH)/gpollfilemonitor.h 	\
	$(LOCAL_PATH)/gresolver.c		\
	$(LOCAL_PATH)/gseekable.c 		\
	$(LOCAL_PATH)/gsimpleasyncresult.c 	\
	$(LOCAL_PATH)/gsimplepermission.c 	\
	$(LOCAL_PATH)/gsocket.c		\
	$(LOCAL_PATH)/gsocketaddress.c	\
	$(LOCAL_PATH)/gsocketaddressenumerator.c \
	$(LOCAL_PATH)/gsocketclient.c		\
	$(LOCAL_PATH)/gsocketconnectable.c	\
	$(LOCAL_PATH)/gsocketconnection.c	\
	$(LOCAL_PATH)/gsocketcontrolmessage.c	\
	$(LOCAL_PATH)/gsocketinputstream.c	\
	$(LOCAL_PATH)/gsocketinputstream.h	\
	$(LOCAL_PATH)/gsocketlistener.c	\
	$(LOCAL_PATH)/gsocketoutputstream.c	\
	$(LOCAL_PATH)/gsocketoutputstream.h	\
	$(LOCAL_PATH)/gsocketservice.c	\
	$(LOCAL_PATH)/gsrvtarget.c		\
	$(LOCAL_PATH)/gtcpconnection.c	\
	$(LOCAL_PATH)/gthreadedsocketservice.c\
	$(LOCAL_PATH)/gthemedicon.c 		\
	$(LOCAL_PATH)/gthreadedresolver.c	\
	$(LOCAL_PATH)/gthreadedresolver.h	\
	$(LOCAL_PATH)/gunionvolumemonitor.c 	\
	$(LOCAL_PATH)/gunionvolumemonitor.h 	\
	$(LOCAL_PATH)/gvfs.c 			\
	$(LOCAL_PATH)/gvolume.c 		\
	$(LOCAL_PATH)/gvolumemonitor.c 	\
	$(LOCAL_PATH)/gzlibcompressor.c	\
	$(LOCAL_PATH)/gzlibdecompressor.c	\
	$(LOCAL_PATH)/gmountprivate.h 	\
	$(LOCAL_PATH)/gioenumtypes.h		\
	$(LOCAL_PATH)/gioenumtypes.c		\
	$(LOCAL_PATH)/gdesktopappinfo.c	\
	$(unix_sources) 	\
	$(settings_sources) 	\
	$(gdbus_sources) 	\
	$(local_sources) 	\
	$(LOCAL_PATH)/ginetaddress.c	\
	$(LOCAL_PATH)/gtask.c \
	$(LOCAL_PATH)/gnetworking.c \
	$(LOCAL_PATH)/gpollableinputstream.c \
	$(LOCAL_PATH)/gpollableoutputstream.c \
	$(LOCAL_PATH)/gdummytlsbackend.c \
	$(LOCAL_PATH)/gnetworkmonitor.c \
	$(LOCAL_PATH)/gtlsbackend.c \
	$(LOCAL_PATH)/gtlscertificate.c \
	$(LOCAL_PATH)/gtlsclientconnection.c \
	$(LOCAL_PATH)/gtlsconnection.c \
	$(LOCAL_PATH)/gtlsdatabase.c \
	$(LOCAL_PATH)/gtlsfiledatabase.c \
	$(LOCAL_PATH)/gtlsinteraction.c \
	$(LOCAL_PATH)/gtlspassword.c \
	$(LOCAL_PATH)/gtlsserverconnection.c \
	$(LOCAL_PATH)/gunionvolumemonitor.c \
	$(LOCAL_PATH)/gnetworkmonitorbase.c \
	$(LOCAL_PATH)/gnetworkmonitornetlink.c \
	$(LOCAL_PATH)/ginetaddressmask.c \
	$(LOCAL_PATH)/gpollableutils.c \
	$(LOCAL_PATH)/gtcpwrapperconnection.c \
	$(LOCAL_PATH)/gresourcefile.c \
	$(LOCAL_PATH)/gresource.c



#	gfileattribute.c	\
	gfile.c	\
	gfiledescriptorbased.c	\
	gfileenumerator.c	\
	gfileinfo.c	\
	gfileinputstream.c	\
	gfileiostream.c	\
	gfilemonitor.c	\
	gfileoutputstream.c	\
	gthreadedresolver.c	\
	libasyncns/asyncns.c	\
	gunixresolver.c	\
	gpollfilemonitor.c	\
	gvfs.c	\
	glocalvfs.c	\
	gresolver.c	\
	gsrvtarget.c	\
	gunixconnection.c	\
	gunixfdlist.c	\
	gunixfdmessage.c	\
	gseekable.c	\
	gioenumtypes.c	\
	\
	gio-querymodules.c	\
	gnetworkaddress.c	\
	gnetworkservice.c	\
	gsocket.c	\
	gsocketconnectable.c	\
	gsocketconnection.c	\
	gsocketcontrolmessage.c	\
	gsocketinputstream.c	\
	gsocketlistener.c	\
	gsocketoutputstream.c	\
	gsocketservice.c	\
	ginetsocketaddress.c	\
	gunixsocketaddress.c	\
	ginitable.c	\
	gcredentials.c	\
	gunixcredentialsmessage.c	\
	gtcpconnection.c	\
	giostream.c	\
	ginputstream.c	\
	gioscheduler.c		\
	gasyncresult.c		\
	gcancellable.c		\
	gioerror.c		\
	gsocketaddress.c	\
	gsocketaddressenumerator.c	\
	gsocketclient.c		\
	gsimpleasyncresult.c \
	gpollableoutputstream.c

LOCAL_STATIC_LIBRARIES := \
	libglib-2.0		\
    libgthread-2.0          \
    libgmodule-2.0          \
    libgobject-2.0

LOCAL_MODULE:= libgio-2.0

LOCAL_C_INCLUDES := 			\
	$(GLIB_TOP)			\
	$(GLIB_TOP)/../zlib \
	$(GLIB_TOP)/android		\
	$(GLIB_TOP)/android/arpa	\
	$(GLIB_TOP)/gio			\
	$(GLIB_TOP)/gio/libasyncns	\
	$(GLIB_TOP)/glib		\
	$(GLIB_TOP)/gmodule		\
	$(LOCAL_PATH)/libcharset        \
	$(LOCAL_PATH)/gnulib            \
	$(LOCAL_PATH)/pcre		\
	$(GLIB_TOP)/../libintl-lite-0.5

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
    -DGIO_COMPILATION		\
    -DGIO_MODULE_DIR=\"/tmp\" \
    -DGLIB_COMPILATION

LOCAL_LDLIBS := \
	-lz

#LOCAL_PRELINK_MODULE := false
include $(BUILD_STATIC_LIBRARY)

#
# DUMY
#

# LOCAL_PATH:= $(call my-dir)
# include $(CLEAR_VARS)
# 
# LOCAL_MODULE:= libgio-2.0-shared
# LOCAL_WHOLE_STATIC_LIBRARIES := \
# 	libgio-2.0
# 
# LOCAL_LDLIBS := \
# 	-lz
# 
# include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := libintl
LOCAL_CFLAGS    := \
    -Wno-multichar \
    -D_ANDROID \
    -DLIBDIR="\"c\"" \
    -DBUILDING_LIBICONV \
    -DIN_LIBRARY
LOCAL_C_INCLUDES := \
    $(GLIB_TOP)/../libintl-lite-0.5/internal \
    $(GLIB_TOP)/../libintl-lite-0.5
LOCAL_SRC_FILES := $(GLIB_TOP)/../libintl-lite-0.5/internal/libintl.cpp
LOCAL_CPP_FEATURES += exceptions
include $(BUILD_STATIC_LIBRARY)