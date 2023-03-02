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
    A dw 0110101010101011b ;0110 1010 1010 1011b=6AABh
    B dw 1001111001110001b ;1001 1110 0111 0001b=9E71h
    C dw 0001110110000110b ;0001 1101 1000 0110b=1D86h
    D resb 2

; our code starts here
segment code use32 class=code
    start:
        ; 31.Se dau cuvintele A, B si C. Sa se formeze cuvantul D ca suma a numerelor reprezentate de:
            ;biţii de pe poziţiile 1-5 ai lui A
            ;biţii de pe poziţiile 6-10 ai lui B
            ;biţii de pe poziţiile 11-15 ai lui C
        mov AX,[A] ;AX=0110 1010 1010 1011b=6AABh
        shl AX,10  ;AX=1010 1100 0000 0000b=AC00h
        shr AX,11  ;AX=0000 0000 0001 0101=0015h
        add word[D],AX ;D=0000 0000 0000 1011B=000Bh
        mov AX,[B] ;AX=1001 1110 0111 0001b=9E71h
        shr AX,6   ;AX=0000 0010 0111 1001b=0279h 
        shl AX,11  ;AX=1100 1000 0000 0000b=C800h
        shr AX,11  ;AX=0000 0000 0001 1001b=0019h
        add word[D],AX; D=0000 0000 0010 1110b=002Eh
        mov AX,[C]  ;AX=0001 1101 1000 0110b=1D86h
        shr AX,11   ;AX=0000 0000 0000 0011b=0003h
        add word[D],AX ; D=0000 0000 0011 0001b=0031h
        mov BX,[D]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
