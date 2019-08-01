#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(mailR)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Send Mail"),
  
  # Sidebar with a slider input for number of bins 
  
  wellPanel(
    textInput(inputId = "from",label = "From:",width = "300px"),
    textInput(inputId = "to",label = "To:",width = "300px"),
    textInput(inputId = "user",label = "User Name:",width = "300px"),
    passwordInput(inputId = "pass",label = "Password: ",width = "300px"),
    hr(),
    actionButton(inputId = "send",label = "Send Email"),
    br(),
    fileInput(inputId = "file",label = "Upload File",multiple = T,width = '400px',buttonLabel = "File Attachments")),
  wellPanel(title = "Email Body: ",
            textInput(inputId = "subject",label = "Subject:",width = "400px"),
            textAreaInput(inputId = "body",label = "Body:",width = "1600",height = "300")
  
            )

)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  observeEvent(input$send,{
    
    showModal(modalDialog(
      title = "Email Sent:",
      paste("Your email has been sent to the following recipients: ",input$to)
    ))
  
  send.mail(from = input$from,
            to = c(input$to),
            replyTo = c("Reply to someone else <someone.else@gmail.com>"),
            subject = input$subject,
            body = input$body,
            smtp = list(host.name = "smtp.gmail.com", port = 587, user.name = input$user, passwd = input$pass, ssl = TRUE),
            authenticate = TRUE
)})

}

# Run the application 
shinyApp(ui = ui, server = server)

