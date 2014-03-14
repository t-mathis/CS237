*----------------------------------------------------------------------
* Programmer: Troy Mathis	
* Objective: To learn about branching.	
* Filename: basicmenu.s
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

				* Your code goes HERE
	lineout		title
	lineout		menu1
	lineout		menu2
	lineout		menu3
	lineout		menu4
	linein		buffer
	
	move.b		buffer,selection
	lea		selection,A0
	adda.l		#1,A0
	move.b		#'!',(A0)
	adda.l		#1,A0
	clr.b		(A0)
	
	cvta2		buffer,D0

	cmpi.b		#1,D0
	beq		one
	cmpi.b		#2,D0
	beq		two
	bra		bad
one:
	lineout		option1
	bra		DONE
two:
	lineout		option2
	bra		DONE
bad:
	lineout		optionbad
DONE:
	lineout		result

	
        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations

				* Your storage declarations go 
				* HERE
title:		dc.b	'Basic Menu Program, Troy Mathis',0
menu1:		dc.b	'Please select an option:',0
menu2:		dc.b	'(1) - Option 1',0
menu3:		dc.b	'(2) - Option 2',0
menu4:		dc.b	'Entry (1 or 2):',0
buffer:		ds.b	80
option1:	dc.b	'Option 1 is great!',0
option2:	dc.b	'Option 2 is better than Option 1!',0
optionbad:	dc.b	'Thats a bad choice!',0
result:		dc.b	'You picked: '
selection:	ds.b	4
        end
