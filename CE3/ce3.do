/************************************************
Part 0: Initial setup
*************************************************/
// Clear screen
cls
// Clear memory
clear all
// Change directory to project directory.
cd "/Users/juangesino/Documents/UvA/Year 2/Semester 1/Period 2/Econometrics/CS/CE3"
// Create a log file
capture log close
log using "ce3.log", replace
/************************************************
Part 1: Reproduce Mankiw, Romer and Weil (1992)
*************************************************/
/*** QUESTION 1 ***/
// Load the dataset
use mrw
// Generate variables
gen ly = ln(y85)-ln(y60)
gen ly60 = ln(y60)
gen linv = ln(inv/100)
gen lpop = ln(pop/100+0.05)
/*** QUESTION 2 ***/
// Run regression for the model
reg ly ly60 linv lpop
/*
p-value for ly60 < 0.000
Therefore the coefficient is significant using a significance level of 5%
*/
/*** QUESTION 3 ***/
// Run regression with heteroskedasticity robust errors.
reg ly ly60 linv lpop, robust
/*
There is not much change in the coefficients, SEs, t-ratios or p-values
*/
/*** QUESTION 4 ***/
// Run reduced regression
reg ly ly60
/*
In this case, the p-value becomes insignificant (>0.05).
The problem is that we probably have some omitted variable bias.
The omitted variables in this regression are likely correlated with ly60 as
well as being determinants of ly.
*/
/*** QUESTION 5 ***/
// F statistic
display ((0.4497-0.0000)/2)/((1-0.4497)*(105-3-1))
/*
Fact = F = 0.0040455
Fcr = F(q=100, infinity) = 1.24
Fact < Fcr => Do not reject H0
*/
/*** QUESTION 6 ***/
// Testing restricted vs unrestricted model
reg ly ly60 linv lpop
test (linv=0) (lpop=0)
/************************************************
Part 2: Own data experiment
*************************************************/
/*** QUESTION 8 ***/
// Set the random number seed
set seed 7845 // --> Student number here.
/*** QUESTION 9 ***/
// Generate variables
gen u=0.35*rnormal()
gen lys=2-0.2*ly60+0.7*linv-0.4*lpop+u
/*
u ~ N(0, 0.35^2)

The true values are the coefficients we found in Part 1
*/
reg lys ly60 linv lpop
// Estiamtion error for ly60
display (-0.2226647)-(-0.1829643)
// => -0.0397004
// Estiamtion error for linv
display (0.7087286)-(0.6932229)
// => 0.0155057
// Estiamtion error for lpop
display (-0.1641832)-(-0.4247699)
// => 0.2605867
/*** QUESTION 10 ***/
reg lys ly60 linv lpop
test (linv=0) (lpop=0)
/*
p-value < 0.0000 => Reject H0
We know the population, and we know the coefficients are not zero.
We reject the hypothesis with a significance level of 5%
We make a Type II error.
*/
/*** QUESTION 11 ***/
// Remove old values for u and lys
drop u lys
/*** QUESTION 12 ***/
// Generate new errors with higher SD
gen u=3.5*rnormal()
gen lys=2-0.2*ly60+0.7*linv-0.4*lpop+u
// Run new regression
reg lys ly60 linv lpop
// Test the coefficients
test (linv=0) (lpop=0)
/*
p-value = 0.6469 => Do not reject H0
*/
/*** QUESTION 13 ***/
drop u lys
gen u=0.35*rnormal()
gen lys=2-0.2*ly60+0.7*linv-0.4*lpop+u
reg lys ly60
/*
TODO:
Compare these simple regression results with the multiple regression results.
What is the problem here?
Which consequence does it have for your estimation results?
*/
/*** QUESTION 14 ***/
test (ly60=-0.2)
/*
p-value < 0.0000 => Reject H0
*/
/*** QUESTION 15 ***/
drop lys
gen lys=2-0.2*ly60+0.55*linv-0.55*lpop+u
gen ip=linv-lpop
regress lys ly60 ip lpop
/*
TODO: What is the value of the population regression coefficient of the
regressor lpop in this model?
*/
/*** QUESTION 16 ***/
// No, the coefficient is not significant.
/*** QUESTION 17 ***/
regress lys ly60 ip
