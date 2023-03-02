bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; .
    a dw 10
    b dw 20
    c dw 30
    d dw 40

; our code starts here
segment code use32 class=code
    start:
        ; 30.a-b+(c-d+a)=10-20+(30-40+10)=-10+0=-10
        mov AX,[a] ;AX=a=10 
        sub AX,[b] ;AX=a-b=-10
        mov BX,[c] ;BX=c=30
        sub BX,[d] ;BX=BX-d=30-40=-10
        add BX,[a] ;BX=BX+a=-10+10=0
        add AX,BX  ;AX=AX+BX=-10+0=-10
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
