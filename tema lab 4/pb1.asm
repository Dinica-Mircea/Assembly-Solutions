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
    A dw 1100001110101001b ;1100 0011 1010 1001b=C3A9h
    B dw 1010111101011110b ;1010 1111 0101 1110b=AF5Eh
    C resb 4
; our code starts here
segment code use32 class=code
    start:
        ; 1.Se dau cuvintele A si B. Sa se obtina dublucuvantul C:
        ;   bitii 0-4 ai lui C coincid cu bitii 11-15 ai lui A
        ;   bitii 5-11 ai lui C au valoarea 1
        ;   bitii 12-15 ai lui C coincid cu bitii 8-11 ai lui B
        ;   bitii 16-31 ai lui C coincid cu bitii lui A
        mov AX,[A] ;AX=1100 0011 1010 1001b=C3A9h
        shr AX,12  ;AX=0000 0000 0000 1100B=000Ch
        add [C],AX ;C=0000 0000 0000 1100B=000Ch
        add dword[C],111111110000b ;C=0000 1111 1111 1100B=0FFCh 
        mov BX,[B] ;BX=1010 1111 0101 1110b=AF5Eh
        shr BX,8   ;BX=0000 0000 1010 1111b=00AFh
        shl BX,12  ;BX=1111 0000 0000 0000b=F000h
        add [C],BX ;C=1111 1111 1111 1100b=FFFCh
        mov CX,[A] ;CX=1100 0011 1010 1001b=C3A9h
        add word[C+2],CX ;C=1100 0011 1010 1001 1111 1111 1111 1100b=C3A9 FFFCh
        mov EDX,[C]
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
