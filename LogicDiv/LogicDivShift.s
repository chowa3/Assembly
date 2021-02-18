@Chris Howard
@Division using Logic Operations
/*
This program conducts long divison of binary numbers using XOR. This is a useful algorithm for Cyclic Redundancy Checks of Data.
The final answer is as follows: R2 = Remainder R4 = Quotient

Psuedo-code:
0. Initialize
R0 = Original Dividend
R1 = Original Divisor
R2 = tempDividend/Remainder
R3 = tempDivisor
R4 = Counter/Quotient
R5 = tempDividend XOR tempDivisor
R6 = tempDividend AND tempDivisor
R8 = MAX align Right!

1. Check for Divide by Zero
2. Check for Division Possible
3. Align Divisor to Dividend (_alignL) Initial
	a. Logical shift left: tempDivisor
	b. Increment R8 counter for max align right.
	c. Is tempDivisor < tempDividend?
	d. If tempDivisor < tempDividend
		-Branch to _alignL
4. XOR
	a. xor tempDividend with tempDivisor
	b. Logical shift left: quotient (counter) <<<<<<<<<<REMOVED
	c. Add 1: quotient (counter) <<<<<<<<<<<<<<<<<<<<REMOVED
5. Align Divisor to Dividend (_alignR) Post Subtraction
	a. Logical Shift Right tempDivisor
	b. Verify if max right shifts has been met
	d. Logical Shift Left Quotient (counter) <<<<<<<REMOVED
6. msbEqual
	a. MSB is equal if (see Z Order Curve)
		-tempDividend XOR tempDivisor <= tempDividend AND tempDivisor
		-eor tempDividend, tempDivisor, R5
		-and tempDividend, tempDivisor, R6
		-cmp R5,R6
		-R5 < R6 = add 1 to quotient branch to _XOR
		-R5 == R6 = add 1 to quotient branch to _XOR
		-R5 > R6 = lsl quotient then branch to _alignR
*/
		.global	_start
_start:		mov	R0,#0b101111	@Move binary Dividend 10111 to R0
		mov	R1,#0b1111	@Move binary Divisor 1111 to R1
		mov	R2,R0		@Move dividend to tempDividend
		mov	R3,R1		@Move divisor to tempDivisor
		mov	R8,#1		@Initialize R8 with value of 1 (do...while). MaxAlignRightCounter
		cmp	R1,#0		@Is the divisor 0?
		beq	end		@If divisor is 0 goto end.
		cmp	R0,R1		@Is the dividend less than divisor?
		beq	end		@If the dividend < divisor goto end.

_alignL:	lsl	R3,R3,#1	@Logical shift left tempDivisor.
		add	R8,#1		@Increment MAX align Right for tempDivisor.
		cmp	R3,R2		@Is the tempDivisor < tempDividend
		blt	_alignL		@If tempDivisor < tempDividend loop back to alignL.

_xor:		eor	R2,R3,R2	@XOR tempDividend with tempDivisor and store in tempDividend.

_alignR:	lsr	R3,R3,#1	@Logic shift right temp divisor.
		sub	R8,#1		@Decrement MAX alignRight
		cmp	R8,#0		@Has tempDivisor reached max alignRight?
		beq	_stop		@if R8 == 0 stop.

_msbTest:	eor	R5,R2,R3	@XOR tempDividend with tempDivisor. Save in R5.
		and	R6,R2,R3	@AND tempDividend with tempDivisor. Save in R6.
		cmp	R5,R6		@Compare R5 and R6
		blt	_msbEqual	@R5<R6 = msb Equal.
		beq	_msbEqual	@R5==R6 = msb Equal.
		bgt	_msbNot		@R5>R6	= msb not Equal.

_msbEqual:	lsl	R4,R4,#1	@Logical Shift Left: Quotient R4
		add	R4,#1		@add 1 to quotient
		b	_xor		@branch to _xor unconditionally

_msbNot:	lsl	R4,R4,#1	@Logical Shift Left: Quotient R4
		b	_alignR		@msb not equal branch to _alignR

_stop:		mov 	R7,#1		@Service command code 1 terminates this program
		svc	0		@Issue linux command to terminate program.
		.end
