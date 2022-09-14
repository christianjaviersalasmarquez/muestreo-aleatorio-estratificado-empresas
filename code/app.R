if(!require(shiny)) install.packages("shiny", repos = "http://cran.us.r-project.org")
if(!require(shinydashboard)) install.packages("shinydashboard", repos = "http://cran.us.r-project.org")
if(!require(shinydashboardPlus)) install.packages("shinydashboardPlus", repos = "http://cran.us.r-project.org")
if(!require(highcharter)) install.packages("highcharter", repos = "http://cran.us.r-project.org")
if(!require(haven)) install.packages("haven", repos = "http://cran.us.r-project.org")
if(!require(e1071)) install.packages("e1071", repos = "http://cran.us.r-project.org")
if(!require(modeest)) install.packages("modeest", repos = "http://cran.us.r-project.org")
if(!require(bs4Dash)) install.packages("bs4Dash", repos = "http://cran.us.r-project.org")
if(!require(plotrix)) install.packages("plotrix", repos = "http://cran.us.r-project.org")
if(!require(DT)) install.packages("DT", repos = "http://cran.us.r-project.org")


##### Texto

titulo_principal <- h1(style="font-family:Open Sans","Muestreo Aleatorio Estratificado")

introduccion <- p(style="text-align: justify; font-family:Open Sans","Analisis exploratorio, descriptivo y multivariante a las variables de la muestra obtenida")

titulo_informacion <- h2(style="font-family:Open Sans","Informacion del proyecto")


titulo_integrantes <- h2(style="font-family:Open Sans","Autor del dashboard")

titulo_objetivo_general <- h2(style="font-family:Open Sans","Objetivo General")



titulo_objetivos_especificos <- h2(style="font-family:Open Sans","Objetivos Especificos")

titulo_info_dataset <- h2(style="font-family:Open Sans","Informacion del Conjunto de Datos")




texto_info_ts <- p(style="font-family:Open Sans","Estimacion de la media del IR Causado 2021: 137739.1 USD")

##### Header, Sidebar, Body


header <- dashboardHeader(title="Muestreo")


sidebar <- dashboardSidebar(status = "primary",
                            sidebarMenu(
                              menuItem("Informacion", tabName = "subitem_intro"),
                              menuItem(text = "Muestra MAE", tabName = "menuitem_ds",

                                       menuSubItem(text = "Muestra Seleccionada",tabName = "data1")),
                              menuItem("Estadistica Descriptiva", tabName = "menuitemed",
                                       menuSubItem("Analisis", tabName = "subitem_hist")),
                              menuItem("Estadistica Multivariante", tabName = "menuitem_EM",
                                       menuSubItem("ACM Empresas", tabName = "subitem_mca"),
                                       menuSubItem("PCA Supercias", tabName = "subitem_pca")),
                              menuItem("Serie de Tiempo", tabName = "item_ts")))


body <- dashboardBody(
  tabItems(
    tabItem(tabName = "subitem_intro",
            fluidPage(titulo_principal,
                      introduccion
            ),
            fluidRow(
              bs4Jumbotron(title="ESPOL",
                           lead = "Facultad de Ciencias Naturales y Matematicas",
                           status = "primary",
                           btnName = ""
              ),
              fluidPage(titulo_integrantes
              ),
              userBox(status= "primary",
                      width=12,
                      gradient = TRUE,
                      background = "white",
                      boxToolSize = "xl",
                      "Estudiante de Ingenieria Estadistica - FCNM",
                      footer = "cjsalas@espol.edu.ec",
                      collapsible = FALSE,
                      title = userDescription(
                        title = "Christian Javier Salas Marquez",
                        backgroundImage = "C:/Users/Computer/Documents/Ingenieria Estadistica II PAO 2021/Estadistica Bayesiana/Proyecto Estadistica Bayesiana/Dashboard_Shiny_EstadisticaBayesiana/SalasMarquezChristianJavier.jpg",
                        type = 2,
                        image = "http://localhost/imagenesdashboardshiny/SalasMarquezChristianJavier.jpg"
                      ))
              
            )),
    tabItem(tabName = "data1" , fluidRow(column(DT::dataTableOutput("datos_MAE"),width = 12))),
    
    tabItem(tabName = "subitem_mca", 
            fluidRow( column(width = 12, box(title = strong("ACM Perfil de las Empresas"), highchartOutput("hc_acm_supercias") ,width = 8)))),
    tabItem(tabName = "subitem_pca", 
            fluidRow( 
                      column(width = 6,box(title = "Scree Plot", highchartOutput("hc_muestreo_5"),width = 12)),
                      column(width = 12, box(title = strong("PCA Biplot de Individuos y Variables"), highchartOutput("hc_muestreo_PCA") ,width = 7)))),

    tabItem(tabName = "subitem_hist",
            fluidRow(  column(width = 8,box(title = "Tipos de Compania", highchartOutput("hc_muestreo_piechart"),width = 12))),
              fluidRow(column(width = 4,box(title = "Estimacion de la media poblacional 1000 muestras", highchartOutput("hc_muestreo_1"),width = 12)), 
                      column(width = 4,box(title = "Estimacion de la media poblacional 1000 muestras", highchartOutput("hc_muestreo_2"),width = 12))),
            column(width = 6,box(title = "Impuesto a la Renta Causado 2021", highchartOutput("hc_muestreo_4"),width = 12))
            ),
    tabItem(tabName = "item_ts",
            column(width = 6,box(title = "Evolucion de la media del Impuesto a la Renta Causado", highchartOutput("hc_timeseries2"),width = 12)),
            column(width = 6,box(title = "Informacion", texto_info_ts,width = 12)))))


ui <- dashboardPage(title= "Dashboard", skin= "black",
                    
                    header = header,
                    sidebar = sidebar,
                    body = body)





# Server
server <- function(input, output) {
  output$datos_MAE <- renderDataTable(datos_MAE)
  output$bi1_plot <- renderUI({
    tags$img(src = "http://localhost/imagenesdashboardshiny/imagen1")
  })
  output$bi2_plot <- renderUI({
    tags$img(src = "http://localhost/imagenesdashboardshiny/imagen2")
  })
  output$hc_muestreo_1 <- renderHighchart(hc_muestreo_1)
  output$hc_muestreo_2 <- renderHighchart(hc_muestreo_2)
  output$hc_muestreo_3 <- renderHighchart(hc_muestreo_3)
  output$hc_muestreo_4 <- renderHighchart(hc_muestreo_4)
  output$hc_muestreo_5 <- renderHighchart(hc_muestreo_5)
  output$hc_acm_supercias <- renderHighchart(hc_acm_supercias)
  output$hc_muestreo_PCA <- renderHighchart(hc_muestreo_PCA)
  output$hc_muestreo_piechart <- renderHighchart(hc_muestreo_piechart)
  output$hc_timeseries2 <- renderHighchart(hc_timeseries2)
}

# Run the application 
shinyApp(ui = ui, server = server)
