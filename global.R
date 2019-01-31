



library(shiny)
library(shinydashboard)
library(googleVis)
library(ggplot2)
library(dplyr)
library(plotly)
library(DT)




###load data###
#h1b

th1b <-read.csv("./data/tr_h1b.csv",stringsAsFactors = FALSE,encoding = "UTF-8",header = T)
h1b_2018 <-read.csv( "./data/H-1BFY2018.csv",stringsAsFactors = FALSE,encoding = "UTF-8",header = T)
h1b_2017 <-read.csv( "./data/H-1BFY2017.csv",stringsAsFactors = FALSE,encoding = "UTF-8",header = T)
h1b_2016 <-read.csv( "./data/H-1BFY2016.csv",stringsAsFactors = FALSE,encoding = "UTF-8",header = T)
age <-read.csv("./data/age.csv",stringsAsFactors = FALSE,encoding = "UTF-8",header = T)
education <-read.csv("./data/education.csv",stringsAsFactors = FALSE,encoding = "UTF-8",header = T)

clean_amount = function(col) {
  tmp <- gsub(",", "", col)
  tmp <- as.numeric(tmp)
  return (tmp)
}


##approval overview

th1b <- th1b %>% mutate(n_Approval = (Approval / max(Approval))) %>%
  mutate(ratio = round(ratio) / 100)

#map plot origine country
country <-read.csv("./data/country_h1b.csv",stringsAsFactors = FALSE,header = T)
country <-country %>% mutate(H1B = ifelse(H1B == "D", 0, ifelse(H1B == "-", 0, H1B))) %>%
  mutate(total = clean_amount(H1B))



#map plot data cleaning

clean_cat <- function(df) {df %>%select(JOB_TITLE,WORKSITE_STATE,CASE_STATUS,EMPLOYER_NAME,WAGE_RATE_OF_PAY_FROM,SOC_NAME,VISA_CLASS) %>%
    filter(CASE_STATUS == "CERTIFIED") %>%
    rename(Employer = EMPLOYER_NAME) %>%
    rename(Job = JOB_TITLE) %>%
    mutate(Wage = clean_amount(WAGE_RATE_OF_PAY_FROM)) %>%
    rename(State = WORKSITE_STATE) %>%
    rename(SOC = SOC_NAME)
}


#by category

fy18 = clean_cat(h1b_2018)

fy17 <- clean_cat(h1b_2017)

fy16 <- clean_cat(h1b_2016)


# top_state

top_state = fy18 %>%
  group_by(State) %>%
  summarise(total = n()) %>%
  mutate(p_state = round(total / sum(total) * 100, 1)) %>%
  arrange(desc(p_state))

#top_cat cleaning

clean_top = function(df1,col_name){
  df1%>%
  group_by(get(col_name)) %>%
  summarise(total = n()) %>%
  mutate(p = round(total / sum(total) * 100, 1)) %>%
  arrange(desc(p)) %>%
  head(20)-> df1
  return(df1)
}

##top employer

top_emp <-clean_top(fy18,"Employer")
top_emp1 = clean_top(fy17,"Employer")
top_emp2 = clean_top(fy16,"Employer")
names(top_emp)[1]="Employer"
names(top_emp1)[1]="Employer"
names(top_emp2)[1]="Employer"
##top job
top_job=clean_top(fy18,"Job")
top_job1=clean_top(fy17,"Job")
top_job2=clean_top(fy16,"Job")
names(top_job)[1]="Job"
names(top_job1)[1]="Job"
names(top_job2)[1]="Job"
##top soc
top_soc=clean_top(fy18,"SOC")
top_soc1=clean_top(fy17,"SOC")
top_soc2=clean_top(fy16,"SOC")
names(top_soc)[1]="SOC"
names(top_soc1)[1]="SOC"
names(top_soc2)[1]="SOC"


#range_wage

clean_wage = function(df1){
  df1%>%
  group_by(Wage = cut(Wage, breaks = c(0, 25000, 50000, 75000, 100000, 125000, 150000, 200000, 10000000),
    labels= c("0-25K","25-50K","50-75K","75-100K","100K-125K","125K-150K","150K-200K","over 200K"),dig.lab = 10)) %>%
  summarise(total = n()) %>%
  arrange(as.integer(Wage))
  }

range_wage=clean_wage(fy18)
range_wage1=clean_wage(fy17)
range_wage2=clean_wage(fy16)

#age

age <- age %>%
  mutate(total = clean_amount(total))


#education
education <- education %>%
  mutate(X2017 = clean_amount(X2017)) %>%
  mutate(X2016 = clean_amount(X2016))

