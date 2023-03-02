bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 3
    b dd -84
    c dq 4000
; our code starts here
segment code use32 class=code
    start:
        ; 1.c+(a*a-b+7)/(2+a)=4000+(3*3+84+7)/(2+a)=4000+(100)/(5)=4000+20=4020
        ; a-byte; b-doubleword; c-qword
        mov AL,[a]
        imul byte[a];AX=a*a
        cwde; EAX=a*a
        sub EAX,[b]
        add EAX,7 ;EAX=a*a-b+7
        mov EBX,EAX ;EBX=a*a-b+7
        mov EAX,0; EAX=0 (resetam EAX)
        mov AL,2
        add AL,[a] ;AL=a+2
        cbw; AX=a+2
        mov CX,AX;CX=a+2
        mov EAX,EBX; EAX=a*a-b+7
        push EAX
        pop AX
        pop DX; DX:AX=a*a-b+7
        idiv CX; AX=DX:AX/CX=(a*a-b+7)/(2+a)
        cwde ;EAX=(a*a-b+7)/(2+a)
        cdq; EDX:EAX=(a*a-b+7)/(2+a)
        add EAX,dword[c+0]
        adc EDX,dword[c+4]; EDX:EAX=c+(a*a-b+7)/(2+a)=4020=FB4h
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
