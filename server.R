library(showtext);
library(ggplot2);
library(plyr);
library(Cairo);

load('gdat.RData')

shinyServer(function(input, output) {
  font.add("wmpeople1", "wmpeople1.TTF")
  font.add("wqy-zenhei", "wqy-zenhei.ttc")
  
  plotInput <- reactive({
    p<-ggplot(gdat, aes(x = x, y = educode)) +
      geom_text(aes(label = char, colour = gender),
                family = "wmpeople1", size = 8, alpha = 0.2, position='jitter') +
      geom_text(aes(label = char, colour = gender),
                family = "wqy-zenhei", size = 8, alpha = 0.2, position='jitter') +
      geom_text(aes(label = char, colour = gender),
                family = "SimHei", size = 8, alpha = 0.2, position='jitter') +
      scale_x_continuous("人数（千万）") +
      scale_y_discrete("受教育程度",
                       labels = unique(dat$edu[order(dat$educode)])) +
      scale_colour_hue(guide = FALSE) +
      ggtitle("2012年人口统计数据") +
      theme(title=element_text(family = 'SimHei')
            #axis.text=element_text(family = 'wqy-zenhei')
            )
    pdf('plot.pdf')
    showtext.begin()
    print(p)
    showtext.end()
    dev.off()
    p
  })
  
  output$plot<-renderPlot({
    plotInput()
  })
  
  output$pdflink<-downloadHandler(
    filename='myplot.pdf',
    content=function(file){
      file.copy('plot.pdf', file)
    }
    )
})
