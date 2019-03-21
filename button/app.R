library(shiny)

# Two scalar arguments to specify rows and columns
#https://github.com/johnmyleswhite/JuliaVsR/blob/master/cipher/cipher.R
english.letters <- c('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
                     'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
                     'w', 'x', 'y', 'z')

caesar.cipher <- list()

inverse.caesar.cipher <- list()

for (index in 1:length(english.letters))
{
  caesar.cipher[[english.letters[index]]] <- english.letters[index %% 26 + 3]
  inverse.caesar.cipher[[english.letters[index %% 26 + 3]]] <- english.letters[index]
}

print(caesar.cipher)
print(inverse.caesar.cipher)

############################ TODO general case.
setup.rot.cipher <- function(cipher, rot) {
  
  for (index in 1:length(english.letters))
  {
    cipher.list[[english.letters[index]]] <- english.letters[index %% 26 + rot]
    cipher.inverse.list[[english.letters[index %% 26 + rot]]] <- english.letters[index]
  }
}

##############################

apply.cipher.to.string <- function(string, cipher)
{
  output <- ''
  
  for (i in 1:nchar(string))
  {
    output <- paste(output, cipher[[substr(string, i, i)]], sep = '')
  }
  
  return(output)
}

ui <- fluidPage(
  tags$head(tags$script(src = "message-handler.js")),
  actionButton("do", "Toggle ceaser chiper - one more time"),
  textOutput("btn_val"),
  verbatimTextOutput("default")
)

server <- function(input, output, session) {
  observeEvent(input$do, {
    df <- readLines("sifra1.txt")
    dat = df[1]
    
    output$btn_val <- renderPrint(print(input$do[1]))
    msg <- 'Ceaser encrypt'
    
    s <- apply.cipher.to.string(dat,caesar.cipher);
    if (input$do %% 2 == 0) {
      s = apply.cipher.to.string(dat,caesar.cipher);
    } else {
      msg <- 'Ceaser decrypt'
      s = apply.cipher.to.string(s,inverse.caesar.cipher)
    }
    
    output$default <- renderText(s)
  })
}

shinyApp(ui, server)