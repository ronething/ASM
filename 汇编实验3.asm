DATAS SEGMENT
     S1 DB ' illegal input $';16
     S2 DB 10 DUP(?)
DATAS ENDS

STACKS SEGMENT
     DW 30 DUP(?)
STACKS ENDS
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
    ;不符合条件输出" illegal input "
    exit0:
    lea dx,S1
    mov ah,09h
    int 21h
    MOV AH,4CH
    INT 21H
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码


    mov bx,0 ;装中间值的寄存器
    mov cx,4 ;四次循环
input0:
    mov ah,01
    int 21h
    cmp al,'0'
    jb exit0 ;比‘0’小 不符合条件
    cmp al,'9'
    jbe legal0 ;说明为0-9的数 跳到 legal0 处理
    cmp al,'a'
    jb nosub;比'a'小 说明可能是大写 或者 不符合
    sub al,'a'-'A' ;比'a'大 转成大写字母 (减去'A')可能符合也可能不符合
    nosub:
    cmp al,'A'
    jb exit0 ;如果比'A'小则不符合条件 退出
    cmp al,'F'
    ja exit0;如果比'F'大则不符合条件 退出
    sub al,7 ;变为数值的ascii '9'=57 'A'=65
legal0:
    sub al,'0'
    push cx ;保护cx中的值
    mov cl,4
    shl bx,cl;逻辑左移
    ADD BL,AL
    pop cx
    loop input0
    ;开始转换
    CMP BX,0
    JGE NONEG;bx大于0则跳转 到 NONEG
    MOV AH,02
    MOV DL,'-';小于0则先显示一个负号即是'-'
    INT 21H
    NEG BX ;求补
NONEG:
    MOV AX,BX
    LEA SI,S2;si而不是s1,偏移地址给s2
    MOV CX,10D
    MOV DX,0
DIVIDE:
    DIV CX;除数为cx 被除数为（dx,ax） 商为ax，余数为dx
    MOV [SI],DL;定义的是字节 传送字节
    INC SI 
    MOV DX,0
    CMP AX,0 ;(dx,ax)置为0
    JNE DIVIDE
OUTPUT:
    DEC SI
    MOV DL,[SI]
    ADD DL,'0';把数值转化成字符
    MOV AH,02H
    INT 21H
    CMP SI,16;之所以是16是因为s2放在s1之后 而 s1 占16个字节
    JNE OUTPUT
    
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
