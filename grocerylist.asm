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

.data
warray WORD 1,2,3,4
grocerylist DWORD 20 dup (?) ; 20 elements

display_grocery_list PROTO :DWORD
.code                       ; Tell MASM where the code starts

start:                          ; The CODE entry point to the program
    call main                   ; branch to the "main" procedure
    exit

main proc
    LOCAL listitem:DWORD        ; a "handle" for the text returned by "input"

	mov ax, 0

    print "Welcome to Jaired's Grocery list program!"

	.while ax == 0
		mov listitem, input("Enter your grocery list, when you're done, input 'no' and press enter. ")
		invoke display_grocery_list, listitem

		.if listitem == 'no'
			mov ax, 1
		.endif

	.endw


    ret
main endp

display_grocery_list proc string:DWORD

    print string

    ret
display_grocery_list endp

end start                       ; Tell MASM where the program ends
                     ; Tell MASM where the program ends
