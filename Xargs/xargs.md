## **xargs命令**

### **使用场景**
在使用 Linux 时，你是否遇到过需要将一些命令串在一起，但是其中一个命令不接受管道输入的情况呢？在这种情况下，我们就可以使用 xargs 命令。xargs 可以将一个命令的输出作为参数发送给另一个命令。

### **常用用法**

- **命令输出去除换行**
    ```sh
    ls -1 | xargs
    # include  jni  lib  platform  readme  src  tool
    ```

- **wc 命令计算多个文件中的单词数**
    ```sh
    ls *.c | xargs wc
    #  1255    3704   40422 ss_process_logfile.c
    #  520    1077   13608 ss_process_patch.c
    #  2120    6109   77331 ss_process_setting.c
    #  1405    3986   48079 ss_process_slave.c
    ```

- **使用带有确认消息的xargs**
    ```sh
    # -p（交互）选项来让 xargs 提示我们是否要进行下一步的操作
    echo 'one two three' | xargs -p touch
    ```

- **将xargs与多个命令一起使用**
    ```sh
    # cat directories.txt ：将 directrories.txt 文件的内容（所有要创建的目录名称）传给 xargs。
    # xargs -I % ：定义了替换字符串 %。
    # sh -c：启动一个新的子shell。-c（commond）让 shell 读取命令。
    # 'echo %; mkdir %'：每个％都会被替换为 xargs 传过来的目录名称 。echo命令打印目录名称，mkdir 命令创建目录。
    # 用directories.txt中的内容创建文件夹并打印 【同时执行echo , mkdir，体现多命令】
    ls > directories.txt
    cat directories.txt | xargs -I % sh -c 'echo %; mkdir %'
    #
    #
    ```
- **将文件复制到多个位置**
    ```sh
    # 将两个目录的名称传给 xargs 。让 xargs 一次只将其中一个参数传递给正在使用的命令。
    # 调用 cp 两次，每次各使用两个目录中的一个作为命令行参数，我们可以通过将 xargs 的 -n（max number）选项设置为 1 来实现。
    # 这里还使用了-v（verbose 详细信息）选项，让 cp 反馈正在执行的操作。
    echo ~/dir1/ ~/dir2/ | xargs -n 1 cp -v ./*.c
    # './lonbon_httpd.c' -> '/home/lb/dir1/lonbon_httpd.c'  
    # './ss_activate.c' -> '/home/lb/dir1/ss_activate.c'
    # './lonbon_httpd.c' -> '/home/lb/dir2/lonbon_httpd.c'  
    # './ss_activate.c' -> '/home/lb/dir2/ss_activate.c'
    ```
- **删除嵌套目录中的文件**
    ```sh
    # ind . -name “*.png” ：find 将从当前目录中搜索名称和 *.png 相匹配的对象，type -f 指定了只搜索文件。
    # -print0：名称将以空字符结尾，并且保留空格和特殊字符。
    # xargs -0：xargs 也将考虑文件名以空值结尾，并且空格和特殊字符不会引起问题。
    # rm -v -rf "{}"：rm 将反馈正在进行的操作（-v），递归进行操作（-r），不发送错误提示而直接删除文件（-f）。每个文件名替换 "{}"。
    find . -name "*.png" -type f -print0 | xargs -0 rm -v -rf "{}"
    ```
- **删除一种文件类型以外的所有文件**
    ```sh
    # -not 选项让 find 返回所有与搜索模式不匹配的文件名。
    # 我们此时再次使用 xargs 的 -I （初始参数）选项。这次定义的替换字符串为 {} 。这和我们之前使用的替换字符串 % 的效果是相同的。
    find . -type f -not -name "*.sh" -print0 | xargs -0 -I {} rm -v {}
    ```
- **使用Xargs创建压缩文件**
    ```sh
    find ./ -name "*.sh" -type f -print0 | xargs -0 tar -cvzf script_files.tar.gz
    ```























