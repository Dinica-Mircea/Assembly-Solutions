bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 
    a dw 10
    b dw 20
    c dw 30
    d dw 10

; our code starts here
segment code use32 class=code
    start:
        ; 1.(c+b+a)-(d+d)=(10+20+30)-(10+10)=60-20=40
        mov AX,[c] ; AX=30
        add AX,[b] ; AX=c+b=50
        add AX,[a] ; AX=c+b+a=60
        mov BX,[d] ; BX=d=40
        add BX,[d] ; BX=d+d=80
        sub AX,BX ; AX=AX-BX=60-80=-20
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
