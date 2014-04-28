	TITLE Silly Counter     (sillycounter.asm)

; Author: Sam Snyder
; Course / Project ID                 Date: 4-25-2014
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
;6.3. Comment outline to explain each section .of code. ;

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

; (insert data definitions here)

.code
main PROC
; GREETING

; INSTRUCTIONS

; READ DATA

; VALIDATE DATA

; CALCULATE SUM

; CALCULATE AVERAGE

; CALCULATE STDEV

; DISPLAY DATA

; GOODBYE

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
