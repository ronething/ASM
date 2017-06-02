DATAS SEGMENT
	;此处输入数据段代码  
	String db 128,?,128 dup('$')
	crlf db 0dh,0ah,24h
	count dw 0
	num dw 0
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
	lea dx,string
	mov ah,0ah;具体见dos功能调用表
	int 21h
	
	lea dx,crlf;换行
	mov ah,09h
	int 21h
	lea si,String+1 
	mov cl,[si];cx存放字符串个数
	mov ch,0
	
	lea di,String+2

L1:
	mov al,[di]
	inc di
	cmp al,30h
	jl L2
	cmp al,39h
	jg L2
	dec num ;如果是数字，就先减后加 结果不变
	
L2:
	inc num 
	loop L1
	
	mov cx,0
	mov ax,num

L3:
	mov bl,10
	div bl
	push ax
	inc cx;记录余数的个数
	mov ah,0
	cmp al,0
	jnz L3

L4:
	pop dx
	mov dl,dh
	add dl,30h
	mov ah,2
	int 21h
	loop L4
	
	
	MOV AH,4CH
	INT 21H
CODES ENDS
	END START