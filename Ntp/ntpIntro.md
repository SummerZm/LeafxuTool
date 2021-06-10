## **ntp时间同步简介** 

### **时区的基本概念**
- GMT(Greenwich Mean Time)： 英国格林尼治平均时间。
- UTC/TUC(Universal Time Coordinated)：通用协调时。
    1. UTC在GMT后面推出，前者精度高，两者约等一个东西。

- DTS(Daylight time saving)：夏令时。
    1. 夏令时，在夏天的时候将时间，调快1个小时，已达到节约省电的目的。
    2. 不同国家对夏令时的实行，规则是不一样的。比如：几月份去调快时钟；俄罗斯使用永久夏令，中国取消使用夏令时

- CST：中国标准时间(东八区)

### **ntp 使用简介**
> 同步时间，可以使用ntpdate命令，也可以使用ntp服务。
- 方法一：使用ntpdate 比较简单。格式如下：
    ```sh
    [root@linl_C ~]# ntpdate lin_S
    23 May 19:50:44 ntpdate[7507]: step time server 10.0.0.15 offset 1.239826 sec
    # 这样的同步，只是强制性的将系统时间设置为ntp 服务器时间。只是治标不治本。所以，一般配合cron命令，来进行定期同步设置。比如，在crontab 中添加：
    [root@linl_C ~]# crontab -e
    2 0 12 * * * /usr/sbin/ntpdate lin_S
    ```
- 方法二：使用ntpd 服务进行同步。
    ```sh
    # ntpd 有一个自我保护设置：如果本机与上源时间相差太大，ntpd 不运行。所以新设置的时间服务器一定要先ntpdate 从上源取得时间初值。然后启动ntpd 服务。
    ```

### **linux修改时区**
- 通过建立软连接，修改配置文件
    ```sh
    # /etc/localtime -> /usr/share/zoneinfo/Asia/Shanghai
    ```
- 通过tzset() ，有弊端。修改全局环境变量，设备重启或者其他进程也执行了tzset()会发送覆盖修改。（不建议使用）

