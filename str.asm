; Vargas, Regine B.
; Learning Task (Strings)
; This is an Assembly program intended to changes all the vowels in the given string to 'e'.
; no uppercase


section .data
    prompt_msg db "Hi! We are Group #8.", 0xA
              db "This program intended to change all the vowels in the given string to 'e'.", 10, 0
    prompt_line db "==========================================", 10, 0

    prompt_input db "Input String: ", 0
    input_string db '%s', 0
    prompt_output db "Output String: ", 0
    output_string db '%s', 0

    prompt_continue db "Continue? (Y/N): ", 0
    input_continue db '%s', 0
    error_msg db "Invalid input. Please enter 'Y' or 'N' ", 10, 0
    thank_you_msg db 'Thank you!', 10, 0
    newline db 10, 0

section .bss
    continue resb 10
    inputStr resb 1000
    outputStr resb 1000

section .text
    global _main
    extern _printf
    extern _scanf
    extern _exit
    extern _gets

string_error:
    ; Display error message for invalid input
    push error_msg   
    call _printf
    add esp, 4
    ret

_main:
    ; Display the prompt for name
    push prompt_msg
    call _printf
    add esp, 4
main_loop:
    push prompt_line
    call _printf
    add esp, 4

    push prompt_input
    call _printf
    add esp, 4

    push inputStr
    call _gets
    add esp, 8

 ; Process the input string
    lea esi, [inputStr]
    lea edi, [outputStr]

convert_vowels:
    mov al, [esi]
    cmp al, 0           ; Check if end of the string
    je display_output
    cmp al, 'a'
    je replace_vowel
    cmp al, 'e'
    je replace_vowel
    cmp al, 'i'
    je replace_vowel
    cmp al, 'o'
    je replace_vowel
    cmp al, 'u'
    je replace_vowel
    cmp al, 'A'       
    je replace_vowel
    cmp al, 'E' 
    je replace_vowel
    cmp al, 'I'      
    je replace_vowel
    cmp al, 'O'     
    je replace_vowel
    cmp al, 'U'     
    je replace_vowel

    ; Copy non-vowel character
    mov [edi], al
    inc esi
    inc edi
    jmp convert_vowels

replace_vowel:
    ; Replace vowel with 'e'
    mov byte [edi], 'e'
    inc esi
    inc edi
    jmp convert_vowels

display_output:
    mov dword [edi], 0
    mov esi, 0
    mov edi, 0

    ; Display the output string
    push prompt_output
    call _printf
    add esp, 4

    lea esi, [outputStr] ; Corrected this line to use outputStr
    push esi
    call _printf
    add esp, 4

    push newline
    call _printf
    add esp, 4

continue_loop:
    push prompt_line
    call _printf
    add esp, 4

    push prompt_continue
    call _printf
    add esp, 4

    push continue
    push input_continue
    call _scanf
    add esp, 8

    push inputStr
    call _gets
    add esp, 4

    ; Check if the user wants to continue (Y/y, N/n)
    movzx eax, byte [continue]   ; Use movzx to zero-extend the byte to a full dword
    cmp eax, 'y'
    je main_loop
    cmp eax, 'Y'
    je main_loop
    cmp eax, 'n'
    je exit
    cmp eax, 'N'
    je exit

    call string_error
    jmp continue_loop

; Display "Thank you!" and exit the program
exit:
    push thank_you_msg
    call _printf
    add esp, 4
    call _exit



