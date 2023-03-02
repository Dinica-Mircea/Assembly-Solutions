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
    a db 5
    b dw 100
    c dd 200
    d dq 1000
    
; our code starts here
segment code use32 class=code
    start:
        ; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
        ; (c+b+a)-(d+d)=(5+100+200)-(1000+1000)=305-2000=-1695=F961h
        mov AL,[a]
        cbw; AX=a
        cwde ;EAX=a
        add EAX,c ; EAX=a+c
        mov EBX,EAX; EBX=a+c
        mov AX,b ;AX=b
        cwde ;EAX=b
        add EAX,EBX; EAX=a+c+b=c+b+a
        cdq; EDX:EAX=c+b+a
        mov EBX,dword[d+0]
        mov ECX,dword[d+4]; ECX:EBX=d
        add EBX,dword[d+0]
        adc ECX,dword[d+4]; ECX:EBX=d+d
        sub EAX,EBX 
        sbb EDX,ECX ; (c+b+a)-(d+d)=(5+100+200)-(1000+1000)=305-2000=-1695=F961h
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
