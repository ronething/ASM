;从键盘接收用户输入并把内容保存在myfile1.txt中，关闭此文件并将属性修改为只读
;再次打开此文件，创建myfile2.txt，对myfile1加密 “大写字母改为小写，a和z互换,b和y互换（以此类推）”
DATAS SEGMENT
FILENAME1  DB   'MYFILE1.TXT',0     ;ASCIIZ串
FILENAME2  DB   'MYFILE2.TXT',0 
HANDLE1    DW   ?                ;保存文件句柄单元
HANDLE2    DW   ?  
BUFFER     DB    1  DUP (?)    ;读写缓冲区      
LEN        DW    ?            ;保存实际读入长度单元
ERR1     DB   'Can Not create File !',0DH,0AH,'$' 
ERR2     DB   'Can Not open file !',0DH,0AH,'$'
ERR3     DB   'Reading File Wrong !',0DH,0AH,'$'
ERR4     DB   'Writing File Wrong !',0DH,0AH,'$'
DATAS ENDS

STACKS SEGMENT
	;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
	ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
	MOV AX,DATAS
	MOV DS,AX
	;新建myfile1
	mov ah,3ch
	lea dx,FILENAME1
	mov cx,0
	int 21h
	jc error1
	mov HANDLE1,ax
	;输入数据
	input: mov ah,01h
		   int 21h
		   mov BUFFER,al
		   cmp BUFFER,0dh
		   je endinput
		   mov ah,40h
		   lea dx,BUFFER
		   mov bx,HANDLE1
		   mov cx,1
		   int 21h
		   jmp input
		   ;关闭myfile1,设置成只读
  endinput:mov ah,3eh
		   mov bx,HANDLE1
		   int 21h
		   mov ah,43h
		   mov al,1
		   mov cx,01
		   int 21h
		   
			
	
 
	;创建myfile2
	mov ah,3ch
	lea dx,FILENAME2
	mov cx,0
	int 21h 
	jc error1
	mov HANDLE2,ax
	;打开myfile2
	mov ah,3dh
	lea dx,FILENAME1
	mov al,0
	int 21h
	jc error2
	mov HANDLE1,ax
	;将myfile1加密复制到myfile2
	again:mov ah,3fh
		  lea dx,BUFFER
		  mov bx,HANDLE1
		  mov cx,1
		  int 21h
		  jc  error3
		  
		  cmp ax,0;比较是否读完数据
		  je l0
		  mov bl,BUFFER
		  cmp bl,'z'
		  ja wrong 
		  cmp bl,'a'
		  jnb lock1
		  cmp bl,'A'
		  jb wrong 
		  cmp bl,'Z'
		  jnb wrong
	  
		  add bl,'a'-'A';大写转小写
		  lock1:
		  sub bl,'a'
		  mov dl,7Ah
	   
		  sub dl,bl;加密存在dl
		  mov BUFFER,dl
		  wrong:
		  mov ah,40h
		  lea dx,BUFFER
		  mov cx,1
		  mov bx,HANDLE2
		  int 21h
		  jc error4
		  jmp again
	
	
	l0:mov ah,3eh
	   mov bx,HANDLE2
	   int 21h
	l1:mov ah,3eh
	   mov bx,HANDLE1
	   int 21h  
	 
	exit: 
	MOV AH,4CH
	INT 21H
	 
	error1:lea dx,ERR1 
		   mov ah,09
		   int 21h
		   jmp l0
		 
	error2:lea dx,ERR2 
		   mov ah,09
		   int 21h
		   jmp l0
	error3:lea dx,ERR3 
		   mov ah,09
		   int 21h
		   jmp l0
	error4:lea dx,ERR4
		   mov ah,09
		   int 21h
		   jmp l0
CODES ENDS
	END START






