#Read in birth data from .csv file
o_data <- read.csv("~/Documents/TEACHING/vitalstats/Yr1116Birth.csv", na.strings=c("99", "9999"))
# drop missing values (not always desired but makes things easy for now)
birth_data <- na.omit(o_data)

#load libraries
library(tidyverse)

#birth_data is a data frame that contains variables below as columns
names(birth_data)
glimpse(birth_data)

#add labels
birth_data$SEX=factor(birth_data$SEX, levels=c(1,2,9),labels=c("Male","Female","Unspecified"))
birth_data$MRACER=factor(birth_data$MRACER, levels=0:8, 
                         labels=c("Other","White","Black",
                                  "Ind. Amer",
                                  "Chinese","Japanese","Nat. HI",
                                  "Filipino","Other As"))
birth_data$MHISP=factor(birth_data$MHISP, levels=c("C","M","N","O","P","S","U"), 
                        labels=c("Cuban","Mexican","Non-Hispanic","Other Hispanic",
                                 "Puerto Rican","Central/South American","Unknown"))

# very basic data cleaning
birth_data$GEST_C=birth_data$GEST; birth_data$BWTG_C=birth_data$BWTG
birth_data$GEST_C[birth_data$GEST_C>50]=NA
birth_data$GEST_C[birth_data$GEST_C<20]=NA
birth_data$BWTG_C[birth_data$BWTG_C<500]=NA

# subset to durham and 2016
birth2016=subset(birth_data,birth_data$YOB=='2016')
#CORES code for Durham Co is 32
durhamb16=subset(birth2016,birth2016$CORES=='32')

#make a plot
ggplot(data = durhamb16, mapping = aes(x = GEST_C, y = BWTG_C)) +
  geom_point(alpha=1/10,color="blue") + xlab("Gestational age (weeks)") + ylab("Birth weight (g)") + 
  ggtitle("Durham Co, NC Births, 2011-2016")

# read in some Stata data (use the foreign library and read.dta for earlier versions of Stata)
# these data are from a study that did not draw a random population sample

install.packages("readstata13")
library(readstata13)
lbw=read.dta13("http://www.stata-press.com/data/r13/gsem_lbw.dta")

glimpse(lbw)

# look at the distribution of birth weight in these data using
# graphical techniques we have discussed so far

# variable definitions
# bwt (birth weight in g)
# age (maternal age)
# lwt (mother's pre-pregnancy weight)
# race (1=white, 2=black, 3=other)
# smoke (1=yes during pregnancy, 0=no)
# ptl (0=never had premature labor, 1=1 episode, etc.)
# ht (1=history of hypertension, 0=no history of hypertension)
# ui (presence of uterine irritability 1=yes 0=no)
# Ignore: low (just an indicator of bwt<2500), ftv (prenatal care intensity)
