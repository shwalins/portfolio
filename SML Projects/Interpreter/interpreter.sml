



(* use readIN "filename.txt"; to store a string list of commands to be executed*)

fun readIN input = 
     let val file = TextIO.openIn input  
	     val this = TextIO.inputAll file
		 val _ = TextIO.closeIn file
     in String.tokens (fn c => c = #"\n") this
	 end	 
	 
	 
	
(* used to delete first item in a list*)	
fun delete (0, _::stack) = stack	
	 
	 
	 
(*strips "push " from string *)
fun Strip (temp) =
	let
	    val temp = String.explode temp
		val temp = delete(0,temp)
		val temp = delete(0,temp)
		val temp = delete(0,temp)
		val temp = delete(0,temp)
		val temp = delete(0,temp)
		val temp = String.implode temp
	in
	    temp 
    end	
	 
	 

(* Datatype myList in order to store a list of different stuff in main list*)
datatype myList = integers of int | strings of string | bools of bool | names of string | error of string | bound of myList * myList;




(* push integers 6 Stack - beta push function *)
fun push n ((xs)::ys) = ((n::xs)::ys);






(* used to convert from myList type to string *)
fun tellMe x =
    case x of
	   integers (x) => Int.toString(x)
       |strings (x) => (x)
	   |bools (x) => ":" ^ Bool.toString(x) ^ ":"
	   |names (x) => (x)
	   |error (x) => (x) 	   
	   
	   
(**********************************************************************************)
	   
	   
(* pops item off of the stack *)	   
fun pop (0, (_::xs)::ys) = xs::ys	
	
	
(* pushes error onto the stack*)	
fun pushError(stack) =
    let
	    val temp = error ":error:"
		val stack = push temp stack
	in 
	    stack
	end;
		
		
(* deletes first item in the stack *)	
fun delete (0, _::stack) = stack	
	
	
(* used to check if a command is a digit *)	
fun checkDigit x = (ord x > 47) andalso (ord x < 58);

 
(* used to check if there's a " *) 
fun checkString x = (ord x = 34);


(*takes in a string of ints, and our stack, transforms the ints, and pushes it onto stack*)
fun pushDigit(temp, stack) =
    let 
	    val isReal = String.isSubstring "." temp
		val SOME temp = Int.fromString temp
        val temp = integers temp
        val stack = if isReal = true then pushError(stack) else push temp stack
    in
        stack
    end;		

	
(* used to push strings onto the stack *)	
fun pushString(temp, stack) =
    let
	    val temp = strings temp
		val stack = push temp stack
	in 
	    stack
	end;
	
	
(* used to push names onto the stack *)	
fun pushName(temp, stack) =
    let 
        val temp = names temp
        val stack = push temp stack
    in 
        stack
    end;		

	
(* used to check if the stack is empty *)
fun checkStack(stack) = (stack = [[]]);	


(* used to check if number is a negative *)
fun checkNegative(x) = (ord x = 45);


(* used to push negative numbers *)
fun pushNegative(temp, stack) =
	let
	   val isReal = String.isSubstring "." temp  (*check if real*)
	   val temp = String.explode(temp)
	   val temp = delete(0,temp)        (*deletes negative*)
	   val temp2 = List.nth(temp,0)           (*stores first number*)
	   val temp = String.implode(temp)         (*restores to string*)
	   val isInt = checkDigit(temp2)            (*checks if its an actual integer*)
	   val temp = if isInt = true then valOf(Int.fromString temp) else ~1
	   val temp = ~temp
       val temp = integers temp
       val stack = if isReal = true then pushError(stack) else if isInt = false then pushError(stack) else push temp stack	   
	in
	   stack
	end;
	
	
(* used to push true bool onto stack *)	
fun pushBoolTrue(stack) =
    let
	    val temp = bools true
		val stack = push temp stack
	in 
	    stack
	end;
	

(* used to push false bool onto stack *)	
fun pushBoolFalse(stack) =	
    let
	    val temp = bools false
		val stack = push temp stack
	in
		stack
	end;
		

	   
(* used to check if top is a digit *)	   
fun topIsDigit((x::xs)::ys) =
    case x of
        integers x => true
		|strings x => false
		|names x => false
		|bools x => false
		|error x => false


(* used to get the top number on stack *)		
fun GetTopDigit((x::xs)::ys) =
    case x of
        integers x => x


(* used to negate the top item in stack *)		
fun negation(stack) = 
    let
        val temp = GetTopDigit(stack)
		val temp = ~temp
		val temp = integers temp;
		val stack = pop(0,stack)
		val stack = push temp stack
    in
        stack
    end		


(* checks if theres two items in the stack *)	
fun moreThanOne(stack) = 
    let
	    val tempStack = List.nth (stack, 0)
		val temp = length tempStack
        val temp2 = temp > 1;
	in
	    temp2
	end

(* checks if top two are digits *)
fun bothDigits((x::y::xs)::ys) =
    case y of
        integers y => true
		|strings y => false
		|names y => false
		|bools y => false
		|error y => false
	
	
(* swaps top two items *)
fun swapTime((x::y::xs)::ys) = ((y::x::xs)::ys)  


(* used to check for divide by zero *)
fun nextIsZero((x::y::xs)::ys) = 
   let
       val temp = GetTopDigit((x::xs)::ys)
       val temp = temp = 0
   in
       temp
   end


(* used to add top two items *)
fun addi((x::y::xs)::ys) = 
   let
       val temp = GetTopDigit((x::xs)::ys)
	   val temp2 = GetTopDigit((y::xs)::ys)
	   val temp3 = temp + temp2
	   val temp3 = integers temp3
   in
  	   ((temp3::xs)::ys)
   end




(* used to multiply top two items *)
fun multi((x::y::xs)::ys) =
   let
       val temp = GetTopDigit((x::xs)::ys)
	   val temp2 = GetTopDigit((y::xs)::ys)
	   val temp3 = temp * temp2
	   val temp3 = integers temp3
   in
  	   ((temp3::xs)::ys)
   end


(* used to divide top two items *)
fun divide((x::y::xs)::ys) =
   let
       val temp = GetTopDigit((x::xs)::ys)
	   val temp2 = GetTopDigit((y::xs)::ys)
	   val temp3 = temp2 div temp
	   val temp3 = integers temp3
   in
  	   ((temp3::xs)::ys)
   end



(* self explanitory *)
fun subt((x::y::xs)::ys) =
   let
       val temp = GetTopDigit((x::xs)::ys)
	   val temp2 = GetTopDigit((y::xs)::ys)
	   val temp3 = temp2 - temp
	   val temp3 = integers temp3
   in
  	   ((temp3::xs)::ys)
   end


(* self explanitory *)   
fun modul((x::y::xs)::ys) =
   let
       val temp = GetTopDigit((x::xs)::ys)
	   val temp2 = GetTopDigit((y::xs)::ys)
	   val temp3 = temp2 mod temp
	   val temp3 = integers temp3
   in
  	   ((temp3::xs)::ys)
   end


(**********************************************************************************************)	
(* main function *)
fun tryThis ([], stack) = stack	(* if list of commands if empty, return the slab-I mean stack*)
  | tryThis ("quit"::commands, stack) = stack
  | tryThis (":error:"::commands, stack) = tryThis(commands, pushError(stack))
  | tryThis (":true:"::commands, stack) = tryThis(commands, pushBoolTrue(stack))
  | tryThis (":false:"::commands, stack) = tryThis(commands, pushBoolFalse(stack))
  | tryThis ("add"::commands, stack) = 
          let
		    val isEmpty = checkStack(stack)
            val oneMore = if isEmpty = false then moreThanOne(stack) else false	
			val isDigit = if oneMore = true then topIsDigit(stack)	else false
			val nextDigit = if isDigit = true then bothDigits(stack) else false
            val stack = if nextDigit = true then addi(stack) else pushError(stack)			
		in
		    tryThis(commands,stack)
		end
  | tryThis ("sub"::commands, stack) = 
          let
		    val isEmpty = checkStack(stack)
            val oneMore = if isEmpty = false then moreThanOne(stack) else false	
			val isDigit = if oneMore = true then topIsDigit(stack)	else false
			val nextDigit = if isDigit = true then bothDigits(stack) else false
            val stack = if nextDigit = true then subt(stack) else pushError(stack)			
		in
		    tryThis(commands,stack)
		end
  | tryThis ("div"::commands, stack) = 
          let
		    val isEmpty = checkStack(stack)
            val oneMore = if isEmpty = false then moreThanOne(stack) else false	
			val isDigit = if oneMore = true then topIsDigit(stack)	else false
			val nextDigit = if isDigit = true then bothDigits(stack) else false
			val isZero = if nextDigit = true then nextIsZero(stack) else true
            val stack = if isZero = false then divide(stack) else pushError(stack)			
		in
		    tryThis(commands,stack)
		end
  | tryThis ("mul"::commands, stack) = 
          let
		    val isEmpty = checkStack(stack)
            val oneMore = if isEmpty = false then moreThanOne(stack) else false	
			val isDigit = if oneMore = true then topIsDigit(stack)	else false
			val nextDigit = if isDigit = true then bothDigits(stack) else false
            val stack = if nextDigit = true then multi(stack) else pushError(stack)			
		in
		    tryThis(commands,stack)
		end
  | tryThis ("rem"::commands, stack) = 
          let
		    val isEmpty = checkStack(stack)
            val oneMore = if isEmpty = false then moreThanOne(stack) else false	
			val isDigit = if oneMore = true then topIsDigit(stack)	else false
			val nextDigit = if isDigit = true then bothDigits(stack) else false
			val isZero = if nextDigit = true then nextIsZero(stack) else true
            val stack = if isZero = false then modul(stack) else pushError(stack)			
		in
		    tryThis(commands,stack)
		end
  | tryThis ("swap"::commands,stack) = 
        let
		    val isEmpty = checkStack(stack)
            val oneMore = if isEmpty = false then moreThanOne(stack) else false	
            val stack = if oneMore = true then swapTime(stack) else pushError(stack)			
		in
		    tryThis(commands,stack)
		end
  | tryThis ("neg"::commands, stack) = 
        let
            val isEmpty = checkStack(stack)
            val isDigit = if isEmpty = false then topIsDigit(stack)	else false
            val stack = if isDigit = true then negation(stack) else pushError(stack)
        in
            tryThis(commands,stack)
        end			
  | tryThis ("pop"::commands, stack) =
        let
			val isEmpty = checkStack(stack)
			val stack = if isEmpty = false then pop(0,stack) else pushError(stack)
		in
			tryThis(commands, stack)
		end	
  | tryThis (commands, stack) = (* if there are commands in the list.... *)
        let
		    val temp = List.nth(commands, 0)    (* takes first command from the list*)
			val commands = delete(0, commands)   (*deletes it from the list*)
			val temp = Strip(temp)  (* as of right now, all pushes, so it deletes the push chars*)
			val temp2 = String.sub(temp,0) (*grabs the first char for testing*)
			val isDigit = checkDigit(temp2)  (*checks if the first char is a digit*)
			val isNegative = checkNegative(temp2)
			val stack = if isDigit = true then pushDigit(temp, stack) else stack
			val stack = if isNegative = true then pushNegative(temp, stack) else stack
			
			
			
			val isString = checkString(temp2)
			
			val stack = if isString = true then pushString(temp, stack) else if isDigit = true then stack else if isNegative = true then stack else pushName(temp, stack)
			
			
			
			
	    in
			tryThis(commands, stack)  (*adds it to stack, recursively calls itself*)
        end;  

	
		
		
		
		
	(*output is outputfile name, stack is stack obviously, and len is length of outerstack*) 
	
	

(* checks if inner stack is empty*)
fun innerIsEmpty(stack) = (stack = [])


fun converter ([], newStack) = newStack	(* if list of commands if empty, return the slab-I mean stack*)
  | converter (original, newStack) = 
  	let
		val tempList = List.nth(original, 0)    (* takes first list*)
	    val temp = List.nth(tempList, 0)   (*takes first item from that list*)
		val original = delete(0, original)   (*deletes it from the list*)
		val tempString = tellMe(temp)  (*converts it into string*)
		val newStack = tempString::newStack
		val tempList = delete(0, tempList)
		val check = innerIsEmpty(tempList)
		val original = if check = true then original else tempList::original
	in
		converter(original, newStack)
	end;
  

 
 
 
 
 


fun printing(output, stack) =
    let 
	    val file = TextIO.openOut(output)
		val _ = TextIO.output(file, stack)
	in 
	    TextIO.closeOut(file)
	end;	  

	
 val negHandler = 
     fn temp => if temp = #"~"
	            then #"-"
                else temp
	   
	   
fun interpreter (input, output) =
    let 
	   val commands = readIN input
	   val stack = tryThis(commands, [[]])
	   val stack = converter(stack,[])
	   val stack = rev stack
	   val stack = String.concatWith "\n" stack
	   val stack = String.explode(stack)
	   val stack = List.map negHandler stack
	   val stack = String.implode(stack)
	in
	   printing (output, stack)
	end; 
	
	


  
 
(*
print "\n\n\n"; 
	
val test = readIN "sample_input1.txt"; 
val test = tryThis(test,[[]]);

print "\n\n\n";   
*)





(* specifically used for finding binds in bindSearch *)
fun boundTell x =
    case x of
	   integers (x) => Int.toString(x)
       |strings (x) => (x)
	   |bools (x) => ":" ^ Bool.toString(x) ^ ":"
	   |names (x) => (x)
	   |error (x) => (x) 
       |bound (x,y) =>  (tellMe x) 

	   
(* used to find value stored in binding *)	   
fun boundFound x =
    case x of
	   bound (x,y) =>  y	   


(* searches temp stack. format is list of myList, and myList type we are searching for *)
fun bindSearch([] , y) = "Not Found"
  | bindSearch(x::xs, y) = 
     let
	     val return = if ((boundTell x) = (boundTell y)) then "Found" else bindSearch(xs,y)
	 in
	     return
	 end
    
     	
(* only called if bindSearch returns "Found" - returns the value stored in bind in form of myList *)		
fun bindFind(x::xs, y) = 
     let
	     val this = if ((boundTell x) = (boundTell y)) then (boundFound x) else bindFind(xs,y)
	 in
	     this
	 end
    		
		

	  
	  
val test2 = [integers 6, bools true, bound (names "a", integers 20), strings "okay"];	  

val test = bound (names "a", integers 16);


 (*
val _ = interpreter("sample_input1.txt", "output.txt");
 *)
 
 
