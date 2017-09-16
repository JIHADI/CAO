String macro msg 
mov ah , 09h
mov dx , offset msg
int 21h  
endm      
     
data segment          
cr equ 0dh       
lf equ 0ah   
Buff db 80 dup(0)    
revbuff db 80 dup(0)  
msg1 db cr,lf ,'Enter the String > $ ' 
msg2 db cr,lf ,'The Reverse of the String is > $ '
data ends   

code segment 
assume cs:code, ds:data

start:  
        mov ax,data
        mov ds,ax
        string msg1              
        mov si,offset Buff        
rdchar1:                         
        mov ah,01h               
        int 21h                   
        mov[si],al
        inc si                    
        cmp al,cr                 
        jne rdchar1              
        
        mov si , offset Buff
        mov bx,00
label3:
        mov al,[si] 
        cmp al,cr
        je label2
        mov [si] , al
        inc si 
        inc bx
        jmp label3
label2:
        mov si ,offset Buff
        add si ,bx
        mov di , offset revbuff
        mov cx ,bx

label4:
        dec si
        mov al ,[si]
        mov [di], al 
        inc di
        loop label4

    mov al, '$'
    mov [di] , al
    String msg2
    String revbuff
    mov ax, 4c00h 
    int 21h
    code ends

end start
