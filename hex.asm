.model small 
.stack 100h        ; Added stack segment declaration 
.data 
        m1 db 10,13,"Enter 4 Digit Hex Number: $"  ; Added carriage return 
        m2 db 10,13,"Equivalent BCD Number: $"    ; Added carriage return 
        num dw 0000h 
        arr db 5 dup(0) 
        count db 00h 
 
.code 
        mov ax,@data 
        mov ds,ax 
 
        lea dx,m1 
        mov ah,09h 
        int 21h 
 
        mov ch,04h 
loop1:  mov ah,01h 
        int 21h 
        cmp al,39h 
        jbe skip1 
        sub al,07h 
skip1:  sub al,30h 
        mov cl,04h       ; Using CL for shift count 
        mov ah,00h 
        mov bx,num       ; Temporary storage 
        shl bx,cl        ; Shift left 4 bits 
        add bx,ax 
        mov num,bx 
        dec ch 
        jnz loop1 
 
        mov ax,num 
        mov dx,0000h 
        mov bx,000Ah 
        lea si,arr 
 
loop2:  div bx 
        mov [si],dl      ; Store remainder (DL contains remainder) 
        inc si 
        inc count 
        mov dx,0000h 
        cmp ax,0000h 
        jnz loop2 
 
        lea dx,m2 
        mov ah,09h 
        int 21h 
        dec si 
        mov ch,count 
loop3:  mov dl,[si] 
        add dl,30h       ; Convert to ASCII 
        mov ah,02h 
        int 21h 
        dec si 
        dec ch 
        jnz loop3 
 
        mov ah,4Ch 
        int 21h 
 
end