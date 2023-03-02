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
    a db 20h
    b dw 200h
    c dd 34440h
    d dq 2000h
; our code starts here
segment code use32 class=code
    start:
        ; adunari si scaderi setul 1
        ; 1.c-(a+d)+(b+d)=34440h- (20h+2000h)+(200h+2000h)=32420h-2200h=30220h
        ; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
                mov AL,[a]
        mov AL,[a] ;AL=a
        cbw;AX=a
        cwde;EAX=a
        cdq ;EDX:EAX=a
        mov EBX,dword[d+0]
        mov ECX,dword[d+4] ;ECX:EBX=d
        add EBX,EAX
        adc ECX,EDX ;ECX:EBX=a+d=2020h
        mov EAX,[c];EAX=c
        cdq;EDX:EAX=c
        sub EAX,EBX ;
        sbb EDX,ECX ;EDX:EAX=c-(a+d)=34440h-2020h=32420h
        mov EBX,EAX
        mov ECX,EDX ;EBX:ECX=c-(a+d)=34440h-2020h=32420h
        mov AX,[b];AX=b
        cwde;EAX=b
        cdq;EDX:EAX=b
        add EAX,dword[d+0]
        adc EDX,dword[d+4]; EDX:EAX=b+d=200h+2000h=2200h
        add EAX,EBX
        adc EDX,ECX; EDX:EAX=c-(a+d)+(b+d)=34440h- (20h+2000h)+(200h+2000h)=32420h+2200h=34620h
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
