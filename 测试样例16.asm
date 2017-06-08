;试编写一个程序，要求比较数组ARRAY中的三个16位补码数，并根据比较结果在终端上显示如下信息：
;（1）如果三个数都不相等则显示0；
;（2）如果三个数有两个相等则显示1；
;（3）如果三个数都相等则显示2。
DATAS SEGMENT
    ;此处输入数据段代码  
    array dw -1,11,1
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    
    mov cx,0
    lea si,array
    add si,2
    mov ax,[si]
    mov bx,[si-2]
    cmp ax,bx
    jnz L1
    inc cx
L1:
	mov bx,[si+2]
	cmp ax,bx
	jnz L2
	inc cx
L2:
	mov dl,cl
	add dl,30h
	mov ah,2
	int 21h
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

