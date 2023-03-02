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
        ; a - byte, b - word, c - double word, d - qword - Interpretare fara semn
        mov AL,[a]
        mov AH,0 ;AX=a
        mov DX,0 ;DX:AX=a
        push DX
        push AX
        pop EAX ;EAX=a
        mov EDX,0 ;EDX:EAX=a
        mov EBX,dword[d+0]
        mov ECX,dword[d+4] ;ECX:EBX=d
        add EBX,EAX
        adc ECX,EDX ;ECX:EBX=a+d=2020h
        mov EAX,[c];EAX=c
        mov EDX,0;EDX:EAX=c
        sub EAX,EBX ;
        sbb EDX,ECX ;EDX:EAX=c-(a+d)=34440h-2020h=32420h
        mov BX,[b]
        mov CX,0 ;CX:BX=b
        push CX
        push BX
        pop EBX ; EBX=b=200h
        mov ECX,0 ;ECX:EBX=b
        add EBX,dword[d+0]
        adc ECX,dword[d+4]; ECX:EBX=b+d=200h+2000h=2200h
        add EAX,EBX
        adc EDX,ECX; EDX:EAX=c-(a+d)+(b+d)=34440h- (20h+2000h)+(200h+2000h)=32420h+2200h=34620h
        
  
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
