TITLE Print5

.486                                    ; create 32 bit code
.model flat, stdcall                    ; 32 bit memory model
option casemap :none                    ; case sensitive

; include necessary libraries
include \masm32\include\windows.inc ; always first
include \masm32\macros\macros.asm

include \masm32\include\masm32.inc
include \masm32\include\masm32rt.inc
include \masm32\include\gdi32.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib

print_word PROTO :DWORD
.data
numberedList DWORD 1, 2, 3, 4, 5 ; numberedList array, will be used to print out the nth time the user's input is printed out

.code                       ; Tell MASM where the code starts

start:                          ; The CODE entry point to the program
    call main                   ; branch to the "main" procedure
    exit

main proc
    LOCAL txtinput:DWORD

	; The user will input a word, we'll take it and print it out 5 times in show_text
    mov txtinput, input("Enter a word, and I'll print it out 5 times: ")
	invoke print_word, txtinput ; call print_word

    ret
main endp

print_word proc userword:DWORD
	mov ax, 0
	mov esi, OFFSET numberedList ; get numberedList array and place it in register
	mov edi, [esi]

	.while ax < LENGTHOF numberedList ; repeats 5 times
		printf("%Xh. ", edi) ; print out the nth time the user's input is being printed
		print userword ; print userword
		mov edi, [esi+4] ; move to next array value
		inc ax ; increment ax by 1
	.endw

    ret
print_word endp

end start                       ; end program
