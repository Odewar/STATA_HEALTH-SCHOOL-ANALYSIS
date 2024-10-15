import excel "C:\Users\Administrator\Desktop\STATA\BUSARA\TOOLS\Busara_Data_Task_April_2019\HealthInsurance.xlsx", sheet("Sheet 1") firstrow
/*Data cleaning*/
tab genderoftherespondent
replace genderoftherespondent= "female" if genderoftherespondent=="Female"
tab selfreportedhealthstatus
replace selfreportedhealthstatus= "yes" if selfreportedhealthstatus=="Y"
replace selfreportedhealthstatus= "yes" if selfreportedhealthstatus=="YES"
replace selfreportedhealthstatus= "no" if selfreportedhealthstatus=="N"

/*Distribution*/
tab genderoftherespondent
sum ageinyears

/*Ho: There is no difference between the health status 
(specifically "poor health") and insurance status.*/

tab selfreportedhealthstatus Doyouhavehealthinsurance, chi

/*Reject the null hypothesis: Since the p-value 0.00 is less than 0.05, 
you reject the null hypothesis. This suggests that there is a statistically significant difference
between the distribution of poor health status and having insurance.*/

/*Question D*/

tab respondentsethnicity
keep if respondentsethnicity== "zulu"
tab Areyouselfemployed
tab Doyouhavehealthinsurance
count if Doyouhavehealthinsurance=="yes" & Areyouselfemployed== "yes"

/*E*/
/*The outcome variable here is insurance uptake,
 which is typically binary (1 = has insurance, 0 = does not have insurance). 
Logistic regression is specifically designed to model binary outcome variables.*/

/*f*/




