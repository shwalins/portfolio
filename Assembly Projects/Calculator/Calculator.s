#########################################################################################
#########################################################################################
#		Version 1.0
#
#	- Project completed.
#
#########################################################################################
#########################################################################################

.globl main


.data 
a:	        .half 0 
b:	        .half 0xFFFF 
c:	        .half 0xCE20 
d:	        .half 1 
e:	        .half 102 
exp:	    .asciiz	"e:=e   - 43 *     e+   e%17+462    - c   /   4"

.text

main:

#####################################################################################################################
####### Section 1 - Input Loop ######################################################################################
#
#     $t0 - null terminator, $t2 - syntax buffer, $t3 - sign buffer
#
#     $t1 - all purpose character checker, $s1 - string iterator, $s0 - char in string
#
#####################################################################################################################

	addi $t0, $0, 0x00	#initialize $t0 as null terminator
	lui $s1, 0x1000
	addi $s1, $s1, 10	#prepares s1 to iterate through the string


	add $t2, $0, 1		#syntax buffer: initialized as 1. -1 for variable/number, +1 for syntax. If 2 or -1, print error
	add $s3, $0, $0		#initializes sign buffer as 0

start:

	lb $s0, ($s1)		#stores character at current point in string at $s0
	or $0, $0, $0

	beq $s0, $t0, prestacktime 
	or $0, $0, $0		#if char in s0 is null terminator, jump to stack section

	addi $t1, $0, 0x25      #ascii value of %
	beq $t1, $s0, preop
	or $0, $0, $0

	addi $t1, $0, 0x2a      #ascii value of *
	beq $t1, $s0, preop
	or $0, $0, $0

	addi $t1, $0, 0x2b      #ascii value of +
	beq $t1, $s0, preop
	or $0, $0, $0

	addi $t1, $0, 0x2d      #ascii value of -
	beq $t1, $s0, swap
	or $0, $0, $0

	addi $t1, $0, 0x2f      #ascii value of /
	beq $t1, $s0, preop
	or $0, $0, $0

	addi $t1, $0, 0x20      #ascii value of ' '
	beq $t1, $s0, skip
	or $0, $0, $0

	addi $t1, $0, 0x3a      #ascii value of :
	beq $t1, $s0, assignment
	or $0, $0, $0

	addi $t1, $0, 0x30      #ascii value of 0
	beq $t1, $s0, numberget
	or $0, $0, $0

	addi $t1, $0, 0x31      #ascii value of 1
	beq $t1, $s0, numberget
	or $0, $0, $0

	addi $t1, $0, 0x32      #ascii value of 2
	beq $t1, $s0, numberget
	or $0, $0, $0

	addi $t1, $0, 0x33      #ascii value of 3
	beq $t1, $s0, numberget
	or $0, $0, $0

	addi $t1, $0, 0x34      #ascii value of 4
	beq $t1, $s0, numberget
	or $0, $0, $0

	addi $t1, $0, 0x35      #ascii value of 5
	beq $t1, $s0, numberget
	or $0, $0, $0

	addi $t1, $0, 0x36      #ascii value of 6
	beq $t1, $s0, numberget
	or $0, $0, $0

	addi $t1, $0, 0x37      #ascii value of 7
	beq $t1, $s0, numberget
	or $0, $0, $0

	addi $t1, $0, 0x38      #ascii value of 8
	beq $t1, $s0, numberget
	or $0, $0, $0

	addi $t1, $0, 0x39      #ascii value of 9
	beq $t1, $s0, numberget
	or $0, $0, $0

	addi $t1, $0, 0x61      #ascii value of a
	beq $t1, $s0, variablea
	or $0, $0, $0

	addi $t1, $0, 0x62      #ascii value of b
	beq $t1, $s0, variableb
	or $0, $0, $0

	addi $t1, $0, 0x63      #ascii value of c
	beq $t1, $s0, variablec
	or $0, $0, $0

	addi $t1, $0, 0x64      #ascii value of d
	beq $t1, $s0, variabled
	or $0, $0, $0

	addi $t1, $0, 0x65      #ascii value of e
	beq $t1, $s0, variablee	
	or $0, $0, $0

	j error			#anything else, jumps to error section
	or $0, $0, $0

				#checks the character at that instance in the string, and jumps
				#depending on what the read in character is.


#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
####### Section 2 - Loop Functions ######################################################
#
#     swap - increments the sign buffer so that the next number read in will be negated
#	     before it's stored to the stack. Called when '-' is read in.
#
#     variable()/varidone - Called when the associated variable is read in. Loads it's
#            value stored in the memory address, negates it if sign buffer is equal to 1,
#	     and stores it onto the stack.
#
#     skip - Last jump before it jumps back to the start of the loop. Purpose is to be
#	     the place where all the different possible loop strands converge at. Increments
#	     the string iterator by one and jumps back to the start.
#
#     assignment - Called when ':' is read. Checks the next character to make sure it is 
#		   a '=' otherwise it prints out an error. If it is, '=' is stored onto 
#		   the stack so that when stack operations are being performed, that loop
#		   knows it stops when it sees '='
#
#     numberget - Called when a number character is read in. Jumps and links to a series of
#                 loops that reads in and stores the number, taking care if it's greater than
#		  ten. See section 3 for in-depth guide to how it works.
#    
#
#########################################################################################

swap:

	addi $s3, $0, 1			#raises sign buffer
	
	j skip
	or $0, $0, $0

#########################################################################################

variablea:

	lui $t5, 0x1000			#loads address of a
	lh $s0, ($t5)			#stores value of a in s0
	or $0, $0, $0 

	j varidone
	or $0, $0, $0	

#########################################################################################

variableb:

	lui $t5, 0x1000			#loads address of a
	addi $t5, $t5, 2		#increments address by 2 to get address of b
	lh $s0, ($t5)			#stores value of b in s0
	or $0, $0, $0 

	j varidone
	or $0, $0, $0

#########################################################################################

variablec:

	lui $t5, 0x1000			#loads address of a
	addi $t5, $t5, 4		#increments address by 4 to get address of c
	lh $s0, ($t5)			#stores value of c in s0
	or $0, $0, $0 

	j varidone
	or $0, $0, $0
	
#########################################################################################

variabled:

	lui $t5, 0x1000			#loads address of a
	addi $t5, $t5, 6		#increments address by 6 to get address of d
	lh $s0, ($t5)			#stores value of d in s0
	or $0, $0, $0 

	j varidone
	or $0, $0, $0

#########################################################################################

variablee:

	lui $t5, 0x1000			#loads address of a
	addi $t5, $t5, 8		#increments address by 8 to get address of e
	lh $s0, ($t5)			#stores value of e in s0
	or $0, $0, $0 

#########################################################################################

varidone:
	
	sh $s0, ($sp)		#pushes value onto stack
	or $0, $0, $0
	sub $sp, $sp, 4		#subtract stack pointer

	beq $0, $s3, skip	#if sign buffer is equal to zero, jump to skip
	or $0, $0, $0

	add $sp, $sp, 4		#otherwise, add to the stack pointer

	sub $s0, $0, $s0	#negate the value stored in s0

	sh $s0, ($sp)		#pushes the negated number onto the stack
	or $0, $0, $0
	sub $sp, $sp, 4		#subtract stack pointer again

	add $s3, $0, $0	        #set the sign buffer back to zero, and go to skip

	j skip
	or $0, $0, $0

#########################################################################################

skip:
	
	addi $s1, $s1, 1	#iterate through the string by 1
	j start			#goes back to the start of the loop
	or $0, $0, $0

#########################################################################################

assignment:

	#check to see if next character is "=", if not error out
	#push special character onto stack
	#increment syntax buffer

	addi $s1, $s1, 1	#iterate through the string by 1

	addi $s0, $0, 0x3d
	sb $s0, ($sp)		#pushes character onto stack
	or $0, $0, $0
	sub $sp, $sp, 4		#subtract stack pointer

	j skip
	or $0, $0, $0

#########################################################################################

numberget:

	jal prenum		#jump and links to numbergetting section
	or $0, $0, $0

	j skip
	or $0, $0, $0

#######################################################################################
#######################################################################################
####### Section 3 - Number Get ########################################################
#
#     prenum - Prepares registers for reading in numbers greater than ten. Stores the
#	       initial number and stack pointer incase the number being read in isn't
#	       greater than ten. Runs through checkers to see if the next character isn't
#	       a number, and if it isn't it will jump to the lessthanten section.
#
#     number - If next character was a number, then the code runs into this section. Here
#              it subtracts this character by 48 to convert it from a character to an integer.
#              It checks if this number is greater than 9 and less than 0 in order to tell if
#              the number is actually a number and not an invalid character, and errors out if
#              so. Otherwise, it will multiply the first number read in by 10, and then add our
#              2nd number read in to it. It will then iterate a 3rd time to check if it's
#              not a operator or the null-terminator. If it isn't it will loop back to itself
#              and repeat the same process as above. Otherwise it jumps to postnum.
#
#     postnum - Replaces the string iterator with the temp iterator's position - 1. Stores the
#		resulting number onto the stack. Also checks the sign buffer, and negates it
#		if the sign buffer is equal to one. If not, it jumps to nonneg section.
#
#     lessthanten - Stores the original number onto the stack, and as in postnum, it checks the
#		    sign buffer and repeats those same steps.
#
#     nonneg - Where lessthanten and postnum converge if the signbuffer is equal to zero.
#   	       Purpose is to offer the jr function.
#
#######################################################################################

prenum:

	add $t5, $0, $0		#cleans register incase multiple numbers greater than 10

	sub $s0, $s0, 48	#changes the character into an integer 
	add $t5, $0, $s0	#t5 is given s0's value so it can be used later on

	addi $s6, $s1, 1	#s6 is now the temp iterator. 

	lb $t4, ($s6)		#stores next number in a temp
	or $0, $0, $0

	addi $t1, $0, 0x20      #ascii value of ' '
	beq $t1, $t4, lessthanten
	or $0, $0, $0	

	addi $t1, $0, 0x25      #ascii value of %
	beq $t1, $t4, lessthanten
	or $0, $0, $0

	addi $t1, $0, 0x2a      #ascii value of *
	beq $t1, $t4, lessthanten
	or $0, $0, $0

	addi $t1, $0, 0x2b      #ascii value of +
	beq $t1, $t4, lessthanten
	or $0, $0, $0

	addi $t1, $0, 0x2d      #ascii value of -
	beq $t1, $t4, lessthanten
	or $0, $0, $0

	addi $t1, $0, 0x2f      #ascii value of /
	beq $t1, $t4, lessthanten
	or $0, $0, $0

	beq $t0, $t4, lessthanten
	or $0, $0, $0

	#if the next character read in is one of the characters above, we can assume 
	#the number stored in s0 is gonna be less than 10. Otherwise the code continues.

##################################################################################################		

number:
	#store number in temp
	#iterate by 1. If whitespace, store number.
	#otherwise, call multiply with that number and 10, then add the newest number.
	#jump to number, so that it's recursive

	#when done:
	#decrements syntax buffer, the pushes the number
	#iterates to check if number is 10/100/1000 etc.

	#t5 - temp adder
	#s6 is temp iterator
	#t4 is temp checker
		
	sub $t4, $t4, 48		#converts character to integer

	bltz $t4, error
	or $0, $0, $0
	sub $t4, $t4, 9
	bgtz $t4, error
	or $0, $0, $0
	addi $t4, $t4, 9		#checks in order to see if the number read in is a valid
					#number and not a character

	addi $t7, $0, 10		#stores 10 in t7 in order to prepare for multiplication



	add $t0, $0, 1
	add $a0, $0, $t5
	
multloop1:
	

	add $t5, $a0, $t5
	addi $t0, $t0, 1
	bne $t7, $t0, multloop1
	or $0, $0, $0



	add $t0, $0, $0

	add $t5, $t5, $t4	#addes t4 to t5*10
	
	addi $s6, $s6, 1	#temporarilly iterate through the string by 1

	lb $t4, ($s6)		#stores next number in a temp
	or $0, $0, $0

	addi $t1, $0, 0x25      #ascii value of %
	beq $t1, $t4, postnum
	or $0, $0, $0

	addi $t1, $0, 0x2a      #ascii value of *
	beq $t1, $t4, postnum
	or $0, $0, $0

	addi $t1, $0, 0x2b      #ascii value of +
	beq $t1, $t4, postnum
	or $0, $0, $0

	addi $t1, $0, 0x2d      #ascii value of -
	beq $t1, $t4, postnum
	or $0, $0, $0

	addi $t1, $0, 0x2f      #ascii value of /
	beq $t1, $t4, postnum
	or $0, $0, $0

	addi $t1, $0, 0x20      #ascii value of ' '
	beq $t1, $t4, postnum
	or $0, $0, $0

	beq $t4, $t0, postnum
	or $0, $0, $0

	j number
	or $0, $0, $0

#########################################################################################
	
postnum:

	add $s1, $s6, $0	#replace sting iterator's value with temps new value - 1
	sub $s1, $s1, 1
	
	sh $t5, ($sp)		#pushes character onto stack
	or $0, $0, $0
	sub $sp, $sp, 4		#subtract stack pointer

				#s3 sign buffer checker            
	beq $0, $s3, nonneg
	or $0, $0, $0

	add $sp, $sp, 4		#subtract stack pointer

	sub $t5, $0, $t5

	sh $t5, ($sp)		#pushes character onto stack
	or $0, $0, $0
	sub $sp, $sp, 4		#subtract stack pointer
		
	add $s3, $0, $0
	jr $ra
	or $0, $0, $0

######################################################################################

lessthanten:

	sh $s0, ($sp)		#pushes character onto stack
	or $0, $0, $0
	sub $sp, $sp, 4		#subtract stack pointer


				#s3 sign buffer check
	beq $0, $s3, nonneg
	or $0, $0, $0

	add $sp, $sp, 4		#subtract stack pointer

	sub $s0, $0, $s0


	sh $s0, ($sp)		#pushes character onto stack
	or $0, $0, $0
	sub $sp, $sp, 4		#subtract stack pointer

	add $s3, $0, $0	

####################################################################################

nonneg:

	jr $ra
	or $0, $0, $0

#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
####### Section 4 - Stack Manipulation ##################################################
#
#     prestacktime - Preps the stackpointer so it points to the first value in the stack.
#		     Initializes t3 as an adder, as well as t7 to check for '='
#
#     stacktime - Loop that pops values off the stack, and adds them together until it sees
#	          the '=' character.
#
#     end/final() - Checks the last value on the stack, and compares it to the values stored
#		    in the variables above. When the match is found, the new value replaces
#		    the old value in the variable.
#    
#
#########################################################################################

prestacktime:		

	add $sp, $sp, 4
	add $t3, $0, $0		#preps t3 to be an adder
	addi $t7, $0, 0x3d	#preps so that it can be compared to find '='


#########################################################################################

stacktime:

	add $t1, $0, $0

	lh $t1, ($sp)		#pops a number off the stack
	or $0, $0, $0

	beq $t1, $t7, end	#if the number is '=' go to end
	or $0, $0, $0

	add $t3, $t3, $t1	#otherwise add it to the adder

	add $sp, $sp, 4		#increment the stack pointer
	
	j stacktime		#loop to itself
	or $0, $0, $0

#########################################################################################

end:	

	add $t1, $0, $0
	add $sp, $sp, 4

	lh $t1, ($sp)		#loads the next value after '='
	or $0, $0, $0

	lui $t7, 0x1000		#loads address of a
	or $0, $0, $0

	lh $t6, ($t7)		#loads value stored at a
	or $0, $0, $0

	bne $t1, $t6, finalb	#if they don't match, jump to finalb
	or $0, $0, $0

	sh $t3, ($t7)		#otherwise save new value to variable a
	or $0, $0, $0	

	j done
	or $0, $0, $0

#####################################################################################

finalb:

	addi $t7, $t7, 2	#iterates through the address

	lh $t6, ($t7)		#loads value of b
	or $0, $0, $0

	bne $t1, $t6, finalc	#compares, and if they arent equal, go to finalc
	or $0, $0, $0

	sh $t3, ($t7)		#otherwise, same as above, saves to b
	or $0, $0, $0

	j done
	or $0, $0, $0

#####################################################################################


finalc:		#finalc, finald, and finale are all the same concept, compare values
		#and store if a match

	addi $t7, $t7, 2

	lh $t6, ($t7)
	or $0, $0, $0

	bne $t1, $t6, finald
	or $0, $0, $0

	sh $t3, ($t7)		
	or $0, $0, $0

	j done
	or $0, $0, $0

####################################################################################

finald:

	addi $t7, $t7, 2

	lh $t6, ($t7)
	or $0, $0, $0

	bne $t1, $t6, finale
	or $0, $0, $0

	#same as a

	sh $t3, ($t7)			
	or $0, $0, $0

	j done
	or $0, $0, $0

##################################################################################

finale:
	
	addi $t7, $t7, 2

	lh $t6, ($t7)
	or $0, $0, $0

	bne $t1, $t6, error		#if the last value doesn't match, it jumps to error
	or $0, $0, $0

	sh $t3, ($t7)			
	or $0, $0, $0

	j done
	or $0, $0, $0


#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
####### Section 5 - Operations   ########################################################
#
#     preop - Preforms the same kind of loops as the number get loop above, except that
#	      it eats up whitespace until a character is found, and if the character
#	      isn't a number, it jumps to an error message. It then goes onto less whitespace
#	      where it checks to see if the next value was a variable or not. Otherwise, it
#	      jump and links to the the number section.
#
#     multiply - Pops the first two numbers off the stack and then checks them to see if theyre
#		 negative or not. Negates them if so, and records it in the sign buffer. 
#		 Performs the multiplication loop, and then negates the number depending on
#		 the sign buffer. Store the result onto the stack.
#
#     divide - Algorithm implemented in Project 0. The design was taken from the textbook,
#	      where it performs a series of shifts to find the quotient. Does also the same
#	      as multiply in regards to the negative numbers.
#
#     modulus - Checks the initial read in sign, and stores the remainder register onto the
#		stack instead.
#    
#
#########################################################################################


iswhitespace:

	
	addi $s6, $s6, 1

	lb $t4, ($s6)		#stores character at current point in string at $s0
	or $0, $0, $0


	
	addi $t1, $0, 32      #ascii value of ' '
	beq $t1, $t4, iswhitespace
	or $0, $0, $0


	addi $t1, $0, 0x25      #ascii value of %
	beq $t1, $t4, error
	or $0, $0, $0

	addi $t1, $0, 0x2a      #ascii value of *
	beq $t1, $t4, error
	or $0, $0, $0

	addi $t1, $0, 0x2b      #ascii value of +
	beq $t1, $t4, error
	or $0, $0, $0

	addi $t1, $0, 0x2d      #ascii value of -
	beq $t1, $t4, error
	or $0, $0, $0

	addi $t1, $0, 0x2f      #ascii value of /
	beq $t1, $t4, error
	or $0, $0, $0

	beq $t4, $t1, error
	or $0, $0, $0


	j lesswhitespace
	or $0, $0, $0


######################################################################################

preop:


#leads into mult,div,mod sections
#deals with negatives and such
#take note of what sign was read in
#jump to mult or div section

	add $s7, $s0, $0	# stores sign

	add $t5, $0, $0		#cleans register incase multiple numbers greater than 10

	#t5 - temp adder
	#t6 is temp iterator
	#t4 is temp checker

	addi $t1, $0, 0x2b      #ascii value of +
	beq $t1, $s0, skip
	or $0, $0, $0




	addi $s6, $s1, 1

	lb $t4, ($s6)		#stores character at current point in string at $s0
	or $0, $0, $0
	
	
	
	
	addi $t1, $0, 0x20      #ascii value of ' '
	beq $t1, $t4, iswhitespace
	or $0, $0, $0

	addi $t1, $0, 0x25      #ascii value of %
	beq $t1, $t4, error
	or $0, $0, $0

	addi $t1, $0, 0x2a      #ascii value of *
	beq $t1, $t4, error
	or $0, $0, $0

	addi $t1, $0, 0x2b      #ascii value of +
	beq $t1, $t4, skip
	or $0, $0, $0

	addi $t1, $0, 0x2d      #ascii value of -
	beq $t1, $t4, swap
	or $0, $0, $0

	addi $t1, $0, 0x2f      #ascii value of /
	beq $t1, $t4, error
	or $0, $0, $0

	beq $t4, $t1, error
	or $0, $0, $0



lesswhitespace:

	#character checker

	add $s1, $s6, $0

	addi $t1, $0, 0x61      #ascii value of a
	bne $t1, $t4, next1
	or $0, $0, $0

	lui $t1, 0x1000
	lh $t5, ($t1)			#stores 5 in a0
	or $0, $0, $0 
	sh $t5, ($sp)		#pushes character onto stack
	or $0, $0, $0
	sub $sp, $sp, 4	

	j isvariable
	or $0, $0, $0



next1:
	addi $t1, $0, 0x62      #ascii value of b
	bne $t1, $t4, next2
	or $0, $0, $0

	lui $t1, 0x1000
	addi $t1, $t1, 2
	lh $t5, ($t1)			#stores 5 in a0
	or $0, $0, $0 
	sh $t5, ($sp)		#pushes character onto stack
	or $0, $0, $0
	sub $sp, $sp, 4	

	j isvariable
	or $0, $0, $0


next2:
	addi $t1, $0, 0x63      #ascii value of c
	bne $t1, $t4, next3
	or $0, $0, $0

	lui $t1, 0x1000
	addi $t1, $t1, 4
	lh $t5, ($t1)			#stores 5 in a0
	or $0, $0, $0 
	sh $t5, ($sp)		#pushes character onto stack
	or $0, $0, $0
	sub $sp, $sp, 4	

	j isvariable
	or $0, $0, $0

next3:
	addi $t1, $0, 0x64      #ascii value of d
	bne $t1, $t4, next4
	or $0, $0, $0

	lui $t1, 0x1000
	addi $t1, $t1, 6
	lh $t5, ($t1)			#stores 5 in a0
	or $0, $0, $0 
	sh $t5, ($sp)		#pushes character onto stack
	or $0, $0, $0
	sub $sp, $sp, 4	

	j isvariable
	or $0, $0, $0


next4:
	addi $t1, $0, 0x65      #ascii value of e
	bne $t1, $t4, notavariable
	or $0, $0, $0

	lui $t1, 0x1000
	addi $t1, $t1, 8
	lh $t5, ($t1)			#stores 5 in a0
	or $0, $0, $0 
	sh $t5, ($sp)		#pushes character onto stack
	or $0, $0, $0
	sub $sp, $sp, 4	

	j isvariable
	or $0, $0, $0


notavariable:

	jal number
	or $0, $0, $0

isvariable:

	addi $t1, $0, 0x25      #ascii value of %
	beq $t1, $s7, divide
	or $0, $0, $0

	addi $t1, $0, 0x2a      #ascii value of *
	beq $t1, $s7, multiply
	or $0, $0, $0

	addi $t1, $0, 0x2f      #ascii value of /
	beq $t1, $s7, divide
	or $0, $0, $0



	

########################################################################################################

multnegchecky:

	addi $s3, $s3, 1

	sub $s6, $0, $s6

	j multswappedy
	or $0, $0, $0

multnegcheckx:

	addi $s3, $s3, 1

	sub $s5, $0, $s5

	beq $s3, 2, multdoubleneg
	or $0, $0, $0

	j multswappedx
	or $0, $0, $0	


multdoubleneg:

	add $s3, $0, $0
	j multswappedx
	or $0, $0, $0
	


multiply:

#mult algorith
#check signbuffer
#store number, jump back to start

	add $sp, $sp, 4

	lh $s6, ($sp)
	or $0, $0, $0


	sh $0, ($sp)
	or $0, $0, $0

	add $sp, $sp, 4

	lh $s5, ($sp)
	or $0, $0, $0


	bltz $s6, multnegchecky
	or $0, $0, $0
multswappedy:

	bltz $s5, multnegcheckx
	or $0, $0, $0
multswappedx:



	addi $t0, $0, 1
	add $a0, $0, $s6
	
multloop2:
	

	add $s6, $a0, $s6
	addi $t0, $t0, 1
	bne $s5, $t0, multloop2
	or $0, $0, $0


	add $t0, $0, $0

	sh $s6, ($sp)
	or $0, $0, $0

	sub $sp, $sp, 4

	beq $s3, $0, skip
	or $0, $0, $0

	add $sp, $sp, 4

	lh $s6, ($sp)
	or $0, $0, $0

	sub $s6, $0, $s6

	sh $s6, ($sp)
	or $0, $0, $0

	sub $sp, $sp, 4

	add $s3, $0, $0

	j skip
	or $0, $0, $0

######################################################################################################




divnegchecky:

	addi $s3, $s3, 1

	sub $t3, $0, $t3

	j divswappedy
	or $0, $0, $0

divnegcheckx:

	addi $s3, $s3, 1

	sub $t1, $0, $t1

	beq $s3, 2, divdoubleneg
	or $0, $0, $0

	j divswappedx
	or $0, $0, $0	


divdoubleneg:

	add $s3, $0, $0
	j divswappedx
	or $0, $0, $0
	


divide:

#mult algorith
#check signbuffer
#store number, jump back to start

	add $sp, $sp, 4

	lh $t3, ($sp)
	or $0, $0, $0


	sh $0, ($sp)
	or $0, $0, $0

	add $sp, $sp, 4

	lh $t1, ($sp)
	or $0, $0, $0

	bltz $t3, divnegchecky
	or $0, $0, $0
divswappedy:

	bltz $t1, divnegcheckx
	or $0, $0, $0
divswappedx:


	addi $t7, $0, 17	#initializes top of counter
	add $t6, $0, $0		#sets to 0
	addi $t5, $0, 1		#initializes counter to 1
	sll $t3, $t3, 16     	#shifts so number is in upper 16 bits

###################### Begin Algorithm ###############################
# t1 = Dividend/remainder  t3 = Divisor  t6- quotient  t7-max   t5 - counter

divstart:
	sub $t1, $t1, $t3
	
case1:
	bltz $t1, case2
	or $0, $0, $0

	sll $t6, $t6, 1
	or $t6, $t6, 1

	j divshift
	or $0, $0, $0

case2:

	add $t1, $t3, $t1	
	sll $t6, $t6, 1	
	xor $t6, $t6, 0

divshift:
	srl $t3, $t3, 1

repcheck:

	beq $t5, $t7, divdone
	or $0, $0, $0	
	addi $t5, $t5, 1
	j divstart
	or $0, $0, $0

#######################################################################

divdone:


	#store accordingly 

	addi $t7, $0, 0x25      #ascii value of %
	beq $t7, $s7, modulus
	or $0, $0, $0


	
	sh $t6, ($sp)
	or $0, $0, $0

	sub $sp, $sp, 4

	beq $s3, $0, skip
	or $0, $0, $0

	add $sp, $sp, 4

	lh $t6, ($sp)
	or $0, $0, $0

	sub $t6, $0, $t6

	sh $t6, ($sp)
	or $0, $0, $0

	sub $sp, $sp, 4

	add $s3, $0, $0

	j skip
	or $0, $0, $0	


modulus:


	sh $t1, ($sp)
	or $0, $0, $0

	sub $sp, $sp, 4

	beq $s3, $0, skip
	or $0, $0, $0

	add $sp, $sp, 4

	lh $t1, ($sp)
	or $0, $0, $0

	sub $t1, $0, $t1

	sh $t1, ($sp)
	or $0, $0, $0

	sub $sp, $sp, 4

	add $s3, $0, $0

	j skip
	or $0, $0, $0


#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
####### Section 6 - End of program ######################################################
#
#     error - Prints error message
#    
#     done - End of program
#
#########################################################################################

error:	

	addi $v0, $0, 11
	addi $a0, $0, 115
	syscall

	addi $v0, $0, 11
	addi $a0, $0, 121
	syscall

	addi $v0, $0, 11
	addi $a0, $0, 110
	syscall

	addi $v0, $0, 11
	addi $a0, $0, 116
	syscall

	addi $v0, $0, 11
	addi $a0, $0, 97
	syscall

	addi $v0, $0, 11
	addi $a0, $0, 120
	syscall

	addi $v0, $0, 11
	addi $a0, $0, 32
	syscall

	addi $v0, $0, 11
	addi $a0, $0, 101
	syscall

	addi $v0, $0, 11
	addi $a0, $0, 114
	syscall

	addi $v0, $0, 11
	addi $a0, $0, 114
	syscall

	addi $v0, $0, 11
	addi $a0, $0, 111
	syscall

	addi $v0, $0, 11
	addi $a0, $0, 114
	syscall

	addi $v0, $0, 11
	addi $a0, $0, 32
	syscall

	#print error message
	or $0, $0, $0
	# jump to 'done' section to avoid run on code
	
##############################################################################################

done:

	#lui $t1, 0x1000
	#or $0, $0, $0

	#addi $t1, $t1, 8

	#lh $t7 ($t1)	#used for testing output values
	#or $0, $0, $0
	#addi $v0, $0, 1
	#add $a0, $0, $t7
	#syscall

#end of program should jump to here
#no op and purpose is to avoid runaway code

	or $0, $0, $0

############################################################################################
############################################################################################
############################################################################################
############################################################################################