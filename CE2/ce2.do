/************************************************
Part 0: Initial setup
*************************************************/
// Clear screen
cls
// Clear memory
clear all
// Change directory to project directory.
cd "/Users/juangesino/Documents/UvA/Year 2/Semester 1/Period 2/Econometrics/CS/CE2"
// Create a log file
capture log close
log using "ce2.log", replace
/************************************************
Part 1: Monte Carlo analysis.
*************************************************/
/*** QUESTION 1 ***/
// Set the random number seed
set seed 7845 // --> Student number here.
// Set number of observations to 1000
set obs 1000
// Generate data from a normal distribution
generate x = 10 + 2* rnormal()
// Generate normally distributed random variables
generate u = rnormal()
// Generate y
gen y = 10 + x + u
// Generate a regression between y and x
reg y x
/*
Why are your estimated coefficients different from the ones you found last week?
Because the randomly generated numbers are generated using a different seed.

What are the estimation errors?
*/
// Estimation error for β0
display (10-10.00786)
// => -0.00786
// Estimation error for β1
display (1-1.000595)
// => -0.000595
/*** QUESTION 2 ***/
// The test statistic for this test is:
display ((1.000595-0.95)/0.146971)
// => 0.34425159
/*
Do you reject or not?
Do not refect (0.344 < 1.64)

In this case you know that the null hypothesis is not true (why?)
Because the true parameter is 1 (defined when we generated y)

Do you make an error? If so, is this a Type 1 or Type 2 error?
Yes, we make a Type II error.
*/
/*** QUESTION 3 ***/
// The test statistic for this test is:
display ((1.000595-1)/0.146971)
// => 0.00404842
/*
Do you reject or not?
Do not refect (0.004 < 1.64)

Compare the outcome of the test (reject or not reject) with your knowledge of
the population regression model.
We do not reject the hypothesis and we know that the hypothesis is true.

Do you make an error? If so, is this a Type 1 or Type 2 error?
We do not make an error.

And finally, given the significance level of 5% how many students present today
will make an error?
There is a probability of 5% of finding a result that rejects H₀.
*/
/*** QUESTION 4 ***/
// Run the regression with the first 10 observations.
reg y x if (_n<=10)
// Calculate again the estimation errors in the regression coefficients.
// Estimation error for β0
display (10-9.395922)
// => 0.604078
// Estimation error for β1
display (1-1.124036)
// => -0.124036
/*
Are estimation errors always larger in case of 10 (instead of 1000)
observations?
The estimation errors are usually larger for the smaller sample.
*/
/*** QUESTION 5 ***/
/*
Given that we use a smaller sample, the power of the test decreases.
The probability of making a Type II error increases.
This is due to the fact that the estimator is consistent and the variance
tends to zero as the number of observations approaches infinity.
*/
/*** QUESTION 6 ***/
// The test statistic for this test is:
display ((1.124036-0.95)/0.0936091)
// => 1.8591782
/*
Do you reject or not?
We reject the null hypothesis (1.859 > 1.64)

Do you make an error? If so, is this a Type 1 or Type 2 error?
We do not make an error.
*/
/*** QUESTION 7 ***/
/*
Compare the outcomes from the t-tests of questions 2 and 6.
Discuss the effect of sample size on power of the t-test as performed
in questions 2 and 6.
A larger sample size increases the power of the test.
*/
/*** QUESTION 8 ***/
// Generate new error
gen u1 = 1 + 2*u
// Generate new y with new error
gen y1 = 10 + x + u1
// Generate a regression between y1 and x
reg y1 x
/*
The estimator for β1 is not affected.
The estimator for β0 becomes bias.
*/
/*** QUESTION 9 ***/
// Generate new (but related) error terms
gen u2 = 2*abs(u)
gen u3=u*u
/*
What distributions do these error terms have?
u2 => Only positive values of the normal distribution
u3 => A chi-square distribution

What are their expectations and variances?
E(u2) = E(2|u|) = 2E(|u|) =
Var(u2) = Var(2|u|) = 4Var(|u|) =
E(u3) = E(u*u) =
Var(u3) = Var(u*u) =
*/
// Generate new y for each error.
gen y2 = 10 + x + u2
gen y3 = 10 + x + u3
// Regress y2 and y3
reg y2 x
reg y3 x
/*
Are the regression results different from what you expected?
No, the errors are absorbed by the constant.
*/
/************************************************
Part 2: CAPM model.
*************************************************/
// Clear screen
cls
// Clear memory
clear all
/*** QUESTION 12 ***/
use capm
/*** QUESTION 13 ***/
/*
Because we have no data for the previous time period.
*/
/*** QUESTION 14 ***/
// Summary statistics
sum rboeing rwalmart rsp500
// Scatter for Boeing and S&P500
twoway (scatter rboeing rsp500)
// Scatter for Walmart and S&P500
twoway (scatter rwalmart rsp500)
// Show correlation between variables
correlate rboeing rwalmart rsp500
/*** QUESTION 15 ***/
/*
CAPM Model:
ER = Rf + β1 (Rm - Rf)
ER: Expected returns
Rf: Risk-free return
β1: Beta
Rm: Market return
*/
// Generate risk premium (with Rf = 0.04)
gen rp = rsp500 - 0.04
// Generate companies deviation from risk-free
gen diffwalmart = rwalmart - 0.04
gen diffboeing = rboeing - 0.04
// Regress returns with risk premium (Boeing)
reg diffboeing rp
// Regress returns with risk premium (Walmart)
reg diffwalmart rp
/*** QUESTION 16 ***/
// Test for Boeing
display (1.205873-1)/0.0859617
// => 2.3949387 > 1.64 (Reject the hypothesis)
display (0.0155256-0)/0.3150954
// => 0.0492727 < 1.64 (Do not reject the hypothesis)
// Test for Walmart
display (0.485359-1)/0.0534229
// => -9.6333408 < -1.64 (Reject the hypothesis)
display (0.1342191-0)/0.1958236
// => 0.68540819 < 1.64 (Do not reject the hypothesis)
/*** QUESTION 17 ***/
/*
Give an interpretation of the estimation results.
What does the beta indicate?
It indicates by how much will the return for the company increase
given a unit increase in the risk premium.

What does it indicate from a mathematical point of view?
It is the slope of the regression between the company's returns and
the risk premium.

What about the alpha?
The alpha captures unaccounted effects that are not specified in the model.
*/
/*** QUESTION 18 ***/
// Can you test whether the beta's of the two companies are equal.
// TODO
/*** QUESTION 19 ***/
// Regressions without a constant
reg diffboeing rp, noconstant
reg diffwalmart rp, noconstant
// Are the estimates of the beta's different from the ones you found in 14?
// They are very slightly different
// Can you test whether they are different from each other?
// TODO
/*** QUESTION 20 ***/
// What is the estimation error w.r.t. beta that you make?
// TODO
