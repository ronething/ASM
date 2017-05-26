DATAS SEGMENT
    ;此处输入数据段代码  
    ARRAY DW 4 DUP(?);存输入的四个字符
    ARRAY1 DB 'illegal input $';23个字符
DATAS ENDS
EXTRA SEGMENT
     ARRAY2 DB 10 DUP(?)
	EXTRA ENDS
STACKS SEGMENT
    ;此处输入堆栈段代码
    DW 30 DUP(?)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS,ES:EXTRA
    
    BIGGER:
    SUB BX,32
    MOV [SI],BX
    JMP BACK1
    
    
    ILLEGAL:
    A1:
    LEA DX,ARRAY1
    MOV AH,09H
    INT 21H
    MOV AH,4CH
    INT 21H 
    
    ;将大于等于'A'的字符转化成数
    A3:
    SUB BX,'A'
    ADD BX,10
    JMP BACK2
   
   
    
    
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    MOV SI,0
    MOV CL,4
    INPUT:
    MOV AH,01H
    INT 21H
    MOV AH,0
    MOV [SI],AX
    ADD SI,2
    CMP SI,8
    JNZ INPUT
    ;将所有字符转化成大写
    MOV SI,0
    A0:
    MOV BX,[SI]
    CMP BX,'a'
    JNB BIGGER
    BACK1:
    ADD SI,2
    CMP SI,8
    JNZ A0
    ;判断是否合法
    MOV SI,0
    IS_LEGAL:
    MOV AX,[SI]
    CMP AX,'0'
    JB ILLEGAL
    CMP AX,'9'
    JBE LEGAL
    CMP AX,'A'
    JB ILLEGAL
    CMP AX,'F'
    JA ILLEGAL
    ADD SI,2
    CMP SI,8
    JNZ IS_LEGAL
    LEGAL:
    ;将四个字符转化成对应的十六进制数
    MOV SI,0
    MOV AX,0
    A2:
    MOV BX,[SI]
    CMP BX,'A'
    JNB A3
     ;将大于等于'0'的字符转化成数
    SUB BX,'0'
    BACK2:
    SHL AX,CL
    ADD AX,BX
    ADD SI,2
    CMP SI,8
    JNZ A2
   
    ;将十六进制数转化成十进制数
    MOV BX,AX
    CMP BX,0
    JGE NONEG
    MOV AH,02
    MOV DL,'-';先输出负号
    INT 21H
    NEG BX;求绝对值
    NONEG:
    MOV DI,0
  	MOV AX,BX
  	MOV DX,0
  	MOV CX,10D
     AGAIN:
  	DIV CX
  	MOV BYTE PTR ES:[DI],DL
  	INC DI
  	MOV DX,0
  	CMP AX,0
    JNE AGAIN
  	OUTPUT:
  	DEC DI
  	MOV DL,BYTE PTR ES:[DI]
  	ADD DL,'0'
  	MOV AH,02H
  	INT 21H
  	CMP DI,0
  	JNE OUTPUT
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
