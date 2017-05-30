DATAS SEGMENT
	up db 0
	down db 0
	array db 128 dup(41h,43h);100H字节的数组
DATAS ENDS

STACKS SEGMENT
	;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
	ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
	MOV AX,DATAS
	MOV DS,AX

	mov cx,256;把循环次数100放入cx
	mov bx,0
	mov dh,0
	mov dl,0;初始化
	again:
		  cmp array[bx],42h
		  jbe blow;如果小于等于42h就跳转到blow
		  inc dh;如果大于42h就执行指令:dh+1
		  jmp next
	blow:
		  je next;如果等于42h就跳转到next
		  inc dl;小于42h就执行:dl+1
	next:
		  add bx,1
		  dec cx
		  jnz again;这两句是一起使用来跳转到循环语句之前重新循环的
		  mov up,dh
		  mov down,dl
	;此处输入代码段代码
	MOV AH,4CH
	INT 21H
CODES ENDS
	END START
