bits 32 
global _transformare
;extern exit,scanf

;import scanf msvcrt.dll
segment data public data use32
;s times 100 db 0
;format db "%s",0;formatul pentru citirea caracterelor
segment code public code use32

    _transformare:
            push ebp
            mov ebp,esp
            mov eax,[ebp+8]
            cmp AL,'-'
            jne continua
            shr EAX,2
            sub EAX,48
            neg EAX
            continua:
            sub EAX,48
            
            
            
            ;push dword s
            ;push dword format
            ;call [scanf]
            ;add esp,4*2;citim sirul de caractere s
            ;mov eax,dword[s]
            mov esp,ebp
            pop ebp
        ret
