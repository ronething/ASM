;显示0-99，每五秒显示一个
DATAS SEGMENT
	;此处输入数据段代码  
	num db 10
	count dw 1
	msg db 0dh,0ah,'$'
	
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
	;存旧中断向量
	mov al,1ch
	mov ah,35h
	int 21h
	push es
	push bx
	push ds
	mov cx,99
	;设置新中断向量
	mov dx,offset ring ;偏移地址给dx
	mov ax,seg ring ;段地址给ax
	mov ds,ax
	mov al,1ch
	mov ah,25h
	int 21h
	 
	pop ds
	in al,21h
	and al,11111110b
	out 21h,al
	sti;允许中断
	
		   mov di,250000
	delay :mov si,30000
	delay1:dec si
		   jnz delay1
		   dec di
		   jnz delay
		   
		   pop dx
		   pop ds
		   mov al,1ch
		   mov ah,25h
		   int 21h
		   
		   mov ax,4c00h
		   int 21h
	 
	MOV AH,4CH
	INT 21H
	ring proc near 
		   push ds
		   push ax
		   push dx
		   
		   mov ax,DATAS
		   mov ds,ax
		   sti
		   dec count 
		   jnz exit
		   mov ax,99
		   sub ax,cx
		   cmp ax,10
		   jb contin
		   div num
		   mov dx,ax
		   add dl,'0'
		   mov ah,02
		   int 21h
		   mov dl,dh
		   add dl,'0'
		   mov ah,02
		   int 21h
		   jmp space
   contin: mov dl,al
		   add dl,'0'
		   mov ah,02
		   int 21h
	space: lea dx,msg
		   mov ah,09
		   int 21h
		   mov count,91
		   cmp cx,0
		   jnz next
		   mov cx,100
	 next: dec cx
		   
	 exit: cli
		   pop dx       
		   pop ax
		   pop ds
		   iret 
	 ring endp
				  
	  
CODES ENDS
	END START






