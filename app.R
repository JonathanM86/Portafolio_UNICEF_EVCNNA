# Cargar librerías necesarias
library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

#install.packages("shiny")

# 1. Construcción del DataFrame (Basado en Tablas Anexas 4.1.1, 5.1.1, 6.1.1, 4.2.1, 5.2.1, 6.2.1 de la EVCNNA 2017)
datos_evcnna <- data.frame(
  indicador = c(rep("Violencia en la infancia (antes de los 18)", 6),
                rep("Violencia en los últimos 12 meses", 6)),
  grupo_edad = c(rep("18-24 años", 6), rep("13-17 años", 6)),
  tipo_violencia = rep(c("Física", "Física", "Sexual", "Sexual", "Emocional", "Emocional"), 2),
  sexo = rep(c("Mujeres", "Hombres"), 6),
  prevalencia = c(22.1, 18.7, 13.5, 2.5, 12.1, 4.0,   # Datos 18-24 años
                  11.8, 10.5, 6.6, 2.7, 8.1, 2.4),    # Datos 13-17 años
  ic_inf = c(17.9, 14.3, 9.5, 1.1, 9.2, 2.2,          # Límite inferior IC 95%
             8.4, 6.9, 3.4, 1.1, 5.2, 1.1),
  ic_sup = c(26.2, 23.1, 17.5, 4.0, 14.9, 5.7,        # Límite superior IC 95%
             15.1, 14.2, 9.7, 4.3, 11.0, 3.6)
)

# 2. Interfaz de Usuario (UI)
ui <- fluidPage(
  titlePanel("Explorador de Prevalencia - EVCNNA El Salvador 2017"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Filtros Analíticos"),
      selectInput("filtro_indicador", 
                  "Seleccione el indicador temporal:", 
                  choices = unique(datos_evcnna$indicador),
                  selected = "Violencia en la infancia (antes de los 18)"),
      
      checkboxGroupInput("filtro_violencia", 
                         "Seleccione tipo(s) de violencia:", 
                         choices = unique(datos_evcnna$tipo_violencia),
                         selected = unique(datos_evcnna$tipo_violencia)),
      
      hr(),
      helpText("Datos extraídos de los tabulados oficiales del reporte EVCNNA 2017. Los intervalos de confianza (95%) controlan el error de diseño complejo.")
    ),
    
    mainPanel(
      plotOutput("grafico_prevalencia"),
      br(),
      h4("Tabla de Microdatos Agregados"),
      DTOutput("tabla_datos")
    )
  )
)

# 3. Lógica del Servidor (Server)
server <- function(input, output) {
  
  # Filtrado reactivo de datos
  datos_filtrados <- reactive({
    datos_evcnna %>%
      filter(indicador == input$filtro_indicador,
             tipo_violencia %in% input$filtro_violencia)
  })
  
  # Generación del Gráfico con ggplot2
  output$grafico_prevalencia <- renderPlot({
    df <- datos_filtrados()
    
    # Prevenir errores si se desmarcan todos los filtros
    if(nrow(df) == 0) return(NULL)
    
    ggplot(df, aes(x = tipo_violencia, y = prevalencia, fill = sexo)) +
      geom_bar(stat = "identity", position = position_dodge(width = 0.8), width = 0.7) +
      geom_errorbar(aes(ymin = ic_inf, ymax = ic_sup), 
                    position = position_dodge(width = 0.8), width = 0.25, color = "#4F4F4D") +
      scale_fill_manual(values = c("Mujeres" = "#C46A2D", "Hombres" = "#6C8D3E")) +
      labs(title = paste("Prevalencia de", input$filtro_indicador),
           subtitle = "Con intervalos de confianza del 95%",
           x = "Tipo de Violencia",
           y = "Prevalencia (%)",
           fill = "Sexo") +
      theme_minimal() +
      theme(
        text = element_text(family = "sans"),
        plot.title = element_text(face = "bold", size = 16, color = "#1F1F1F"),
        axis.text = element_text(size = 12),
        legend.position = "top"
      )
  })
  
  # Generación de la tabla interactiva
  output$tabla_datos <- renderDT({
    datatable(datos_filtrados(),
              options = list(pageLength = 5, dom = 't'),
              rownames = FALSE,
              colnames = c("Indicador", "Grupo de Edad", "Tipo", "Sexo", "Prevalencia (%)", "Límite Inf.", "Límite Sup.")) %>%
      formatRound(columns = c('prevalencia', 'ic_inf', 'ic_sup'), digits = 1)
  })
}

# 4. Ejecución de la aplicación
shinyApp(ui = ui, server = server)
