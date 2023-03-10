bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 1
    b db 2 
    c db 3
    d db 4
    
    ; ...

; our code starts here
segment code use32 class=code
    start:
        ; 1.c-(a+d)+(b+d)=3-(1+4)+(2+4)=3-5+6=4
            mov AH,[a] ;AH=a=1
            add AH,[d] ;AH=a+d=5
            mov BH,[b] ;BH=b=2
            add BH,[d] ;BH=b+d=6
            mov CH,[c] ;CH=c
            sub CH,AH  ;CH=CH-AH=3-5=-2
            add CH,BH  ;CH=CH+BH=-2+6=4
            
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
