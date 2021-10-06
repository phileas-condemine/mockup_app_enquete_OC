library(data.table)
library(shiny)
library(shinydashboard)
library(dplyr)
library(shinyWidgets)
library(jsonlite)
library(mongolite)


source("db_connection.R")
print("data is coming")
base_identifiants=data.table(loadAuth())
print(base_identifiants)
print("boom that's the data")

click_ID=0



# TO DO : 
# REPARER LA PAGE D'ACCUEIL MAUVAISE AUTHENTIFICATION
# RECUPERER TOUTES LES SAUVEGARDES ET LAISSER L'UTILISATEUR CHOISIR PAR DATE DE SAUVEGARDE
# RECUPERER LA DERNIERE SAUVEGARDE DU FORMULAIRE
# REMPLIR LES CHAMPS AVEC LA DERNIERE SAUVEGARDE
# REALISER UNE SAUVEGARDE AUTOMATIQUE
