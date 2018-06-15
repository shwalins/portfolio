comment |
***************************************************************
Programmer:  Steven Walinski
Date      :  October 20, 2014
Course    :  CS221 - Machine Organization & Assembly Lang. Programming
Project   :  This program reads in ten integers from the user, sorts
            them, and prints out the results with a table.
Assembler :  Borland TASM 3.0
File Name :  NumSort.asm

PROGRAM IDENTIFICATION SECTION:

  Input  :  Ten integers (values of tabl1.)
  Output :  Ten integers, sorted and unsorted (values of tabl1 and tabl2.)
  Input Files : None
  Output Files: None
  Purpose:  Sorts the integers given by the user, and prints a table with 
            the original and a new sorted list.
	
PROCEDURES CALLED:

    External procedures called: 
	FROM iofar.lib: PutCrLf, GetDec, PutDec
    Internal procedures called: 
	Greet, InsertionSort
|
;****** BEGIN MAIN PROGRAM ************************************
        DOSSEG
	.186
	.model large
	.stack 200h

;****** MAIN PROGRAM DATA SEGMENT *****************************
       .data
align word
tabl1 dw 10 dup(?)
tabl2 dw 10 dup(?)
Prompt db ' Please enter any ten integers: $'
name1 db ' Unsorted List $'
name2 db '  Sorted List  $'
flrcnt dw 33
spacer db '         $'
dist equ tabl2-tabl1
count dw 10

;****** MAIN PROGRAM CODE SEGMENT *****************************
        .code
        extrn PutCrLf: PROC
        extrn GetDec: PROC, PutDec: PROC

ProgramStart PROC NEAR 
; Initialize ds register to hold data segment address
        mov ax,@data
        mov ds, ax

; call subroutine to print a greeting to user
        call Greet

; prepares array and loop for which integers will be read into
        mov cx, count
        lea bx, tabl1

; prompt user for an integer and input the integer from keyboard
	  mov dx,OFFSET Prompt  ; point to the Prompt mesg
	  mov ah,9   ; DOS print string function #
	  int 21h    ; print string
        call PutCrLf  ; newline

; loop to gather numbers from user
  getNums:
        call GetDec  ; waits for user input
        mov [bx], ax    ; moves this value into array
        mov [bx+dist], ax  ; moves this value into 2nd array
        push [bx+dist]      ; pushes parameter into stack for later
        add bx, 0002h       ; increments to move to next value
        loop getNums        ; loops until 10 integers are taken in

; call subroutine to sort the array
        call InsertionSort

; loop to copy the sorted values into the 2nd array
        mov cx, count
  transfer:
        pop [bx]  ; pops value and places it in array
        add bx, 0002h  ; moves to next array position
        loop transfer  ; loops until all values are replaced

        mov si, 0
        call PutCrLf

; loop to create the table
  Prefloor:
        mov cx, flrcnt ;  moves length of row into cx
  floormaker:
        mov ah, 2                     
        mov dl, 219  ; ascii value for block                  
        int 21h
        loop floormaker  ; loops until row of blocks is made
        call PutCrLf

; checks to see if number of rows needed has been meet
        cmp si, 19
        jg finish  ; jumps to end if so

; jumps to value if si has been incremented
        cmp si, 0
        jg value 

;  section to print the heading of the table
  label:
        mov ah, 2
        mov dl, 219
        int 21h   ; used to print the ascii block
        mov dx, OFFSET name1 ; points to 1st column name
        mov ah,9   
        int 21h   ; prints the string
        mov ah, 2
        mov dl, 219
        int 21h    ; prints the block
        mov dx, OFFSET name2  ; points to 2nd column name
        mov ah,9
        int 21h    ; prints block again
        mov ah, 2
        mov dl, 219
        int 21h     ; prints block again
        call PutCrLf 
        inc si     ; increments si
        jmp Prefloor   ; jumps to create row of blocks

; section to print values in the table
  value:
        dec si   ; decrements so its in proper place
        mov ah, 2
        mov dl, 219
        int 21h   ; prints block
        mov ax, tabl1[si]   ; puts 1st table value in ax
        call PutDec        ; procedure to print value in ax
        mov dx, OFFSET spacer ; points to the spacer
        mov ah,9
        int 21h   ; prints string, spacer used to organize column
        mov ah, 2
        mov dl, 219
        int 21h     ; prints block 
        mov ax, tabl2[si]   ; puts 2nd table value in ax
        call PutDec     ; prints value in ax
        mov dx, OFFSET spacer    ; points to spacer
        mov ah,9
        int 21h         ; prints the spacer 
        mov ah, 2
        mov dl, 219
        int 21h        ; prints the block
        call PutCrLf 
        add si ,3      ; increments to prepare for next iteration     
        jmp Prefloor    ; jumps to print floor

; end of the program
  finish:
        mov ah,4ch    ; DOS terminate program #
        int 21h
ProgramStart ENDP

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
Msgg1	 db  '     Welcome to the numerical sorting program  $'
Msgg2	 db  '     Programmer: Steven Walinski $'
Msgg3	 db  '     Date:   October 20, 2014 $'
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
  PROCEDURE NAME : InsertionSort
  PURPOSE :  Sorts the elements passed in through the stack
            using a temporary array, and modifies the original
            stack values
  INPUT PARAMETERS :
	     Pass by reference parameter - tabl2
  OUTPUT PARAMETERS:
	     Pass by reference parameter - tabl2
  NON-LOCAL VARIABLES REFERENCED: None
  NON-LOCAL VARIABLES MODIFIED :None
  PROCEDURES CALLED : 
	FROM iofar.lib: PutCrLf
  CALLED FROM : Main Program
|
;****** SUBROUTINE DATA SEGMENT ********************************
        .data
temp    dw 10 dup(?)
counter dw 10

;****** SUBROUTINE CODE SEGMENT ********************************
	.code
InsertionSort PROC near

; Save registers on the stack
        pusha
        pushf

; set up bp register to point to parameter
        mov bp,sp

; prepares loop and temp array
        mov cx, counter
        lea bx, temp

; loop to add values from stack to the temp array
        add bp, 0026h ; adds hex value to find first element 
  tempmaker: 
        mov ax, [bp] ; moves element into register
        mov [bx],ax  ; moves value to the temp array
        sub bp, 2    ; decrements to point to next stack element
        add bx, 0002h ; moves to next position in array
        loop tempmaker ; loops until all elements are in

        mov cx,2        ; makes cx hold 2, for seconds element position

; insertion sorting method using a series of loops
  outerloop: 
        mov dx,cx  ; moves value cx into dx
        dec dx       ; takes away 1 from dx
        mov si,dx    ; moves dx into si
        add si,si    ; adds value of si to itself
        mov ax,[si]  ; moves the value at si to ax
        mov ax,temp[si] ; moves the value of the array at si postion to ax 
  innerloop: 
        cmp temp[si-2],ax ; compares value one postion of array to another
        jle outside ; jumps if true
        mov di,temp[si-2]  ; moves the value into di register
        mov temp[si],di    ; moves the value into other array position
        sub si, 2        ; decrements si by 2
        dec dx              ; decrements dx
        jnz innerloop       ; recursion until hits zero      
  outside: 
        mov temp[si],ax ; move ax into temp array
        inc cx         ; increment cx by 1
        cmp cx,counter ; compare the counter and cx
        jle outerloop  ; if less than, go back to starting loop

; resetup bp register to point to parameter
        mov bp,sp
        mov cx, counter
        mov si, 0
        lea bx, temp

; loop to rewrite values on stack
        add bp,0014h  ;  repostions to point to parameters
  overwrite:  
        mov ax,temp[si]  ; moves value in ax
        mov [bp],ax    ; moves ax into stack
        add bp, 2    ; increments stack
        add si, 2   ;  increments array position
        add bx, 0002h  ; increments bx
        loop overwrite  ; loops until all 10 are recopied

; resetup bp register
        mov bp,sp

; restore registers and return to main function
        popf
        popa
        ret  

InsertionSort ENDP
        end ProgramStart
