

shinyServer(function(input, output){
  #trend tap
  output$globe <- renderGvis({
    gvisGeoChart(country, locationvar="Country", 
                 colorvar="total",
                 options=list(projection="kavrayskiy-vii",width= 430))
    
  })
  
  output$map <- renderGvis({
    gvisGeoChart(top_state, locationvar="WORKSITE_STATE",colorvar="total",
                 options=list(region="US", 
                              displayMode="regions", 
                              resolution="provinces", displayMode="text",width=430))
   
  })
  
  
  #H1B

  
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
    valueBox(paste("$",round(mean(range_wage$total))),"Avg Wage",
            icon = icon("dollar-sign"), color = "yellow")})
  
 
  #plots 
  
  output$job<-renderGvis({
    gvisPieChart(g(), options=list(width=200, height=300,title='Top occupation'))
  })
  
  output$topemp<-renderGvis({
    
    gvisPieChart(g(), options=list(width=200, height=300,title='Top occupation'))
  })

  
  
  output$h1btrend <- renderPlotly({
    ggplot(th1b, aes(x=year))+ 
      geom_bar( aes( y=n_Approval),alpha=0.75, stat = "identity")+ geom_line(data=th1b, aes(y=ratio), colour = "green", size=1.5)+
      labs(x="Year",y="Approval",title=" H1B Approval trends from 2007-2018")+  theme_bw()
    
 
    
  })

  
  # show data using DataTable
# output$table <- DT::renderDataTable({
#   datatable(h1b_2018) %>%
#     formatStyle(colnames(h1b_2018), background="skyblue", fontWeight='bold')
#   })
 })

