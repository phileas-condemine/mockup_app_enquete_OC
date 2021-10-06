library(mongolite)

# create file secrets.json
# {
#   "db_host":"XXXX",
#   "db_username":"XXXX",
#   "db_password":"XXXX"
# }


options(mongodb = jsonlite::read_json("secrets.json"))




saveData <- function(data) {
  # on suppose que data est une liste puisqu'on va sauvegarder un élément à la fois et que certains inputs contiennent plusieurs valeurs par exemple les checkboxgroups
  
  # Connect to the database
  db <- mongo(collection = "formulaire_oc",
              url = sprintf(
                "mongodb+srv://%s:%s@%s/%s",
                options()$mongodb$db_username,
                options()$mongodb$db_password,
                options()$mongodb$db_host,
                options()$mongodb$db_name))
  # Insert the data into the mongo collection as a data.frame
  db$insert(data)
}


loadAuth <- function() {
  # Connect to the database
  db <- mongo(collection = "auth_oc",
              url = sprintf(
                "mongodb+srv://%s:%s@%s/%s",
                options()$mongodb$db_username,
                options()$mongodb$db_password,
                options()$mongodb$db_host,
                options()$mongodb$db_name))
  # Read all the entries
  data <- db$find()
  data
}


loadForm <- function(ID) {
  # Connect to the database
  db <- mongo(collection = "formulaire_oc",
              url = sprintf(
                "mongodb+srv://%s:%s@%s/%s",
                options()$mongodb$db_username,
                options()$mongodb$db_password,
                options()$mongodb$db_host,
                options()$mongodb$db_name))
  # Read all the entries
  data <- db$find(query = sprintf('{"user" : "%s"}',ID))
  data
}


