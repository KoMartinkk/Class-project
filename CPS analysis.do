#Initial procedure

#generate earnings
use cps_sample_Q1.dta,clear
gen earning = salary + 2*busfarm/3

#generate real earnings using PCE deflator on individual level
gen real_earnings = earning/pcedef 

#only keep working age individuals
keep if age >= 25 & age <= 60

# Generate household earnings (real) by summing up the individual earnings (real) in that household 
# for each year
sort year serial
by year serial: egen hh_earnings_real = total(real_earnings)

# Trim the lowest 0.5% household earnings by taking out zeros for each year
# To avoid extreme small values that affect calculations
replace hh_earnings_real = . if hh_earnings_real <= 0 
do trim hh_earnings_real .5 

# Generate equivalized real household earnings
gen hh_earnings_real_equiv = hh_earnings_real/equiv_measure
keep if head == 1
save hh_cps_sample.dta,replace

# Compute and generate a graph that shows the 
# variance of natural log of equivalized household earnings year by year from 1967- 2019
use hh_cps_sample.dta,clear
gen ln_hh_earnings_real_equiv =ln(hh_earnings_real_equiv)
collapse (sd) sd_lhh_earnings_real = ln_hh_earnings_real_equiv [weight=asecwth], by(year)
gen var_log_hh_earnings_real = sd_lhh_earnings_real^2
line var_log_hh_earnings_real year

# Compute and generate a graph for the Gini coefficient of 
# equivalized real household earnings year by year from 1967 - 2019
use hh_cps_sample.dta,clear
do gini hh_earnings_real_equiv year pcedef
line gini year

# Compute the 90th percentile-50th percentile and 50th percentile-10th percentile ratio of
# equivalized real household earnings year by year from 1967-2019
use hh_cps_sample.dta,clear
use hh_cps_sample.dta,clear
rename hh_earnings_real_equiv var
collapse (p10) p10e=var (p50) p50e=var (p90) p90e=var [weight=asecwth], by(year)
gen ratio90_50 = p90/p50
gen ratio50_10 = p50/p10
line ratio90_50 ratio50_10 year 

# Compute the Gini coefficient of equivalized household earnings year by year from 1967
# 2019 again
use cps_sample_Q1.dta,clear
gen earning = salary + 2*busfarm/3
gen real_earnings = earning/pcedef 
keep if age >= 25 & age <= 60
sort year serial
by year serial: egen hh_earnings_real = total(real_earnings)
gen hh_earnings_real_equiv = hh_earnings_real/equiv_measure
keep if head == 1
save hh_cps_sample_with_zeros.dta,replace
use hh_cps_sample_with_zeros.dta, clear
do gini hh_earnings_real_equiv year pcedef
line gini year

# Compute the 50th percentile-10th percentile ratio of 
# equivalized real household earnings year by year from 1967-2019 to observe anomaly 
use hh_cps_sample_with_zeros.dta,clear
rename hh_earnings_real_equiv var
collapse (p10) p10e=var (p50) p50e=var (p20) p20e=var [weight=asecwth], by(year)
gen ratio50_10 = p50/p10
gen ratio50_20 = p50/p20
line ratio50_10 year
line ratio50_20 year

# use data of weekly wages of routine and non-routine workers to plot
# average annual salaries for both occupations and do comparisons
use cps_weekly_wage_sample_Q2.dta,clear
line weekly_wage1 wkswk1 year
line weekly_wage2 wkswk2 year
line salary1 salary2 year

# Generate a figure showing the ratio of non-routine wage to routine wage and plot the ratio with respect
# to year
gen ratio_nonroutine_routine = weekly_wage2/weekly_wage1
line ratio_nonroutine_routine year



