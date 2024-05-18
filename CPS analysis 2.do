*1.

use cps_project3_Q1_sample.dta, clear
reg wage sex_dummy edu_dummy age age2 race_dummy if year == 2000


*1. part 2.

use cps_project3_Q1_sample.dta, clear
gen lny = log(wage)
gen r1 = .

forvalues year = 1976(1)2017 {

reg lny sex_dummy edu_dummy age age2 race_dummy  [aweight = hh_wgt] if year == `year'

predict r1_temp if year == `year',resid
replace r1 = r1_temp if year == `year'

drop r1_temp
}

gen resid_sd = r1
collapse (sd) resid_sd [aweight=hh_wgt],by(year) fast

gen resid_var = resid_sd^2
line resid_var year 


*2.1.

use cps_project3_Q2_sample.dta, clear
collapse (mean) earnings [weight=asecwth], by(age)
line earnings age 


*2.2.

use cps_project3_Q2_sample.dta, clear
gen ln_earnings=ln(earnings)
collapse (sd) ln_earnings [weight=asecwth], by(age)
gen variance_ln_earnings = ln_earnings^2
twoway (line variance_ln_earnings age), title("Variance of natural log of male earnings by age") ytitle("Variance") xtitle("Age")


*2.3.

clear
use cps_project3_Q2_sample.dta, clear
gen ln_real_e = ln(earnings_real)
gen r1 = .

forvalues age = 25(1)60 {

reg ln_real_e year [aweight=asecwth] if age == `age'

predict r1_temp if age == `age',resid
replace r1 = r1_temp if age == `age'

drop r1_temp
}

gen resid_sd = r1
collapse (sd) resid_sd [aweight=asecwth] ,by(age) fast

gen residual_var = resid_sd^2
twoway (line residual_var age), title("Variance of residuals for each age group") ytitle("Variance of residuals") xtitle("Age") 




