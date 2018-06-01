TITLE TwoQuestions

.486                                    ; create 32 bit code
.model flat, stdcall                    ; 32 bit memory model
option casemap :none                    ; case sensitive

include \masm32\include\windows.inc
include \masm32\macros\macros.asm  

include \masm32\include\masm32.inc
include \masm32\include\gdi32.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
 
; procedure that determines what object the user is thinking of based on their input
 
determine_object PROTO :DWORD, :DWORD

.data
; array that holds the number of questions the user will answer
questions dd 1, 2

.code                       ; start code

start:                         
    call main                   ; call main procedure
    exit

main proc
    LOCAL answer1:DWORD        ; variables that hold user input
	LOCAL answer2:DWORD
	LOCAL playAgain: DWORD

	push eax

	mov ax, 0

	; while loop repeats until the user decides to quit the game

	.while ax == 0
		mov eax, OFFSET questions

		print "TWO QUESTIONS!", 13, 10
		print "Think of an object and I'll try to guess it.", 13, 10

		print str$([eax]) ; print out question number
		mov answer1, input(". Is it an 'A' animal, 'V' vegtable, or 'M' mineral? ")
		mov eax, 4 ; increment array to next value

		print str$([eax])
		mov answer2, input("2. Is it bigger than a breadbox? 'Y' Yes or 'N' No: ")
		mov eax, 4

		; call determine_object procedure

		invoke determine_object, answer1, answer2

		mov playAgain, input("Would you like to play again? 'Y' Yes or 'N' No: ")

		; repeat the game unless the user states otherwise

		.if playAgain == 'N'
			mov ax, 1
		.endif
	.endw

	pop eax

    ret
main endp

determine_object proc answer1:DWORD, answer2:DWORD
	; determines the object we'll guess the user is thinking of based on user input
	; for example, if answer1 is 'A' and answer2 is 'Y', we'll guess that the user is thinking of a squirrel

	.if answer1 == 'A' && answer2 == 'Y'
		print "My guess is that you are thinking of a squirrel.", 13, 10
	.elseif answer1 == "A" && answer2 == "N"
		print "My guess is that you are thinking of a moose.", 13, 10
	.elseif answer1 == "V" && answer2 == "Y"
		print "My guess is that you are thinking of a watermelon.", 13, 10
	.elseif answer1 == "V" && answer2 == "N"
		print "My guess is that you are thinking of a carrot.", 13, 10
	.elseif answer1 == "M" && answer2 == "Y"
		print "My guess is that you are thinking of a paper clip.", 13, 10
	.elseif answer1 == "M" && answer1 == "N"
		print "My guess is that you are thinking of a Camaro.", 13, 10
	.endif

	print "I would ask you if I'm right, but I don't really care.", 13, 10

    ret
determine_object endp

end start                       ; end program
