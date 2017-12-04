################################################################################
## sensoric test: interactive calculation
## can you taste the difference between drink A and drink B?
## one of n glasses contains a different drink
## try to identify the one that ist differnet
## H0: no difference in taste, H1: difference in taste
################################################################################

# use shiny package
library(shiny)

# define ui
ui <- fluidPage(
    titlePanel("Sensoric Test (find the one that is different)"),
    sidebarLayout(
      sidebarPanel(
        textInput(inputId = "drink", 
                  label = " Drink",
                  value = "Beer"),
        sliderInput(inputId = "glasses", 
                  label = "Glasses", 
                  value = 3, min = 3, max = 10),
        numericInput(inputId = "trials", label = "Repeats", 
                     value = 3, min = 1, max = 100),
        radioButtons(inputId = "alpha", label = "Alpha (p same result by guessing)", 
                     choices = c("1%" = "0.01", "5%" = "0.05", "10%" = "0.10"),
                     selected = "0.05") ,
        checkboxInput(inputId = "values", label="Show Values", value=TRUE)
      ),
      mainPanel(
        plotOutput("graph")
      ) 
    ) # sidebarLayout
) # fluidPage

# server: calculate statistics and generate plot
server <- function(input, output) {
  output$graph <- renderPlot({
    
    # setup
    trials <- input$trials
    p_gotit = 1/input$glasses    

    # which result is statistically significant?
    max_p <- as.numeric(input$alpha)
    success_no <- qbinom(1-max_p, size = trials, prob = p_gotit)
    success_no
    p_success_no <- pbinom(success_no, size = trials, prob = p_gotit)
    p_success_yes <- 1 - p_success_no
    
    # calculate x and y coordinates for plot
    x <- c(0:trials)
    y <- dbinom(x = x, size = trials, prob = p_gotit) * 100

    # define colors (green for significant results)
    color <- rep("grey",length(x))
    color[success_no+2:length(x)] <- "darkgreen"
    
    # plot bar
    p <- barplot(y, names.arg = x, 
                 ylim = c(0, max(y)*1.2),
                 main = paste0("Sensoric ", input$drink, " Test\n",
                              "Find the one ", input$drink, 
                              " that is different out of ", input$glasses, 
                              " (" , trials, " repeats)"),
                 xlab = paste("Times found the right", input$drink),
                 ylab = "Probability in %",
                 col = color,
                 border = FALSE)
    
    # plot text (percentage)
    if (input$values)  {
      text(p[,1],y, round(y,1), pos=3, cex=0.8)  
    }
    
    # x coordinate of success line in bar chart
    x_success_no <- p[,1][success_no+1]  # +1 because x starts with 0
    x_success_yes <- p[,1][success_no+2]
    x_success_plot <- mean(c(x_success_no, x_success_yes))
    
    # plot success line (border between "no success" and "success")
    if (success_no+1 < length(x))  {
        abline(v = x_success_plot, col = "darkgreen", lty="dotted", lwd=2)
        text(x_success_plot+(length(x)*0.02), max(y)*0.9, 
             paste0("Success if >=", success_no+1), 
             col="darkgreen", srt=90)
    } # if
  }) # renderPlot
} # server

# run shiny app
shinyApp(ui = ui, server = server)
