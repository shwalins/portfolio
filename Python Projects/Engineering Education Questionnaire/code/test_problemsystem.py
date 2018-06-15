from unittest import TestCase, main as unittest_main
from Problem_System import *
from multiprocessing import connection

class tests(TestCase):

    # Tests if when given a .txt, the function will correctly pull from the file and store each question in an array in preparation for further use.
    def test_parseIn(self):
        actual_Answer = [['Name: Problem_Test\n', 'Img: Realworld2.png\n', 'Img: Idealizedmodel2.png\n', 'Assumption: Test One\n', 'Answer: incorrect\n', 'Assumption: Test Two\n', 'Answer: complicated\n', 'Reason: Invalid Reason #Test Two_R1\n', 'Reason_Answer: incorrect\n', 'Reason: Valid Reason #Test Two_R2\n', 'Reason_Answer: correct\n', 'Reason: Invalid Reason #Test Two_R3\n', 'Reason_Answer: incorrect\n', 'Assumption: Test Three\n', 'Answer: correct\n', 'Points: 5\n']]
        self.assertEqual(test_driver.p.parsingIn(infile), actual_Answer)

    # Tests pulling a single question from the array where all the questions would be stored.
    def test_loadQuestion_case1(self):
        actual_Answer = ['Name: Problem_Test\n', 'Img: Realworld2.png\n', 'Img: Idealizedmodel2.png\n', 'Assumption: Test One\n', 'Answer: incorrect\n', 'Assumption: Test Two\n', 'Answer: complicated\n', 'Reason: Invalid Reason #Test Two_R1\n', 'Reason_Answer: incorrect\n', 'Reason: Valid Reason #Test Two_R2\n', 'Reason_Answer: correct\n', 'Reason: Invalid Reason #Test Two_R3\n', 'Reason_Answer: incorrect\n', 'Assumption: Test Three\n', 'Answer: correct\n', 'Points: 5\n']
        testing_temp = test_driver.p.loadQuestion(test_driver.p.parsingIn(infile))
        self.assertEqual(testing_temp, actual_Answer)

    # Tests pulling a single question from the array of nothing.
    def test_loadQuestion_case2(self):
        actual_Answer = []
        temp = [[]]
        testing_temp = test_driver.p.loadQuestion(temp)
        self.assertEqual(testing_temp, actual_Answer)

    # Tests if when given a single question, the function will pull all the assumptions from it and store them in a set.
    def test_getAssumptions_case1(self):
        actual_Answer = {'Test One': 'incorrect', 'Test Two': 'complicated', 'Test Three': 'correct'}
        temp = test_driver.p.loadQuestion(test_driver.p.parsingIn(infile))
        testing_temp = test_driver.p.getAssumptions(temp)
        self.assertEqual(testing_temp, actual_Answer)

    # Tests if when given a nothing, the function will return nothing.
    def test_getAssumptions_case2(self):
        actual_Answer = {}
        temp = []
        testing_temp = test_driver.p.getAssumptions(temp)
        self.assertEqual(testing_temp, actual_Answer)

    # Tests if when given a single question, the function will pull the points to be awarded.
    def test_getPoints(self):
        actual_Answer = 5
        temp = test_driver.p.loadQuestion(test_driver.p.parsingIn(infile))
        testing_temp = test_driver.p.getPoints(temp)
        self.assertEqual(testing_temp, actual_Answer)

    # Tests if when given a single assumption and a single question, the function will check if the assumption has reasons and returns a bool if there is/isn't any.
    def test_hasReasons_True(self):
        actual_Answer = True
        temp = test_driver.p.loadQuestion(test_driver.p.parsingIn(infile))
        temp_list = test_driver.p.getAssumptions(temp)
        assumption = list(temp_list)[1]
        testing_temp = test_driver.p.hasReasons(assumption, temp)
        self.assertEqual(testing_temp, actual_Answer)

    # Tests if when given a single assumption and a single question, the function will check if the assumption has reasons and returns a bool if there is/isn't any.
    def test_hasReasons_False(self):
        actual_Answer = False
        temp = test_driver.p.loadQuestion(test_driver.p.parsingIn(infile))
        temp_list = test_driver.p.getAssumptions(temp)
        assumption = list(temp_list)[0]
        testing_temp = test_driver.p.hasReasons(assumption, temp)
        self.assertEqual(testing_temp, actual_Answer)

    # Tests when given a single assumption and a single question, the function will pull the correct list of reasons associated with that assumption.
    def test_getReasons_case1(self):
        actual_Answer = {'Invalid Reason #Test Two_R1': 'incorrect', 'Valid Reason #Test Two_R2': 'correct', 'Invalid Reason #Test Two_R3': 'incorrect'}
        temp = test_driver.p.loadQuestion(test_driver.p.parsingIn(infile))
        temp_list = test_driver.p.getAssumptions(temp)
        assumption = list(temp_list)[1]
        testing_temp = test_driver.p.getReasons(assumption, temp)
        self.assertEqual(testing_temp, actual_Answer)

    # Case 2 makes sure nothing is returned when an assumption has no associated reasons.
    def test_getReasons_case2(self):
        actual_Answer = {}
        temp = test_driver.p.loadQuestion(test_driver.p.parsingIn(infile))
        temp_list = test_driver.p.getAssumptions(temp)
        assumption = list(temp_list)[0]
        testing_temp = test_driver.p.getReasons(assumption, temp)
        self.assertEqual(testing_temp, actual_Answer)



if __name__ == '__main__':
    test_driver = educators()
    infile = 'testQuestion.txt'
    unittest_main()

# currently having some issues with this. Unless you strictly add temp = test_driver.p.parsingIn(infile) in each definition
# and use temp inplace of question_database, the code will for some reason pull from wherever the questions in problems.txt is stored
# and use those by default.