

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
                 options=list(projection="kavrayskiy-vii",width = "automatic",
                              height = "automatic"))
  })
  
  output$map <- renderGvis({
    gvisGeoChart(top_state, locationvar="State",colorvar="total",
                 options=list(region="US", 
                              displayMode="regions", 
                              resolution="provinces", displayMode="text", width = "automatic",
                              height = "automatic"))
   
  })
  
  
  #H1B

  ##2018
  #show statistics using infoBox
  
  output$topjobbox <- renderValueBox({
    if (input$category =="Job"){
      
      top_job = top_job%>%
        mutate(m=Job)
        }else {
          top_job = top_soc%>%
            mutate(m=SOC)
        }
    max_value=max(top_job$total)
    t_job= top_job$m[top_job$total == max_value]
    
    valueBox(max_value,t_job, icon = icon("briefcase"),color='purple')
})
  
  
  output$topempbox <- renderValueBox({
    
    max_value<-max(top_emp$p)
    t_emp<- top_emp$Employer[top_emp$p == max_value]
    
    valueBox(paste(max_value," %"),t_emp,  icon = icon("building"))
})
  
  output$avgwagebox <- renderValueBox({
    
    valueBox(paste("$",round(mean(range_wage$total))),"AVERAGE WAGE",
             icon = icon("dollar-sign"), color = "yellow")
})
  
 
  #plots 
  
  output$job<-renderGvis({
    
    if (input$category =="Job"){
      
      plot_job = top_job
      }else {
      plot_job = top_soc
            
        }
    
    gvisPieChart(plot_job, labelvar= input$category , numvar="p", 
                 options=list( height=300,is3D=T, title='Top Occupation',fontSize=12))
    })
  
  output$topemp<-renderGvis({
    
    gvisPieChart(top_emp,labelvar = "Employer",numvar = "p" , 
                 options=list(height=300,is3D=T,title='Top Employer',fontSize=12))
  })
  
  
  output$wage<-renderGvis({
    gvisBarChart(range_wage, xvar = "Wage", yvar = "total", options = list( height=300,title='Wage Range',legend='none'))
  })
  
  output$age<-renderGvis({
    gvisBarChart(age, xvar = "AGE", yvar = "total", options = list(height=300,title='Age Range',legend='none'))
  })
  
  
  ##2017
  #show statistics using infoBox
  output$topjobbox1 <- renderValueBox({
    if (input$category1 =="Job"){
      
      top_job1 = top_job1%>%
        mutate(m=Job)
    }else {
      top_job1 = top_soc1%>%
        mutate(m=SOC)
    }
    
    max_value=max(top_job1$total)
    t_job1= top_job1$m[top_job1$total == max_value]
    
    valueBox(max_value,t_job1, icon = icon("briefcase"),color='purple')
  })
  
  output$topempbox1 <- renderValueBox({
    
    max_value<-max(top_emp1$p)
    t_emp<- top_emp1$Employer[top_emp1$p == max_value]
    
    valueBox(paste(max_value," %"),t_emp,  icon = icon("building"))
  })
  output$avgwagebox1 <- renderValueBox({
    
    valueBox(paste("$",round(mean(range_wage1$total))),"AVERAGE WAGE",
             icon = icon("dollar-sign"), color = "yellow")
  })
  
  
  #plots 
  
  output$job1<-renderGvis({
    if (input$category1 =="Job"){
      
      plot_job1 = top_job1
    }else {
      plot_job1 = top_soc1
      
    }
    gvisPieChart(plot_job1, labelvar= input$category1 , numvar="p", 
                 options=list( height=300,is3D=T, title='Top Occupation',fontSize=12))
  })
  
  output$topemp1<-renderGvis({
    
    gvisPieChart(top_emp1,labelvar = "Employer",numvar = "p" , 
                 options=list( height=300,is3D=T,title='Top Employer',fontSize=12))
  })
  
  
  output$wage1<-renderGvis({
    gvisBarChart(range_wage1, xvar = "Wage", yvar = "total", options = list( height=300,title='Wage Range',legend='none'))
  })
  

  output$edu<-renderGvis({
    gvisBarChart(education, xvar = "Education", yvar = "X2017", options = list(height=300,title='Education',legend='none'))
  })
  
  
  ##2016
  
  #show statistics using infoBox
  output$topjobbox2 <- renderValueBox({
    if (input$category2 =="Job"){
      top_job2 = top_job2%>%
        mutate(m=Job)
    }else {
      top_job2 = top_soc2%>%
        mutate(m=SOC)
    }
    max_value=max(top_job2$total)
    t_job2= top_job2$m[top_job2$total == max_value]
    
    valueBox(max_value,t_job2, icon = icon("briefcase"),color='purple')
  })
  
  output$topempbox2 <- renderValueBox({
    
    max_value<-max(top_emp2$p)
    t_emp<- top_emp2$Employer[top_emp2$p == max_value]
    
    valueBox(paste(max_value," %"),t_emp,  icon = icon("building"))
  })
  output$avgwagebox2 <- renderValueBox({
    
    valueBox(paste("$",round(mean(range_wage2$total))),"AVERAGE WAGE",
             icon = icon("dollar-sign"), color = "yellow")
  })
  
  
  #plots 
  
  output$job2<-renderGvis({
    if (input$category2 =="Job"){
      
      plot_job2 = top_job2
    }else {
      plot_job2 = top_soc2
      
    }
    gvisPieChart(plot_job2, labelvar= input$category2 , numvar="p", 
                 options=list(height= 300,is3D=T, title='Top Occupation',fontSize=12))
  })
  
  output$topemp2<-renderGvis({
    
    gvisPieChart(top_emp2,labelvar = "Employer",numvar = "p" , 
                 options=list( height=300,is3D=T,title='Top Employer',fontSize=12))
  })
  
  
  output$wage2<-renderGvis({
    gvisBarChart(range_wage2, xvar = "Wage", yvar = "total", options = list( height=300,title='Wage Range',legend='none'))
  })
  
 
  output$edu1<-renderGvis({
    gvisBarChart(education, xvar = "Education", yvar = "X2016", options = list(height=300,title='Education',legend='none'))
  })
  
  
  
#show data using DataTable
 output$table <- DT::renderDataTable({
  datatable(h1b_2018) %>%
    formatStyle(colnames(h1b_2018), background="skyblue", fontWeight='bold')
  })
 })

