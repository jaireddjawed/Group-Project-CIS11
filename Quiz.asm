TITLE Quiz

.486                                    ; create 32 bit code
.model flat, stdcall                    ; 32 bit memory model
option casemap :none                    ; case sensitive

include \masm32\include\windows.inc     ; always first
include \masm32\macros\macros.asm

include \masm32\include\masm32.inc
include \masm32\include\gdi32.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib

; three procedures that determine whether the user answered each question correctly

determine_q1 PROTO :DWORD
determine_q2 PROTO :DWORD
determine_q3 PROTO :DWORD

.data
	; arrays that store the number of answers for each question on the quiz

	answers1 dd 1, 2, 3
	answers2 dd 1, 2
	answers3 dd 1, 2, 3 

.code                       ; code starts

start:                          ; entry point
    call main                   ; call main procedure
    exit

main proc
	; stores the answers for each question the user answers
	LOCAL question1:DWORD
	LOCAL question2:DWORD
	LOCAL question3:DWORD
	LOCAL playAgain:DWORD

	push eax
	push ebx
	push ecx

	mov ax, 0

	.while ax == 0 ; will cause quiz to rerun unless the user explicitly says not to

		; place arrays into registers
		mov eax, OFFSET answers1
		mov ebx, OFFSET answers2
		mov ecx, OFFSET answers3

		print "Let's get ready for a quiz. Here it comes...", 13, 10

		print "What is the capital of Alaska? ", 13, 10

		; print out each answer for the question along with their answer number

		print str$([eax])
		print ". Sacremento", 13, 10
		add eax, 4 ; increment array

		print str$([eax])
		print ". Austin", 13, 10
		add eax, 4

		print str$([eax])
		print ". Juneau", 13, 10

		mov question1, input("Answer: ")

		; send answer to procedure to determine if the user answered correctly
		invoke determine_q1, question1

		print "In C++, are you able to store the value 'cat' in a variable type int?", 13, 10
		
		print str$([ebx])
		print ". Yes", 13, 10
		mov ebx, 4

		print str$([ebx])
		print ". No", 13, 10

		mov question2, input("Answer: ")

		invoke determine_q2, question2

		print "How old is Bill Gates?", 13, 10

		print str$([ecx])
		print ". 62", 13, 10
		mov ecx, 4

		print str$([ecx])
		print ". 71", 13, 10
		mov ecx, 4

		print str$([ecx])
		print ". 58", 13, 10

		mov question3, input("Answer: ")

		invoke determine_q3, question3

		print "Done! Would you like to play again?", 13, 10
		print "1. Yes", 13, 10
		print "2. No", 13, 10

		; if the user states no, prevent the loop from running again
		.if playAgain == '2'
			mov ax, 1
		.endif
	.endw

	pop eax
	pop ebx
	pop ecx

    ret
main endp

determine_q1 proc answer1:DWORD
	; if the user answers correctly, print 'That's correct!' to the terminal, otherwise state the correct answer

	.if answer1 == '3'
		print "That's correct!", 13, 10
	.else
		print "You got it wrong. The correct answer was Juneau, better luck next time!", 13, 10
	.endif

	ret
determine_q1 endp

determine_q2 proc answer2:DWORD
	.if answer2 == '2'
		print "That's correct!", 13, 10
	.else
		print "You got it wrong. The value 'cat' is a string, not an integer, better luck next time!", 13, 10
	.endif

	ret
determine_q2 endp

determine_q3 proc answer3:DWORD
	.if answer3 == '1'
		print "That's correct!", 13, 10
	.else
		print "You got it wrong. Bill Gates is 62 years old, better luck next time!", 13, 10
	.endif

	ret
determine_q3 endp

end start                       ; program end
