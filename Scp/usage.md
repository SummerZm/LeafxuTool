## **scp 常见用法简介**

### **脚本中免密上传文件
- **例子: sshpass -p password scp scrfile root@192.168.3.247:/targetfile**
```sh
# 将以下代码放到 ~/.bash_profile文件下，可自定义成通用的命令
zmMcudeploy(){
    sshpass -p 123456 scp conference root@192.168.3.247:/usr/local/sbin/$1
}s
```







