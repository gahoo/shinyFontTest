library(shiny)

shinyUI(fluidPage(
  plotOutput('plot'),
  downloadLink('pdflink')
  ))