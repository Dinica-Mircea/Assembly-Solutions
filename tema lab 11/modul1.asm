bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
global citire
extern s;transmitem prin variabila globala s
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=public
    ; ...
    format db "%s",0;formatul pentru citirea caracterelor
; our code starts here
segment code use32 class=public
        citire:
            push dword s
            push dword format
            call [scanf]
            add esp,4*2;citim sirul de caractere s
            
        ret
