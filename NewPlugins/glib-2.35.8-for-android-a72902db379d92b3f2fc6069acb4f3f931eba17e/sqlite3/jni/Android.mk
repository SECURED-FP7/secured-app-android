# SQLITE
# aucd29@gmail.com, Burke.Choi@obigo.com

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_CFLAGS := -DHAVE_USLEEP=1 -DSQLITE_DEFAULT_JOURNAL_SIZE_LIMIT=1048576 -DSQLITE_THREADSAFE=1 -DNDEBUG=1 -DSQLITE_ENABLE_MEMORY_MANAGEMENT=1 -DSQLITE_DEFAULT_AUTOVACUUM=1 -DSQLITE_TEMP_STORE=3 -DSQLITE_ENABLE_FTS3 -DSQLITE_ENABLE_FTS3_BACKWARDS -DSQLITE_DEFAULT_FILE_FORMAT=4 -DANDROID
LOCAL_MODULE := sqlite
#LOCAL_LDLIBS := -lutils
LOCAL_EXPORT_C_INCLUDES := $(GLIB_TOP)/../sqlite3
LOCAL_SRC_FILES:= $(GLIB_TOP)/../sqlite3/sqlite3.c

include $(BUILD_STATIC_LIBRARY)

# SHARED LIB

# include $(CLEAR_VARS)
# 
# LOCAL_MODULE := sqlite-shared
# LOCAL_WHOLE_STATIC_LIBRARIES := sqlite
# 
# include $(BUILD_SHARED_LIBRARY)