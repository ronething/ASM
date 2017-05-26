DATAS SEGMENT
     S1 DB ' illegal input $';16
     S2 DB 10 DUP(?)
DATAS ENDS

STACKS SEGMENT
     DW 30 DUP(?)
STACKS ENDS
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
    exit0:
    lea dx,emsg
    mov ah,09h
    int 21h
    MOV AH,4CH
    INT 21H
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    mov ax,datas
    mov ds,ax
    mov bx,0 ;装中间值的寄存器
    mov cx,4 ;四次循环
    input0:
    mov ah,01
    int 21h
    cmp al,'0'
    jb exit0
    cmp al,'9'
    jbe legal0 ;说明为0-9的数
    cmp al,'a'
    jb nosub
    sub al,'a'-'A'
    nosub:
    cmp al,'A'
    jb exit0
    cmp al,'F'
    ja exit0
    sub al,7 ;变为数值的ascii
    legal0:
    sub al,'0'
    push cx ;保护cx中的值
    mov cl,4
    shl bx,cl
    ADD BL,AL
    pop cx
    loop input0
    ;开始转换
    CMP BX,0
    JGE NONEG
    MOV AH,02
    MOV DL,'-'
    INT 21H
    NEG BX
    NONEG:
    MOV AX,BX
    LEA SI,S2
    MOV CX,10D
    MOV DX,0
    DIVIDE:
    DIV CX
    MOV [SI],DL
    INC SI 
    MOV DX,0
    CMP AX,0
    JNE DIVIDE
    OUTPUT:
    DEC SI
    MOV DL,[SI]
    ADD DL,'0';把数值转化成字符
    MOV AH,02H
    INT 21H
    CMP SI,16
    JNE OUTPUT
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
