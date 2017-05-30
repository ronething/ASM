DATAS SEGMENT
	;此处输入数据段代码  
	clf db 0ah,0dh,"$"
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
	
	xor ax,ax
	mov ah,01
	int 21h
	
	lea dx,clf
	mov ah,09
	int 21h
	
	sub al,32D
	mov dl,al
	mov ah,02
	int 21h
	MOV AH,4CH
	INT 21H
CODES ENDS
	END START