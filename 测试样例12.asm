;从键盘上输入一串字符（用回车键结束，使用10号功能调用。）放在STRING中
;试编制一个程序测试字符串中是否存在数字。如有，则把CL的第5位置1，否则将该位置置0。
DATAS SEGMENT
	;此处输入数据段代码 
	liu db 0
	string db 128,?,128 dup('$')
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
	mov ah,0ah
	int 21h
	
	lea si,string+1
	mov cl,[si]
	mov ch,0
	inc si
	
L:
	mov al,[si]
	cmp al,30h	
	jl L1
	cmp al,39h
	jg L1
	or cl,00100000b
	mov liu,cl
	jmp next
L1:
	inc si
	loop L
	and cl,0dfh
	;39行其实这句不用也可以。检查到最后没有cx就是0了
	;cl第五位置其实就是0
next:
	MOV AH,4CH
	INT 21H
CODES ENDS
	END START
