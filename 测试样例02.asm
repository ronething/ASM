DATAS SEGMENT
    ;此处输入数据段代码  
    
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
    mov ah,01h
    int 21h
    mov bl,al
    mov ah,01h
    int 21h
    add bl,al
    sub bl,30h
    mov dl,bl
    mov ah,02h
    int 21h
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
    




