org 100h
blue macro
    pusha
    mov ax,0b800h
    mov es,ax
    mov di,0
    cld
    mov cx,2000   
    mov al,20h
    mov ah,30h
    rep stosw
    popa
endm

clrscr macro
    pusha
    mov ax,0b800h
    mov es,ax
    mov di,0
    cld
    mov cx,2000   
    mov ax,0
    rep stosw
    popa
endm
clr_pos macro y
    pusha
    mov ax,0b800h
    mov es,ax
    mov bx,80
    mov ax,y
    mul bx
    add ax,40
    shl ax,1
    mov di,ax
    mov ax,0
    stosw
    popa 
endm
clrh macro y
    pusha
    local for
    mov cx,y
    mov si,-1
for:inc si
    clr_pos si
    loop for
    popa
endm

clrhft macro from,to
    pusha
    local for
    local skip
    mov si,from  
for:
    clr_pos si
    inc si
    cmp si,to
    ja skip
    jmp for
skip:
    popa 
endm
putchar_pos macro char,y
    pusha
    mov ax,0b800h
    mov es,ax
    mov bx,80
    mov ax,y
    mul bx
    add ax,40
    shl ax,1
    mov di,ax
    mov al,char
    mov ah,14
    stosw
    popa 
endm
write_hor_pos_ft macro str,from,to,y
     pusha
     local for
     local skip
     mov si,to
     mov di,y     
for: dec si
     putchar_pos str[si],di
     inc di
     cmp si,from
     je skip
     jmp for
skip:
     popa
endm

write_hor_pos macro str,n,y
    pusha
    local for  
    mov cx,n
    mov si,n
    mov di,y
for:dec si
    putchar_pos str[si],di
    inc di
    loop for
    popa 
endm
rolstr macro inp
        local for
        pusha 
        mov cx,23
        mov si,23
        mov bl,inp[23]
for:    dec si
        mov al,inp[si]
        mov inp[si+1],al
        loop for
        mov inp[0],bl
        popa
endm
rorstr macro inp
        local for
        pusha 
        mov cx,23
        mov si,0
        mov bl,inp[0]
for:    inc si
        mov al,inp[si]
        mov inp[si-1],al
        loop for
        mov inp[23],bl
        popa
endm
jmp main
str db 'abcdefghijklmnopqrstuvwx','$'
main:
repeat:
        mov cx,24
        mov si,0
for1:   inc si
        write_hor_pos_ft str,0,si,0
        clrh si
        loop for1
      
        mov cx,24
        mov di,0
        mov bx,0
for2:   dec si
        write_hor_pos_ft str,bx,24,di
        clrhft di,24
        inc di
        inc bx
        loop for2
        jmp repeat
ret
end