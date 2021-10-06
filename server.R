# https://shiny.rstudio.com/articles/persistent-data-storage.html#mongodb


# https://shinydata.wordpress.com/2015/02/02/a-few-things-i-learned-about-shiny-and-reactive-programming/
function(input, output,session) { 
  
  source("db_connection.R")
  print("data is coming")
  base_identifiants=data.table(loadAuth())
  print(base_identifiants)
  print("boom that's the data")
  
  click_ID=0
  
  
  output$match_ID=reactive(-1)
  showModal(modalDialog(
    title = "Connexion à l'outil",size="s",
    footer = actionButton("clickID","Connexion",icon=icon("sign-in-alt")),
    HTML("<p>Entrez vos identifiants de connexion</p>"),
    tags$div(id="user_pwd",textInput(inputId = "identifiant","Indentifiant de connexion",placeholder = "Nom d'utilisateur"),
    passwordInput(inputId = "password","Mot de passe",placeholder = "clef sur 12 caractères"))
  ))
  
  observeEvent(c(input$clickID),{
    print(input$clickID)
    
    if(input$clickID==click_ID+1){
      removeModal()
      withProgress(message = 'Validation des identifiants',
                   detail = 'Dure 2 secondes', value = 0, {
                     for (i in 1:20) {
                       incProgress(1/20)
                       Sys.sleep(0.1)
                     }
                     
                  nb_auth_matches=nrow(base_identifiants[user==input$identifiant&password==input$password])
                  output$match_ID=reactive(nb_auth_matches)
                  if(nb_auth_matches>0){
                    saved_form=loadForm(input$identifiant)
                    print(saved_form)
                  }

                   })
    print("match ou pas ?")
    click_ID=input$clickID
    
    }
  })
  observeEvent(input$openAuth,{
    showModal(modalDialog(
      title = "Nouvelle tentative de connexion",size="s",
      footer = actionButton("clickID","Connexion",icon=icon("sign-in-alt")),
      HTML("<p>Entrez de nouveau vos identifiants de connexion</p>"),
      tags$div(id="user_pwd",textInput(inputId = "identifiant","Indentifiant de connexion",placeholder = "Nom d'utilisateur"),
               textInput(inputId = "password","Mot de passe",placeholder = "clef sur 12 caractères"))
    ))
  })
  outputOptions(x = output, name = "match_ID", suspendWhenHidden=FALSE)
  
  
  observeEvent(input$save_form,{
    # print("available inputs")
    # print(input)
    
    AllInputs <- reactive({
      x <- reactiveValuesToList(input)
      x <- x[names(x)]# on ne conserve que les inputs nommés
      x[["password"]]=NULL #on évite de stocker le password à chaque fois
      x[["identifiant"]]=NULL #on va l'enregistrer sous le nom de "user"
      
      print(names(x))
      x

    })
    output$show_inputs <- renderUI({
      AllInputs()
    })
    showModal(modalDialog(easyClose = T,uiOutput("show_inputs")

    ))
    
    current_form=c(list("date"=as.character(Sys.time()),
                      "user"=input$identifiant),
                   AllInputs()
                      )
    print("current form to save")
    print(current_form)
    saveData(current_form)
  })
}



