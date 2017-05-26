DATAS SEGMENT
    ;此处输入数据段代码  
    string db 'BASED ADDRESSING','$'
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
    dw 20h dup(?)
    top label word
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
    
	p proc far 
    MOV AX,DATAS
    MOV DS,AX
    
    mov ax,stacks
    
    mov ss,ax;堆栈段地址
    
    lea sp,top;堆栈偏移地址
    
     ;cx计数字符个数,si定位到最后一个字符
    lea si,string
    mov cx,0
L1:
	;比较是否到字符串尾
	
	cmp BYTE PTR [si],"$"
	je input
	inc si
	inc cx
	jmp L1
	
input:
	;指向最后一个字符
	
	lea si,string
	add si,cx
	dec si
L2:
	;从后往前输出字符

	mov dl,[si]
	mov ah,02h
	int 21h
	dec si
	loop L2
	
exit:
	;返回终止码
    
    MOV AH,4CH
    INT 21H
    p endp
    
CODES ENDS
    END p
