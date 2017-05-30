DATAS SEGMENT
	;此处输入数据段代码  
	string db "zabcdefghijklmnopqrstuvwxyza"
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
	
	lea di,string
	
	mov ah,1
	int 21h
Loop1:
	inc di;先自增1,第一个的地址就是指向'a',而不是'z'
	cmp al,[di]
	jnz Loop1
	
	dec di ;找到之后减一 即是前导字母的地址
	
	mov cx,3
Loop2:
	mov dl,[di]
	inc di
	mov ah,2
	int 21h
	loop Loop2
	
	MOV AH,4CH
	INT 21H
CODES ENDS
	END START