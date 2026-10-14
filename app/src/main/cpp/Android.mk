LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := argon2jni
LOCAL_C_INCLUDES := $(LOCAL_PATH)/argon2/include $(LOCAL_PATH)/argon2/src
LOCAL_SRC_FILES := argon2_jni.c argon2/src/argon2.c argon2/src/core.c argon2/src/encoding.c argon2/src/ref.c \
    argon2/src/thread.c argon2/src/blake2/blake2b.c
LOCAL_CFLAGS := -O3 -std=c99
LOCAL_LDFLAGS := -Wl,-z,max-page-size=16384
include $(BUILD_SHARED_LIBRARY)
