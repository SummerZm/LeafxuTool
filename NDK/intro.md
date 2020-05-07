## NDK简介 ##
> NDK是android项目下的一套工具集合. 用于提高开发Jni开发效率

### NDK工具的使用 ###
- Application.mk
    1. 配置要编译目标平台库：  APP_ABI:= x86    [路径：ndk/toolchains/]
    2. 配置使用android-x以上平台库:  APP_PLATFORM:= android-9   [路径：ndk/platforms/android-9/]
    3. 注: ndk/platforms/存放着平台相关的基础库; ndk/toolchains/存放着相关的交叉编译工具链(arm,X86,mips).

- Android.mk
> 默认所有代码和文件在$project/jni

1. 编译静态库
    ```sh
    #文件Android.mk:
    LOCAL_PATH := $(call my-dir)
    include $(CLEAR_VARS)
    LOCAL_MODULE    := hello-jni
    LOCAL_SRC_FILES := hello-jni.c
    include $(BUILD_STATIC_LIBRARY)

    #文件Application.mk:
    APP_MODULES :=hello-jni
    ```
2. 编译动态库
    ``` sh
    #文件Android.mk:

    LOCAL_PATH := $(call my-dir)
    include $(CLEAR_VARS)
    LOCAL_MODULE    := hello-jni
    LOCAL_SRC_FILES := hello-jni.c
    include $(BUILD_SHARED_LIBRARY)
    ```
3. 编译动态库+静态库
    ```sh
    #文件Android.mk:

    LOCAL_PATH := $(call my-dir)

    include $(CLEAR_VARS)
    LOCAL_MODULE    := mylib_static
    LOCAL_SRC_FILES := src.c
    include $(BUILD_STATIC_LIBRARY)

    include $(CLEAR_VARS)
    LOCAL_MODULE    := mylib_shared
    LOCAL_SRC_FILES := src2.c

    LOCAL_STATIC_LIBRARIES := mylib_static

    ```

4. 已有第三方静态库（动态库），编译静态库（动态库）
    ```sh
    #文件Android.mk:

    LOCAL_PATH := $(call my-dir)

    include $(CLEAR_VARS)
    LOCAL_MODULE := thirdlib1      # name it whatever
    LOCAL_SRC_FILES := $(TARGET_ARCH_ABI)/libthird1.a     # or $(so_path)/libthird1.so
    #LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/include
    include $(PREBUILT_STATIC_LIBRARY)    #or PREBUILT_SHARED_LIBRARY

    include $(CLEAR_VARS)
    LOCAL_MODULE    := mylib_use_thirdlib
    LOCAL_SRC_FILES := src.c

    LOCAL_STATIC_LIBRARIES := thirdlib1       #or LOCAL_SHARED_LIBRARY 

    include $(BUILD_SHARED_LIBRARY)   #如果编译静态库，需要Application.mk

    ```
原文链接：https://blog.csdn.net/heng615975867/article/details/11904737