.model small 
.data 
a dw 01211H 
b dw 00011H 
.code 
mov ax, @data        
mov ds, ax           
mov ax, a            
mov bx, b            
add ax, bx           
mov ch, 04h          
mov cl, 04h          
mov bx, ax           
l2: rol bx, cl       
mov dl, bl           
and dl, 0Fh          
cmp dl, 09           
jbe l4               
add dl, 07           
l4: add dl, 30H      
mov ah, 02           
int 21H 
dec ch               
jnz l2               
mov ah, 4CH          
int 21H 


end