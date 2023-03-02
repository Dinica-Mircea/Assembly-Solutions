bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

global s
extern citire

; our data is declared here (the variables needed by our program)
segment data use32 class=public
    ; ...
    format db "%s",0
s times 10 db 0
semn equ '-'
d times 20 db 0
; our code starts here
segment code use32 class=public
    start:
        ; ...
        mov edi,d
        mov ecx,100
        jecxz final
        repeta:
        call citire
        mov esi,s
        
        jecxz final
            mov EAX,0
            lodsb
            cmp AL,'$'
            je iesire
            cmp AL,semn
            jne continua
            push EAX
            lodsb
            sub AX,48
            neg AX
            stosb
            pop EAX
            jmp continua2
            continua:
            sub AX,48
            stosw
            continua2:
        loop repeta
        iesire:
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
