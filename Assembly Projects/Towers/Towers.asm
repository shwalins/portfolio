comment |
***************************************************************
Programmer:  Steven Walinski
Date      :  November 18, 2014
Course    :  CS221 - Machine Organization & Assembly Lang. Programming
Project   :  This program reads in ten integers from the user, sorts
            them, and prints out the results with a table.
Assembler :  Borland TASM 3.0
File Name :  NumSort.asm

PROGRAM IDENTIFICATION SECTION:

  Input  :  3:Number of disks, starting pole, finish pole
  Output :  The movements of the disks from pole to pole (solving the algorithm)
  Input Files : None
  Output Files: None
  Purpose:  Hanoi Towers. Asks the user for a number of disks, as well as a starting
            and ending position. Then using the algorithm, it moves the disks so that
            all of them reach the destination chosen by the user. Based on the Hanoi 
            Towers puzzle.
	
PROCEDURES CALLED:

    External procedures called: 
	FROM iofar.lib: PutCrLf, GetDec, PutDec
    Internal procedures called: 
	Greet, GetNums, Hanoi
|
;****** BEGIN MAIN PROGRAM ************************************
          DOSSEG
        .model large
        .186
	  .stack 200h

;****** MAIN PROGRAM DATA SEGMENT *****************************
        .data
align word
num dw ?
start dw ?
end dw ?

;****** MAIN PROGRAM CODE SEGMENT *****************************
        .code
    extrn PutCrLf: PROC
    extrn	GetDec: PROC, PutDec: PROC

ProgramStart   PROC  NEAR
; Initialize ds register to hold data segment address
    mov	ax,@data
    mov	ds,ax

; call subroutine to print a greeting to user
    call Greet

; Pushes variable locations onto the stack in preperation
    lea bx, num
    push [bx]       ; Number of disks
    lea bx, start
    push [bx]       ; Starting Pole
    lea bx, end
    push [bx]       ; Ending Pole

; call subroutine to gather data from user
    call GetNums

; call subroutine to solve puzzle
    call Hanoi

; end of program
    mov ah,4ch    ; DOS terminate program #
    int 21h
ProgramStart	ENDP

comment |
******* PROCEDURE HEADER **************************************
  PROCEDURE NAME : Greet
  PURPOSE :  To print an initial greeting to the user
  INPUT PARAMETERS : None
  OUTPUT PARAMETERS or RETURN VALUE:  None
  NON-LOCAL VARIABLES REFERENCED: None
  NON-LOCAL VARIABLES MODIFIED :None
  PROCEDURES CALLED : 
	FROM iofar.lib: PutCrLf
  CALLED FROM : main program
|
;****** SUBROUTINE DATA SEGMENT ********************************
	 .data
Msgg1	 db  '     Welcome to the Towers of Hanoi  $'
Msgg2	 db  '     Programmer: Steven Walinski $'
Msgg3	 db  '     Date:   November 18, 2014 $'
blankline db 80 dup(32), '$'

;****** SUBROUTINE CODE SEGMENT ********************************
	  .code
Greet	  PROC near

; Save registers on the stack
        pusha
        pushf

; clears the screen
        mov cx, 25             ; prepares loop
 blank: mov dx, offset blankline ; sets pointer to blankline
        mov ah,9               ; DOS print string function #
        int 21h                ; print string 
        loop blank             ; loop back to blank

; Print program name
        mov dx, OFFSET Msgg1  ; set pointer to 1st greet message
        mov ah,9            ; DOS print string function #
        int 21h             ; print string
        call PutCrLf        ; new line

; Print name of programmer
        mov dx, OFFSET Msgg2  ; set pointer to 2nd greet message
        mov ah,9            ; DOS print string function #
        int 21h             ; print string
        call PutCrLf        ; new line

; Print date
        mov dx, OFFSET Msgg3  ; set pointer to 3rd greet message
        mov ah,9            ; DOS print string function #
        int 21h             ; print string
        call PutCrLf        ; new line
        call PutCrLf
        call PutCrLf

; Restore registers from stack
        popf
        popa

; Return to caller module
        ret
Greet   ENDP

comment |
******* PROCEDURE HEADER **************************************
  PROCEDURE NAME : GetNums
  PURPOSE :  To get input data from the user, which is to be
             used for the algrotihm later
  INPUT PARAMETERS : Passed by reference - num, start, end
  OUTPUT PARAMETERS or RETURN VALUE:  Passed by reference - num, start, end
  NON-LOCAL VARIABLES REFERENCED: None
  NON-LOCAL VARIABLES MODIFIED :None
  PROCEDURES CALLED : 
	FROM iofar.lib: PutCrLf, GetDec
  CALLED FROM : main program
|
;****** SUBROUTINE DATA SEGMENT ********************************
	 .data
Msg1	 db  'Enter (between 3 and 10) the number of disks to use: $'
Msg2	 db  'Enter (between 1 and 3) your starting tower: $'
Msg3	 db  'Enter (between 1 and 3, but not same as before) your ending tower: $'
Er     db  'Invalid Input, try again:$'

;****** SUBROUTINE CODE SEGMENT ********************************
	  .code
GetNums	  PROC near

; Save registers on the stack
        pusha
        pushf

; Ask for number of disks
        mov dx, OFFSET Msg1  ; set pointer to 1st message
        mov ah,9            ; DOS print string function #
        int 21h             ; print string
        mov bp, sp
        add bp, 0018h       ; Used to find num variable in stack
        jmp get1
        
error1:                     ; Error checking loop
        mov dx, OFFSET Er  ; Displays error message
        mov ah,9            
        int 21h 
        
get1:
        call GetDec         ; gets number from user
        cmp ax, 3
        jl error1
        cmp ax, 10          ; checks to see if its valid value
        jg error1           ; jumps otherwise
        mov [bp],ax         ; overwrites the stack space
        sub bp, 2           ; moves to next variable
        call PutCrLf        ; new line

; Ask for starting location
        mov dx, OFFSET Msg2  
        mov ah,9            ; DOS print string function #
        int 21h             ; print string
        jmp get2
        
error2:                     ; second error checking loop
        mov dx, OFFSET Er  ; displays error messag
        mov ah,9            
        int 21h 
get2:
        call GetDec         ; gets starting postion
        cmp ax, 1
        jl error2
        cmp ax, 3           ; checks if its valid
        jg error2           ; jumps otherwise
        mov [bp],ax         ; overwrites the stack
        call PutCrLf        ; new line

; Ask for ending location
        mov dx, OFFSET Msg3  
        mov ah,9            
        int 21h             
        jmp get3
        
error3:                     ; 3rd error checking loop
        mov dx, OFFSET Er  
        mov ah,9            
        int 21h 
get3:
        call GetDec         ; gets ending location
        cmp ax, 1
        jl error3
        cmp ax, 3           ; checks to see if its valid
        jg error3
        cmp ax, [bp]        ; checks if same as start
        je error3           ; jumps if it fails any of those conditions
        sub bp, 2           ; finds variable on stack
        mov [bp],ax         ; replaces it
        call PutCrLf        ; new line

; Restore registers from stack
        popf
        popa

; Return to caller module
        ret
GetNums   ENDP

comment |
******* PROCEDURE HEADER **************************************
  PROCEDURE NAME : Hanoi
  PURPOSE :  To solve the Towers of Hanoi puzzle. Uses recursion
            and use of the stack to store values and call itself
            so that it can gather new data but keep the old so
             it can come back to it later.
  INPUT PARAMETERS : By reference; num, start, end
  OUTPUT PARAMETERS or RETURN VALUE:  None
  NON-LOCAL VARIABLES REFERENCED: None
  NON-LOCAL VARIABLES MODIFIED :None
  PROCEDURES CALLED : 
	FROM iofar.lib: PutCrLf, PutDec
  CALLED FROM : main program
|
;****** SUBROUTINE DATA SEGMENT ********************************
	 .data
MovDis db ')    Moved disk $'
MovPol1 db ', from pole $'
MovPol2 db  ', to pole $'
movnum dw 0

;****** SUBROUTINE CODE SEGMENT ********************************
	  .code
Hanoi	  PROC near

; Save registers on the stack
    pusha
    pushf

; has bp point to the current stack location
    mov bp, sp

; start of algorithm
    mov ax, [bp+24] ; moves num into ax for comparison
    cmp ax, 1       ; compares
    je other        ; if equal, jumps to other to print message
    mov ax,[bp+24]  ; otherwise, move it into ax again,
    dec ax          ; decrement it
    push ax         ; and push it for recursion later
    push [bp+22]    ; pushes start for recursion later
    mov ax, 6       ; moves 6 into ax, so it can be altered
    sub ax, [bp+22] ; subtracts value of start from 6
    sub ax, [bp+20] ; subtracts value of end from 6
    push ax         ; pushes it for recursion later

; call subroutine - recursion
    call Hanoi

; print the movement of the disk
    inc movnum          ; increment movnum to display current move number
    mov ax, movnum      ; move to ax so,
    call PutDec         ; it can be displayed to user
    mov dx, OFFSET MovDis  ; set pointer to 1st part of move sentence
    mov ah,9          
    int 21h            
    mov ax, [bp+24]        ; grabs the disk number from the stack
    call PutDec            ; displays it to the user
    mov dx, OFFSET MovPol1  ; set pointer to 2nd part of sentence
    mov ah,9           
    int 21h           
    mov ax, [bp+22]           ; grabs start pole position from stack
    call PutDec               ; displays it to user
    mov dx, OFFSET MovPol2  ; set pointer to final part of sentence
    mov ah,9            
    int 21h             
    mov ax, [bp+20]           ; grabs ending position from stack
    call PutDec             ; prints it to user
    call PutCrLf        ; new line

; prepares stack for second type of recursion call
    mov ax, [bp+24]    ; moves number of disks into ax
    dec ax              ; decrements it 
    push ax             ; adds it to stack
    mov ax, 6           ; moves 6 in ax
    sub ax, [bp+22]     ; subtracts the start
    sub ax, [bp+20]     ; subtracts the end
    push ax             ; pushes new value
    push [bp+20]        ; pushes end

; call subroutine - recursion
    call Hanoi

; jump to ending
    jmp ending

other:      ; jumps here is number of disks was equal to 1
; print the movement of the disk

    inc movnum          ; increment movnum to display current move number
    mov ax, movnum      ; move to ax so,
    call PutDec         ; it can be displayed to user
    mov dx, OFFSET MovDis  ; set pointer to 1st part of move sentence
    mov ah,9          
    int 21h            
    mov ax, [bp+24]        ; grabs the disk number from the stack
    call PutDec            ; displays it to the user
    mov dx, OFFSET MovPol1  ; set pointer to 2nd part of sentence
    mov ah,9           
    int 21h           
    mov ax, [bp+22]           ; grabs start pole position from stack
    call PutDec               ; displays it to user
    mov dx, OFFSET MovPol2  ; set pointer to final part of sentence
    mov ah,9            
    int 21h             
    mov ax, [bp+20]           ; grabs ending position from stack
    call PutDec             ; prints it to user
    call PutCrLf        ; new line
    jmp ending          ; jumps to ending

ending:         ; ending of algorithm

; Restore registers from stack
    popf
    popa

; return to caller
    ret  6         ; pops return address and adds 6 to pointer

Hanoi ENDP
	end	ProgramStart