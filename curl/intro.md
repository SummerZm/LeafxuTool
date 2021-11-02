## **使用 curl 发送自带头的 https 请求, 用于测试报文合法性**
- **curl -k -v -H "`cat /work/Git/huawei_Test`" https://192.168.3.208**
	1. -k or -insecuce : 跳过验证
	2. -v : 打印详细信息
	3. -H : 指定请求头
	4. 结果展示:
	```sh
		* Rebuilt URL to: https://192.168.3.208/
		*   Trying 192.168.3.208...
		* TCP_NODELAY set
		* Connected to 192.168.3.208 (192.168.3.208) port 443 (#0)
		* ALPN, offering h2
		* ALPN, offering http/1.1
		* successfully set certificate verify locations:
		*   CAfile: /etc/ssl/certs/ca-certificates.crt
		  CApath: /etc/ssl/certs
		* TLSv1.3 (OUT), TLS handshake, Client hello (1):
		* TLSv1.3 (IN), TLS handshake, Server hello (2):
		* TLSv1.2 (IN), TLS handshake, Certificate (11):
		* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
		* TLSv1.2 (IN), TLS handshake, Server finished (14):
		* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
		* TLSv1.2 (OUT), TLS change cipher, Client hello (1):
		* TLSv1.2 (OUT), TLS handshake, Finished (20):
		* TLSv1.2 (IN), TLS handshake, Finished (20):
		* SSL connection using TLSv1.2 / ECDHE-RSA-AES128-GCM-SHA256
		* ALPN, server did not agree to a protocol
		* Server certificate:
		*  subject: C=GB; L=China; O=Golanggrpc; CN=localhost
		*  start date: Aug 28 09:57:08 2021 GMT
		*  expire date: Aug 26 09:57:08 2031 GMT
		*  issuer: C=GB; L=China; O=Golanggrpc; CN=localhost
		*  SSL certificate verify result: self signed certificate (18), continuing anyway.
		> GET / HTTP/1.1
		> Host: 172.31.11.67\r\n
		> User-Agent: HTTP·Test Suite TestSuite/1.0.59901 (X11; U; Linux·x86_32; en-US;·rv:1.8.0.10) (Test case number:59901)\r\n
		> Accept: text/xml,application/%a%#f%@%@%+i%#f%#f%a%#f%@%@%+i%#[not showing 468 anomaly octets],application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5\r\n
		> Accept-Language: en-us,en;q=0.5\r\n
		> Accept-Encoding: gzip,deflate\r\n
		> Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7\r\n
		> Keep-Alive: 300\r\n
		> Connection: keep-alive\r\n\r\n
		> User-Agent: curl/7.58.0
		> Accept: */*
		>
		* HTTP 1.0, assume close after body
		< HTTP/1.0 200 OK
		< Access-Control-Allow-Origin: *
		< Cache-control: no-cache
		< Pragma: no-cache
		< Expires: "Mon, 06 Jan 1990 00:00:01 GMT"
		< X-Frame-Options: SAMEORIGIN
		< Content-Length: 5645
		< Content-type: text/html;charset=gb2312
		<
		<html>
		<head>
	```
