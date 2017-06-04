;在首地址为DATA的字数组中，存放了100H个16位补码数
;试编写一个程序，求出它们的平均值放在AX寄存器中；并求出数组中有多少个数小于此平均值，将结果放在BX寄存器中。
DATAS SEGMENT
	;此处输入数据段代码  
	sum dw 0
	less dw 0
	data dw 64 dup(1,3,3,5)
	count dw ($-data)/2
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
	
	mov dx,0
	mov ax,0
	mov cx,count
	lea si,data
L:
	mov bx,[si]
	add ax,bx
	add si,2
	loop L
	
	mov sum,ax
	
	mov bx,count
	div bx
	lea si,data
	mov cx,count
	mov bx,0

L2:
	mov dx,[si]
	cmp dx,ax
	jnl L3
	inc bx
	
L3:
	add si,2
	loop L2
	
	mov less,bx
	
	MOV AH,4CH
	INT 21H
CODES ENDS
	END START
