

library(DT)
library(shiny)
library(googleVis)
library(ggplot2)
library(dplyr)
library(shinydashboard)
library(plotly)




###load data###
#h1b

th1b<-read.csv("./data/tr_h1b.csv",stringsAsFactors=FALSE, encoding = "UTF-8",header = T)
h1b_2018<-read.csv("./data/H-1BFY2018.csv",stringsAsFactors=FALSE, encoding = "UTF-8",header = T)
h1b_2017<-read.csv("./data/H-1BFY2017.csv",stringsAsFactors=FALSE, encoding = "UTF-8",header = T)
h1b_2016<-read.csv("./data/H-1BFY2016.csv",stringsAsFactors=FALSE, encoding = "UTF-8",header = T)
age<-read.csv("./data/age.csv",stringsAsFactors=FALSE, encoding = "UTF-8",header = T)
education<-read.csv("./data/education.csv",stringsAsFactors=FALSE, encoding = "UTF-8",header = T)

nrow(h1b_2018)

clean_amount = function(col){
  tmp <- gsub(",","",col)
  tmp <- as.numeric(tmp)
  return (tmp)
}


##approval overview

th1b<-th1b%>%mutate(n_Approval=(Approval/max(Approval)))%>%
  mutate(ratio=round(ratio)/100)

#map plot origine country
country <-read.csv("./data/country_h1b.csv",stringsAsFactors=FALSE,header=T)
country<-country %>% mutate(H1B=ifelse(H1B=="D",0,ifelse(H1B=="-",0,H1B)))%>%
  mutate(total=clean_amount(H1B))



#map plot state 


# top_state
top_state = fy18 %>%
  group_by(State)%>%
  summarise(total=n())%>%
  mutate(p_state= round(total/sum(total)*100,1))%>%
  arrange(desc(p_state))

#by category

fy18<-h1b_2018 %>%
  select(JOB_TITLE,WORKSITE_STATE,CASE_STATUS,EMPLOYER_NAME,WAGE_RATE_OF_PAY_FROM,SOC_NAME) %>%
  filter(CASE_STATUS=="CERTIFIED")%>%
  rename(Employer=EMPLOYER_NAME)%>%
  rename(Job = JOB_TITLE)%>%
  mutate(Wage= clean_amount(WAGE_RATE_OF_PAY_FROM))%>%
  rename(State=WORKSITE_STATE)%>%
  rename(SOC=SOC_NAME)
colnames(fy18)


fy17<-h1b_2017 %>%
  select(JOB_TITLE,WORKSITE_STATE,CASE_STATUS,EMPLOYER_NAME,WAGE_RATE_OF_PAY_FROM,SOC_NAME,VISA_CLASS) %>%
  filter(CASE_STATUS=="CERTIFIED" & VISA_CLASS=="H-1B")%>%
  rename(Employer=EMPLOYER_NAME)%>%
  rename(Job = JOB_TITLE)%>%
  mutate(Wage= clean_amount(WAGE_RATE_OF_PAY_FROM))%>%
  rename(State=WORKSITE_STATE)%>%
  rename(SOC=SOC_NAME)

fy16<-h1b_2016 %>%
  select(JOB_TITLE,WORKSITE_STATE,CASE_STATUS,EMPLOYER_NAME,WAGE_RATE_OF_PAY_FROM,SOC_NAME,VISA_CLASS) %>%
  filter(CASE_STATUS=="CERTIFIED" & VISA_CLASS=="H-1B")%>%
  rename(Employer=EMPLOYER_NAME)%>%
  rename(Job = JOB_TITLE)%>%
  mutate(Wage= clean_amount(WAGE_RATE_OF_PAY_FROM))%>%
  rename(State=WORKSITE_STATE)%>%
  rename(SOC=SOC_NAME)

#top_employer
top_emp = fy18 %>%
  group_by(Employer)%>%
  summarise(total=n())%>%
  mutate(p_emp= round(total/sum(total)*100,1))%>%
  arrange(desc(p_emp))%>%
  head(7)

top_emp1 = fy17 %>%
  group_by(Employer)%>%
  summarise(total=n())%>%
  mutate(p_emp= round(total/sum(total)*100,1))%>%
  arrange(desc(p_emp))%>%
  head(7)

top_emp2 = fy16 %>%
  group_by(Employer)%>%
  summarise(total=n())%>%
  mutate(p_emp= round(total/sum(total)*100,1))%>%
  arrange(desc(p_emp))%>%
  head(7)

top_emp1
#range_wage
##wage rate for h1b 2018

#ave wage 
options("scipen"=100, "digits"=4)
range_wage = fy18 %>%
  group_by(Wage= cut(Wage,breaks=c(0, 25000, 50000, 75000, 100000,125000,150000,200000,10000000),dig.lab=10,right=FALSE))%>%
  summarise(total=n())%>%
  arrange(as.integer(Wage))

range_wage

#top_job

top_job = fy18 %>%
  group_by(Job)%>%
  summarise(total=n())%>%
  mutate(p_job= round(total/sum(total)*100,1))%>%
  arrange(desc(p_job))%>%
  head(10,p_job)

top_job



#soc

top_soc = fy18 %>%
  group_by(SOC)%>%
  summarise(total=n())%>%
  mutate(p_soc= round(total/sum(total)*100,1))%>%
  arrange(desc(p_soc))%>%
  head(10)

top_soc

#age

age <- age %>%
  mutate(total= clean_amount(total))


#2017
#ave wage 

range_wage1 = fy17 %>%
  group_by(Wage= cut(Wage,breaks=c(0, 25000, 50000, 75000, 100000,125000,150000,200000,10000000),dig.lab=10,right=FALSE))%>%
  summarise(total=n())%>%
  arrange(as.integer(Wage))

range_wage1

#top_job

top_job1 = fy17 %>%
  group_by(Job)%>%
  summarise(total=n())%>%
  mutate(p_job= round(total/sum(total)*100,1))%>%
  arrange(desc(p_job))%>%
  head(10,p_job)

top_job1



#soc

top_soc1 = fy17 %>%
  group_by(SOC)%>%
  summarise(total=n())%>%
  mutate(p_soc= round(total/sum(total)*100,1))%>%
  arrange(desc(p_soc))%>%
  head(10)

top_soc1

#education
education <- education %>%
  mutate(X2017= clean_amount(X2017))%>%
  mutate(X2016= clean_amount(X2016))

#2016
#ave wage 
options("scipen"=100, "digits"=4)
range_wage2 = fy16 %>%
  group_by(Wage= cut(Wage,breaks=c(0, 25000, 50000, 75000, 100000,125000,150000,200000,10000000),dig.lab=10,right=FALSE))%>%
  summarise(total=n())%>%
  arrange(as.integer(Wage))

range_wage2

#top_job

top_job2 = fy16 %>%
  group_by(Job)%>%
  summarise(total=n())%>%
  mutate(p_job= round(total/sum(total)*100,1))%>%
  arrange(desc(p_job))%>%
  head(10,p_job)

top_job2



#soc

top_soc2 = fy16 %>%
  group_by(SOC)%>%
  summarise(total=n())%>%
  mutate(p_soc= round(total/sum(total)*100,1))%>%
  arrange(desc(p_soc))%>%
  head(10)

top_soc2

# create variable with colnames as choice
choice <- colnames(fy18)
choice

