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
    a db 3
    b db 2
    c db 4
    d db 6
    e dw 7
    f dw 8
    g dw 9
    h dw 10


; our code starts here
segment code use32 class=code
    start:
        ; 1.((a-b)*4)/c=((3-2)*4)/4=1
        mov AH,[a] ;AH=a=1
        sub AH,[b] ;AH=a-b=3-2=1
        mov AL,4   ;AL=4
        mul AH     ;AX=AH*AL=4*1=4
        mov BL,4   ;BL=4
        div BL     ;AL=AX/BL=4/4=1
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
