/************************************************
Part 0: Initial setup
*************************************************/
// Clear screen
cls
// Clear memory
clear all
// Change directory to project directory.
cd "/Users/juangesino/Documents/UvA/Year 2/Semester 1/Period 2/Econometrics/CS/CE4"
// Create a log file
capture log close
log using "ce4.log", replace
/************************************************
Part 1: Functional Form
*************************************************/
/*** QUESTION 2 ***/
// Load dataset
use CE4.dta
// Construct the logarithms of all variables
gen ly = log(y)
gen ll = log(l)
gen lk = log(k)
/*** QUESTION 3 ***/
// Summary statistics
sum *
// Sample correlations
correlate *
// Histograms
hist y
hist ly
/*
What is the main difference in the frequency distributions of y and ly?
The main difference is the shape of the distribution. The distribution of
ly seems to have a bell-shaped distribution.

TODO: From the perspective of the least squares method do you prefer to work
with the original or logarithmic transformed data?
*/
/*** QUESTION 4 ***/
reg ly ll lk
/*
Given the specific functional form interpret the meaning of the k
estimated regression coefficient.
A 1% increase in k will cause a 0.207% increase in y.
*/
/*** QUESTION 5 ***/
/*
Are the individual coefficients of labor and capital significantly different
from zero?
Yes, the p-values < 0.05 (for all coefficients)

In addition, are they jointly significant?
Yes, the p-value for the entire model (F-test) is less than 0.05
*/
/*** QUESTION 6 ***/
reg ly ll
reg ly lk
/*
TODO: Use the results on p.231/232 of S&W (2015, 3rd updated ed.) to explain
the difference between the labor and capital elasticities from these simple
regressions and the multiple regression of question 4.

TODO: Which estimates do you prefer?
*/
/*** QUESTION 7 ***/
gen lys = log(1000*y)
gen lks = log(1000*k)
reg lys ll lks
/*
Describe the effects of such scaling on the regression coefficients
taking into account the specific functional form used here.
Because we are using a log-log regression, the coefficients are can be
interepreted as percentage changes, thus this scalling has no effect on them.
*/
/*** QUESTION 8 ***/
reg ly ll lk
test ll+lk=1
// Reject the null hypothesis (p-value < 0.0000)
/*** QUESTION 9 ***/
reg ly ll lk, robust
test ll+lk=1
// Reject the null hypothesis (p-value < 0.0000)
/*** QUESTION 10 ***/
gen lyd = ly-ll
gen lkd = lk-ll
reg lyd ll lkd
// Reject the null hypothesis (p-value < 0.0000)
