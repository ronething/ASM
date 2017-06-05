;试编写一段程序，要求比较两个字符串string1和string2所含字符是否相等,
;如相等则显示“MATCH”, 若不相同则显示“NO MATCH”。
DATAS SEGMENT
	str1 db 'string1$';七个字符
	str2 db 'string1$'
	str3 db 'MATCH$'
	str4 db 'NO MATCH$'
DATAS ENDS

CODES SEGMENT
	ASSUME CS:CODES,DS:DATAS,ES:DATAS
START:
	MOV AX,DATAS
	MOV DS,AX
	MOV ES,AX
	
	MOV CX,7;七个字符
	MOV DI,OFFSET str1
	MOV SI,OFFSET str2
	cld
	;16-18也可写成如下:
	;lea di,str1+6
	;lea si,str2+6
	;std
	REPZ CMPSB
	JZ LAB1
	JNZ LAB2
	LAB1:
	MOV DX,OFFSET str3
	MOV AH,09H
	INT 21H
	MOV AH,4CH
	INT 21H
	LAB2:
	MOV DX,OFFSET str4
	MOV AH,09H
	INT 21H
	MOV AH,4CH
	INT 21H
	CODES ENDS
	END START
