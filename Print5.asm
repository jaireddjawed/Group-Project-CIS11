.486                                    ; create 32 bit code
.model flat, stdcall                    ; 32 bit memory model
option casemap :none                    ; case sensitive

include \masm32\include\windows.inc     ; always first
include \masm32\macros\macros.asm       ; MASM support macros

include \masm32\include\masm32.inc
include \masm32\include\gdi32.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib

show_text PROTO :DWORD
.data
numberedList DWORD 1, 2, 3, 4, 5


.code                       ; Tell MASM where the code starts

start:                          ; The CODE entry point to the program
    call main                   ; branch to the "main" procedure
    exit

main proc
    LOCAL txtinput:DWORD

    mov txtinput, input("Enter a word, and I'll print it out 5 times: ")
	invoke show_text, txtinput

    ret
main endp

show_text proc string:DWORD
	mov ax, 0

	.while ax < LENGTHOF numberedList
		print string
		inc ax
	.endw

    ret
show_text endp

end start                       ; Tell MASM where the program ends
