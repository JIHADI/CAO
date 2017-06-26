string macro msg
    mov ah,09h
    mov dx,offset msg
    int 21h
endm

data segment
    cr equ 0dh
    lf equ 0ah
    Buff db 80 dup(0)
    revbuff db 80 dup(0)
    msg1 db cr,lf,'Enter the String > $' 
    msg2 db cr,lf,'The reverse of the string > $'
    msg3 db cr,lf,'The String is a Palindrome. $'
    msg4 db cr,lf,'The String is not a Palindrome. $'
data ends

code segment
    assume cs:code,ds:data 
    Start: 
        mov ax,data
        mov ds,ax       
        string msg1 
        mov si,offset Buff
        rdchar1:
        mov ah,01h
        int 21h
        mov [si],al 
        inc si
        cmp al,cr
        jne rdchar1
        mov si,offset Buff
        mov bx,00

    label3:
        mov al,[si]
        cmp al,cr
        je label2
        mov [si],al
        inc si
        inc bx
        jmp label3
    
    label2:
        mov si,offset Buff 
        add si,bx
        mov di,offset revbuff
        mov cx,bx
        
    label4:
        dec si
        mov al,[si]
        mov [di],al
        inc di
        loop label4
        mov al,'$'
        mov [di],al
        string msg2
        string revbuff
        mov si,offset buff
        mov di,offset revbuff
        mov cx,bx
     
    nextchar:
        mov al,[si]
        cmp al,[di]
        jne notpali
        inc si
        inc di
        loop nextchar
    
    pal:
        string msg3
        jmp skip
        notpali:
        string msg4
 
    skip:
        mov ah,4ch
        mov al,00h
                
        int 21h
    code ends
end start
