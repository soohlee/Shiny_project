shinyUI(dashboardPage(skin="green",
                      dashboardHeader(title = "Working in the US",titleWidth = 300),
                                  dashboardSidebar(width=300,
                                                   sidebarMenu(
                                                     menuItem("Immigrant Profiles", tabName = "trend", icon = icon("address-card")),
                                                     menuItem("H1B", tabName = "h1b", icon = icon("check")),
                                                     menuItem("Green Card", tabName = "greencard", icon = icon("check")),
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
                                  fluidRow(box(title="By country of origin", htmlOutput("globe",width="100%"),width=6),
                                           box(title= "By State",htmlOutput("map"),width=6)
                                           
                          )),
                          tabItem(tabName = "h1b",
                                  fluidRow( 
                                           valueBoxOutput("topjobbox"),
                                           valueBoxOutput("topempbox"),
                                           valueBoxOutput("avgwagebox")),
                                  fluidRow(box(selectInput("category","By Category",choices=c("Job","SOC"),selected="Job"),
                                               htmlOutput("job"), width=6),
                                           box(htmlOutput("topemp"), width=6)),
                                 fluidRow(box(htmlOutput("wage"), width=6),
                                           box(htmlOutput("age"), width=6))
                                                    
                                  ),
                          tabItem(tabName = "greencard",
                                  fluidRow(box(title="in prep..."))
                          ))
                
                          #         )),
                          # tabItem(tabName = "data",
                          #             fluidRow(box(DT::dataTableOutput("table"), width = 12)))
                          )) 
)