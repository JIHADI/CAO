readnum macro num  
        mov ah,01h
        int 21h 
        Sub al,'0'
        mov bh,0ah 
        mul bh
        mov num , al
        mov ah,01h
        int 21h
        Sub al,'0'
        add num,al
endm

printstring macro msg
        mov ah,09h
        mov dx,offset msg 
        int 21h 
endm   

data segment
        cr equ 0dh
        lf equ 0ah
        msg1 db cr,lf,'Enter  the Number: $'
        msg2 db cr,lf,'The Factorial of the number is: $'
        msg3 db cr,lf,'$'
        num db ?
        result db 20 dup('$')
data ends
Code Segment
        assume cs:code,ds:data
start:
        mov ax,data
        mov ds,ax
        printstring msg1
        readnum num
        mov ax,01
        mov ch,00
        mov cl,num
        cmp cx,00
        je skip
rpt:
        mov dx,00
        mul cx
        loop rpt
skip:
        mov si,offset result
        call hex2asc
        
        printstring msg2
        printstring result
        printstring msg3
        mov ax,4c00h
        int 21h
hex2asc proc near
        push ax
        push bx
        push cx
        push dx
        push si
        mov cx,00h
        mov bx,0ah
rpt1:
        mov dx,00
        div bx
        add dl,'0'
        push dx
        inc cx
        cmp ax,0ah
        jge rpt1
        add al,'0'
        mov [si], al
rpt2:
        pop ax
        inc si
        mov [si],al
        loop rpt2
        inc si
        mov al,'$'
        mov [si],al
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
ret
        hex2asc endp
code ends
        end start


