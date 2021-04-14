## Strace 使用简介

### Strace 用法
```sh
# strace 启动要跟踪的进程。
strace ls -lh /var/log/messages

# strace 跟踪已启动的进程
strace -p 17553

strace -tt -T -v -f -e trace=file -o /data/log/strace.log -s 1024 -p 23489
# -tt 在每行输出的前面，显示毫秒级别的时间
# -T 显示每次系统调用所花费的时间
# -v 对于某些相关调用，把完整的环境变量，文件stat结构等打出来。
# -f 跟踪目标进程，以及目标进程创建的所有子进程
# -e 控制要跟踪的事件和跟踪行为,比如指定要跟踪的系统调用名称
# -o 把strace的输出单独写到指定的文件
# -s 当系统调用的某个参数是字符串时，最多输出指定长度的内容，默认是32个字节
# -p 指定要跟踪的进程pid, 要同时跟踪多个pid, 重复多次-p选项即可。
# -e trace=file 输出只显示和文件访问有关的内容。
# 跟踪nginx, 看其启动时都访问了哪些文件
# strace -tt -T -f -e trace=file -o /data/log/strace.log -s 1024 ./nginx
```

### Strace 的作用
- **定位进程异常退出：进程被什么信号杀死**
- **定位共享内存异常**
    ```sh
    # 案例：
    # 有个服务启动时报错：
        shmget 267264 30097568: Invalid argument
        Can not get shm...exit!
    # 错误日志大概告诉我们是获取共享内存出错，通过strace看下：
        strace -tt -f -e trace=ipc ./a_mon_svr     ../conf/a_mon_svr.conf
    # 输出：
        22:46:36.351798 shmget(0x5feb, 12000, 0666) = 0
        22:46:36.351939 shmat(0, 0, 0)          = ?
        Process 21406 attached
        22:46:36.355439 shmget(0x41400, 30097568, 0666) = -1 EINVAL (Invalid argument)
        shmget 267264 30097568: Invalid argument
        Can not get shm...exit!
    # 通过-e trace=ipc 选项，让strace只跟踪和进程通信相关的系统调用。
    ```
- ***性能分析：strace -c**
    ```sh
    # 统计Linux 4.5.4 版本内核中的代码行数(包含汇编和C代码)
    # poor-script.sh  耗时：几百秒
    total_line=0
    while read filename; do
    line=$(wc -l $filename | awk ‘{print $1}’)
    (( total_line += line ))
    done < <( find linux-4.5.4 -type f  ( -iname ‘.c’ -o -iname ‘.h’ -o -iname ‘*.S’ ) )
    echo “total line: $total_line”

    # good-script.sh  耗时：几秒
    find linux-4.5.4 -type f  ( -iname ‘.c’ -o -iname ‘.h’ -o -iname ‘*.S’ ) -print0 \
    | wc -l —files0-from - | tail -n 1

    # 通过strace分析, poor-script.sh创建了成千上万的进程，good-script.sh创建了3个进程
    ```

### Strace 的重要选项  
```sh
# -e trace=file     跟踪和文件访问相关的调用(参数中有文件名)
# -e trace=process  和进程管理相关的调用，比如fork/exec/exit_group
# -e trace=network  和网络通信相关的调用，比如socket/sendto/connect
# -e trace=signal    信号发送和处理相关，比如kill/sigaction
# -e trace=desc  和文件描述符相关，比如write/read/select/epoll等
# -e trace=ipc 进程见同学相关，比如shmget等

# 绝大多数情况，我们使用上面的组合名字就够了。实在需要跟踪具体的系统调用时，可能需要注意C库实现的差异
# 我们知道创建进程使用的是fork系统调用，但在glibc里面，fork的调用实际上映射到了更底层的clone系统调用。
#    使用strace时，得指定-e trace=clone, 指定-e trace=fork什么也匹配不上。
```

### 补充：
- 当目标进程卡死在用户态时，strace就没有输出。我们需要其他的跟踪手段，比如gdb/perf/SystemTap等。
    ```sh
    # 备注：
    # 1、perf原因kernel支持
    # 2、ftrace  kernel支持可编程 
    # 3、systemtap 功能强大，RedHat系统支持，对用户态，内核态逻辑都能探查，使用范围更广
    ```





