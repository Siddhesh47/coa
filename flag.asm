.MODEL SMALL
.STACK 100H
.DATA
MSG DB '8086 Flags (CF..OF): $'
.CODE
START:
    MOV AX,@DATA
    MOV DS,AX

    ; Display header
    LEA DX, MSG
    MOV AH,09H
    INT 21H

    PUSHF           ; Push flags
    POP AX          ; AX = flags

    MOV CX,16       ; Loop 16 bits
    MOV BX,AX       ; Copy flags

SHOW_FLAGS:
    ROL BX,1        ; Rotate left through carry
    JC ONE
    MOV DL,'0'
    JMP PRINT
ONE:
    MOV DL,'1'
PRINT:
    MOV AH,02H
    INT 21H
    LOOP SHOW_FLAGS

    ; Exit program
    MOV AH,4CH
    INT 21H
END START