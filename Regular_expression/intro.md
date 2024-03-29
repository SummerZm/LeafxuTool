## **正则表达式简介** ##

### ***历史背景*** ###
- 美国新泽西州的Warren McCulloch和出生在美国底特律的Walter Pitts这两位神经生理方面的科学家，研究出了一种用数学方式来描述神经网络的新方法。
- 1951年, 数学科学家Stephen Kleene，他在Warren McCulloch和Walter Pitts早期工作的基础之上，发表了一篇《神经网事件的表示法》论文，引入了正则表达式的概念。

### **正则引擎分类** ###
> DFA, NFA这两种引擎都有了很久的历史(至今二十多年)  

- DFA
- 传统型NFA
- POSIX NFA。

### **DFA引擎** ###
- DFA 引擎在线性时状态下执行，因为它们不要求回溯（并因此它们永远不测试相同的字符两次）
- DFA 引擎可以确保匹配最长的可能的字符串 
- DFA 引擎只包含有限的状态，所以它不能匹配具有反向引用的模式；并且因为它不构造显示扩展，所以它不可以捕获子表达式。

### **NFA** ###
- 传统的 NFA 引擎运行“贪婪的”匹配回溯算法，它可以捕获子表达式匹配和匹配的反向引用。
- 在最坏情况下，它的执行速度可能非常慢
- 传统的 NFA 接受它找到的第一个匹配，所以它还可能会导致其他（可能更长）匹配未被发现。

### **POSIX NFA** ###
- POSIX NFA 引擎与传统的 NFA 引擎类似
- 不同的一点在于：在它们可以确保已找到了可能的最长的匹配之前，它们将继续回溯
- POSIX NFA 引擎的速度慢于传统的 NFA 引擎

### **应用场景**
- FA引擎的程序主要有：awk,egrep,flex,lex,MySQL,Procmail等；
- 传统型NFA引擎的程序主要有：GNU Emacs,Java,ergp,less,more,.NET语言,PCRE library,Perl,PHP,Python,Ruby,sed,vi；
- POSIX NFA引擎的程序主要有：mawk,Mortice Kern Systems’ utilities,GNU Emacs(使用时可以明确指定)；
- DFA/NFA混合的引擎：GNU awk,GNU grep/egrep,Tcl。

### **NFA与DFA工作的区别** ###
```sh
# 字符串: this is yansen’s blog
# 正则表达式: /ya(msen|nsen|nsem)/

# NFA工作方式: 【以正则表达式为标准，反复测试字符串，同一个字符可能被多次测试】
1. 先在字符串中查找 y 然后匹配其后是否为 a
2. 如果是 a 则继续，查找其后是否为 m 如果不是则匹配其后是否为 n (此时淘汰msen选择支)
3. 然后继续看其后是否依次为 s,e，接着测试是否为 n ，是 n 则匹配成功，不是则测试是否为 m 

# DFA工作方式：【以文本为主导】
1. 从 this 中 t 开始依次查找 y，定位到 y ，已知其后为a，则查看表达式是否有 a ，此处正好有a 。然后字符串a 后为n
2. 然后DFA依次检查字符串，检测到sen 中的 n 时只有nsen 分支符合，则匹配成功！

# 总结： 一般而论，DFA引擎则搜索更快一些！但是NFA以表达式为主导，反而更容易操纵
```

### **正则表达式表示** ###
- {}：表示重复次数
    ```sh
    # ?,*,+,\d,\w 都是等价字符
    # ?等价于匹配长度{0,1}
    # *等价于匹配长度{0,}
    # +等价于匹配长度{1,}
    ```
- []: 表示字符集合
    ```SH
    # [abc]
    # [^abc]
    # [a|b|c]
    ```
- (): 一个正则子匹配
