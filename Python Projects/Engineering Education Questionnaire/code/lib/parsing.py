#gotta turn the problems into a class, basically. 
import random

class parser:
    def parsingIn(self, inputText): 
        temporary_data_structure = []
        question_Database = []
        for line in open(inputText,'r'):    #Opens the text file and parses in only the relevant data required to form the question.
            if line.startswith("-"):
                question_Database.append(temporary_data_structure)
                temporary_data_structure = []
            elif line.startswith("end"):
                question_Database.append(temporary_data_structure)        
                temporary_data_structure = []
                return(question_Database)
            elif line.startswith("#"):
                continue
            elif line.isspace():
                continue
            else:
                temporary_data_structure.append(line)
    def getAssumptions(self, input):
        temp = []
        for line in input:
            if (line.startswith("Assumption:")) or (line.startswith("Answer")):
                temp.append(line.split(": ",1)[1].rstrip("\n"))
        list = temp[1::2]
        #print(list)
        #listToInt = [int(x) for x in list] #Converts string numbers to list numbers
        #print(listToInt)
        val = temp[0::2]
        tempdict = dict(zip(val, list))
        return tempdict
    def getPoints(self, input):
        for line in input:
            if (line.startswith("Points:")):
                temp = int(line.split(": ",1)[1].rstrip("\n"))
        return temp
    def getImgs(self, input):
        temp = []
        for line in input:
            if(line.startswith("Img:")):
                temp.append("img/"+line.split(": ",1)[1].rstrip("\n"))
        return temp
        #print(temp)
    def loadQuestion(self, question_Database):
        if (len(question_Database) > 0):
            tempProblem = question_Database.pop(random.randint(0,(len(question_Database)-1)))
            return tempProblem
        else:
            quit()
            
    def hasReasons(self,assumption,qdatabase):
        checkReasons = False
        hasReasons = False
        temp = []
        for line in qdatabase:
            if line.startswith("Assumption:" or "Points:"):
                checkReasons = False
            if checkReasons:
                if line.startswith("Reason:"):
                    hasReasons = True
                    #temp.append(line)
                    break
            if line.split(": ",1)[1].rstrip("\n") == assumption:
                checkReasons = True
        return hasReasons
    def getReasons(self, assumption, qdatabase): #gets the assumption list and checks all of the assumptions to get reasons (for incorrect/complicated questions.)
        checkReasons = False
        hasReasons = False
        temp = []
        for line in qdatabase:
            if line.startswith("Assumption:"):
                checkReasons = False
            if checkReasons:
                if (line.startswith("Reason:")) or (line.startswith("Reason_Answer:")):
                    hasReasons = True
                    temp.append(line.split(": ",1)[1].rstrip("\n"))
            if line.split(": ",1)[1].rstrip("\n") == assumption:
                checkReasons = True
        list = temp[1::2]
        val = temp[0::2]
        tempdict = dict(zip(val, list))
        return tempdict