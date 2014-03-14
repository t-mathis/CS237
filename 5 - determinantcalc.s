*----------------------------------------------------------------------
* Programmer: Troy Mathis
* Objective: To find the determinant of a 2x2 or 3x3 matrix.
* Filename: determinantcalc.s
*----------------------------------------------------------------------
*
        ORG     $0
        DC.L    $3000           * Stack pointer value after a reset
        DC.L    start           * Program counter value after a reset
        ORG     $3000           * Start at location 3000 Hex
*
*----------------------------------------------------------------------
*
#minclude /home/ma/cs237/bsvc/iomacs.s
#minclude /home/ma/cs237/bsvc/evtmacs.s
*
*----------------------------------------------------------------------
*
start:  initIO                  	* Initialize (required for I/O)
	setEVT				* Error handling routines
*	initF				* For floating point macros only	

					* Your code goes HERE
	lineout		title
	
prompt:
	lineout		getmatrixsize
	linein		buffer
	cvta2		buffer,D0
	move.l		D0,D5
	
	cmpi.b		#2,D5
	beq		order2
	cmpi.b		#3,D5
	beq		order3
	cmpi.b		#0,D5
	beq		DONE
	bra		bad
	
order2:					* (X1*X3) - (X2*X4)
	lineout		by2
	lineout		sample21
	lineout		sample22
	
	lea		curentry,A0
	move.b		#'1',(A0)
	adda.l		#1,A0
	move.b		#'?',(A0)
	adda.l		#1,A0
	clr.b		(A0)
	suba.l		#2,A0
	
	lineout		whatis
	linein		buffer
	cvta2		buffer,D0
	move.w		D0,D1
	move.b		#'2',(A0)
	
	lineout		whatis
	linein		buffer
	cvta2		buffer,D0
	move.w		D0,D2
	move.b		#'3',(A0)
	
	lineout		whatis
	linein		buffer
	cvta2		buffer,D0
	move.w		D0,D3
	move.b		#'4',(A0)
	
	lineout		whatis
	linein		buffer
	cvta2		buffer,D0
	move.w		D0,D4
	
	muls		D1,D3
	muls		D2,D4	
	sub.l		D4,D3
	
	move.l		D3,D0	
	bra		DONE

order3:					* X1*(X5X9-X6X8) - X2*(X4X9*X6X7) + X3*(X4X8*X5X7)
	lineout		by3
	lineout		sample31
	lineout		sample32
	lineout		sample33
	
	lea		curentry,A0
	move.b		#'0',(A0)
	adda.l		#1,A0
	move.b		#'?',(A0)
	adda.l		#1,A0
	clr.b		(A0)
	suba.l		#2,A0

	clr.l		D1
	moveq		#8,D1
	move.b		#'1',D2
	clr.l		D3
	lea		matrixdata,A1
	
getXs:	
	move.b		D2,(A0)
	addq.b		#1,D2
	lineout		whatis
	linein		buffer
	cvta2		buffer,D0
	move.w		D0,(A1)
	adda.l		#2,A1
	dbra		D1,getXs		
	
	** B1 = X1 * (X5*X9 - X6*X8)
	move.w		matrixdata+0,D5
	move.w		matrixdata+8,D1
	move.w		matrixdata+16,D3
	move.w		matrixdata+10,D2
	move.w		matrixdata+14,D4	
	muls		D1,D3
	muls		D2,D4	
	sub.l		D4,D3
	muls		D3,D5
	move.l		D5,blockdata+0
	
	** B2 = X2 * (X4*X9 - X6*X7)
	move.w		matrixdata+2,D5
	move.w		matrixdata+6,D1
	move.w		matrixdata+16,D3
	move.w		matrixdata+10,D2
	move.w		matrixdata+12,D4
	muls		D1,D3
	muls		D2,D4	
	sub.l		D4,D3
	muls		D3,D5
	move.l		D5,blockdata+4
	
	** B3 = X3 * (X4*X8 - X5*X7)
	move.w		matrixdata+4,D5
	move.w		matrixdata+6,D1
	move.w		matrixdata+14,D3
	move.w		matrixdata+8,D2
	move.w		matrixdata+12,D4
	muls		D1,D3
	muls		D2,D4	
	sub.l		D4,D3
	muls		D3,D5
	move.l		D5,blockdata+8
	
	** B1 - B2 + B3
	move.l		blockdata+0,D1
	move.l		blockdata+4,D2
	move.l		blockdata+8,D3
	sub.l		D2,D1
	add.l		D3,D1
		
	move.l		D1,D0
	bra		DONE

bad:
	lineout		badchoice
	bra		prompt

DONE:
	cvt2a		determinant,#6
	stripp		determinant,#6
	
	lea		determinant,A0
	adda.l		D0,A0
	clr.b		(A0)	
	lineout		result

        break                   	* Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations

					* Your storage declarations go 
					* HERE
title:		dc.b	'Matrix Determinant Calculator, Troy Mathis',0
getmatrixsize:	dc.b	'Is the matrix 2x2, or 3x3? (Enter 2 or 3):',0
buffer:		ds.b	80
by2:		dc.b	'Here is a sample 2x2 matrix. Enter the values 1 at a time.',0
by3:		dc.b	'Here is a sample 3x3 matrix. Enter the values 1 at a time.',0
badchoice:	dc.b	'You have entered an incorrect entry. Try again.',0
sample21:	dc.b	'|X1 X2|',0
sample22:	dc.b	'|X3 X4|',0
sample31:	dc.b	'|X1 X2 X3|',0
sample32:	dc.b	'|X4 X5 X6|',0
sample33:	dc.b	'|X7 X8 X9|',0
matrixdata:	dcb.w	10,0
blockdata:	dcb.l	3,0
whatis:		dc.b	'What is X'
curentry:	ds.b	3
result:		dc.b	'The determinant is: '
determinant:	ds.b	10

        end
