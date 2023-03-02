bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ..
    a db 2
    b db 3
    c db 4
    d dw 6


; our code starts here
segment code use32 class=code
    start:
        ; 30.[(a-b)*5+d]-2*c=[(2-3)*5+6]-2*4=(-5+6)-8=-7
        mov AH,[a] ;AH=a=2
        sub AH,[b] ;AH=a-b=-1
        mov AL,5   ;AL=5
        mul AH     ;AX=AL*AH=-1*5=-5
        add AX,[d] ;AX=AX+6=1
        mov BX,AX  ;BX=AX=1
        mov AL,2   ;AL=2
        mov AH,[c]  ;AH=4
        mul AH     ;AX=AL*AH=2*4=8
        sub BX,AX  ;BX=BX-AX=1-8=-7
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
