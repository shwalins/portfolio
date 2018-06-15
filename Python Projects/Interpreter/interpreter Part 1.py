infile = ("test.txt")
outfile = ("output.txt")

def IsInt(s):
    try:
        int(s)
        return True
    except ValueError:
        return False

def IsFloat(s):
    try:
        float(s)
        return True
    except ValueError:
        return False


def FindBind(s, list):
    length = len(list)
    for i in range (0, length, 2):
        if list[i] == s:
            return list[i+1]






def interpreter(infile, outfile):

    input = open(infile)
    output = open(outfile, 'w')
    commands = input.read().splitlines()

    print(commands)

    stack = []
    bindings = []

    for counter in commands:
        #print(counter)

        if 'and' in counter:
            if not stack:
                stack.insert(0, ':error:')
            elif 2 > len(stack) == True:
                stack.insert(0, ':error:')
            elif any(c in stack[0] for c in (':true:', ':false:')):
                if any(c in stack[1] for c in (':true:', ':false:')):
                    temp = stack[0]
                    temp2 = stack[1]
                    stack.pop(0)
                    stack.pop(0)
                    if ':false:' in temp:
                        stack.insert(0,':false:')
                    elif ':false:' in temp2:
                        stack.insert(0, ':false:')
                    else:
                        stack.insert(0, ':true:')
                else:
                    stack.insert(0,':error:')
            elif (FindBind(stack[0], bindings) != None) and any(c in (FindBind(stack[0], bindings)) for c in (':true:', ':false:')):
                if (FindBind(stack[1], bindings) != None) and any(c in (FindBind(stack[1],bindings)) for c in (':true:', ':false:')):
                    temp = FindBind(stack[0], bindings)
                    temp2 = FindBind(stack[0], bindings)
                    stack.pop(0)
                    stack.pop(0)
                    if ':false:' in temp:
                        stack.insert(0, ':false:')
                    elif ':false:' in temp2:
                        stack.insert(0, ':false:')
                    else:
                        stack.insert(0, ':true:')
                else:
                    stack.insert(0,':error:')
            else:
                stack.insert(0,':error:')


        if 'bind' in counter:
            if not stack:
                stack.insert(0, ':error:')
            elif 2 > len(stack) == True:
                stack.insert(0, ':error:')
            else:
                temp = stack[0] #value
                temp2 = stack[1] #should be a name
                if '"' in temp2:
                    stack.insert(0,':error:')
                elif any(c in temp2 for c in (':true:',':false:','rror:')):
                    stack.insert(0,':error:')
                elif (IsInt(temp2) == True):
                    stack.insert(0,':error:')
                else:
                    bindings.insert(0,temp)
                    bindings.insert(0,temp2)
                    stack.pop(0)
                    stack.pop(0)
                    stack.insert(0,':unit:')




        if 'or' in counter:
            if not stack:
                stack.insert(0, ':error:')
            elif 2 > len(stack) == True:
                stack.insert(0, ':error:')
            elif any(c in stack[0] for c in (':true:', ':false:')):
                if any(c in stack[1] for c in (':true:', ':false:')):
                    temp = stack[0]
                    temp2 = stack[1]
                    stack.pop(0)
                    stack.pop(0)
                    if ':true:' in temp:
                        stack.insert(0,':true:')
                    elif ':true:' in temp2:
                        stack.insert(0, ':true:')
                    else:
                        stack.insert(0, ':false:')
                else:
                    stack.insert(0,':error:')
            elif (FindBind(stack[0], bindings) != None) and any(c in (FindBind(stack[0], bindings)) for c in (':true:', ':false:')):
                if (FindBind(stack[1], bindings) != None) and any(c in (FindBind(stack[1],bindings)) for c in (':true:', ':false:')):
                    temp = FindBind(stack[0], bindings)
                    temp2 = FindBind(stack[1], bindings)
                    stack.pop(0)
                    stack.pop(0)
                    if ':true:' in temp:
                        stack.insert(0, ':true:')
                    elif ':true:' in temp2:
                        stack.insert(0, ':true:')
                    else:
                        stack.insert(0, ':false:')
                else:
                    stack.insert(0,':error:')
            else:
                stack.insert(0,':error:')


        if 'not' in counter:
            if not stack:
                stack.insert(0, ':error:')
            elif any(c in stack[0] for c in (':true:',':false:')):
                temp = stack[0]
                stack.pop(0)
                if ':true:' in temp:
                    stack.insert(0, ':false:')
                elif ':false:' in temp:
                    stack.insert(0, ':true:')
            elif (FindBind(stack[0], bindings) != None) and any(c in (FindBind(stack[0], bindings)) for c in (':true:', ':false:')):
                temp = FindBind(stack[0], bindings)
                stack.pop(0)
                if ':true:' in temp:
                    stack.insert(0, ':false:')
                elif ':false:' in temp:
                    stack.insert(0, ':true:')
            else:
                stack.insert(0, ':error:')




#        if 'equal' in counter:
#
 #           if not stack:
  #              stack.insert(0, ':error:')
#
 #           elif 2 > len(stack) == True:
  #              stack.insert(0, ':error:')
#
 #                          ##if first item is a binding
  #          elif (FindBind(stack[0], bindings) != None) and (IsInt(FindBind(stack[0], bindings)) == True):
#
 #               temp = int(FindBind(stack[0],bindings))
                            #if second item is an int or a binding
  #              if IsInt(stack[1] == True) or (IsInt(FindBind(stack[1], bindings)) == True):
                            #if its an int
   #                 if(IsInt(stack[1]) == True):
    #                    temp2 = stack[1]
  #                  else:
   #                     temp2 = int(FindBind(stack[1],bindings))
 #                   stack.pop(0)
#                    stack.pop(0)
#                    temp = (temp == temp2)
#                    if(temp == True):
#                        stack.insert(0, ':true:')
#                    else:
#                        stack.insert(0, ':false:')

                else:
                    stack.insert(0, ':error:')

            elif (IsInt(stack[0]) == False):
                stack.insert(0, ':error:')

            elif(FindBind(stack[1],bindings) != None) and (IsInt(FindBind(stack[1],bindings)) == True):
                temp = int(stack[0])
                temp2 = int(FindBind(stack[1],bindings))
                stack.pop(0)
                stack.pop(0)
                temp = (temp == temp2)
                if temp == True:
                    stack.insert(0, ':true:')
                else:
                    stack.insert(0, ':false:')

            elif (IsInt(stack[1]) == False):
                stack.insert(0, ':error:')
            else:
                temp = int(stack[0])
                temp2 = int(stack[1])
                stack.pop(0)
                stack.pop(0)
                temp = (temp == temp2)
                if temp == True:
                    stack.insert(0, ':true:')
                else:
                    stack.insert(0, ':false:')



























'''



        if any(c in counter for c in ('equal', 'lessThan', 'add', 'sub', 'mul', 'div', 'rem')):

            if not stack:
                stack.insert(0, ':error:')

            elif 2 > len(stack) == True:
                stack.insert(0, ':error:')

                           ##if first item is a binding
            elif (FindBind(stack[0], bindings) != None) and (IsInt(FindBind(stack[0], bindings)) == True):

                temp = int(FindBind(stack[0],bindings))
                            #if second item is an int or a binding
                if IsInt(stack[1] == True) or (IsInt(FindBind(stack[1], bindings)) == True):
                            #if its an int
                    if(IsInt(stack[1]) == True):
                        temp2 = stack[1]
                    else:
                        temp2 = int(FindBind(stack[1],bindings))
                    stack.pop(0)
                    stack.pop(0)
          ######################################### here ####################################
                    if 'equal' in counter:
                        temp = (temp == temp2)
                        if(temp == True):
                            stack.insert(0, ':true:')
                        else:
                            stack.insert(0, ':false:')

                    elif 'lessThan' in counter:
                        temp = (temp > temp2)
                        if temp == True:
                            stack.insert(0, ':true:')
                        else:
                            stack.insert(0, ':false:')

                    elif 'add' in counter:
                        temp = temp + temp2
                        stack.insert(0, temp)

                    elif 'sub' in counter:
                        temp = temp2 - temp
                        stack.insert(0, temp)

                    elif 'mul' in counter:
                        temp = temp2 * temp
                        stack.insert(0, temp)

                    elif temp == 0:
                        stack.insert(0,temp2)
                        stack.insert(0,temp)
                        stack.insert(0,':error:')
                    elif 'div' in counter:
                        temp = int(temp2 / temp)
                        stack.insert(0,temp)

                    elif 'rem' in counter:
                        temp = int(temp2 % temp)
                        stack.insert(0, temp)

#########################################################################################################
                else:
                    stack.insert(0, ':error:')

            elif (IsInt(stack[0]) == False):
                stack.insert(0, ':error:')

            elif(FindBind(stack[1],bindings) != None) and (IsInt(FindBind(stack[1],bindings)) == True):
        ############################# here #####################################3
                temp = int(stack[0])
                temp2 = int(FindBind(stack[1],bindings))
                stack.pop(0)
                stack.pop(0)
                if 'equal' in counter:
                    temp = (temp == temp2)
                    if (temp == True):
                        stack.insert(0, ':true:')
                    else:
                        stack.insert(0, ':false:')

                elif 'lessThan' in counter:
                    temp = (temp > temp2)
                    if temp == True:
                        stack.insert(0, ':true:')
                    else:
                        stack.insert(0, ':false:')

                elif 'add' in counter:
                    temp = temp + temp2
                    stack.insert(0, temp)

                elif 'sub' in counter:
                    temp = temp2 - temp
                    stack.insert(0, temp)

                elif 'mul' in counter:
                    temp = temp2 * temp
                    stack.insert(0, temp)

                elif temp == 0:
                    stack.insert(0, temp2)
                    stack.insert(0, temp)
                    stack.insert(0, ':error:')
                elif 'div' in counter:
                    temp = int(temp2 / temp)
                    stack.insert(0, temp)

                elif 'rem' in counter:
                    temp = int(temp2 % temp)
                    stack.insert(0, temp)

##############################################################################################
            elif (IsInt(stack[1]) == False):
                stack.insert(0, ':error:')
            else:
      ##################################### here #################################
                temp = int(stack[0])
                temp2 = int(stack[1])
                stack.pop(0)
                stack.pop(0)
                if 'equal' in counter:
                    temp = (temp == temp2)
                    if (temp == True):
                        stack.insert(0, ':true:')
                    else:
                        stack.insert(0, ':false:')

                elif 'lessThan' in counter:
                    temp = (temp > temp2)
                    if temp == True:
                        stack.insert(0, ':true:')
                    else:
                        stack.insert(0, ':false:')

                elif 'add' in counter:
                    temp = temp + temp2
                    stack.insert(0, temp)

                elif 'sub' in counter:
                    temp = temp2 - temp
                    stack.insert(0, temp)

                elif 'mul' in counter:
                    temp = temp2 * temp
                    stack.insert(0, temp)

                elif temp == 0:
                    stack.insert(0, temp2)
                    stack.insert(0, temp)
                    stack.insert(0, ':error:')
                elif 'div' in counter:
                    temp = int(temp2 / temp)
                    stack.insert(0, temp)

                elif 'rem' in counter:
                    temp = int(temp2 % temp)
                    stack.insert(0, temp)



















'''

        if 'lessThan' in counter:
            if not stack:
                stack.insert(0, ':error:')
            elif (IsInt(stack[0]) == False):
                stack.insert(0, ':error:')
            elif 2 > len(stack) == True:
                stack.insert(0, ':error:')
            elif (IsInt(stack[1]) == False):
                stack.insert(0, ':error:')
            else:
                temp = int(stack[0])    #8
                temp2 = int(stack[1])     #7
                stack.pop(0)
                stack.pop(0)
                temp = (temp > temp2)
                if temp == True:
                    stack.insert(0, ':true:')
                else:
                    stack.insert(0, ':false:')


'''

        if 'swap' in counter:
            if not stack:
                stack.insert(0, ':error:')
            elif 2 > len(stack) == True:
                stack.insert(0, ':error:')
            else:
                temp = stack[0]
                temp2 = stack[1]
                stack.pop(0)
                stack.pop(0)
                stack.insert(0, temp)
                stack.insert(0, temp2)

        if 'pop' in counter:
            if not stack:
                stack.insert(0, ':error:')
            else:
                stack.pop(0)

        if ':error:' in counter:
            stack.insert(0, ':error:')

        if ':true:' in counter:
            stack.insert(0, ':true:')

        if ':false:' in counter:
            stack.insert(0, ':false:')

        if 'push' in counter:
            temp = counter[5:]
            #print(IsFloat(temp))
            if IsFloat(temp) == True:
                if '.' in temp:
                    stack.insert(0, ':error:')
                else:
                    stack.insert(0, temp)
            else:
                stack.insert(0, temp)






        if 'neg' in counter:
            if not stack:
                stack.insert(0, ':error:')
            elif (FindBind(stack[0], bindings) != None) and (IsInt(FindBind(stack[0], bindings)) == True):
                temp = int(FindBind(stack[0],bindings))
                temp = -temp
                stack.pop(0)
                stack.insert(0,temp)
            elif (IsInt(stack[0]) == False):
                stack.insert(0, ':error:')
            else:
                temp = int(stack[0])
                temp = -temp
                stack.pop(0)
                stack.insert(0,temp)



'''

        if 'add' in counter:
            if not stack:
                stack.insert(0, ':error:')
            elif (IsInt(stack[0]) == False):
                stack.insert(0, ':error:')
            elif 2 > len(stack) == True:
                stack.insert(0, ':error:')
            elif (IsInt(stack[1]) == False):
                stack.insert(0, ':error:')
            else:
                temp = int(stack[0])
                temp2 = int(stack[1])
                stack.pop(0)
                stack.pop(0)
                temp = temp + temp2
                stack.insert(0, temp)



        if 'mul' in counter:
            if not stack:
                stack.insert(0, ':error:')
            elif (IsInt(stack[0]) == False):
                stack.insert(0, ':error:')
            elif 2 > len(stack) == True:
                stack.insert(0, ':error:')
            elif (IsInt(stack[1]) == False):
                stack.insert(0, ':error:')
            else:
                temp = int(stack[0])
                temp2 = int(stack[1])
                stack.pop(0)
                stack.pop(0)
                temp = temp * temp2
                stack.insert(0, temp)



        if 'sub' in counter:
            if not stack:
                stack.insert(0, ':error:')
            elif (IsInt(stack[0]) == False):
                stack.insert(0, ':error:')
            elif 2 > len(stack) == True:
                stack.insert(0, ':error:')
            elif (IsInt(stack[1]) == False):
                stack.insert(0, ':error:')
            else:
                temp = int(stack[0])
                temp2 = int(stack[1])
                stack.pop(0)
                stack.pop(0)
                temp = temp2 - temp
                stack.insert(0, temp)


        if 'div' in counter:
            if not stack:
                stack.insert(0, ':error:')
            elif (IsInt(stack[0]) == False):
                stack.insert(0, ':error:')
            elif (int(stack[0]) == 0):
                stack.insert(0, ':error:')
            elif 2 > len(stack) == True:
                stack.insert(0, ':error:')
            elif (IsInt(stack[1]) == False):
                stack.insert(0, ':error:')
            else:
                temp = int(stack[0])
                temp2 = int(stack[1])
                stack.pop(0)
                stack.pop(0)
                temp = temp2 / temp
                stack.insert(0, int(temp))

        if 'rem' in counter:
            if not stack:
                stack.insert(0, ':error:')
            elif (IsInt(stack[0]) == False):
                stack.insert(0, ':error:')
            elif (int(stack[0]) == 0):
                stack.insert(0, ':error:')
            elif 2 > len(stack) == True:
                stack.insert(0, ':error:')
            elif (IsInt(stack[1]) == False):
                stack.insert(0, ':error:')
            else:
                temp = int(stack[0])
                temp2 = int(stack[1])
                stack.pop(0)
                stack.pop(0)
                temp = temp2 % temp
                stack.insert(0, int(temp))
'''

    stack = list(map(str, stack))   #converts everything to string
    stack = '\n'.join(stack)
    print(stack)

    for this in stack:
        output.write(this)
        #output.write('\n')
    output.close()

interpreter(infile, outfile)