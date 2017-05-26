DATAS SEGMENT
    ;此处输入数据段代码 
    array1  db 40 dup(?) 
    array2  db 40 dup(?) 
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
    MOV SI,0
    MOV CX,1
AGAIN: 
	MOV DI,0
	MOV DX,CX
	MOV AX,CX
AGA:
	MOV BL,10
	DIV BL
	MOV CX,AX
	MOV Ax,DI
	ADD AH,CH
	MOV DI,AX
	
	CMP CL,0
	MOV AL,CL
	MOV AH,0
	JG AGA
	;MOV AX,DI
	MOV AX,DI
	MOV AL,AH
	MOV AH,0
	MOV BL,5
	DIV BL
	CMP AH,0
	
	
	JG AGAIN2
	mov cx,dx
	mov array1[si],dl
	inc si
AGAIN2:
	MOV CX,DX
	inc CX
	cmp cx,201
	JNZ AGAIN
	MOV AX,SI
	mov cx,si
	mov di,-1
	again3:
	dec si
	inc di
	mov al,array1[di]
	mov array2[si],al
	
	loop again3
	
  
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
