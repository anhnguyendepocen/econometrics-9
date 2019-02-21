/************************************************
Part 0: Initial setup
*************************************************/
// Clear screen
cls
// Clear memory
clear all
// Change directory to project directory.
cd "/Users/juangesino/Documents/UvA/Year 2/Semester 1/Period 2/Econometrics/CS/CE6"
// Create a log file
capture log close
log using "ce6.log", replace
/************************************************
Part 1: Individual data
*************************************************/
/*** QUESTION 1 ***/
use MROZ
/*** QUESTION 2 ***/
gen lhw = log(hw)
gen ax2 = ax*ax
/*** QUESTION 3 ***/
gen lww=log(ww) in 1/428
reg lww we ax ax2 in 1/428
replace lww = _b[_cons] + _b[we]*we + _b[ax]*ax + _b[ax2]*ax2 in 429/753
/*** QUESTION 4 ***/
reg lfp lww lhw we un
/*
Regression on LFP (dummy variable = 1 if woman worked in 1975, else 0)
Coefficients:
- lww: wife's average hourly earnings, in 1975 dollars
=> Positive
- lhw: husband's wage, in 1975 dollars
=> Negative
- we: wife's age
=> Positive
- un: unemployment rate in county of residence, in percentage points
=> Negative
*/
/*** QUESTION 6 ***/
logit lfp lww lhw we un
probit lfp lww lhw we un
/*** QUESTION 7 ***/
dprobit lfp lww lhw we un
/*
The coefficients are similar and all of them have the same sign.
*/
/*** QUESTION 8 ***/
clear
/************************************************
Part 2: Regional data
*************************************************/
/*** QUESTION 9 ***/
use usstate
gen lyf = log(yf)
gen lym = log(ym)
/*** QUESTION 10 ***/
reg wlfp lyf lym educ ue
/*
Regression on WLFP (female labor force participation rate)
Coefficients:
- lyf: average wage female
=> Positive
- lym: average wage males
=> Negative
- educ: percentage females with completed highschool education
=> Positive
- ue: unemployment rate in county of residence
=> Negative
*/
/*** QUESTION 11 ***/
gen lo = log(wlfp/(100-wlfp))
reg lo lyf lym educ ue
sum wlfp
disp (0.0118244)*(57.474/100)*(1-(57.474/100))*100
