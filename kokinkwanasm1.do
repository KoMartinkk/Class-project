Q1:
import excel NIPA_2_1, sheet(Sheet1) firstrow clear
use deflator.dta , clear
import excel NIPA_2_1, sheet(Sheet1) firstrow clear
destring year, replace 
des
import excel NIPA_2_1, sheet(Sheet1) firstrow clear
destring year, replace 
merge 1:1 year using deflator.dta , keep (3)
des
gen cpi2 = (Wages_and_salaries/ Population*1000)/cpiu
gen labor_income = ln(cpi2)
line  labor_income year

Q1.2:
gen pced1 = ln((Wages_and_salaries/ Population*1000)/pcedef)
line pced1 year

Q2
import excel NIPA_1_14, sheet(Sheet1) firstrow clear
destring year, replace 
des
gen lshare =   Compensation_of_employees/Gross_value_added_of_corporate_b
line lshare year

Q2.2:
import excel IPP_data_for_question2, sheet(Sheet1) firstrow clear

line IPP_C year

Q2.3:
import excel NIPA_1_14, sheet(Sheet1) firstrow clear
destring year, replace 
des
save NIPA114.dta , replace

import excel IPP_data_for_question2, sheet(Sheet1) firstrow clear
destring year, replace 
merge 1:1 year using NIPA114.dta, keep (3)
des

gen oldLshare= Compensation_of_employees/ (Gross_value_added_of_corporate_b - IPP_C)
gen lshare = Compensation_of_employees/Gross_value_added_of_corporate_b

line lshare oldLshare year

Q3:

import excel NIPA2_3_5, sheet(Sheet1) firstrow clear
destring year, replace 
des
merge 1:1 year using deflator.dta , keep (3)
des


gen food__perc = ln((Foodandnonalcoholicbeverages/(Population*1000))/cpiu)
line food__perc year


gen nondurable__perc = ln((Non_durable/(Population*1000))/cpiu)
line nondurable__perc year

gen durable_perc = ln((Durable/(Population*1000))/cpiu)
line durable_perc year

gen Housing__perc = ln((Housing/(Population*1000))/cpiu)
line Housing__perc year













