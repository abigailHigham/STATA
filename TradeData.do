// second attempt
rename icountryname countryA
rename counterpartcountryname countryB
rename (v8-v76) year#, addnumber(1948)
drop year1948-year1989
drop if indicatorcode != "TMG_CIF_USD"
drop if attribute == "Status" 

foreach x in 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 {
destring year`x', replace
}

reshape long year, i(countryA countrycode countryB counterpartcountrycode) j(importsA)
order countryA countryB year importsA
sort countryA countryB year
rename importsA x
rename year importsA
rename x year
save "C:\Users\ahigham4\Downloads\DOT_07-23-2018 20-11-26-64_timeSeries\break1dta"
clear

merge m:m countryB counterpartcountrycode using "C:\Users\ahigham4\Downloads\DOT_07-23-2018 20-11-26-64_timeSeries\break1dta"
tab countryB if _merge!=3
drop if _merge!=3
drop _merge
save "C:\Users\ahigham4\Downloads\NEWNEWNEW.dta", replace

*reentering imports from countryB
rename countryA x
rename countryB countryA
rename x countryB
rename REALccode REALccodeB
rename importsA importsB
drop countryBcheck indicatorname indicatorcode attribute
rename counterpartcountrycode x
rename countrycode counterpartcountrycode
rename x countrycode
sort countryA countryB year
save "C:\Users\ahigham4\Downloads\DOT_07-23-2018 20-11-26-64_timeSeries\TEMP.dta"
use "C:\Users\ahigham4\Downloads\NEWNEWNEW.dta"
sort countryA countryB year
order countryA countryB year
merge 1:1 _n using "C:\Users\ahigham4\Downloads\DOT_07-23-2018 20-11-26-64_timeSeries\TEMP.dta"
drop _merge
order countryA countryB importsA importsB


**removing nations and other observations I don't want
rename REALccodeB ccodeB
rename REALccode ccodeB
gen ccodeB =1500
drop if ccodeA==0
drop if ccodeB==0
drop if ccodeA==.
drop if ccodeB==.
drop if ccodeA ==1001
drop if ccodeA ==1022
drop if ccodeA ==1002
drop if ccodeA ==1003
drop if ccodeA ==1004
drop if ccodeA ==1027
drop if ccodeA ==1006
drop if ccodeA ==1007
drop if ccodeA ==1029
drop if ccodeA ==1009
drop if ccodeA ==1010
drop if ccodeA ==327
drop if ccodeA ==715
drop if ccodeA ==1011
drop if ccodeA ==716
drop if ccodeA ==1030
drop if ccodeA ==1012
drop if ccodeA ==1025
drop if ccodeA ==1020
drop if ccodeA ==6
drop if ccodeA ==1024
drop if ccodeA ==713
drop if ccodeA ==1018
drop if ccodeA ==983
drop if ccodeA ==1005
drop if ccodeB ==1001
drop if ccodeB ==1022
drop if ccodeB ==1002
drop if ccodeB ==1003
drop if ccodeB ==1004
drop if ccodeB ==1027
drop if ccodeB ==1006
drop if ccodeB ==1007
drop if ccodeB ==1029
drop if ccodeB ==1009
drop if ccodeB ==1010
drop if ccodeB ==327
drop if ccodeB ==715
drop if ccodeB ==1011
drop if ccodeB ==716
drop if ccodeB ==1030
drop if ccodeB ==1012
drop if ccodeB ==1025
drop if ccodeB ==1020
drop if ccodeB ==6
drop if ccodeB ==1024
drop if ccodeB ==713
drop if ccodeB ==1018
drop if ccodeB ==983
drop if ccodeB ==1005

egen dyadtrade = rowtotal(importsA importsB)
save "C:\Users\ahigham4\Downloads\DOT_07-23-2018 20-11-26-64_timeSeries\TEMP.dta", replace

collapse (sum) dyadtotal, by (countryA year)
rename dyadtotal totaltradeA
save "C:\Users\ahigham4\Downloads\DOT_07-23-2018 20-11-26-64_timeSeries\hahatemptemptemp.dta"
merge m:m countryA year using "C:\Users\ahigham4\Downloads\DOT_07-23-2018 20-11-26-64_timeSeries\TEMP.dta"




// sum dataset
collapse (sum) totalbyimport, by(countryAcode year_n)
rename totalbyimport sumtotalbyimport
// merge dataset
merge m:1 countryAcode year_n using "C:\Users\ahigham4\Downloads\DOT_07-23-2018 20-11-26-64_timeSeries\tempfile.dta"
gen tradepercent = totalbyimport/sumtotalbyimport
order countryA countryB year_n totalbyimport sumtotalbyimport tradepercent 

foreach x in EPInbiomes EPIgbiomes EPInspecies EPIgspecies EPImpa {
gen `x'trade = tradeweight*`x'
}

collapse (sum) EPInbiomestrade-EPImpatrade, by(countryA year)

*done
