; CS 318 – Architecture and Organization
; BSCS 3A
; Group 8
; GROUP MEMBERS: Braga, Angelika V. 
;				 Labios, Justine D.
;	             Vargas, Regine B.
  
; This is an Assembly program intended to sort numbers using Selection Sort.

section .data
    ; Prompt for the program
	prompt_intro db 'Hi! We are Regine, Angelika, and Justine.', 10, 0
    prompt_msg db 'This program is intended to sort numbers using Selection Sort.', 10, 0    
    prompt_by db '======== SELECTION SORT by Regine, Angelika, Justine ========', 10, 0
    prompt_line db '==============================================================', 10, 0
    enter_num db 'Enter one-digit number: ', 0 
    input_num db '%d', 0 
    prompt_sorted db 'Sorted array: ', 0  
    input_sorted db '%d ', 0
    prompt_continue db 'Continue? (Y/N): ', 0 
    input_continue db '%s', 0

    ; Error prompts
    prompt_invalid_input db "Input should be a one-digit number. Please enter again a valid input.", 10, 0
    prompt_error db "Invalid input. Please enter 'Y' or 'N' ", 10, 0
    ; Exit message
    thank_you db 'Thank you!', 10, 0
    newline db 10,0

    num1 times 20 db 1 
    sortednum1 times 200 db 0
    counter dd 0
    counter1 dd 0
    ctr1 dd 10

section .bss 
    ; Buffer for user input
    continue resb 2
    numberint resb 1

section .text 
    global _main
    extern _printf
    extern _scanf
    extern _exit

 ; Display error message for invalid input
input_string_error:
    push prompt_invalid_input
    call _printf
    add esp, 4
    ret
error_function:
    push prompt_error
    call _printf
    add esp, 4
    ret

_main:
    push newline
    call _printf
    add esp, 4

    ; Display the introduction message
    push prompt_intro       
    call _printf
    add esp, 4

    push prompt_msg
    call _printf
    add esp, 4

input_loop:
    push newline
    call _printf
    add esp, 4

    push prompt_by
    call _printf
    add esp, 4

    ; Prompt the user to enter a one-digit number
    push enter_num
    call _printf

    ; Get user input
    push numberint
    push input_num
    call _scanf
    add esp, 8

    ; Check if the input is a one-digit number
    mov eax, [numberint]
    cmp eax, 0         
    je sorted_num
    cmp eax, 1        
    je sorted_num
    cmp eax, 2         
    je sorted_num
    cmp eax, 3        
    je sorted_num
    cmp eax, 4         
    je sorted_num
    cmp eax, 5         
    je sorted_num          
    cmp eax, 6
    je sorted_num 
    cmp eax, 7         
    je sorted_num
    cmp eax, 8         
    je sorted_num
    cmp eax, 9         
    je sorted_num

    ; Display an error message for invalid input
    push newline
    call _printf
    add esp, 4
    push prompt_invalid_input
    call _printf
    jmp input_loop 

    lea esi, [numberint] 
    cmp al, 'a'
    je string_error
    cmp al, 'z'
    je string_error

string_error:
    call input_string_error
    jmp input_loop         

sorted_num:
    push prompt_sorted
    call _printf
    add esp, 4

append:
    ; Append the entered number to the array
    mov eax, [numberint]
    mov ebx, [counter]
    mov [num1+ebx], eax
    mov ecx, ebx 
    add ecx, 4
    mov [counter], ecx
    mov edx, [counter1]  ; this is to increment or add 1 to counter1
    add edx, 1
    mov [counter1], edx
    add esp, 8

selection_sort:
    ; Selection Sort algorithm
    mov ecx, [counter1]  ; get the current size of the array
    dec ecx

    mov esi, 0  ; outer loop index i

outer_loop:
    mov edi, esi  ; inner loop index j
    inc edi     ; start from the next element

inner_loop:
    mov eax, [num1 + esi * 4]
    mov ebx, [num1 + edi * 4]

    cmp eax, ebx
    jnge not_swap   ; jump if not greater or equal (unsigned comparison)

    mov edx, eax
    mov eax, ebx
    mov ebx, edx
    mov [num1 + esi * 4], eax
    mov [num1 + edi * 4], ebx

not_swap:
    inc edi  ; move to the next element in the inner loop
    cmp edi, ecx   ; check if we reached the end of the array
    jl inner_loop   ; jump to the inner loop if not

    inc esi  ; move to the next element in the outer loop
    cmp esi, ecx
    jl outer_loop   ; jump to outer loop if not

forLoop:
    ; Display the sorted array
    push ebp
    mov ebp, esp
    mov eax, [counter1]
    mov ebx, num1   ; point ebx to first number
    mov ecx, 0

loop:
    ; store the value because external function like printf modify the value
    push ebx
    push eax
    push ecx

    ; print the value stored on stack
    push dword [ebx]
    push input_sorted
    call _printf
    add esp, 8

    ; restore these values
    pop ecx
    pop eax
    pop ebx
    inc ecx  ; increment the counter
    add ebx, 4
    cmp ecx, eax  ; compare value stored in ecx and eax
    jne loop
    ; destroy the stack
    mov esp, ebp
    pop ebp

    push newline
    call _printf
    add esp, 4

continue_loop:
    push prompt_line
    call _printf
    add esp, 4

    ; Prompt the user to continue
    push prompt_continue
    call _printf
    add esp, 4

    ; Get user input for continuing the program
    push continue
    push input_continue
    call _scanf
    add esp, 8

    ; Check if the user wants to continue (Y/y, N/n)
    movzx eax, byte [continue]   ; Use movzx to zero-extend the byte to a full dword
    cmp eax, 'y'
    je input_loop
    cmp eax, 'Y'
    je input_loop
    cmp eax, 'n'
    je exit
    cmp eax, 'N'
    je exit

    ; Display an error message for invalid input
    call error_function
    jmp continue_loop

; Display "Thank you!" and exit the program
exit:
    push prompt_line
    call _printf
    add esp, 4

    push thank_you
    call _printf
    add esp, 4
    call _exit


    

