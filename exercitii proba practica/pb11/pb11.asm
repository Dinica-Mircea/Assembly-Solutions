bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s times 100 db 0
    nume_fisier db "afisare.txt",0
    mod_acces db "w",0
    format db "%s",0
    format2 db "textul citit este: %s",0ah,0
    descriptor_fis dd -1
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp,4*2
        mov [descriptor_fis],eax
        mov ecx,5
        jecxz final
        repeta:
            push dword s
            push dword format
            call [scanf]
            add esp,4*2
            cmp byte[s],'$'
            je final
            push dword s
            push dword format2
            push dword [descriptor_fis]
            call [fprintf]
            add esp,4*3
            inc ecx
        loop repeta
        final:
        push dword[descriptor_fis]
        call [fclose]
        add esp,4*1
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
