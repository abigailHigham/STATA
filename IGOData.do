//Abbey Higham, Revised 1/18/2019
//Creating a dta that contains all IOs. Diplometrics has all of the data sets
//separated by IO. I am not quite sure why, but none of the forloop/foreach commands worked
//with the excel file names within the quotation marks, so I created an excel
//page with all IO names and used VBA to create the syntax for all IO diplometric
//files. The diplometric IO files were coded by two different RAs that had
//different labeling techniques, hence the two different examples below on 
//lines 10-17 and 20-27. The full do file is avaiable in the IO folder, IOMerge,do

import excel "C:\Users\ahigham4\Downloads\IGOs_V.3.16.16\Updated IGOs coding 2.22.16\ATS.xls", sheet("Sheet1") firstrow
rename Country country
rename (B-GS) BIE#, addnumber(1816)
keep in 1/336
keep country-BIE2015
reshape long BIE, i(country) j(year)
save "C:\Users\ahigham4\Downloads\BIE.dta"
clear


import excel "C:\Users\ahigham4\Downloads\IGOs_V.3.16.16\Updated IGOs coding 2.22.16\BIE.xls", sheet("Longitudinal") firstrow
rename A country
rename (B-GS) BIE#, addnumber(1816)
keep in 1/336
keep country-BIE2015
reshape long BIE, i(country) j(year)
save "C:\Users\ahigham4\Downloads\BIE.dta"
clear

//The IOMerge.do also contains merge command I used. Below is an example.
merge 1:1 country year using "C:\Users\ahigham4\Downloads\AAEA.dta", nogenerate

//I replaced all partial memberships (value=2) with 0.
foreach var = varlist AU-WTOURO t*{
	replace `var' = 0 if `var' ==2
}

//after this, I saved the IO data set as IO Data Set.dta

**DYAD CREATION**
help dyads
// install 'DYADS': module to transform observations into dyads
**This created a new var called country_d that made all possible combinations
**of country dyads**
dyads country, dyadvars(country)

//below, I create 2 different files for each IO 
//ran a foreach command for all IOs 
foreach `x' of list AAEA AALCO AARDO ABEDA ABEPSEAC ACAC ACC ACCT ACDT ACI ACML ACP ACS ACU AEIB AfDB AFESD AFGEC AfricaRice Afristat AGC AIC AIDB AIDC AIOEC AIPO AIPU AITIC ALO AMCO AMF AMIPO AMPTU AMSC AMU ANRPC ANZUS AOAD AOCRS AOMR APCC APEC APO APPA APPC APPU APT APTU ARADO ARC ARIPO ArticC ASATP ASBA ASCBC ASCO AsDB ASEAN ASECNA ASEF ASPAC ATO ATPC ATS AU BDS BENELUX BIE BIISEF BIPM BIS BNDP BOrganizationIP BSEC CAAD CAARC CAB CACB CAEC CAEU CAMES CAMRSD CAMSF CAN CARICOM CARIFTA CARII CATC CBI CBSS CCNR CCOM CComm CD CDB CE CEAO CEC CEI CELC CEMAC CENTO CEPGL CEPT CERN CFAC CFATF CFC CHSTEA CIC CIEC CIESM CILSS CIMA CIS CLAF CMAEC CMEA COLOMBO ComAB COMESA COMSEC CONFEJES COrg COSAVE CPA CPAB CPLP CPSC CPU CSTO CTCAf CTO CTU CWGC DBGLS DLCOEA EAC EACM EACSO EADB EAEC EAPO EBRD ECB ECCA ECCAS ECCB ECCM ECCPIF ECO ECOWAS ECSC EEC EFCC EFTA EIPA ELDO EMBC EMBL EMI Entente EPA EPFSC EPO EPPO EPU ESA ESO ESRO EU EUN EURATOM EUROCONTROL EUROFIMA FAO FEC FOPREL GATT GBACT GCC GCRSNC GLACSEC GOIC HCPIL IACB IACO IACS IACW IADB IAEA IAFC IAI IAIGC IAMLO IAPhy IARA IARadiO IARuhr IATTC IBA IBE IBI IBPCT IBRD ICAC ICAO ICAP ICC ICCAT ICCEC ICCILMB ICCO ICCROM ICCSLT ICDO ICES ICFI IChemO ICMM ICMPD ICNWAF ICO ICPMS ICPR ICSEAF ICSG IDB IEA IES IFAD IFC IGAD IGC IGCC IHO IIA IICA IICom IIDEA IIFEO IIR IJO ILO ILZSG IMC IMF IMO IMSO INFOFISH INPFC INRO INSG INTELSAT INTERPOL IOATHRE IOC IOM IOOC IOPCF IOPH IORARC IOSC IPC IPentC IPI IRENA IRLCOCSA IRLCS IRO IRSG IRU ISA ISB ISESCO ISHREST ISO ISTC ISuC ITC ITCC ITPA ITTO ITU IVWO IWC IWSG JALAAO JINR JNOLCRH LACAC LAEO LAFDO LAFTA LAIA LAS LATIN LCBC LGA LoN MAOC MERCOSUR MOWCA MRU NACAP NAFO NAFTA NAMMCO NAPPO NASCO NATO NBA NC NCRR NEAFC NERC NIB NPFSC NPI NTSC OAPEC OAS OAU OCAM OCAS OCCAR OCEAC OECD OECS OEEC OEI OIC OIE OIF OIML OIV OMDKR OMVG OPANAL OPEC OSCE OSJD OSLO OSPAR OTIF PAHC PAHO PAIGH PC PCA PCB PIANC PICES PIF PMAESA PSNARCO PTASEA PUASP RCAELA RCC RIOPPAH SAAFA SAARC SADC SADCC SARTC SCAf SCHENGEN SCO SEAMO SEATO SELA SICA SIECA SPC SRDO SWAPU TCRMG TURKSOY UBE UDEAC UEMOA UIUCV UKDWD UMAC UMOA UN UNESCO UNIDO UNIDROIT UPU WAEC WAHC WAPCO WASSEN WCO WEU WHO WIPO WMO WNF WPact WTO WTOURO {
	use "C:\Users\ahigham4\Downloads\`x'.dta"
	rename `x' `x'a
	save "C:\Users\ahigham4\Downloads\`x'a.dta"
	clear
}
foreach `x' of list AAEA AALCO AARDO ABEDA ABEPSEAC ACAC ACC ACCT ACDT ACI ACML ACP ACS ACU AEIB AfDB AFESD AFGEC AfricaRice Afristat AGC AIC AIDB AIDC AIOEC AIPO AIPU AITIC ALO AMCO AMF AMIPO AMPTU AMSC AMU ANRPC ANZUS AOAD AOCRS AOMR APCC APEC APO APPA APPC APPU APT APTU ARADO ARC ARIPO ArticC ASATP ASBA ASCBC ASCO AsDB ASEAN ASECNA ASEF ASPAC ATO ATPC ATS AU BDS BENELUX BIE BIISEF BIPM BIS BNDP BOrganizationIP BSEC CAAD CAARC CAB CACB CAEC CAEU CAMES CAMRSD CAMSF CAN CARICOM CARIFTA CARII CATC CBI CBSS CCNR CCOM CComm CD CDB CE CEAO CEC CEI CELC CEMAC CENTO CEPGL CEPT CERN CFAC CFATF CFC CHSTEA CIC CIEC CIESM CILSS CIMA CIS CLAF CMAEC CMEA COLOMBO ComAB COMESA COMSEC CONFEJES COrg COSAVE CPA CPAB CPLP CPSC CPU CSTO CTCAf CTO CTU CWGC DBGLS DLCOEA EAC EACM EACSO EADB EAEC EAPO EBRD ECB ECCA ECCAS ECCB ECCM ECCPIF ECO ECOWAS ECSC EEC EFCC EFTA EIPA ELDO EMBC EMBL EMI Entente EPA EPFSC EPO EPPO EPU ESA ESO ESRO EU EUN EURATOM EUROCONTROL EUROFIMA FAO FEC FOPREL GATT GBACT GCC GCRSNC GLACSEC GOIC HCPIL IACB IACO IACS IACW IADB IAEA IAFC IAI IAIGC IAMLO IAPhy IARA IARadiO IARuhr IATTC IBA IBE IBI IBPCT IBRD ICAC ICAO ICAP ICC ICCAT ICCEC ICCILMB ICCO ICCROM ICCSLT ICDO ICES ICFI IChemO ICMM ICMPD ICNWAF ICO ICPMS ICPR ICSEAF ICSG IDB IEA IES IFAD IFC IGAD IGC IGCC IHO IIA IICA IICom IIDEA IIFEO IIR IJO ILO ILZSG IMC IMF IMO IMSO INFOFISH INPFC INRO INSG INTELSAT INTERPOL IOATHRE IOC IOM IOOC IOPCF IOPH IORARC IOSC IPC IPentC IPI IRENA IRLCOCSA IRLCS IRO IRSG IRU ISA ISB ISESCO ISHREST ISO ISTC ISuC ITC ITCC ITPA ITTO ITU IVWO IWC IWSG JALAAO JINR JNOLCRH LACAC LAEO LAFDO LAFTA LAIA LAS LATIN LCBC LGA LoN MAOC MERCOSUR MOWCA MRU NACAP NAFO NAFTA NAMMCO NAPPO NASCO NATO NBA NC NCRR NEAFC NERC NIB NPFSC NPI NTSC OAPEC OAS OAU OCAM OCAS OCCAR OCEAC OECD OECS OEEC OEI OIC OIE OIF OIML OIV OMDKR OMVG OPANAL OPEC OSCE OSJD OSLO OSPAR OTIF PAHC PAHO PAIGH PC PCA PCB PIANC PICES PIF PMAESA PSNARCO PTASEA PUASP RCAELA RCC RIOPPAH SAAFA SAARC SADC SADCC SARTC SCAf SCHENGEN SCO SEAMO SEATO SELA SICA SIECA SPC SRDO SWAPU TCRMG TURKSOY UBE UDEAC UEMOA UIUCV UKDWD UMAC UMOA UN UNESCO UNIDO UNIDROIT UPU WAEC WAHC WAPCO WASSEN WCO WEU WHO WIPO WMO WNF WPact WTO WTOURO {
	use "C:\Users\ahigham4\Downloads\`x'.dta"
	rename country country_d
	rename `x'a `x'b
	save "C:\Users\ahigham4\Downloads\`x'b.dta"
	clear
}

//merged the two IOs together to see if there is a match, this is in wide format
reshape wide
foreach `z' of list AAEA AALCO AARDO ABEDA ABEPSEAC ACAC ACC ACCT ACDT ACI ACML ACP ACS ACU AEIB AfDB AFESD AFGEC AfricaRice Afristat AGC AIC AIDB AIDC AIOEC AIPO AIPU AITIC ALO AMCO AMF AMIPO AMPTU AMSC AMU ANRPC ANZUS AOAD AOCRS AOMR APCC APEC APO APPA APPC APPU APT APTU ARADO ARC ARIPO ArticC ASATP ASBA ASCBC ASCO AsDB ASEAN ASECNA ASEF ASPAC ATO ATPC ATS AU BDS BENELUX BIE BIISEF BIPM BIS BNDP BOrganizationIP BSEC CAAD CAARC CAB CACB CAEC CAEU CAMES CAMRSD CAMSF CAN CARICOM CARIFTA CARII CATC CBI CBSS CCNR CCOM CComm CD CDB CE CEAO CEC CEI CELC CEMAC CENTO CEPGL CEPT CERN CFAC CFATF CFC CHSTEA CIC CIEC CIESM CILSS CIMA CIS CLAF CMAEC CMEA COLOMBO ComAB COMESA COMSEC CONFEJES COrg COSAVE CPA CPAB CPLP CPSC CPU CSTO CTCAf CTO CTU CWGC DBGLS DLCOEA EAC EACM EACSO EADB EAEC EAPO EBRD ECB ECCA ECCAS ECCB ECCM ECCPIF ECO ECOWAS ECSC EEC EFCC EFTA EIPA ELDO EMBC EMBL EMI Entente EPA EPFSC EPO EPPO EPU ESA ESO ESRO EU EUN EURATOM EUROCONTROL EUROFIMA FAO FEC FOPREL GATT GBACT GCC GCRSNC GLACSEC GOIC HCPIL IACB IACO IACS IACW IADB IAEA IAFC IAI IAIGC IAMLO IAPhy IARA IARadiO IARuhr IATTC IBA IBE IBI IBPCT IBRD ICAC ICAO ICAP ICC ICCAT ICCEC ICCILMB ICCO ICCROM ICCSLT ICDO ICES ICFI IChemO ICMM ICMPD ICNWAF ICO ICPMS ICPR ICSEAF ICSG IDB IEA IES IFAD IFC IGAD IGC IGCC IHO IIA IICA IICom IIDEA IIFEO IIR IJO ILO ILZSG IMC IMF IMO IMSO INFOFISH INPFC INRO INSG INTELSAT INTERPOL IOATHRE IOC IOM IOOC IOPCF IOPH IORARC IOSC IPC IPentC IPI IRENA IRLCOCSA IRLCS IRO IRSG IRU ISA ISB ISESCO ISHREST ISO ISTC ISuC ITC ITCC ITPA ITTO ITU IVWO IWC IWSG JALAAO JINR JNOLCRH LACAC LAEO LAFDO LAFTA LAIA LAS LATIN LCBC LGA LoN MAOC MERCOSUR MOWCA MRU NACAP NAFO NAFTA NAMMCO NAPPO NASCO NATO NBA NC NCRR NEAFC NERC NIB NPFSC NPI NTSC OAPEC OAS OAU OCAM OCAS OCCAR OCEAC OECD OECS OEEC OEI OIC OIE OIF OIML OIV OMDKR OMVG OPANAL OPEC OSCE OSJD OSLO OSPAR OTIF PAHC PAHO PAIGH PC PCA PCB PIANC PICES PIF PMAESA PSNARCO PTASEA PUASP RCAELA RCC RIOPPAH SAAFA SAARC SADC SADCC SARTC SCAf SCHENGEN SCO SEAMO SEATO SELA SICA SIECA SPC SRDO SWAPU TCRMG TURKSOY UBE UDEAC UEMOA UIUCV UKDWD UMAC UMOA UN UNESCO UNIDO UNIDROIT UPU WAEC WAHC WAPCO WASSEN WCO WEU WHO WIPO WMO WNF WPact WTO WTOURO {
	foreach x of numlist 1816/2014 {
		merge m:1 country using "C:\Users\ahigham4\Downloads\`z'a.dta", nogenerate
		merge m:1 country_d using "C:\Users\ahigham4\Downloads\`z'b.dta", nogenerate

		if(`z'a==1 & `z'b==1) {
			gen `z'`x'=1
			drop `z'a
			drop `z'b
		}
		else {
			drop `z'a
			drop `z'b
		}
	}
}

//After completing this for all IOs, which I had to complete with FHSS compute,
//I had the dyad format, saved as masterdyads.dta

//Before I could collpse the data to find the proportion of shared IOs for each 
//dyad, I had to 
	//1) create a duplicate of the masterduyads.dta and switch country
	//country_d to have each dyad listed twice.
	//2) remove all nations
	//3) egen totalio = rowtotal(AAAID-WTO)
	
//removing countries that I don't want
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

//reshape it back to long format
reshape long
//creating total number of shared IOs in dyads
egen totalio = rowtotal(AAAID-WTO)
//save dataset

// create new data set to merge to the bottom 
rename country x
rename country_d country
rename x country_d
//save temp file

//append data set to temp file

//save as dyadtemp1
collapse (sum) totalio, by (country year)
rename totatio sumtotalio
//save as dyadtemp2
merge 1:m country year using "C:\Users\ahigham4\Downloads\DOT_07-23-2018 20-11-26-64_timeSeries\dyadtemp1.dta"
gen ioweight = totalio/sumtotalio


//applying weights
merge m:m country_d year ccode using ""C:\Users\ahigham4\Downloads\EPIYale.dta"
**Before I imported the EPIYale data set, I made sure to rename country country_d in the data set
foreach x in EPInbiomes EPIgbiomes EPInspecies EPIgspecies EPImpa {
	gen `x'io = ioweight*`x'
}





