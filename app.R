library(shiny)
library(shinyjs)
library(rsconnect)
rsconnect::writeManifest(
  appDir = ".",
  appPrimaryDoc = "app.R",
  appFiles = NULL
)

# Function to validate DNA sequence
validate_dna <- function(dna) {
  dna <- toupper(gsub(" ", "", dna))
  if (!grepl("^[ATCG]*$", dna)) {
    return("Error: DNA sequence must contain only A, T, C, G")
  }
  if (nchar(dna) %% 3 != 0) {
    return("Error: DNA sequence length must be a multiple of 3")
  }
  return(dna)
}

# Function to transcribe DNA to RNA
transcribe_dna <- function(dna) {
  dna <- toupper(gsub(" ", "", dna))
  rna <- chartr("ATCG", "UAGC", dna)
  return(rna)
}

# Function to validate RNA against DNA
validate_rna <- function(dna, rna) {
  dna <- toupper(gsub(" ", "", dna))
  rna <- toupper(gsub(" ", "", rna))
  expected_rna <- transcribe_dna(dna)
  if (nchar(rna) != nchar(dna)) {
    return("Error: RNA length does not match DNA length")
  }
  if (rna != expected_rna) {
    return("Error: RNA does not match DNA based on base pairing rules (A-U, C-G)")
  }
  return(rna)
}

# Function to format sequence for display
format_sequence <- function(seq) {
  paste(strsplit(seq, "")[[1]], collapse = " ")
}

# Function to generate random DNA sequence
generate_dna <- function(length = 15) {
  bases <- c("A", "T", "C", "G")
  paste(sample(bases, length, replace = TRUE), collapse = "")
}

# UI Definition
ui <- fluidPage(
  useShinyjs(),
  titlePanel("🌟 DNA Transcription Explorer"),
  tags$style(HTML("
    body {
      background-color: #f0f4f8;
      font-family: 'Arial', sans-serif;
      color: #333;
    }
    .title-panel {
      text-align: center;
      color: #2c3e50;
      font-size: 28px;
      margin-bottom: 20px;
    }
    .intro-text {
      text-align: center;
      font-size: 16px;
      color: #666;
      margin-bottom: 30px;
      background-color: #e6f0fa;
      padding: 15px;
      border-radius: 8px;
    }
    .shiny-input-container {
      margin-bottom: 20px;
    }
    input[type='text'] {
      font-family: 'Courier New', monospace !important;
      font-size: 24px !important;
      letter-spacing: 3px !important;
      padding: 10px !important;
      border-radius: 5px !important;
      border: 2px solid #ccc !important;
      width: 100% !important;
      box-sizing: border-box;
    }
    /* Color-code nucleotides */
    input[type='text']::placeholder {
      color: #999;
    }
    .valid {
      border-color: #28a745 !important;
    }
    .invalid {
      border-color: #dc3545 !important;
    }
    .btn-transcribe, .btn-refresh {
      font-size: 16px;
      padding: 10px 20px;
      border-radius: 5px;
      margin-right: 10px;
      transition: background-color 0.3s;
    }
    .btn-transcribe {
      background-color: #007bff;
      color: white;
      border: none;
    }
    .btn-transcribe:hover {
      background-color: #0056b3;
    }
    .btn-refresh {
      background-color: #28a745;
      color: white;
      border: none;
    }
    .btn-refresh:hover {
      background-color: #218838;
    }
    .sequence-label {
      font-weight: bold;
      font-size: 18px;
      color: #2c3e50;
      margin-top: 15px;
    }
    .sequence-text {
      font-family: 'Courier New', monospace;
      font-size: 20px;
      color: #333;
      letter-spacing: 5px;
      background-color: #fff;
      padding: 10px;
      border-radius: 5px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .error-message {
      color: #dc3545;
      font-size: 16px;
      margin-top: 10px;
    }
    .success-message {
      color: #28a745;
      font-size: 16px;
      margin-top: 10px;
    }
    .sidebar-panel {
      background-color: #ffffff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    .main-panel {
      background-color: #ffffff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
  ")),
  div(class = "intro-text",
      "Welcome, students! 🎓 Enter a DNA sequence (using A, T, C, G) and its RNA match to transcribe it. The length must be a multiple of 3 for codons. Let’s explore the Central Dogma! 🧬"
  ),
  div(
    div(
      class = "sidebar-panel",
      textInput("dna_input", "Enter DNA Sequence:", value = "TACACCGAAGGCTAA",
                placeholder = "e.g., TACACCGAAGGCTAA"),
      textInput("rna_input", "Enter RNA Sequence:", value = "",
                placeholder = "e.g., AUGUGGCUUCCGAUU"),
      div(
        actionButton("transcribe", "Transcribe", class = "btn-transcribe"),
        actionButton("refresh", "Refresh DNA", class = "btn-refresh")
      )
    ),
    div(
      class = "main-panel",
      style = "margin-top: 20px;",
      h4("Transcription Results", style = "color: #2c3e50;"),
      uiOutput("sequence_display"),
      div(class = "error-message", textOutput("error_message")),
      div(style = "color: blue; font-size: 14px; margin-top: 10px;", textOutput("debug_message"))
    )
  )
)

# Server Definition
server <- function(input, output, session) {
  # Disable dna_input to make it readonly
   shinyjs::disable("dna_input")
  
  # Validate inputs and update border colors and show error messages for invalid characters
  observe({
    dna_invalid_chars <- grepl("[^ATCG]", toupper(input$dna_input))
    rna_invalid_chars <- grepl("[^AUCG]", toupper(input$rna_input))
    
    error_msg <- NULL
    if (dna_invalid_chars) {
      error_msg <- "Error: DNA sequence contains invalid characters. Only A, T, C, G are allowed."
    } else if (rna_invalid_chars) {
      error_msg <- "Error: RNA sequence contains invalid characters. Only A, U, C, G are allowed."
    }
    
    output$error_message <- renderText({
      if (!is.null(error_msg)) {
        error_msg
      } else {
        ""
      }
    })
    
    dna_valid <- validate_dna(input$dna_input) == toupper(input$dna_input) && !dna_invalid_chars
    rna_valid <- if (nchar(input$rna_input) > 0) {
      validate_rna(input$dna_input, input$rna_input) == toupper(input$rna_input) && !rna_invalid_chars
    } else {
      TRUE
    }
    
    shinyjs::toggleCssClass("dna_input", "valid", dna_valid)
    shinyjs::toggleCssClass("dna_input", "invalid", !dna_valid)
    shinyjs::toggleCssClass("rna_input", "valid", rna_valid)
    shinyjs::toggleCssClass("rna_input", "invalid", !rna_valid)
  })
  
  # Handle transcription
  observeEvent(input$transcribe, {
    dna <- validate_dna(input$dna_input)
    if (dna != toupper(input$dna_input)) {
      output$error_message <- renderText(dna)
      output$sequence_display <- renderUI(NULL)
      output$debug_message <- renderText("")
      return()
    }
    rna <- validate_rna(input$dna_input, input$rna_input)
    if (rna == toupper(input$rna_input)) {
      output$error_message <- renderText("")
      output$sequence_display <- renderUI({
        tagList(
          div(class = "sequence-label", "DNA 🧬"),
          div(class = "sequence-text", format_sequence(dna)),
          div(class = "sequence-label", "RNA 📜"),
          div(class = "sequence-text", format_sequence(rna)),
          div(style = "color: #28a745; font-size: 16px; margin-top: 10px;", "Congrats it matched")
        )
      })
      output$debug_message <- renderText("Match")
    } else {
      output$error_message <- renderText(rna)
      output$sequence_display <- renderUI(NULL)
      output$debug_message <- renderText("No match")
    }
  })
  
  # Handle refresh
  observeEvent(input$refresh, {
    new_dna <- generate_dna()
    updateTextInput(session, "dna_input", value = new_dna)
    updateTextInput(session, "rna_input", value = "")
    output$error_message <- renderText("")
    output$sequence_display <- renderUI(NULL)
  })
}

# Run the app
shinyApp(ui = ui, server = server)