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
    s db '+', '4', '2', 'a', '@', '3', '$', '*'     ;S: '+', '4', '2', 'a', '@', '3', '$', '*'
    ls equ $-s;ls=lungimea sirului s=8
    l db '!', '@', '#', '$', '%', '^', '&', '*' ;l=sirul de caractere care trebuie scoase din s si puse in d
    ls2 equ $-l;ls2=lungime sirului l=8
    d times ls db 0;d=sirul pe care vrem sa l obtinem
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;Se da un sir de caractere S. Sa se construiasca sirul D care sa contina toate caracterele speciale (!@#$%^&*) din sirul S
        mov EBX,0;EBX=0=contor pentru sirul s
        mov EDX,0;EDX=0=contor pentru sirul d
        repeta:
            mov ECX,0;ECX=0=control pentru sirul l
            repeta2:
                mov AL,[s+EBX];AL=elementul de ordin EBX din s
                cmp AL,[l+ECX];comparam AL cu elementul de ordin ECX din l
                jnz final;sarim peste repeta3 daca instructiunea de cmp anterioara seteaza ZF=0
                repeta3:
                    mov [d+EDX],AL;pe pozitia EDX din sirul d il punem pe AL=elementul de ordin EBX din s
                    inc EDX;incrementam EDX pentru ca urmatorul numar sa fie pus pe pozitia urmatoare
                    inc AL;AL=AL+1
                    cmp AL,[s+ebx];comparand AL dupa incrementare cu fosta sa valoare vom seta ZF=0,pentru a iesi din loope
                    inc ECX;incrementam ECX,deoarece loope face dec ECX, loope sfarsindu se cand ZF=0
                loope repeta
                final
                inc ECX;comparam ECX cu lungimea sirului l pentru a iesi din repeta2 
                cmp ECX,ls2;comparam ECX cu lungimea sirului l pentru a iesi din repeta2 
            jb repeta2
            inc EBX;comparam EBX cu lungimea sirului s pentru a iesi din repeta
            cmp EBX,ls;comparam EBX cu lungimea sirului s pentru a iesi din repeta
        jb repeta      
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
 