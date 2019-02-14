//descriptive data

sum minority

sum female

tab ses //-3.758  to 2.692 with a potential outlier

tab mathach //ceiling on high achievement, also there are negative scores

histogram mathach // slightly left skewed

tab size

tab pracad // percentage

sum mathach if minority==0,d

sum ses if minority ==0, d

sum ses if minority ==1, d

** generating new cars**

gen catsize = 0 if size < 1000

replace catsize = 1 if size > 1000

replace catsize = 2 if size > 2000

//visualizations

hist ses

graph box ses

//analysis

reg mathach i.minority##c.ses female, r

reg mathach i.minority##c.ses c.ses##c.female sector c.size##i.minority, cluster(schoolid)

reg mathach i.minority##c.ses c.ses##c.female sector i.catsize, cluster(schoolid)

reg mathach i.minority##c.ses c.ses##c.female sector i.catsize, r

** does not make a difference. there does not seem to be a problem of multicollinearity between size and school districts

**exploring solutions to school size

reg mathach i.minority##c.ses c.ses##c.female sector i.catsize##i.minority, cluster(schoolid)

reg mathach i.female##i.minority i.minority##c.ses c.ses##i.female sector size, cluster(schoolid)

margins, at(size =(0(100)3000))

marginsplot

quietly margins i.female#i.minority

marginsplot

quietly margins if minority==0, at(ses =(-3.7(.1)2.7))

marginsplot

quietly margins if minority==1, at(ses =(-3.7(.1)2.7))

marginsplot

help coefplot

**the first option

coefplot, drop(_cons) xline(0)

ssc install outreg2

reg mathach i.minority##i.female female, cluster(schoolid)

outreg2 using "A1table.doc"

reg mathach i.female##i.minority i.minority##c.ses c.ses##i.female sector size, cluster(schoolid)

outreg2 using "A1table.doc"

reg mathach i.female##i.minority i.minority##c.ses c.ses##i.female sector size pracad, cluster(schoolid)

outreg2 using "A1table.doc"

reg mathach 0.female##1.minority i.minority##c.ses c.ses##i.female sector size
