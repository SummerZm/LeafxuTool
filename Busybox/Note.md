## **注意问题**
- 1. 要取消安装选项中的/usr , 否则会在 make install 覆盖自身系统中的里链接.  
- 2. 交叉编译时可以在的make menuconfig 中配置, 也可以在MakeFile中修改 CROSS_COMPLIE 选项
- 3. 编译过程中出现某个工具失败，同时这个工具不是必要的可以通过make menuconfig 关闭相应的工具编译选项
- 4. 编译过程中可以通过CFLAGS，LDGLAGS参数指定第三方依赖库
		ex: make CFLAGS="-I/usr/local/arm/4.2.2-eabi/include -L/usr/local/arm/4.2.2-eabi/lib"  LDGLAGS="-L/usr/local/arm/4.2.2-eabi/lib"

- 5. 如果在交叉编译工具lib目录找不到需要的静态库, 可以到交叉编译工具usr/lib目录找找看
- 6. 如果找到对应的静态库，链接是仍找不到需要的符号，则可能是工具链的版本较低

