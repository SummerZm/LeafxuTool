
## 1. 扫描指定主机端口
- 命令： nc -v -w 2 192.168.1.34 -z 21-24
    1. -v：显示执行流程，可用于debug
    2. -w: 设置超时时间，单位：sec
    3. -z: 使用0输入/输出模式，只在扫描通信端口时使用
    
    ```
    nc: connect to 192.168.1.45 port 21 (tcp) failed: Connection refused
    Connection to 192.168.1.45 22 port [tcp/ssh] succeeded!
    nc: connect to 192.168.1.45 port 23 (tcp) failed: Connection refused
    nc: connect to 192.168.1.45 port 24 (tcp) failed: Connection refused
    ```

## 2. TCP聊天工具
- 服务端命令： nc -l 8686
    1. -l: 监听端口

- 客户端命令： nc target-IP 8686

## 3. HTTP命令
- 建立连接： nc target-IP 80
- 例子： echo -n "GET / HTTP/1.0"r"n"r"n" | nc target-IP 80
    ```
    HTTP/1.0 401 Unauthorized
    Cache-Control: no-cache
    Pragma: no-cache
    WWW-Authenticate: Basic realm= /
    Content-Length: 23
    Content-type: text/html

    <Html><Head><Title>Unauthorized</Title></Head><Body><script>top.window.document.write("<BR><H1>Authentication Failed!!!</H4><BR><BR><li><H3>User name and password are upper/lower case sensitive.</H3></li>");</script></Body></Html>
    ```

## 4. UDP连接：向某个主机端口建立
- 命令：nc -u 192.168.1.200 5500
- 例子：echo "Action:AppNotify\r\nInterCmd:DataListGet\r\n" | nc -u 192.168.1.200 5500

## 5. 传输文件
- 接收端： nc -l 4444 > fileName
- 发送端： cat file | nc 192.168.1.45 4444


