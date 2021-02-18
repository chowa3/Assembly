@Chris Howard
@Arithmetic Multiplication

		.global		_start
_start:		mov		R0,#4		@Load integer to R0
		mov		R1,#5		@Load integer to R1
		MUL		R0,R1,R0	@R0 * R1 = R2
		mov		R7,#1		@Service command code 1 terminate
		svc		0		@Issue Linux command to terminate
		.end
