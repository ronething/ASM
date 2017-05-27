;比较两个十进制数字 谁大输出谁
DATAS SEGMENT
	string db "error input",'$'
DATAS ENDS

STACKS SEGMENT
	dw 100 dup(?)
	tos label word
STACKS ENDS

CODES SEGMENT
	 
	ASSUME CS:CODES,DS:DATAS,SS:STACKS
 
main proc far
 
	mov ax,stacks
	mov ss,ax;堆栈段地址
	mov sp,offset tos;堆栈偏移地址
	sub ax,ax
	push ax
	
	MOV AX,DATAS
	MOV DS,AX
   
	input:   mov ah,01
			 int 21h
			 cmp al,'0'
			 jb exit ;小于'0'退出
			 cmp al,'9'
			 ja exit;大于'9'退出
			 sub al,'0'
			 cbw ;拓展到字	AL—>AX
			 ;执行操作： 若(AL)的最高有效位为0，则(AH)= 00H
			 ;           若(AL)的最高有效位为1，则(AH)= FFH
			 
			 push ax
			 
			 mov ah,01
			 int 21h
			 cmp al,'0'
			 jb exit
			 cmp al,'9'
			 ja exit
			 sub al,'0'
			 cbw
			 ;换行
			 push ax
			 mov dl,0ah
			 mov ah,02h
			 int 21h
			 
			 
			 call near ptr compare
			 
			 mov ah,4ch
			 int 21h
			 
			 exit:   mov dx,offset string 
			 mov ah,09h
			 int 21h
			 
			 main endp
	;定义子程序
	compare proc near 
			 push bp
			 mov bp,sp
			 push si
			 push di
			 mov ax,[bp+6];取到第一个输入的字符
			 mov bx,[bp+4];取到第二个输入的字符
			 cmp ax,bx
			 jb less;第一个小于第二个
			 mov dl,al
			 jmp big
	less:	
			 mov dl,bl
	big:
			 mov ah,02h
			 add dl,'0'
			 int 21h
			
			 pop di
			 pop si
			 pop bp
			 
			 ret 4
			 
			 compare endp
			  
	 
			
CODES ENDS
	END main




