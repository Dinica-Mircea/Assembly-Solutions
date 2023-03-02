bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    B db 10011100b ;=9Ch
    A dw 1110001110001101b;=E38Dh
    ; ...
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;10. Sa se inlocuiasca bitii 0-3 ai octetului B cu bitii 8-11 ai cuvantului A.
        mov AL,[B] ;AL=1001 1100b=9Ch
        shr AL,4 ;AL=0000 1001b=09h
        shl AL,4 ;AL=1001 0000b=90h(B fara bitii 0-3 ai octetului B)
        mov BX,[A] ;BX=1110 0011 1000 1101b=E38Dh
        shr BX,8   ;BX=0000 0000 1110 0011b=00E3H
        shl BL,4   ;BL=0011 0000b=30h
        shr BL,4   ;BL=0000 0011b=03h
        add AL,BL  ;AL=1001 1110b=93h
        mov [B],AL ;B=1001 1110b=93h
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
