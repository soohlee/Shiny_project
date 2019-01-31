shinyUI(dashboardPage(skin="green",
                      dashboardHeader(title = "Working in the US",titleWidth = 300),
                                  dashboardSidebar(width=300,
                                                   sidebarMenu(
                                                     menuItem("Trend", tabName = "trend", icon = icon("address-card")),
                                                     menuItem("H1B", tabName = "h1b", icon = icon("check"),
                                                              menuSubItem("2018", tabName = "2018"),
                                                              menuSubItem("2017", tabName = "2017"),
                                                              menuSubItem("2016", tabName = "2016")
                                                     ),
                                                     #menuItem("Green Card", tabName = "greencard", icon = icon("check")),
                                                     menuItem("Data", tabName = "data", icon = icon("database"))
                                                  )),
                      
                      dashboardBody(tags$head( tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
                                               tags$style(HTML('

          .skin-green .sidebar-menu > li.active > a,
          .skin-green .sidebar-menu > li:hover > a {
            border-left-color: #008d4c;
          }
          .skin-green .main-sidebar .sidebar .sidebar-menu .active a{
          background-color:	 #ffffff;
          color: #000000;font-size: 17px;
          }    
                          '))),
                        tabItems(
                          tabItem(tabName = "trend",
                                  
                                  fluidRow(box(plotlyOutput("h1btrend",width = "100%",height=300),width="90%")),
                                  fluidRow(box(title="Approval trend by country of origin", htmlOutput("globe",width="100%"),width=6),
                                           box(title= "Approval trend by state",htmlOutput("map",width="100%"),width=6)
                                           
                          )),
                          tabItem(tabName = "h1b"),
                          tabItem(tabName = "2018",
                                  fluidRow( 
                                           valueBoxOutput("topjobbox"),
                                           valueBoxOutput("topempbox"),
                                           valueBoxOutput("avgwagebox")),
                                  fluidRow(box(selectInput("category","By Category",choices=c("Job","SOC"),selected="Job"),
                                               htmlOutput("job"),width=12)),
                                 fluidRow(box(htmlOutput("topemp"),width=12)),
                                 fluidRow(box(htmlOutput("wage"), width=6),
                                           box(htmlOutput("age"), width=6))
                                                    
                                  ),
                          tabItem(tabName = "2017",
                                  fluidRow( 
                                    valueBoxOutput("topjobbox1"),
                                    valueBoxOutput("topempbox1"),
                                    valueBoxOutput("avgwagebox1")),
                                  fluidRow(box(selectInput("category1","By Category",choices=c("Job","SOC"),selected="Job"),
                                               htmlOutput("job1"),width=12)),
                                  fluidRow(box(htmlOutput("topemp1"),width=12)),
                                  fluidRow(box(htmlOutput("wage1"), width=6),
                                           box(htmlOutput("edu"), width=6))
                                           
                                  
                          ),
                          tabItem(tabName = "2016",
                                  fluidRow( 
                                    valueBoxOutput("topjobbox2"),
                                    valueBoxOutput("topempbox2"),
                                    valueBoxOutput("avgwagebox2")),
                                  fluidRow(box(selectInput("category2","By Category",choices=c("Job","SOC"),selected="Job"),
                                               htmlOutput("job2"),width=12)),
                                  fluidRow(box(htmlOutput("topemp2"),width=12)),
                                  fluidRow(box(htmlOutput("wage2"), width=6),
                                           box(htmlOutput("edu1"), width=6))
                                           
                                  
                          ),
                          #tabItem(tabName = "greencard",
                                 # fluidRow(box(title="in prep..."))
                          #),
                
                        
                          tabItem(tabName = "data",
                                      fluidRow(box(title= " Data from USCIS and USDL", 
                                                   DT::dataTableOutput("table"))))
                          )) 
))