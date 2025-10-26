.model small 
.stack 100h 
.data 
msg1 db 'Enter first digit: $' 
msg2 db 0Dh,0Ah,'Enter second digit: $' 
msg3 db 0Dh,0Ah,'Sum = $' 
 
.code 
main proc 
    mov ax, @data 
    mov ds, ax 
 
    ; Ask first number 
    mov ah, 9 
    mov dx, offset msg1 
    int 21h 
 
    ; Read first digit 
    mov ah, 1 
    int 21h           ; AL = ASCII of digit 
    sub al, 30h       ; convert ASCII -> number 
    mov bl, al        ; store in BL 
 
    ; Read and discard Enter key 
    mov ah, 1 
    int 21h           ; just eats Enter, ignore result 
 
    ; Ask second number 
    mov ah, 9 
    mov dx, offset msg2 
    int 21h 
 
    ; Read second digit 
    mov ah, 1 
    int 21h           ; AL = ASCII of digit 
    sub al, 30h       ; convert ASCII -> number 
    mov bh, al        ; store in BH 
 
    ; Add numbers 
    mov al, bl 
    add al, bh        ; AL = BL + BH 
 
    ; Convert result to ASCII 
    add al, 30h 
 
    ; Print message 
    mov ah, 9 
    mov dx, offset msg3 
    int 21h 
 
    ; Print sum 
    mov dl, al 
    mov ah, 2 
    int 21h 
 
    ; Exit 
    mov ah, 4Ch 
    int 21h 
 
main endp 
end main