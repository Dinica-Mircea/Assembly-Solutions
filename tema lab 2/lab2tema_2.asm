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
    a db 1
    b db 2
    c db 3
    d db 4

; our code starts here
segment code use32 class=code
    start:
        ; 30.d-(a+b)-(c+c)=4-(1+2)-(3+3)=4-3-6=-5 
        mov AH,[d] ; AH=d=4
        mov BH,[a] ; BH=a=1
        add BH,[b] ; BH=a+b=3
        mov CH,[c] ; CH=c=3
        add CH,[c] ; CH=c+c=6
        sub AH,BH  ; AH=AH-BH=4-3=1
        sub AH,CH  ; AH=AH-CH=1-6=-5
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
