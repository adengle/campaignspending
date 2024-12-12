# Course Project 2
# Campaign Data Shiny App
#
# Andrew Engle
# PDAT 624G - Dr. Wayne Johnson
# 08 Dec 2024


# Load required packages
library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)
library(bslib)
library(scales)
library(markdown)


# Load and clean data
fec <- read.csv("data/fec_data.csv") |>
  # Allocate transactions to candidate by FEC committee ID
  mutate(candidate_name = if_else(
    committee_id %in% c("C00703975", "C00694455"),
    "Harris",
    "Trump"
  )) |>
  mutate(disbursement_date = as.Date(disbursement_date)) |>
  mutate(
    candidate = as.factor(candidate_name),
    disb_date = as.Date(disbursement_date),
    amount = disbursement_amount,
    category = as.factor(disbursement_purpose_category)
  ) |>
  select(candidate, disb_date, amount, category) |>
  # Limiting transactions to those in 2024, dropping some erroneous entries
  filter(between(disb_date, ymd("2024-01-01"), ymd("2024-12-31")))


# Define UI
ui <- fluidPage(
  titlePanel("How the Candidates Spent Their Money in 2024"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        "candidates",
        "Select Candidates:",
        choices = unique(fec$candidate),
        selected = unique(fec$candidate)
      ),
      dateRangeInput(
        "dateRange",
        "Select Date Range:",
        start = min(fec$disb_date),
        end = max(fec$disb_date),
        min = min(fec$disb_date),
        max = max(fec$disb_date)
      ),
      checkboxGroupInput(
        "categories",
        "Select Spending Categories:",
        choices = sort(unique(fec$category)),
        selected = unique(fec$category)
      ),
      # Add radio button for vertical dashed line to show Biden withdrawal
      radioButtons(
        "showLine", 
        "Show Biden's Withdrawal:",
        choices = c("Yes", "No"),
        selected = "No" 
      )
    ),
    mainPanel(tabsetPanel(
      tabPanel("Visualization", plotOutput("stackedPlot", height = "600px")),
      tabPanel("Discussion", includeMarkdown("instructions.md"))
    ))
  ),
  theme = bs_theme(bootswatch = "pulse")
)

# Define server logic
server <- function(input, output) {
  filteredData <- reactive({
    fec |>
      # Respond to candidate checkbox selections
      filter(candidate %in% input$candidates) |>
      # Respond to timeframe selections
      filter(between(
        disb_date,
        as.Date(input$dateRange[1]),
        as.Date(input$dateRange[2])
      )) |>
      # Respond to categories selected
      filter(category %in% input$categories)
  })
  
  output$stackedPlot <- renderPlot({
    data <- filteredData() |>
      mutate(month = floor_date(disb_date, "month")) |>
      group_by(candidate, month, category) |>
      summarize(total_amount = sum(amount)) |>
      ungroup()
    
    p <- ggplot(data, aes(x = month, y = total_amount, fill = category)) +
      geom_col() +
      scale_y_continuous(labels = dollar_format(scale = 0.000001, suffix = "M")) +
      scale_x_date(date_labels = "%b %Y", date_breaks = "1 month") +
      facet_wrap( ~candidate) +
      labs(
        x = "Month",
        y = "Expenditures",
        fill = "Spending Category"
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 12), 
            axis.text.y = element_text(size = 12), 
            axis.title.x = element_text(size = 16, face = "bold"), 
            axis.title.y = element_text(size = 16, face = "bold"), 
            legend.text = element_text(size = 14),
            legend.title = element_text(size = 16, face = "bold"),
            strip.text = element_text(size = 18, face = "bold")) +

    
    # Add vertical dashed line if selected 
    if (input$showLine == "Yes") { 
      p <- p + 
        geom_vline(xintercept = as.Date("2024-07-21"), 
                   linetype = "dashed", 
                   color = "red") + 
        annotate("text", 
                 x = as.Date("2024-07-21"), 
                 y = Inf, 
                 label = "Biden's Withdrawal", 
                 angle = 270, 
                 vjust = -0.5, 
                 hjust = 0,
                 color = "red")
    }
    
    # Render plot to output
    p
    
  })
}

# Run the application
shinyApp(ui = ui, server = server)
