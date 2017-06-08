;已定义了两个整数变量A和B,试编写程序完成下列功能：
;（1）若两个数种有一个是奇数，则将奇数存入A中，偶数存入B中；
;（2）若两个数均为奇数，则将两数均加1后存回原变量；
;（3）若两个数均为偶数，则两个变量均不改变。
DATAS SEGMENT
    ;此处输入数据段代码  
    A DW 3
    B DW 7
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
    MOV AX,A
    RCR AX,1
    JNC L2;是偶数则跳转
    MOV BX,B
    RCR BX,1
    JNC NEXT
    INC A
    INC B
    JMP NEXT;如果一开始是奇数 则加一后就变为偶数 也会在30行跳转 所以这句可加可不加
L2:
	MOV BX,B
	PUSH BX
	RCR BX,1
	JNC NEXT
	PUSH A
	PUSH B
	POP A
	POP B
NEXT:
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
