	TITLE MASM Counter Practice  (masmcounterpractice.asm)

; Author: Sam Snyder
; Course / Project ID                 Date: 5-4-2014
; Description: 
 ;This a practice project with the goal of practicing the
;following concepts in MASM:
;1. Implementing data validation
;2. Implementation of an accumulator
;3. Integer arithmetic
;4. Defining variables (integer and string)
;5. Using library procedures for I/O
;6. Implementing control structures (decision, loop, procedure)
;
 ;Specifications:
 ;Repeatedly prompt user for a number
 ;Validate user input to be less than or equal to 200
 ;Count and accumulate the valid numbers until encountering negative number
	;Discard negatives
	;Numbers over max not accumulated
 ;Track largest non-neg integer
 ;Track smallest non-neg integer
 ;Calculate (rounded integer) average
 ;Calculate (rounded integer) standard deviation
	;Do this without storing all values
 ;Display:
	;Largest number
	;Smallest
	;Count
		;Display message if none entered
	;Sum
	;Average to nearest integer
		;NOT truncated to nearest integer
	;Standard deviation rounded to the nearest integer
	;Parting message

;Further Project Constraints: 
;1. The main procedure must be modularized into commented logical sections. 
;1.1. Procedures are not required this time. 
;2. The upper limit should be defined as a constant. 
;3. The maximum and minimum values must be stored in named variables. 
;3.1. Initialize both max and min values to zero. 
;4. The code and the output must be well-formatted. 
;5. Apply the usual requirements regarding 
;5.1. Documentation. 
;5.2. Readability. 
;5.3. User-friendliness 
;6. The program must be fully documented. This includes: 
;6.1. Complete header block for identification. 
;6.2. Description. 
;6.3. Comment outline to explain each section .of code. 
;

INCLUDE Irvine32.inc

upperLimit = 200; Upper limit defined as constant

.data


debugMsg BYTE "madeit"

;Greeting data
greetingTitle BYTE "MASM Counter Practice",0
greetingCredit BYTE "by Sam Snyder",0
greetingGetName BYTE "Please enter your name: ",0
greetingName BYTE 21 DUP(0); user name
greetingHello BYTE "Hello ",0

;Instructions
instructionsStart BYTE "Enter numbers between less than or equal to ", 0
instructionsNegative BYTE "Enter a negative number to end.", 0 
instructionsInput BYTE "Enter a number: ",0

;Data
inputNumber DWORD ?

;Feedback messages
feedbackNumber BYTE "You entered ",0
feedbackError BYTE "You must enter a number less than 200",0

;Results messages
resultsMessageMax BYTE "The largest number was ",0
resultsZeroCount BYTE "No numbers were entered.",0

;Results
resultsMax DWORD 0;largest input number
resultsMin DWORD 999; smallest input number initialized to impossibly larged number
resultsCount DWORD 0; total number of numbers input
resultsAverage DWORD 0; Average of input values
resultsStdDev DWORD 0 ; standard deviation
resultsSum DWORD 0; sum of all input numbers

;Results Messages
resultsMaxMessage BYTE "Largest number: ",0
resultsMinMessage BYTE "Smallest number: ",0
resultsCountMessage	BYTE "Number count: ",0
resultsAverageMessage BYTE "Average: ",0
resultsStdDevMessage BYTE "Standard Deviation: ",0
resultsSumMessage BYTE "Sum: ",0

;GoodBye Message
goodbyeMessage BYTE "Goodbye ",0

.code
main PROC
; GREETING - display title and author, greet user

mov edx, OFFSET greetingTitle
call WriteString
call Crlf
mov edx, OFFSET greetingCredit
call WriteString
call Crlf
mov edx, OFFSET greetingGetName
call WriteString
mov edx, OFFSET greetingName
mov ecx, SIZEOF greetingName
call ReadString
call Crlf
mov edx, OFFSET greetingHello
call WriteString
mov edx, OFFSET greetingName
call WriteString
call Crlf

; INSTRUCTIONS - tell user to enter numbers in specified range
mov edx, OFFSET instructionsStart
call WriteString
mov eax, upperLimit
call WriteDec
call Crlf
mov edx, OFFSET instructionsNegative
call WriteString
call Crlf

;READ DATA
getInput:
	mov edx, OFFSET instructionsInput
	call WriteString
	call ReadInt
	call Crlf

	;VALIDATE DATA
	cmp eax, upperLimit ; 
	jg badInput ; Out of range
	cmp eax, 0
	jl printResults ; negative, display data
	mov inputNumber, eax
	jmp calculateData ;input is in range, do calculations

badInput: 
	mov edx, OFFSET feedbackError
	call WriteString
	call Crlf
	jmp getInput
		
; CALCULATE VALUES
calculateData:
	; UPDATE MAX?
	mov eax, inputNumber
	cmp eax, resultsMax
	jg newMax
afterMax:
	; UPDATE MIN?
	mov eax, inputNumber
	cmp eax, resultsMin
	jl newMin
afterMin:

	; UPDATE COUNT
	inc resultsCount

	; UPDATE SUM
	mov eax, resultsSum
	add eax, inputNumber
	mov resultsSum, eax

	; UPDATE AVERAGE
	;Div instruction reminder:
	mov edx, 0
	mov eax, resultsSum
	div resultsCount ;quotient in eax, remainder in edx
	mov resultsAverage, eax
	mov eax, 2
	mul edx
	cmp eax, resultsCount
	jge incAverage ;if 2*remainder >= divisor, then increment average

afterAverage:

	; CALCULATE STDEV--Not implemented
	jmp getInput

incAverage:
	inc resultsAverage
	jmp afterAverage

newMax:
	mov resultsMax, eax
	jmp afterMax

newMin:
	mov resultsMin, eax
	jmp afterMin

; DISPLAY DATA
printResults:

mov eax, resultsCount
cmp eax, 1
jl zeroCount ;no numbers entered, special message

mov edx, OFFSET resultsMaxMessage
mov eax, resultsMax
call WriteString
call WriteDec
call Crlf

mov edx, OFFSET resultsMinMessage
mov eax, resultsMin
call WriteString
call WriteDec
call Crlf

mov edx, OFFSET resultsCountMessage
mov eax, resultsCount
call WriteString
call WriteDec
call Crlf

mov edx, OFFSET resultsAverageMessage
mov eax, resultsAverage
call WriteString
call WriteDec
call Crlf

mov edx, OFFSET resultsSumMessage
mov eax, resultsSum
call WriteString
call WriteDec
call Crlf
jmp Goodbye

zeroCount:
mov edx, OFFSET resultsZeroCount
call WriteString
call Crlf

; GOODBYE
Goodbye:
mov edx, OFFSET goodbyeMessage
call WriteString
mov edx, OFFSET greetingName
call WriteString
call Crlf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
