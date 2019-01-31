org 100h
new_line macro
        local str,next
        push ax
        push dx
        jmp next
str db 13,10,'$'
next:   mov ah,9
        lea dx,str
        int 21h
        pop dx
        pop ax
endm

write_msg macro msg
        local str,around
        push dx
        push ax
        new_line
        jmp around
str db msg,'$'
around: mov ah,9
        lea dx,str
        int 21h
        pop ax
        pop dx
endm
putchar macro char
        push ax
        push dx
        mov ah,2
        mov dl,char
        int 21h
        pop dx
        pop ax
endm
        
getche macro char
        push ax
        mov ah,1
        int 21h
        mov char,al
        pop ax
endm

cls macro
        pusha
        mov ah,6h
        mov al,0
        mov bh,7
        mov cx,0
        mov dl,79
        mov dh,24
        int 10h
        popa
endm

gotoxy macro x,y
        push ax
        push bx
        push dx
        mov ah,2H
        mov bh,0
        mov dh,y
        mov dl,x
        INT 10H
        pop dx
        pop bx
        pop ax
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

jmp main
strv db "abcdefghijklmnopqrstuvwx",'$'
strh db "abcdefghijklmnopqrstuvwx",'$'
xv db 40
yv db 0
xh db 0
yh db 12
main:   
repeat: 
        mov cx,24
        mov si,-1
for:    inc si
        gotoxy xv,yv
        putchar strv[si]
        new_line
        inc yv
        
        gotoxy xh,yh
        putchar strh[si]
        inc xh
        cmp xh,79
        ja hor
        jmp next
hor:    mov xh,0
next:
        loop for
        cmp yv,24
        jb repeat
        rolstr strv
        mov yv,0
        jmp repeat
ret
end
