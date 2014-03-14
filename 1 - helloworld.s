*----------------------------------------------------------------------
* Programmer: Troy Mathis
* Objective: Hello World
* Filename: helloworld.s
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
	lineout		hello
	lineout		final

        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
title: 		dc.b		'Hello World, Troy Mathis',0
hello: 		dc.b		'Hello World',0
final:		dc.b		'So anticlimactic...',0
				* Your storage declarations go 
				* HERE
        end
