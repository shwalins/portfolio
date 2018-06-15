import numpy as np
from scipy import stats
from scipy.stats import norm
import matplotlib.pyplot as plt
from scipy.stats import multivariate_normal
#import plotly
#import plotly.plotly as py
#import plotly.graph_objs as go
#import plotly.figure_factory as ff
#plotly.tools.set_credentials_file(username='opfball91', api_key='Vn7E87sE4E4Tg3mFaHlP')
np.set_printoptions(formatter={'float': lambda x: "{0:0.3f}".format(x)})

csScore = [5,4.6,4.5,4.3,4.3,4.2,4.1,4.1,4,4,3.7,3.6,3.6,3.4,3.4,3.4,3.4,3.3,3.3,3.3,3.3,3.1,3.1,3.1,3.1,3.1,3.1,3,3,3,2.9,2.9,2.8,2.8,2.8,2.7,2.6,2.6,2.6,2.6,2.5,2.5,2.4,2.4,2.4,2.4,2.4,2.4,2.4]

overheadRates = [57,58.6,54.5,55.9,55,53,54,55,55,52,55,59,52,54.5,54.5,52,58,54,55,57,53.5,58,48.5,53,53.5,49,61,54.5,51.5,50,56,54,53.5,54,53.5,59.8,50,59.5,51,45,49.9,46,47,48.7,50.5,51,49,53,51]

presidentPay = [400400,512500,550000,440000,628190,437000,416000,603357,376827,459000,202487,363605,482515,571668,392200,610000,485000,851303,526549,400000,315000,644455,425000,475000,389000,358850,496688,566200,464946,525166,544848,580000,520000,188294,310000,411752,448800,643309,493272,403337,499194,485088,332100,421000,423074,341053,394956,518279,662500]

tuition = [25064,30228,33513,30698,34722,26660,35580,41811,36180,29720,28804,28813,33624,30452,37635,20876,42184,26537,28591,36774,36624,21550,26356,28379,33151,25267,27444,23312,23551,28591,33241,28168,34980,36286,36276,26030,20816,21550,27409,30888,29960,23540,39360,26077,21642,21388,29696,30378,25510]

#Used to get pairwise Data plots
'''
plt.plot(presidentPay,tuition, 'ro')
plt.xlabel('President Pay')
plt.ylabel('Tuition')
plt.show()
'''

print('UBitName = jnboyd and shwalins')
print('personNumber = 37165689 and 50106260')

#Mean
mu1 = np.mean(csScore)
mu2 = np.mean(overheadRates)
mu3 = np.mean(presidentPay)
mu4 = np.mean(tuition)
mu1Rounded = round(mu1,3)
mu2Rounded = round(mu2,3)
mu3Rounded = round(mu3,3)
mu4Rounded = round(mu4,3)
print('mu1 = '+str(mu1Rounded))
print('mu2 = '+str(mu2Rounded))
print('mu3 = '+str(mu3Rounded))
print('mu4 = '+str(mu4Rounded))

#Variance
var1 = np.var(csScore)
var2 = np.var(overheadRates)
var3 = np.var(presidentPay)
var4 = np.var(tuition)
var1Rounded = round(var1,3)
var2Rounded = round(var2,3)
var3Rounded = round(var3,3)
var4Rounded = round(var4,3)
print('var1 = '+str(var1Rounded))
print('var2 = '+str(var2Rounded))
print('var3 = '+str(var3Rounded))
print('var4 = '+str(var4Rounded))

#Standard Deviation
sigma1 = np.std(csScore)
sigma2 = np.std(overheadRates)
sigma3 = np.std(presidentPay)
sigma4 = np.std(tuition)
sigma1Rounded = round(sigma1,3)
sigma2Rounded = round(sigma2,3)
sigma3Rounded = round(sigma3,3)
sigma4Rounded = round(sigma4,3)
print('sigma1 = '+str(sigma1Rounded))
print('sigma2 = '+str(sigma2Rounded))
print('sigma3 = '+str(sigma3Rounded))
print('sigma4 = '+str(sigma4Rounded))

'''
#Code borrowed from https://plot.ly/python/table/
data_matrix = [['Data','CS Score', 'Overhead Rates', 'President Pay', 'Tuition'],
		['Mean',mu1Rounded,mu2Rounded,mu3Rounded,mu4Rounded],
		['Variance',var1Rounded,var2Rounded,var3Rounded,var4Rounded],
		['Standard Deviation',sigma1Rounded,sigma2Rounded,sigma3Rounded,sigma4Rounded]]

table = ff.create_table(data_matrix)
py.iplot(table, filename='MVSTD')
'''

#Covariance
cov1 = np.cov(csScore,overheadRates)
cov2 = np.cov(csScore,presidentPay)
cov3 = np.cov(csScore,tuition)
cov4 = np.cov(overheadRates,presidentPay)
cov5 = np.cov(overheadRates,tuition)
cov6 = np.cov(presidentPay,tuition)
### covarianceMat = np.matrix([[.458, 1.106, 3879.781, 1058.4797619],[1.106, 1.28504167e+01, 7.02793765e+04, 2805.7889881],[ 3.87978185e+03, 7.02793765e+04, 1.41897208e+10, -1.63685641e+08],[1058.4797619, 2805.7889881, -1.63685641e+08, 31367695.78996599]])
covarianceMat = np.matrix('.488, 1.106, 3879.782, 1058.480; 1.106, 12.588, 70279.377, 2805.789; 3879.782, 70279.377, 13900134681.701, -160345117.967; 1058.480, 2805.789, -160345117.967, 30727538.733')
print('covarianceMat:')
print(covarianceMat)

#Correlation
cor1 = np.corrcoef(csScore,overheadRates)
cor2 = np.corrcoef(csScore,presidentPay)
cor3 = np.corrcoef(csScore,tuition)
cor4 = np.corrcoef(overheadRates,presidentPay)
cor5 = np.corrcoef(overheadRates,tuition)
cor6 = np.corrcoef(presidentPay,tuition)
correlationMat = np.matrix('1., 0.456, 0.048, 0.279; 0.456, 1., 0.165, 0.14; 0.048, 0.165, 1., -0.245; 0.279, 0.14, -0.245, 1')
print('correlationMat:')
print(correlationMat)

'''
#Borrowed from https://plot.ly/python/bar-charts/
correlationGraph = [go.Bar(
		   x=['CS Score/Overhead Rates', 'CS Score/President Pay', 'CS Score/Tuition','Overhead Rates/President Pay', 'Overhead Rates/Tuition', 'President Pay/Tuition'],
		   y=[.456,.048,.279,.165,.140,-.245]
		)]
py.iplot(correlationGraph, filename='Correlation Graph')
'''

## borrowed function from http://interactivepython.org/courselib/static/pythonds/Recursion/pythondsCalculatingtheSumofaListofNumbers.html
def listsum(numList):
   if len(numList) == 1:
        return numList[0]
   else:
        return numList[0] + listsum(numList[1:])


#LogLikelihood
pdf1 = stats.norm.pdf(csScore, mu1, sigma1)
pdf2 = stats.norm.pdf(overheadRates, mu2, sigma2)
pdf3 = stats.norm.pdf(presidentPay, mu3, sigma3)
pdf4 = stats.norm.pdf(tuition, mu4, sigma4)
log1 = np.log(pdf1)
log2 = np.log(pdf2)
log3 = np.log(pdf3)
log4 = np.log(pdf4)
logLikelihood = listsum(log1) + listsum(log2) + listsum(log3) + listsum(log4)
print('(Independent) logLikelihood: ')
print(round(logLikelihood,3))

#LogLikelihood with Multivariate
m_pdf1 = stats.multivariate_normal.pdf(csScore, mu1, .488)
m_pdf2 = stats.multivariate_normal.pdf(overheadRates, mu2, 53.386)
m_pdf3 = stats.multivariate_normal.pdf(presidentPay, mu3, 13900134681.7)
m_pdf4 = stats.multivariate_normal.pdf(tuition, mu4, 30727538.733)
m_log1 = np.log(m_pdf1)
m_log2 = np.log(m_pdf2)
m_log3 = np.log(m_pdf3)
m_log4 = np.log(m_pdf4)
m_logLikelihood = listsum(m_log1) + listsum(m_log2) + listsum(m_log3) + listsum(m_log4)
print('(Dependent) logLikelihood: ')
print(round(m_logLikelihood,3))


'''
#Debug section to determine 4x4 Covariance Matrix
print('x1/x2')
print(cov1)
print('[(x1,x1),(x1,x2)]')
print('[(x2,x1),(x2,x2)]')
print('x1/x3')
print(cov2)
print('[(x1,x1),(x1,x3)]')
print('[(x3,x1),(x3,x3)]')
print('x1/x4')
print(cov3)
print('[(x1,x1),(x1,x4)]')
print('[(x4,x1),(x4,x4)]')
print('x2/x3')
print(cov4)
print('[(x2,x2),(x2,x3)]')
print('[(x3,x2),(x3,x3)]')
print('x2/x4')
print(cov5)
print('[(x2,x2),(x2,x4)]')
print('[(x4,x2),(x4,x4)]')
print('x3/x4')
print(cov6)
print('[(x3,x3),(x3,x4)]')
print('[(x4,x3),(x4,x4)]')      

#Debug section to determine 4x4 Correlation Matrix
print('x1/x2')
print(cor1)
print('[(x1,x1),(x1,x2)]')
print('[(x2,x1),(x2,x2)]')
print('x1/x3')
print(cor2)
print('[(x1,x1),(x1,x3)]')
print('[(x3,x1),(x3,x3)]')
print('x1/x4')
print(cor3)
print('[(x1,x1),(x1,x4)]')
print('[(x4,x1),(x4,x4)]')
print('x2/x3')
print(cor4)
print('[(x2,x2),(x2,x3)]')
print('[(x3,x2),(x3,x3)]')
print('x2/x4')
print(cor5)
print('[(x2,x2),(x2,x4)]')
print('[(x4,x2),(x4,x4)]')
print('x3/x4')
print(cor6)
print('[(x3,x3),(x3,x4)]')
print('[(x4,x3),(x4,x4)]')      
'''
