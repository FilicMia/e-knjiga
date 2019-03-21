library(shiny)
df <- readLines("sifra1.txt")
dat = df[1]

ui <- fluidPage(
  tags$head(tags$script(src = "message-handler.js")),
  textInput("plaintext", "Write plaintext to dechiper:", value = dat),
  actionButton("do", "Start dechipering"),
  textOutput("btn_val"),
  p(id = "chipertext", "")
)

server <- function(input, output, session) {
  observeEvent(input$do, {
    if (input$do[1] == 1) {
      session$sendCustomMessage(type = 'setdecypher',
                                message = "Hello")
    } 
  
  })
}

shinyApp(ui, server)