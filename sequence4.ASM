format PE console
entry start

include 'win32a.inc'

section '.data' data readable writable
        el db '%u', 10, 0
        strNumber    db 'Enter n = ', 0
        strScanInt   db '%d', 0
        strI  db 'n = %d   t_n =', 0
        num dd 0
        t_1 dd 0d
        t_2 dd 1d
        t_3 dd 0d
        t_4 dd 1d
        real df 0d
        i dd 4 ;for loop
        t_n dd 0
        slashn db 10, 0, 0
        tt df 0
        numerating dd '  ', 0
        lastel db 'n = 37   t_n =  %u', 10, 0
        num1 dd 0

section '.code' code readable executable

        start:
                        push strNumber
                        call [printf]
                        push num
                        push strScanInt
                        call [scanf] ;Enter n

                        ;check for more than 4 n
                        mov eax,4
                        cmp eax, [num]
                        jg loopend

                        mov dword [t_1],0 ;Setting the initial value for the first element
                        mov dword [t_2],1 ;Setting the initial value for the second element
                        mov dword [t_3],0 ;Setting the initial value for the third element
                        mov dword [t_4],1 ;Setting the initial value for the fourth element
                        mov dword [t_n],0 ;Setting the initial value for the n element
                        call Main



Main:
                ;initialization edx and ecx
                mov edx, 0
                mov ecx, 0
                loopS:

                        mov eax, [t_1] ;add a variable t_1
                        Jo loopend

                        add eax, [t_2] ;add a variable t_2
                        Jo loopend

                        add eax, [t_3] ;add a variable t_3
                        Jo loopend

                        add eax, [t_4] ;add a variable t_4
                        Jo loopend

                        mov dword [t_n], eax
                        ;JO loopend

                        ;write in t_1
                        mov ecx, [t_1]
                        mov ebx, [t_2]
                        mov [t_1], ebx

                        ;write in t_2
                        mov ecx, [t_2]
                        mov ebx, [t_3]
                        mov [t_2], ebx

                        ;write in_3
                        mov ecx, [t_3]
                        mov ebx, [t_4]
                        mov [t_3], ebx

                        ;write in t_4
                        mov ecx, [t_4]
                        mov ebx, [t_n]
                        mov [t_4], ebx

                        ;increment i loop
                        inc [i]

                        ;output
                        cinvoke printf, strI, [i]
                        cinvoke printf, numerating
                        cinvoke printf, el, [t_n]



                        mov eax, [num]  ;write to register n
                        cmp eax, [i] ;compare register and n
                        je loopend ;if equal then finish

                        jmp loopS ;new iteration

loopend:
                        mov eax, [num]  ;write to register n
                        cmp eax, [i] ;compare register and n
                        jg writeanother ;if bigger
                        call [getch]
                        push 0
                        call [ExitProcess]

writeanother:
                            mov eax, 0
                            add eax, [t_1]
                            add eax, [t_2]
                            add eax, [t_3]
                            add eax, [t_4]
                            cinvoke printf, lastel, eax
                            call [getch]
                            push 0
                            call [ExitProcess]


section '.idata' import data readable

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll',\
                user32,'user32.dll'

        import msvcrt,\
               printf, 'printf',\
                scanf, 'scanf',\
               getch, '_getch'

        import kernel,\
               GetProcessHeap, 'GetProcessHeap',\
               ExitProcess, 'ExitProcess'
