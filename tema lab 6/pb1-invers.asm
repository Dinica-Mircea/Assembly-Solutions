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
    s dd 127F5678h, 11223344h
    ls equ ($-s)/4
    d times ls dd; rezultatul dorit este d=00440066h, 006800F7h
; our code starts here
segment code use32 class=code
    start:
        ; Se da un sir de dublucuvinte continand date impachetate (4 octeti scrisi ca un singur dublucuvant). Sa se obtina un nou sir de dublucuvinte, in care fiecare dublucuvant se va obtine dupa regula: suma octetilor de ordin impar va forma cuvantul de ordin impar, iar suma octetilor de ordin par va forma cuvantul de ordin par. Octetii se considera numere cu semn, astfel ca extensiile pe cuvant se vor realiza corespunzator aritmeticii cu semn.
        mov esi,s;punem in esi sirul sursa
        mov edi,d;punem in esi sirul destinatie
        mov ecx,ls; contorul ecx ia valoarea numarul de dublucuvinte din s
        add esi,ls*4-1;adaugam la esi numarul de dublu cuvinte ori 4 pentru a obtine octetii si scadem 1
        jecxz final
        repeta:
            std;setam direction flag pentru a parcurge de la stanga la dreapta
            mov bx,0;in bx punem 0, el devenind dupa aceea suma octetilor pari din dublu cuvant
            mov dx,0;in dx punem 0, el devenind dupa aceea suma octetilor impari din dublu cuvant
            lodsb;scoatem primul octet din dublu cuvant
            mov ah,0; punem in ah 0 pentru ca in ax sa fie primul octet din dublu cuvant
            add bx,ax; adaugam la bx primul octet(octetul 0)
            lodsb; scoatem al doilea octet din dublu cuvant(octetul 1)
            mov ah,0;punem in ah 0 pentru ca in ax sa fie al doilea octet din dublu cuvant
            add dx,ax; adaugam la dx al doilea octet(octetul 2)
            lodsb; scoatem al treilea octet din dublu cuvant(octetul 2)
            mov ah,0;punem in ah 0 pentru ca in ax sa fie al treilea octet din dublu cuvant
            add bx,ax; adaugam la bx al treilea octet(octetul 2)
            lodsb;scoatem al patrulea octet din dublu cuvant(octetul 3)
            mov ah,0;punem in ah 0 pentru ca in ax sa fie al patrulea octet din dublu cuvant
            add dx,ax;; adaugam la dx al patrulea octet(octetul 3)
            mov ax,dx;punem in ax suma octetilor impari
            cld;curatam direction flag pentru a parcurge sirul destinatie de la dreapta la stanga
            stosw; punem in sirul sursa pe ax
            mov ax,bx;punem in ax suma octetilor pari
            stosw;punem in sirul sursa pe ax
        loop repeta
        final
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
