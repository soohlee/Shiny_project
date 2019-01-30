shinyUI(dashboardPage(skin="green",
                      dashboardHeader(title = "Working in the US",titleWidth = 300),
                                  dashboardSidebar(width=300,
                                                   sidebarMenu(
                                                     menuItem("Immigrant Profiles", tabName = "trend", icon = icon("address-card")),
                                                     menuItem("H1B", tabName = "h1b", icon = icon("check")),
                                                     menuItem("Green Card", tabName = "greencard", icon = icon("check")),
                                                  #selectizeInput("selected","Select Item",choice)),
                                                     menuItem("Data", tabName = "data", icon = icon("database"))
                                                  )),
                      
                      dashboardBody(tags$head( tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
                                  ),
                        tabItems(
                          tabItem(tabName = "trend",
                                  
                                  fluidRow(box(plotlyOutput("h1btrend",width = "100%",height=250),width="90%"),
                                           box(htmlOutput("globe")),
                                           box(htmlOutput("map"))
                                           
                          )),
                          tabItem(tabName = "h1b",
                                  fluidRow( 
                                           valueBoxOutput("topjobbox"),
                                           valueBoxOutput("topempbox"),
                                           valueBoxOutput("avgwagebox")),
                                  fluidRow(box(radioButtons("Year", "Year",
                                                            c("2016" = "2016",
                                                              "2017" = "2017",
                                                              "2018" = "2018")),
                                                selectInput("PieChart", "Input Test",
                                                            choices = c("Job","Employer","Wage","Soc"),selected="Job"),
                                               width=4),
                                                    box(htmlOutput("job"), height = 300))
                                                    
                                  ))
                
                          #         )),
                          # tabItem(tabName = "data",
                          #             fluidRow(box(DT::dataTableOutput("table"), width = 12)))
                          )) 
)