/************************************************
Part 0: Initial setup
*************************************************/
// Clear screen
cls
// Clear memory
clear all
// Change directory to project directory.
cd "/Users/juangesino/Documents/UvA/Year 2/Semester 1/Period 2/Econometrics/CS/CE1"
// Create a log file
capture log close
log using "ce1.log", replace
/************************************************
Part 1: Basic elements of Stata.
*************************************************/
/*** QUESTION 1 ***/
// Import the data
use caschool
/*** QUESTION 3 ***/
// List data
list testscr str
/*** QUESTION 4 ***/
// Summary statistics
sum testscr str
/*** QUESTION 5 ***/
// Summary statistics with additional details
sum testscr str, d
/*** QUESTION 6 ***/
// Show correlation between variables
correlate testscr str
/*** QUESTION 8 ***/
// Create two-way graph (Y: testscr, X:str)
twoway (scatter testscr str)
/*** QUESTION 9 ***/
// Run the regression of testscr on a constant and str
regress testscr str testscr str
/*** QUESTION 10 ***/
// Regression with heteroskedasticity robust standard errors
regress testscr str testscr str, vce(robust)
/*** QUESTION 11 ***/
// Clear the results
clear
/************************************************
Part 2: Generate own data.
*************************************************/
/*** QUESTION 12 ***/
// Set the random number seed
set seed 7845 // --> Student number here.
/*** QUESTION 13 ***/
// Set number of observations to 1000
set obs 1000
/*** QUESTION 14 ***/
// Generate data from a normal distribution
generate x = 10 + 2* rnormal()
// Generate normally distributed random variables
generate u = rnormal()
// Generate y
gen y = 10 + x + u
// Summary statistics
sum x y
// Create a two-way plot
twoway (scatter y x)
/*** QUESTION 15 ***/
// Run a regression between x and y
regress y x
// The real value of β0 is 10
// The real value of β1 is 1
// Estimation error β0 is 0.05
// Estimation error β1 is -0.00395
// Show scatter diagram with regression line
twoway (lfit y x) (scatter y x)
/*** QUESTION 16 ***/
// Generate more random variables
gen xx=10+2*rnormal()
gen uu=rnormal()
gen yy=10+xx+uu
// Run a regression with the new variables
regress yy xx
// Estimation error β0 is 0.00459
// Estimation error β1 is -0.00168
// They are different beacause it is a different random sample.
/*** QUESTION 17 ***/
// The average estimation error should be zero.
// The average of all estimates should be the population parameter.
/*** QUESTION 18 ***/
// This is not possible as we do not have the population parameters.
/************************************************
Part 3: Algebraic properties of OLS.
*************************************************/
/*** QUESTION 19 ***/
// Generate new variable
gen w=2*x
// Regress y and the new variable
reg y w
// Create residuals
predict resid, residuals
// The estimator for β0 stays very similar.
// The estimator for β1 is close to 1/2 of the previous value.
/*** QUESTION 20 ***/
correlate y x w resid, covariance
// From the population parameters, we can see that w=2*x
// Therefore Var(w)=Var(2*x)=4Var(x)
/*** QUESTION 22 ***/
// The residuals mostly explain the random variable u which was generated
// indeendently from x and w.
/*** QUESTION 23 ***/
// Sample correlation coefficients
correlate y x w resid
// Because they are not independent, we created w by multiplying x by 2.
