;有一个首地址为mem的100个字的数组，试编制程序删除数组中所有为零的项
;并将后续项向前压缩，最后将数组的剩余部分补上零。
DATAS SEGMENT
	;此处输入数据段代码  
	mem dw 10 dup(0,2,3,0,5,6,0,8,9)
	count dw ($-mem)/2
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
	
	lea di,mem-2 ;先减掉再恢复
	mov cx,count
L:			 ;找0
	cmp cx,0
	jz next
	add di,2
	mov ax,[di]
	dec cx
	cmp ax,0
	jnz L
	
	mov si,di
	push cx

L2:			;找非0
	cmp cx,0
	jz next
	add si,2
	mov ax,[si]
	dec cx
	cmp ax,0
	jz L2
	
	mov [di],ax
	mov word ptr [si],0
	pop cx
	jmp L

next:  
	MOV AH,4CH
	INT 21H
CODES ENDS
	END START