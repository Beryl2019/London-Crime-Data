import delimited "/Users/beryloranga/Documents/The New School/Fellowhips/Data Science/Data/new/Parking_Citations.csv", bindquote(strict) encoding(ISO-8859-1)
describe violdate
list violdate in 1/10
#generates and changes from string
gen violdate3 = clock(violdate, "MDYhms")
list violdate violdate3 in 1/10
format %tcMon_DD,_CCYY_HH:MM:SS violdate3
list violdate violdate3 in 1/10
gen violyear = year(dofc(violdate3))
drop if violyear >= 2019
sum violyear
# Mean of viofine before Jan, 1 2019
sum violfine 
return list

# Police district
bysort policedistrict: sum ïcitation if !missing(policedistrict)
gen policedistrict2 = upper(policedistrict)
replace policedistrict2 = "NORTHEASTERN" if policedistrict2 == "NOTHEASTERN"
#Mean violation by police district
bysort policedistrict2: sum violfine 
sum violfine if policedistrict2 == "NORTHEASTERN"
return list

#Citations between 2004 $ 2014
bysort violyear: sum ïcitation if  violyear >= 2004 & violyear <= 2014
tabstat ïcitation, s(n) by( violyear) 
preserve
collapse (count) ïcitation, by(violyear)
regress ïcitation violyear if  violyear >= 2004 & violyear <= 2014
return list
matlist e(b), for(%20.10f)
restore

# 81 pecentile
centile openpenalty if openpenalty != 0 & !missing(openpenalty), c(81)
return list
matlist r(lb_1), for(%20.10f)

# Vehicle makes
 tabstat ïcitation, s(n) by(make) 
 
 table major_category month, c(sum value)
 
 # Question three
 import delimited "/Users/beryloranga/Documents/The New School/Fellowhips/Data Science/Data/Project/london_crime_by_lsoa.csv", bindquote(strict) encoding(ISO-8859-1)
 #Examining Data
 sort minor_category
 table minor_category month year, c(sum value)
 table minor_category month, c(sum value)
 table major_category month, c(sum value)
 sort major_category month
 
 #Subset for graphs
 preserve
 collapse (sum) value, by(borough major_category month)
 separate value, by(borough)
 
 #Examine different graphs to identify trends across Boroughs
 line value? month, by(major_category)
 #Plot Boroughs with obvious trends
 line value? month if major_category == "Violence Against the Person"
 line value? month if major_category == "Burglary"
 
 
 
 
 
 
 
