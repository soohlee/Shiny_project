

shinyServer(function(input, output){
  #trend tap
  
  output$h1btrend <- renderPlotly({
   g<- ggplot(th1b, aes(x=year))+ 
      geom_bar( aes( y=n_Approval),alpha=0.55,fill="blue", stat = "identity")
   g +geom_line(data=th1b, aes(y=ratio), size=1)+
     scale_color_discrete(name = "Rate", labels = "ratio")+
      labs(x="Year",y="Approval",title=" H1B Approval trends from 2007-2018")+ 
      theme_classic()
    
    
  })
  
  output$globe <- renderGvis({
    gvisGeoChart(country, locationvar="Country", 
                 colorvar="total",
                 options=list(projection="kavrayskiy-vii",width= 430))
  })
  
  output$map <- renderGvis({
    gvisGeoChart(top_state, locationvar="State",colorvar="total",
                 options=list(region="US", 
                              displayMode="regions", 
                              resolution="provinces", displayMode="text", width=430))
   
  })
  
  
  #H1B

  ##2018
  #show statistics using infoBox
  
  output$topjobbox <- renderValueBox({
    
    max_value<-max(top_job$total)
    t_job<- top_job$Job[top_job$total == max_value]
    
    valueBox(max_value,t_job, icon = icon("briefcase"),color='purple')
})
  
  
  output$topempbox <- renderValueBox({
    
    max_value<-max(top_emp$p_emp)
    t_emp<- top_emp$Employer[top_emp$p_emp == max_value]
    
    valueBox(paste(max_value," %"),t_emp,  icon = icon("building"))
})
  
  output$avgwagebox <- renderValueBox({
    
    valueBox(paste("$",round(mean(range_wage$total))),"AVERAGE WAGE",
             icon = icon("dollar-sign"), color = "yellow")
})
  
 
  #plots 
  
  output$job<-renderGvis({
    if (input$category =="Job"){

    top_job = fy18 %>%
      group_by(Job)%>%
      summarise(total=n())%>%
      mutate(p= round(total/sum(total)*100,1))%>%
      arrange(desc(p))%>%
      head(7,p)}else {
        top_job = fy18 %>%
          group_by(SOC)%>%
          summarise(total=n())%>%
          mutate(p= round(total/sum(total)*100,1))%>%
          arrange(desc(p))%>%
          head(7,p)
      }
    
    gvisPieChart(top_job, labelvar= input$category , numvar="p", 
                 options=list(height=250, width=400,is3D=T, title='Top Occupation'))
    })
  
  output$topemp<-renderGvis({
    
    gvisPieChart(top_emp,labelvar = "Employer",numvar = "p_emp" , 
                 options=list( height=300,is3D=T,title='Top Employer'))
  })
  
  
  output$wage<-renderGvis({
    gvisBarChart(range_wage, xvar = "Wage", yvar = "total", options = list( height=300,title='Wage Range'))
  })
  
  output$age<-renderGvis({
    gvisBarChart(age, xvar = "AGE", yvar = "total", options = list(height=300,title='Age Range'))
  })
  
  
  ##2017
  #show statistics using infoBox
  output$topjobbox1 <- renderValueBox({
    
    max_value<-max(top_job1$total)
    t_job<- top_job1$Job[top_job1$total == max_value]
    
    valueBox(max_value,t_job, icon = icon("briefcase"),color='purple')
  })
  
  output$topempbox1 <- renderValueBox({
    
    max_value<-max(top_emp1$p_emp)
    t_emp<- top_emp1$Employer[top_emp1$p_emp == max_value]
    
    valueBox(paste(max_value," %"),t_emp,  icon = icon("building"))
  })
  output$avgwagebox1 <- renderValueBox({
    
    valueBox(paste("$",round(mean(range_wage1$total))),"AVERAGE WAGE",
             icon = icon("dollar-sign"), color = "yellow")
  })
  
  
  #plots 
  
  output$job1<-renderGvis({
    if (input$category1 =="Job"){
      
      top_job1 = fy17 %>%
        group_by(Job)%>%
        summarise(total=n())%>%
        mutate(p= round(total/sum(total)*100,1))%>%
        arrange(desc(p))%>%
        head(7,p)}else {
          top_job1 = fy17 %>%
            group_by(SOC)%>%
            summarise(total=n())%>%
            mutate(p= round(total/sum(total)*100,1))%>%
            arrange(desc(p))%>%
            head(7,p)
        }
    
    gvisPieChart(top_job1, labelvar= input$category , numvar="p", 
                 options=list(height=250, width=400,is3D=T, title='Top Occupation'))
  })
  
  output$topemp1<-renderGvis({
    
    gvisPieChart(top_emp1,labelvar = "Employer",numvar = "p_emp" , 
                 options=list( height=300,is3D=T,title='Top Employer'))
  })
  
  
  output$wage1<-renderGvis({
    gvisBarChart(range_wage1, xvar = "Wage", yvar = "total", options = list( height=300,title='Wage Range'))
  })
  

  output$edu<-renderGvis({
    gvisBarChart(education, xvar = "Education", yvar = "X2017", options = list(height=300,title='Education'))
  })
  
  
  ##2016
  
  #show statistics using infoBox
  output$topjobbox2 <- renderValueBox({
    
    max_value<-max(top_job2$total)
    t_job<- top_job2$Job[top_job2$total == max_value]
    
    valueBox(max_value,t_job, icon = icon("briefcase"),color='purple')
  })
  
  output$topempbox2 <- renderValueBox({
    
    max_value<-max(top_emp2$p_emp)
    t_emp<- top_emp2$Employer[top_emp2$p_emp == max_value]
    
    valueBox(paste(max_value," %"),t_emp,  icon = icon("building"))
  })
  output$avgwagebox2 <- renderValueBox({
    
    valueBox(paste("$",round(mean(range_wage2$total))),"AVERAGE WAGE",
             icon = icon("dollar-sign"), color = "yellow")
  })
  
  
  #plots 
  
  output$job2<-renderGvis({
    if (input$category2 =="Job"){
      
      top_job2 = fy16 %>%
        group_by(Job)%>%
        summarise(total=n())%>%
        mutate(p= round(total/sum(total)*100,1))%>%
        arrange(desc(p))%>%
        head(7,p)}else {
          top_job2 = fy18 %>%
            group_by(SOC)%>%
            summarise(total=n())%>%
            mutate(p= round(total/sum(total)*100,1))%>%
            arrange(desc(p))%>%
            head(7,p)
        }
    
    gvisPieChart(top_job2, labelvar= input$category , numvar="p", 
                 options=list(height=250, width=400,is3D=T, title='Top Occupation'))
  })
  
  output$topemp2<-renderGvis({
    
    gvisPieChart(top_emp2,labelvar = "Employer",numvar = "p_emp" , 
                 options=list( height=300,is3D=T,title='Top Employer'))
  })
  
  
  output$wage2<-renderGvis({
    gvisBarChart(range_wage2, xvar = "Wage", yvar = "total", options = list( height=300,title='Wage Range'))
  })
  
 
  output$edu1<-renderGvis({
    gvisBarChart(education, xvar = "Education", yvar = "X2016", options = list(height=300,title='Education'))
  })
  
  
  
#show data using DataTable
 output$table <- DT::renderDataTable({
  datatable(h1b_2018) %>%
    formatStyle(colnames(h1b_2018), background="skyblue", fontWeight='bold')
  })
 })

