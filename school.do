import excel "C:\Users\Administrator\Desktop\STATA\BUSARA\TOOLS\Busara_Data_Task_April_2019\School data.xlsx", sheet("Data") firstrow

gen total_enrolled= enrolled_male_students + enrolled_female_students

bysort district_id (total_enrolled): gen school_id = _n
save "sheet1_data.dta", replace
/*file sheet1_data.dta saved*/

import excel "C:\Users\Administrator\Desktop\STATA\BUSARA\TOOLS\Busara_Data_Task_April_2019\School data.xlsx", sheet("District names") firstrow clear

rename DISTRICTID district_id

save "sheet2_data.dta", replace
/*file sheet2_data.dta saved*/

use "sheet1_data.dta", clear

use "sheet1_data.dta", clear

merge m:1 district_id using "sheet2_data.dta"

drop C
drop if _merge==1
drop if _merge==2

drop _merge
sum total_enrolled
list if total_enrolled<0
sum total_enrolled if total_enrolled>0
sum enrolled_female_students if enrolled_female_students>0
sum enrolled_male_students if enrolled_male_students> 0
replace enrolled_male_students=537 if enrolled_male_students<0
replace enrolled_female_students= 443 if enrolled_female_students<0
list if total_enrolled<0
gen total_enrolled_updated = enrolled_male_students+ enrolled_female_students
list if total_enrolled_updated<0
sum total_enrolled_updated
label define treat_label 0 "Control" 1 "Treatment"
label values treatment treat_label
graph bar attended_female, over( treatment)
xtset district_id
gen total_attendance= attended_male+ attended_female
xtreg total_attendance treatment, fe

xtreg total_attendance treatment total_enrolled, fe

/*The difference between the two is accomodation of total enrolled 
as a control which puts into place other factors such as size of school 
influencing total attendance*/

