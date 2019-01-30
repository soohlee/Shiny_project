

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


clean_amount = function(col){
  tmp <- gsub(",","",col)
  tmp <- as.numeric(tmp)
  return (tmp)
}


##approval overview

th1b<-th1b%>%mutate(n_Approval=(Approval/max(Approval)))%>%
  mutate(ratio=ratio/100)

#map plot origine country
country <-read.csv("./data/country_h1b.csv",stringsAsFactors=FALSE,header=T)
country<-country %>% mutate(H1B=ifelse(H1B=="D",0,ifelse(H1B=="-",0,H1B)))%>%
  mutate(total=clean_amount(H1B))

#map plot state 
# top_state
top_state = h1b_2018 %>%
  select(JOB_TITLE,WORKSITE_STATE,CASE_STATUS,EMPLOYER_NAME,WAGE_RATE_OF_PAY_FROM) %>%
  filter(CASE_STATUS=="CERTIFIED")%>%
  group_by(WORKSITE_STATE)%>%
  summarise(total=n())%>%
  mutate(p_state= round(total/sum(total)*100,1))%>%
  arrange(desc(p_state))

#top_employer

top_emp = h1b_2018 %>%
  filter(CASE_STATUS=="CERTIFIED")%>%
  rename(Employer=EMPLOYER_NAME)%>%
  group_by(Employer)%>%
  summarise(total=n())%>%
  mutate(p_emp= round(total/sum(total)*100,1))%>%
  arrange(desc(p_emp))

top_emp
#range_wage
##wage rate for h1b 2018


#ave wage 
range_wage = h1b_2018 %>%
  select(JOB_TITLE,WORKSITE_STATE,CASE_STATUS,EMPLOYER_NAME,WAGE_RATE_OF_PAY_FROM) %>%
  filter(CASE_STATUS=="CERTIFIED")%>%
  mutate(wage= clean_amount(WAGE_RATE_OF_PAY_FROM))%>%
  group_by(wage= cut(wage,breaks=seq(0,200000,by= 25000),right=FALSE))%>%
  summarise(total=n())%>%
  mutate(p_wage= total/sum(total)*100)%>%
  arrange(as.numeric(wage))
mean(range_wage$total)
range_wage

#top_job

top_job = h1b_2018 %>%
  filter(CASE_STATUS=="CERTIFIED")%>%
  rename(Job = JOB_TITLE)%>%
  group_by(Job)%>%
  summarise(total=n())%>%
  mutate(p_job= round(total/sum(total)*100,1))%>%
  arrange(desc(p_job))

top_job



#soc

top_soc = h1b_2018 %>%
  filter(CASE_STATUS=="CERTIFIED")%>%
  rename(Soc = SOC_NAME)%>%
  group_by(Soc)%>%
  summarise(total=n())%>%
  mutate(p_soc= round(total/sum(total)*100,1))%>%
  arrange(desc(p_soc))

top_soc

# create variable with colnames as choice
#choice <- colnames(state_stat)[-1]
#choice

# create variable with colnames as choice
choice <- colnames(h1b_2018)
choice

