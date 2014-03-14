*----------------------------------------------------------------------
* Programmer: Troy Mathis
* Objective: To display a number the user enters.
* Filename: enteranumber.s
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
start:  initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only	
	lineout		title
	lineout 	prompt
	linein 		buffer	* Your code goes HERE
	cvta2		buffer,D0
	cvt2a		num1,#6
	stripp		num1,#6
	lea		num1,A0
	adda.l		D0,A0
	move.b		#'.',(A0)
	adda.l		#1,A0
	clr.b		(A0)
	lineout		result

        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
title:		dc.b	'Enter A Number, Troy Mathis',0
prompt:		dc.b 	'Enter a number:',0
buffer: 	ds.b 	80
result:		dc.b	'Your number was: '
num1:		ds.b	8
				* Your storage declarations go 
				* HERE
        end
