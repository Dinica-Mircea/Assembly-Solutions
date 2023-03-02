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
    s db 1,2,3,4 ;s:1,2,3,4
    ls EQU $-s;ls=lungime sirului=4
    d times ls+ls db 0;d=0,0,0,0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;Se da un sir de octeti S de lungime l. Sa se construiasca sirul D de lungime l-1 astfel incat elementele din D sa reprezinte produsul dintre fiecare 2 elemente consecutive S(i) si S(i+1) din S
        MOV EBX, 1 
        repeta: 
          mov AL,[s+EBX] ;   in AL punem termnul al doilea din inmultirea celor doi termeni consecutivi
          dec EBX; scadem EBX cu 1
          mul byte[s+EBX];inmultim AL cu primul termen din inmultirea celor doi termeni consecutiv
          mov [d+EBX*2], AX ;punem in d pe pozitia EBX*2 rezultatul
          inc EBX; incrementam ebx de 2 ori pentru a avea termenul corect la urmatoarea inmultire
          inc EBX 
          cmp EBX, ls;comparam pentru a putea iesi din loop
        
        JB repeta ;facem saltul if below
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
