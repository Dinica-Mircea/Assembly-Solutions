bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,fclose,scanf,fread,fprintf,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import fread msvcrt.dll
import fprintf msvcrt.dll             
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    mod_acces_citire db "r",0
    mod_acces_afisare db "w",0
    descriptor_fis_citire dd 0
    descriptor_fis_afisare dd 0
    nume_fisier_citire db 0
    nume_fisier_afisare db "output.txt",0
    
    format db "%s",0
    
    c db 0
    len equ 100
    
    text times len db 0
    
    spartiu db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;citire nume fisier citire
        push dword nume_fisier_citire
        push dword format
        call [scanf]
        add esp,4*2
        ;citire caracter
        push c
        push format
        call [scanf]
        add esp,4*2
        ;deschidere input.txt
        push dword mod_acces_citire
        push dword nume_fisier_citire
        call [fopen]
        mov dword[descriptor_fis_citire],eax
        add esp,4*2
        ;deschidere output.txt
        push mod_acces_afisare
        push nume_fisier_afisare
        call [fopen]
        add esp,4*2
        mov dword[descriptor_fis_afisare],eax
        ;citire din fisier
        push dword[descriptor_fis_citire]
        push len
        push 1
        push text
        call [fread]
        add esp,4*4
        ;afisare
        push text
        push format
        call [printf]
        add esp,4*2
        ;afisare text din fisier
        push text
        push format
        push dword[descriptor_fis_afisare]
        call [fprintf]
        add esp,4*3
        ;inchidere
        push dword[descriptor_fis_afisare]
        call [fclose]
        add esp,4*1
        ;inchidere
        push dword[descriptor_fis_citire]
        call [fclose]
        add esp,4*1
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
