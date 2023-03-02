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
    a db 2
    b db 3
    c db 4
    d dw 6

; our code starts here
segment code use32 class=code
    start:
        ; 1.((a+b-c)*2 + d-5)*d=((2+3-4)*2+6-5)*6=(2+1)*6=18
         mov AL,[a] ;AL=a=2
         add AL,[b] ;AL=a+b=2+3=5
         sub AL,[c] ;AL=a+b-c=5-4=1
         mul BYTE [a] ; AX=AL*2=1*2=2
         add AX,[d] ; AX=AX+d=2+6=8
         sub AX,5 ;AX=AX-5=8-5=3
         mul WORD[d]; DX:AX=AX*6=3*6=18
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
