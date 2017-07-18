readnum macro num    
    mov ah,01h  
    int 21h   
    sub al,'0' 
    mov bh,0ah   
    mul bh 
    mov num,al  
    mov ah,01h  
    int 21h
    sub al,'0' 
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
    msg1 db cr,lf,'How many Numbers > $'
    msg2 db cr,lf,'Enter the Number > $' 
    msg3 db cr,lf,'Largest Number > $'
    ntable db 100(0)

    num db ? 
    temp db ? 
    result db 20 dup(0)
data ends 
 
    code segment
    assume cs:code,ds:data  
start:
    mov ax,data 
    mov ds,ax 
    printstring msg1 
    readnum num 
    mov si,offset ntable
    mov ch,00 
    mov cl,num
nextread:
    printstring msg2
    readnum temp  
    mov al,temp
    mov [si],al
    inc si 
    loop nextread
    mov si,offset ntable 
    mov bl,[si]
    mov cl,01 
    nextchk:
        inc si
        cmp cl,num
        je nomore
        cmp bl,[si] 
        jge skip
        mov bl,[si]
    skip:
        inc cl
        jmp nextchk
    nomore: 
        mov ah,00
        mov al,bl 
        mov si,offset result
        call hex2asc
        printstring msg3
        printstring result
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
        mov [si],al
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


