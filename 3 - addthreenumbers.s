*----------------------------------------------------------------------
* Programmer: Troy Mathis
* Objective: To add 3 numbers.
* Filename: addthreenumbers.s
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
	lineout 	title
			
	lineout		prompt1
	linein		buffer
	cvta2		buffer,D0
	
	move.l		D0,D1		* Copy D0 into D1
	lineout		prompt2
	linein		buffer
	cvta2		buffer,D0
	add.l		D1,D0		* Sum of integers
	
	move.l		D0,D1
	lineout		prompt3
	linein		buffer
	cvta2		buffer,D0
	add.l		D1,D0
	
	cvt2a		sum,#6
	stripp		sum,#6		* Length of string in D0
	lea		sum,A0		* Load the address of sum into A0
	adda.l		D0,A0		* Move pointer to the byte after sum
	move.b		#'.',(A0)	* Put a period after sum
	adda.l		#1,A0		* Move pointer to the right 1
	clr.b		(A0)		
	lineout		result
	
        break                   	* Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations

					* Your storage declarations go 
					* HERE
title: 		dc.b	'Add 3 Numbers, Troy Mathis',0
prompt1:	dc.b	'Enter the first number: ',0
prompt2: 	dc.b	'Enter the second number: ',0
prompt3:	dc.b	'Enter the third number: ',0
buffer:		ds.b	80
result:		dc.b	'The total is: '
sum:		ds.b	8
        end
