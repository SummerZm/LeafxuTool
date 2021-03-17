## **lsof使用简介**

- **以文件为核心**
	```sh
	# 【文件目录】		lsof +d /DIR/ 显示目录下被进程打开的文件
	# 【文件名】		lsof filename 显示打开指定文件的所有进程
	# 【文件描述符】	lsof -d FD 显示指定文件描述符的进程
	```

- **以用户为核心**
	```sh
	# 【用户名称】		lsof -u username 显示所属user进程打开的文件 
	# 【组ID】			lsof -g gid 显示归属gid的进程情况
	
	```

- **以其他为核心**
	```sh
	# lsof -i[46] [protocol][@hostname|hostaddr][:service|port]
	#	46			-->		IPV4 or IPV6
	#	protocol 	-->		TCP or UDP
	#	hostname	-->		Internet host name 
	#	hostaddr 	-–>		IPv4地址
	#	service 	-–>		/etc/service中的 service name (可以不只一个)
	#	port 		-–>		端口号 (可以不只一个)
	#

	#【超实用】			lsof -i :22 -i :80  查看22端口现在运行的情况 
	#
	
	# lsof -a 表示两个参数都必须满足时才显示结果
	# lsof -c string 显示COMMAND列中包含指定字符的进程所有打开的文件
	```

- **适用场景**
	```sh
	# 查看所属root用户进程所打开的文件类型为txt的文件: # lsof -a -u root -d txt
	# lsof filename.txt 显示开启文件filename.txt的进程
	# lsof -i :22 知道22端口现在运行什么程序
	# lsof -c abc 显示abc进程现在打开的文件
	# lsof -g gid 显示归属gid的进程情况
	# lsof +d /usr/local/ 显示目录下被进程开启的文件
	# lsof +D /usr/local/ 同上，但是会搜索目录下的目录，时间较长
	# lsof -d 4 显示使用fd为4的进程
	# lsof -i 用以显示符合条件的进程情况	
	```

- **使用场景**
	```sh
	# 当系统中的某个文件被意外地删除了，只要这个时候系统中还有进程正在访问该文件，那么我们就可以通过lsof从/proc目录下恢复该文件的内容。
	# 假如由于误操作将/var/log/messages文件删除掉了，那么这时要将/var/log/messages文件恢复的方法如下：
	#
	# 首先使用lsof来查看当前是否有进程打开/var/logmessages文件，如下：
	# lsof |grep /var/log/messages
	# syslogd 1283 root 2w REG 3,3 5381017 1773647 /var/log/messages (deleted)
	# 从上面的信息可以看到 PID 1283（syslogd）打开文件的文件描述符为2。同时还可以看到/var/log/messages已经标记被删除了。
	#
	# 如果可以通过文件描述符查看相应的数据，那么就可以使用 I/O 重定向将其复制到文件中，
	# 如: cat /proc/1283/fd/2 > /var/log/messages
	```


























