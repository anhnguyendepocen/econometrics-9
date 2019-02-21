/************************************************
Part 0: Initial setup
*************************************************/
// Clear screen
cls
// Clear memory
clear all
// Change directory to project directory.
cd "/Users/juangesino/Documents/UvA/Year 2/Semester 1/Period 2/Econometrics/CS/CE5"
// Create a log file
capture log close
log using "ce5.log", replace
/************************************************
Part 1: Generated data
*************************************************/
/*** QUESTION 1 ***/
// Set observation size
set obs 100
/*** QUESTION 2 ***/
// Generate variables
gen U = rnormal()
gen IS = rnormal()
// Reduced forms
gen CS = 10+IS+2*U
gen YS = 10+2*IS+2*U
/*** QUESTION 3 ***/
reg CS YS
// Estiamtion error for YS
display (0.5)-(0.7482)
// => -0.2482
/*
Given the reduced form equations, the coefficient for YS is 0.5
Doing the regression gives us a coefficient of 0.7482
*/
/*** QUESTION 4 ***/
disp (0.7482467-0.5)/(0.0234548)
/*
t-statistic = 10.584047 > 1.96
Therefore, reject the null hypothesis.
*/
/*** QUESTION 6 ***/
clear
set obs 1000
gen U = rnormal()
gen IS = rnormal()
gen CS = 10+IS+2*U
gen YS = 10+2*IS+2*U
reg CS YS
/*** QUESTION 7 ***/
ivreg CS (YS=IS)
// Estiamtion error for YS
display (0.5)-(0.4835579)
// => 0.0164421
/*
The true coefficient for YS is 0.5
The regression gives us a coefficient of 0.4835579
*/
/*** QUESTION 8 ***/
disp (0.4835579-0.5)/(0.0183132)
/*
t-statistic = |-0.8978278| < 1.96
Therefore, fail to reject the null hypothesis.
*/
/*** QUESTION 9 ***/
// TSLS
regress YS IS
predict YSFIT
regress CS YSFIT
/*** QUESTION 10 ***/
clear
/************************************************
Part 2: Schooling data
*************************************************/
/*** QUESTION 11 ***/
use Brabant
/*** QUESTION 12 ***/
gen lexp2 = lexp*lexp
reg lwage educ lexp lexp2
/*** QUESTION 13 ***/
ivreg lwage (educ = faed mark ssoc fhigh fint fself) lexp lexp2
/*
flow cannot be included because we are using fhigh and otherwise we would have
dummy variable trap.

*/
/*** QUESTION 14 ***/
regress educ lexp lexp2 faed mark ssoc fhigh fint fself
/*
Yes, the regression is significant with a p-value < 0.0000
Furthermore, most coefficients are individually significant.
Finally according to the rule of thumb: F > 10
The instruments are strong.
*/
/*** QUESTION 15 ***/
ivreg lwage (educ = faed mark ssoc fhigh fint fself) lexp lexp2
predict resid, residuals
regress resid faed mark ssoc fhigh fint fself lexp lexp2
regress resid faed mark ssoc fhigh fint fself
display ((0.0147-0.0140)/2)/((1-0.0147)/(839-8-1))
// => J-statistic = 0.29483406
// Critical value = (4) F(6-2=4, ∞)  = 9.48
// 0.29483406 < 9.48 => Fail to reject, the instruments are not exogenous.
