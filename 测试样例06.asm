DATAS SEGMENT
    ;此处输入数据段代码  
    M db 5 dup(-1,1,1,3)
    P dw 0
    N dw 0
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
    
    
    lea si,M
    mov cx,20
    
L:
	mov al,[si]
	cmp al,0
	jl below
	jg large
	jmp L1
below:
	inc N
	jmp L1
large:
	inc P
	jmp L1
	
L1:
	inc si
	loop L
	
	mov ax,P ;输出P
	mov bl,10
	div bl
	mov bh,ah
	mov dl,al
	add dl,30h
	mov ah,02
	int 21h
	mov dl,bh
	add dl,30h
	mov ah,02
	int 21h
	
	mov ax,N ;输出N
	mov bl,10
	div bl
	mov bh,ah
	mov dl,al
	add dl,30h
	mov ah,02
	int 21h
	mov dl,bh
	add dl,30h
	mov ah,02
	int 21h
	
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


