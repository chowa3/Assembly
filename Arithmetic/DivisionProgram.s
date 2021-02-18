@Chris Howard
@Division Program using Arithmetic

		.global		_start		@Program start address.
_start:		mov		R0,#4		@Load integer into R0.
		mov		R1,#1		@Load integer into R1
		cmp		R1,#0		@IF R1 == 0
		beq		end		@Jump to end if R1 == 0
		cmp		R0,R1		@Compare R0 and R1
		bgt		while		@if R0 > R1 continue loop

while:		sub		R0,R1		@Subtract R1 from R0
		add		R3,#1		@Add 1 to iterator R3 this will also be the final answer.
		cmp		R0,R1		@Compare R0 and R1
		blt		end		@If R0 < R1 exit loop
		bl		while

end:		mov		R7,#1		@Return control to Linux
		svc		0		@Linux command to terminate program
		.end


