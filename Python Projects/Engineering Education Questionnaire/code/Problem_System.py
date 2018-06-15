"""
References: https://docs.python.org/3.6/library/tkinter.html
A library that is required is tkinter(tk)
Refer to problems.txt on the format of the text file being parsed in
"""

import tkinter as designTK  # Required to execute the graphical user interface(GUI)
from tkinter import messagebox
from tkinter import font
from tkinter import Checkbutton
from tkinter import *
from tkinter import DISABLED

import PIL as designPIL  # Required to parse and show images in tk
from PIL import Image
from PIL import ImageTk
from PIL import *

import copy, random

from lib.parsing import parser

import importlib
from importlib import *


class educators:
    def __init__(self):  # Turns all datastructures into global variables that can be accessed from anywhere in the code.
        self.temporary_data_structure = []
        self.question_Database = []

        self.parentFrame = designTK.Tk()
        self.scoreFrame = Frame(self.parentFrame)
        self.questionFrame = Frame(self.parentFrame)
        self.submitAndButton = Frame(self.parentFrame)
        self.checkButtonList = []
        self.currentQuestionGlobal = []
        self.assumptionDictionaryGlobal = {}
        self.assumptionDictionaryGlobalNotManipulated = {}
        self.valueOfAnswerSelected = []
        self.pointsForSelectedQuestion = 0
        self.hasReasons = False

        self.totalPoints = 0
        self.totalPointsConvertToString = "0"
        self.totalPointsCopy = 0
        self.totalPointsConstantlyDisplayed = "0"

        self.p = parser()
        self.question_Database = self.p.parsingIn(inputText='problems.txt')

    def disableNextButton(self):
        self.nextButton.grid_forget()

    def enableNextButton(self):
        self.nextButton.grid(row=0, column=1, padx=10, pady=4)

    def disableSubmitButton(self):
        self.submitButton.config(state='disabled')

    def enableSubmitButton(self):
        self.submitButton.config(state='active')

    def disableCheckButton(self):
        self.allCheckButtons.config(state="disabled")

    def highlightAssumptions(self):
        rowcnt = 8
        if self.hasReasons == True:
            for key, value in self.reasonsDictNotManipulated.items(): #{'Incorrect Assumption that includes a lot of text to make certain you can handle it #1.3': 0, 'Lower leg remains approximately perpendicular to upper leg': 0,}
                if value == "incorrect":
                    self.reasonsDict[key] = IntVar()
                    self.allCheckButtons = Checkbutton(self.questionFrame, text=key, variable=self.reasonsDict[key],  # Variable is used to check if the answer has been selected. However, because this is in a loop everything gets selected.
                                                  height=1, width=64, font=("Arial", 14),
                                                  bg="white", anchor="w")
                    self.allCheckButtons.grid(row=rowcnt, column=0)
                    rowcnt += 1
                    self.disableCheckButton()
                elif value == "correct":
                    self.reasonsDict[key] = IntVar()
                    self.allCheckButtons = Checkbutton(self.questionFrame, text=key, variable=self.reasonsDict[key],  # Variable is used to check if the answer has been selected. However, because this is in a loop everything gets selected.
                                                  height=1, width=64, font=("Arial", 14),
                                                  bg="green",disabledforeground="black", anchor="w")
                    self.allCheckButtons.grid(row=rowcnt, column=0)
                    rowcnt += 1
                    self.disableCheckButton()
        else:
            for key, value in self.assumptionDictionaryGlobalNotManipulated.items(): #{'Incorrect Assumption that includes a lot of text to make certain you can handle it #1.3': 0, 'Lower leg remains approximately perpendicular to upper leg': 0,}
                if value == "incorrect":
                    self.assumptionDictionaryGlobal[key] = IntVar()
                    self.allCheckButtons = Checkbutton(self.questionFrame, text=key, variable=self.assumptionDictionaryGlobal[key],  # Variable is used to check if the answer has been selected. However, because this is in a loop everything gets selected.
                                                  height=1, width=64, font=("Arial", 14),
                                                  bg="white", anchor="w")
                    self.allCheckButtons.grid(row=rowcnt, column=0)
                    rowcnt += 1
                    self.disableCheckButton()
                elif value == "correct":
                    self.assumptionDictionaryGlobal[key] = IntVar()
                    self.allCheckButtons = Checkbutton(self.questionFrame, text=key, variable=self.assumptionDictionaryGlobal[key],  # Variable is used to check if the answer has been selected. However, because this is in a loop everything gets selected.
                                                  height=1, width=64, font=("Arial", 14),
                                                  bg="green",disabledforeground="black", anchor="w")
                    self.allCheckButtons.grid(row=rowcnt, column=0)
                    rowcnt += 1
                    self.disableCheckButton()
                elif value != "correct" or "incorrect":
                    self.assumptionDictionaryGlobal[key] = IntVar()
                    self.allCheckButtons = Checkbutton(self.questionFrame, text=key, variable=self.assumptionDictionaryGlobal[key],  # Variable is used to check if the answer has been selected. However, because this is in a loop everything gets selected.
                                                  height=1, width=64, font=("Arial", 14,),
                                                  bg="yellow", anchor="w")
                    self.allCheckButtons.grid(row=rowcnt, column=0)
                    rowcnt += 1

    def enableCheckButtons(self):  
        rowcnt = 8

        for key in self.assumptionDictionaryGlobal:
            self.assumptionDictionaryGlobal[key] = IntVar()
            self.allCheckButtons = Checkbutton(self.questionFrame, text=key, variable=self.assumptionDictionaryGlobal[key],  # Variable is used to check if the answer has been selected. However, because this is in a loop everything gets selected.
                                               height=1
                                               , width=64,
                                               font=("Arial", 14,)
                                               , activebackground="blue",
                                               anchor="w")
            self.allCheckButtons.grid(row=rowcnt, column=0)
            rowcnt += 1
            self.checkButtonList.append(self.allCheckButtons)

    def updateTotalPoints(self):
        Label(self.scoreFrame,).place(x=1, y=1, relwidth=1, relheight=1)
        stringWithTotalPoints = "Total Points: " + self.totalPointsConstantlyDisplayed
        self.reflectedTotalPoints = Label(self.scoreFrame, text=stringWithTotalPoints, width=20, relief=RAISED)  # This pushes the points on the score board
        self.reflectedTotalPoints.config(font=("Arial", 30))
        self.reflectedTotalPoints.grid(row=2, column=1, pady=10)

    def query_checkbuttons(self):
        self.hasSubmitButtonChecked = 1
        self.selectedValList = []
        if self.hasReasons:
            self.valueOfAnswerSelected = []
            for key, value in self.reasonsDict.items():
                state = value.get()
                self.selectedValList.append(state)
                if state != 0:
                    self.reasonsDict[key].set(0)
                    self.valueOfAnswerSelected.append(self.reasonsDictNotManipulated[key])
            for value in self.valueOfAnswerSelected:
                if len(self.valueOfAnswerSelected) > 1:  # Controls how many checkboxes are allowed to be selected
                    print("You have selected too many answers, choose 1!")
                    self.valueOfAnswerSelected = []  # This resets the answers selected instead of continuing to append more answers to the list structure.
                    messagebox.showinfo("Warning", "You are only allowed to select one checkbox!")
                    break
                elif value == "incorrect":
                    self.hasReasons = False
                    combineTextWithPoints1 = "Incorrect! Maybe Next Time"
                    self.updateTotalPoints()
                    self.scoreLabel = Label(self.scoreFrame, text=combineTextWithPoints1, relief=RAISED)  # This pushes the points on the score board
                    self.scoreLabel.config(font=("Arial", 18), bg='black', fg='white')
                    self.scoreLabel.grid(row=1, column=1)
                    self.disableCheckButton()
                    self.disableSubmitButton()
                    self.enableNextButton()
                elif value == "correct":
                    self.hasReasons = False
                    self.totalPoints += self.pointsForSelectedQuestion  # Points do accumulate
                    self.totalPointsConvertToString = str(self.totalPoints)
                    self.totalPointsConstantlyDisplayed = self.totalPointsConvertToString
                    self.updateTotalPoints()
                    temporaryCurrentPoints = str(self.pointsForSelectedQuestion)
                    combineTextWithPoints2 = "Correct! You Earned " + temporaryCurrentPoints + " Points"
                    self.scoreLabel = Label(self.scoreFrame, text=combineTextWithPoints2, relief=RAISED)
                    self.scoreLabel.config(font=("Arial", 18), bg='black', fg='white')
                    # self.updateScoreboard.set(self.totalPointsConvertToString)
                    self.scoreLabel.grid(row=1, column=1)
                    self.disableCheckButton()
                    self.disableSubmitButton()
                    self.enableNextButton()
        else:  
            for key, value in self.assumptionDictionaryGlobal.items():
                state = value.get()
                self.selectedValList.append(state)
                if state != 0:
                    self.assumptionDictionaryGlobal[key].set(0)
                    self.valueOfAnswerSelected.append(self.assumptionDictionaryGlobalNotManipulated[key])
            for value in self.valueOfAnswerSelected:
                #print("Value from for loop", value)
                if len(self.valueOfAnswerSelected) > 1:  # Controls how many checkboxes are allowed to be selected
                    # print(self.valueOfAnswerSelected)
                    print("You have selected too many answers, choose 1!")
                    self.valueOfAnswerSelected = []  # This resets the answers selected instead of continuing to append more answers to the list structure.
                    messagebox.showinfo("Warning", "You are only allowed to select one checkbox!")
                    break
                elif value == "incorrect":
                    temp0 = 0
                    for key, value in self.assumptionDictionaryGlobalNotManipulated.items():
                        if self.selectedValList[temp0] == 1:
                            self.selectedAssumption = key
                            break
                        else:
                            temp0 +=1
                    if (self.p.hasReasons(self.selectedAssumption, self.currentQuestionGlobal) == True):
                        self.hasReasons = True
                        self.reasonsDict = self.p.getReasons(self.selectedAssumption, self.currentQuestionGlobal)
                        self.reasonsDictNotManipulated = copy.deepcopy(self.reasonsDict)  
                    if self.hasReasons == True:
                        combineTextWithPoints1 = "Incorrect! Choose a reason to gain back some points."
                        self.scoreLabel = Label(self.scoreFrame, text=combineTextWithPoints1, relief=RAISED)  # This pushes the points on the score board
                        self.scoreLabel.config(font=("Arial", 18), bg='black', fg='white')
                        self.scoreLabel.grid(row=1, column=1)
                        self.questionFrameContents()
                    else:
                        self.highlightAssumptions()
                        combineTextWithPoints1 = "Incorrect! Maybe Next Time"
                        self.updateTotalPoints()
                        self.scoreLabel = Label(self.scoreFrame, text=combineTextWithPoints1, relief=RAISED)  # This pushes the points on the score board
                        self.scoreLabel.config(font=("Arial", 18), bg='black', fg='white')
                        self.scoreLabel.grid(row=1, column=1)
                        self.disableCheckButton()
                        self.disableSubmitButton()
                        self.enableNextButton()
                elif value == "correct":
                    self.highlightAssumptions()
                    self.totalPoints += self.pointsForSelectedQuestion  # Points do accumulate
                    self.totalPointsConvertToString = str(self.totalPoints)
    
                    self.totalPointsConstantlyDisplayed = self.totalPointsConvertToString
                    self.updateTotalPoints()
    
                    temporaryCurrentPoints = str(self.pointsForSelectedQuestion)
    
                    combineTextWithPoints2 = "Correct! You Earned " + temporaryCurrentPoints + " Points"
                    self.scoreLabel = Label(self.scoreFrame, text=combineTextWithPoints2, relief=RAISED)
                    self.scoreLabel.config(font=("Arial", 18), bg='black', fg='white')
                    # self.updateScoreboard.set(self.totalPointsConvertToString)
                    self.scoreLabel.grid(row=1, column=1)
                    self.disableCheckButton()
                    self.disableSubmitButton()
                    self.enableNextButton() 
                elif value == "complicated":
                    temp0 = 0
                    for key, value in self.assumptionDictionaryGlobalNotManipulated.items():
                        if self.selectedValList[temp0] == 1:
                            self.selectedAssumption = key
                            break
                        else:
                            temp0 +=1
                    if (self.p.hasReasons(self.selectedAssumption, self.currentQuestionGlobal) == True):
                        self.hasReasons = True
                        self.reasonsDict = self.p.getReasons(self.selectedAssumption, self.currentQuestionGlobal)
                        self.reasonsDictNotManipulated = copy.deepcopy(self.reasonsDict)
                    if self.hasReasons == True:
                        combineTextWithPoints1 = "Incorrect! Choose a reason to gain back some points."
                        self.scoreLabel = Label(self.scoreFrame, text=combineTextWithPoints1, relief=RAISED)  # This pushes the points on the score board
                        self.scoreLabel.config(font=("Arial", 18), bg='black', fg='white')
                        self.scoreLabel.grid(row=1, column=1)
                        self.questionFrameContents()
                    else:
#                         self.highlightAssumptions()
                        combineTextWithPoints1 = "Incorrect! Maybe Next Time"
                        self.updateTotalPoints()
                        self.scoreLabel = Label(self.scoreFrame, text=combineTextWithPoints1, relief=RAISED)  # This pushes the points on the score board
                        self.scoreLabel.config(font=("Arial", 18), bg='black', fg='white')
                        self.scoreLabel.grid(row=1, column=1)
                        self.disableCheckButton()
                        self.disableSubmitButton()
                        self.enableNextButton()
        
    def questionFrameContents(self):
        self.questionFrame.grid(row=1, column=0)
        Label(self.questionFrame,).place(x=1, y=1, relwidth=1, relheight=1)
        # print(self.p.loadQuestion(self.question_Database))
        if self.hasReasons == True:
            self.pointsForSelectedQuestion = (self.p.getPoints(self.currentQuestionGlobal)//2)
            rowcnt = 8
            for key in self.reasonsDict:
                self.reasonsDict[key] = IntVar()
                self.allCheckButtons = Checkbutton(self.questionFrame, text=key, variable=self.reasonsDict[key],  # Variable is used to check if the answer has been selected. However, because this is in a loop everything gets selected.
                                                   height=1
                                                   , width=64,
                                                   font=("Arial", 14,)
                                                   , activebackground="blue",
                                                   anchor="w")
                self.allCheckButtons.grid(row=rowcnt, column=0)
                self.checkButtonList.append(self.allCheckButtons)
                rowcnt += 1
        else:
            self.currentQuestionGlobal = [s.rstrip() for s in self.currentQuestion]
            self.assumptionDictionaryGlobal = self.p.getAssumptions(self.currentQuestionGlobal)
            self.pointsForSelectedQuestion = self.p.getPoints(self.currentQuestionGlobal)
            self.assumptionDictionaryGlobalNotManipulated = copy.deepcopy(self.assumptionDictionaryGlobal)  # Holds a deep unchanged copy of the original assumptiondictionary
            rowcnt = 8
            for key in self.assumptionDictionaryGlobal:
                self.assumptionDictionaryGlobal[key] = IntVar()
                self.allCheckButtons = Checkbutton(self.questionFrame, text=key, variable=self.assumptionDictionaryGlobal[key],  # Variable is used to check if the answer has been selected. However, because this is in a loop everything gets selected.
                                                   height=1
                                                   , width=64,
                                                   font=("Arial", 14,)
                                                   , activebackground="blue",
                                                   anchor="w")
                self.allCheckButtons.grid(row=rowcnt, column=0)
                self.checkButtonList.append(self.allCheckButtons)
                rowcnt += 1

    def submitAndNextFrameContents(self):
        self.submitAndButton.grid(row=2, column=0)
        Label(self.submitAndButton).place(x=1, y=1, relwidth=1, relheight=1)

        self.submitButton = Button(self.submitAndButton, text="Submit", command=self.query_checkbuttons, width=15, height=1, font=("Arial", 16))
        self.submitButton.grid(row=0, column=0, padx=10, pady=4)

        self.nextButton = Button(self.submitAndButton, text="Next Question", command=self.nextQuestion, width=15, height=1, font=("Arial", 16))
        self.nextButton.grid(row=0, column=1, padx=10, pady=4)

    def scoreFrameContents(self):
        self.scoreFrame.grid(row=1, column=1)  # This is referring to the frame location

        self.updateTotalPoints()


    def nextQuestion(self):
        if len(self.question_Database) > 0:
            self.currentQuestion = [s.rstrip() for s in self.p.loadQuestion(self.question_Database)]
            self.currentQuestionGlobal = [s.rstrip() for s in self.currentQuestion]
            self.hasReasons = False
            self.assumptionDictionaryGlobal = self.p.getAssumptions(self.currentQuestionGlobal)
            self.pointsForSelectedQuestion = self.p.getPoints(self.currentQuestionGlobal)
            self.assumptionDictionaryGlobalNotManipulated = copy.deepcopy(self.assumptionDictionaryGlobal)
            self.questionFrameContents()
            self.enableSubmitButton()
            self.enableCheckButtons()
            self.disableNextButton()
            self.valueOfAnswerSelected = []
            self.scoreLabel.destroy()
            combineTextWithPoints2 = "Choose your answer!"
            self.scoreLabel = Label(self.scoreFrame, text=combineTextWithPoints2, relief=RAISED)
            self.scoreLabel.config(font=("Arial", 18), bg='black', fg='white')
        else:
            messagebox.showinfo("QUIT", "That's the end of the questions. You earned " + str(self.totalPoints) + " points. Let an educator see your grade, and close the window when you are done. Thanks!")
            self.parentFrame.destroy()
        self.parentFrame.mainloop()
    # ___________________Parent and Child Frames___________________
    # Issue with imaging when being called form a module

    def gui(self):  # Parent Frame

        self.parentFrame.title("Engineer Questionnaire")

        # ___________________No child frame implemented in parent frame for images___________________

        self.currentQuestion = [s.rstrip() for s in self.p.loadQuestion(self.question_Database)]  # loads current question here
        imgList = self.p.getImgs(self.currentQuestion)  # Retrieves specific images for that question here

        colcnt = 0

        for img in imgList:
            if colcnt == 0:  # Only if column count is equal to 0 when run this
                imgOpen = Image.open(img)  # Opens the image
                imgOpen = imgOpen.resize((700, 400), Image.ANTIALIAS)
                imgResize = ImageTk.PhotoImage(imgOpen)
                imgLbl = Label(self.parentFrame, image=imgResize)
                imgLbl.grid(row=0, column=colcnt)
                colcnt = colcnt + 1
                continue
            if colcnt == 1:
                imgOpen = Image.open(img)  # Opens the image
                imgOpen = imgOpen.resize((700, 400), Image.ANTIALIAS)
                imgResize2 = ImageTk.PhotoImage(imgOpen)  # Issue resided here with ImageTk package variable name
                imgLbl = Label(self.parentFrame, image=imgResize2)
                imgLbl.grid(row=0, column=colcnt)
                colcnt = colcnt + 1
                continue
            else:
                print("Max amount of images is 2!")
                break
        self.questionFrameContents()
        self.submitAndNextFrameContents()
        self.disableNextButton()
        self.scoreFrameContents()
        self.parentFrame.mainloop()  # Loads all the frames and content into the parent frame.

if __name__ == '__main__':  # Serves as a way to execute each function in order.
    connectionToEducator = educators()  # When unit testing, you may also want to comment out the print statements.
    connectionToEducator.gui()
