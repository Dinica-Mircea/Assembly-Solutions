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
    b db 2
    c db 4
    d db 6
    e dw 9
    f dw 8
    g dw 9
    h dw 10
; our code starts here
segment code use32 class=code
    start:
        ; 30.100/(e+h-3*a)=100/(9+10-3*3)=100/10=10
        mov AH,[a]   ;AH=a=3
        mov AL,3   ;AL=3
        mul AH     ;AX=AL*AH=3*3=9
        mov BX,[e]   ;BX=e=9
        add BX,[h]   ;BX=e+h=9+10=19
        sub BX,AX  ;BX=BX-AX=19-9=10
        mov ECX,100
        push ECX
        pop AX
        pop DX   ;DX:AX=100
        div BX     ;AX=DX:AX/BX=100/10=10
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
