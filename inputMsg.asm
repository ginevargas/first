; Vargas, Regine B. BSCS-3A
; Basic Assembly Instruction

section .data

    prompt_name db 'Hi! What is your name? ', 10, 0         ; Define a prompt for the user's name
    prompt_age db 'How old are you? ',  10, 0                ; Define a prompt for the user's age
    UserAge db '%d', 0                                       ; Define format specifier for an integer (%d)
    prompt_address db 'Where do you live? ', 10, 0          ; Define a prompt for the user's address

    message: db 'Nice to meet you, %s, %d, who lives at %s.', 10, 0  ; Define a message format

section .bss

    ; Buffers to store user input
    user_name resb 200
    user_age resd 1
    user_address resb 200

section .text

    global _main                  ; Declare the _main function as global
    extern _printf                ; Declare the external _printf function
    extern _scanf                 ; Declare the external _scanf function
    extern _gets                  ; Declare the external _gets function to read a complete address

_main:
    ; Display the prompt for name
    push prompt_name
    call _printf
    add esp, 4

  ; Read user input               
  push user_name                                             
  call _gets                    
  add esp, 8           

  ; Display the prompt for age
  push prompt_age           
  call _printf                 
  add esp, 4                 

  ; Read user input
  push user_age          
  push UserAge   
  call _scanf    
  add esp, 8     

  ; Display the prompt for address
  push prompt_address   
  call _printf             
  call _gets     
  add esp, 4       

  ; Read user input for address using gets
  push user_address     
  call _gets                  
  add esp, 8          

  ; Display the message
  push user_address                          
  push dword [user_age]  ; push integer value on to the stack                          
  push user_name                                     
  push message                    
  call _printf                         
  add esp, 16                                       

  ret   ; Return from the main function

