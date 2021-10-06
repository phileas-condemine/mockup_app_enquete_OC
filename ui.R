dashboardPage(
  dashboardHeader(title = "Enquête OC",
                  tags$li(class = "dropdown", 
                          actionButton("save_form","Enregistrer le formulaire",icon=icon("save"))
                          )
                  ),
  dashboardSidebar(
    conditionalPanel(condition="output.match_ID==0",sidebarMenu(
      menuItem("Erreur",tabName = "auth_error")
    )),
    conditionalPanel(condition="output.match_ID>0",sidebarMenu(
      menuItem("Première partie du formulaire",
               menuSubItem("page 1",tabName = "part1_page1"),
               menuSubItem("page 2",tabName = "part1_page2")),
      menuItem("Seconde partie du formulaire",
               menuSubItem("page 1",tabName = "part2_page1"),
               menuSubItem("page 2",tabName = "part2_page2"),
               menuSubItem("page 3",tabName = "part2_page3")))
    )),
  dashboardBody(tabItems(
    tabItem("auth_error",
        conditionalPanel(condition="output.match_ID==0",
                         panel(icon("exclamation-triangle","fa-9x"),
                            h3("Echec d'authentification"),
                            actionButton("openAuth","Cliquez ici pour vous identifier")))),
    tabItem("part1_page1",
        conditionalPanel(condition="output.match_ID>0",panel(
          selectInput("categ_p1p1","Catégorie",c("A","B","C")),
          textInput("blabla_p1p1","texte",placeholder = "votre texte"),
          awesomeCheckbox("checkbox_p1p1","check the box"),
          awesomeCheckboxGroup("checkboxgroup_p1p1","check the boxes",choices=1:5,selected=c(2,4))
    ))),
    
    
    tabItem("part1_page2",
      conditionalPanel(condition="output.match_ID>0",panel(
                                                            selectInput("categ_p1p2","Catégorie",c("A","B","C")),
                                                            textInput("blabla_p1p2","texte",placeholder = "votre texte")
    ))),
    tabItem("part2_page1",
    conditionalPanel(condition="output.match_ID>0",panel(
                                                            selectInput("categ_p2p1","Catégorie",c("A","B","C")),
                                                            awesomeCheckbox("checkbox_p2p1","check the box")
    ))),
    
    tabItem("part2_page2",
      conditionalPanel(condition="output.match_ID>0",panel(
                                                            textInput("blabla_p2p2","texte",placeholder = "votre texte"),
                                                            awesomeCheckboxGroup("checkboxgroup_p2p2","check the boxes",choices=1:5,selected=c(2,4))
    ))),
    
    tabItem("part2_page3",
      conditionalPanel(condition="output.match_ID>0",panel(
                                                            selectInput("categ_p2p3","Catégorie",c("A","B","C")),
                                                            awesomeCheckboxGroup("checkboxgroup_p2p3","check the boxes",choices=1:5,selected=c(2,4))
    )))
    
    
    
  ))
)