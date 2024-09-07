; CS 318 – Architecture and Organization
; Group_8
; Vargas, Regine
; Braga, Angelika
; Labios, Justine  
; BSCS-3A
 
; Structured Assembly Language Part1    
; This is an Assembly program intented to sort numbers using Selection Sort.

section .data
    num1 times 20 db 1 
    sortednum1 times 200 db 0
    counter dd 0
    counter1 dd 0
    ctr1 dd 10
    prompt_intro db 10, "Hi! We are Group_8, Regine, Angelika, Justine",0
    promptSelection db 10, "=== SELECTION SORT === by Regine, Angelika, Justine", 10,0
    prompt_msg db 10, "This program is intended to sort numbers using selection sort.", 10,0

    prompt1 db 10, "Enter one-digit number: ", 0
    prompt_continue db 10, "Continue? (Y/N) :", 0
    input_continue db '%s', 0

    msg dd "Sorted array:  ", 0
    value1 dd "%d ", 0

    exit_msg db 'Thank you!', 10 , 0
    num_format db "%d", 0

    error_msg db "Input should be a one-digit number. Please enter again a valid input.", 10,0

section .bss
    numint resb 1
    continue resb 100

section .text
    extern _printf, _scanf
    global _main

_main:
     ; Display the introduction message
    push prompt_intro
    call _printf

    push prompt_msg
    call _printf

menu:
    push promptSelection
    call _printf
    add esp, 4

    push prompt1
    call _printf

    push numint
    push num_format
    call _scanf
    add esp, 8

    cmp byte [numint], 0
    je msgprompt
    cmp byte [numint], 1
    je msgprompt
    cmp byte [numint], 2
    je msgprompt
    cmp byte [numint], 3
    je msgprompt
    cmp byte [numint], 4
    je msgprompt
    cmp byte [numint], 5
    je msgprompt
    cmp byte [numint], 6
    je msgprompt
    cmp byte [numint], 7
    je msgprompt
    cmp byte [numint], 8
    je msgprompt
    cmp byte [numint], 9
    je msgprompt
    push error_msg
    call _printf
    jmp menu

msgprompt:
    push msg
    call _printf
    ; clear the stack
    add esp, 4

append:
    ; append an element to the array
    mov eax, [numint]
    mov ebx, [counter]
    mov [num1+ebx], eax
    mov ecx, ebx ; this is to increment or add 4 to the counter
    add ecx, 4
    mov [counter], ecx
    mov edx, [counter1] ; this is to increment or add 1 to counter1
    add edx, 1
    mov [counter1], edx
    add esp, 8

selection_sort:
    mov ecx, [counter1] ; get the current size of the array
    dec ecx ; decrement to get the actual size

    mov esi, 0 ; outer loop index i

outer_loop:
    mov edi, esi ; inner loop index j
    inc edi ; start from the next element

inner_loop:
    mov eax, [num1 + esi * 4] ; num1[i]
    mov ebx, [num1 + edi * 4] ; num1[j]

    cmp eax, ebx
    jnge not_swap ; jump if not greater or equal (unsigned comparison)

    ; swap num1[i] and num1[j]
    mov edx, eax
    mov eax, ebx
    mov ebx, edx
    mov [num1 + esi * 4], eax
    mov [num1 + edi * 4], ebx

not_swap:
    inc edi ; move to the next element in the inner loop
    cmp edi, ecx ; check if we reached the end of the array
    jl inner_loop ; jump to the inner loop if not

    inc esi ; move to the next element in the outer loop
    cmp esi, ecx ; check if we reached the end of the array
    jl outer_loop ; jump to the outer loop if not

forLoop:
    push ebp
    mov ebp, esp
    mov eax, [counter1]
    mov ebx, num1 ; point bx to first number
    mov ecx, 0    ; load 0

loop:

    ; store the value because external function like printf modify the value
    push ebx
    push eax
    push ecx

    ; print the value stored on stack
    push dword [ebx]
    push value1
    call _printf
    ; clear the stack
    add esp, 8

    ; restore these values
    pop ecx
    pop eax
    pop ebx

    ; increment the counter
    inc ecx
    ; add 4 bytes to ebx
    add ebx, 4
    ; compare value stored in ecx and eax
    cmp ecx, eax
    jne loop

    ; destroy the stack
    mov esp, ebp
    pop ebp

yesorno:
    push prompt_continue
    call _printf
    add esp, 4

    ; Read user's name
    push continue
    push input_continue
    call _scanf
    add esp, 8

    ; Check if the eser wants to continue (Y/y, N/n)
    movzx eax, byte [continue]   ; Use movzx to zero-extend the eax to a full dword
    cmp eax, 'Y'
    je menu
    cmp eax, 'y'
    je menu
    cmp eax, 'N'
    je exit
    cmp eax, 'n'
    je exit

; Heho
    ; Hello

exit:
    ; Display a thank you message
    push exit_msg
    call _printf

    ; Exit the program
    ret

