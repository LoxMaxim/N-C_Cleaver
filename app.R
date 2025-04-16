# Protein Fragment Generator in Shiny with Copy-to-Clipboard
# Author: Maxim Lox
# Description: Generates N- and C-terminal fragments of protein sequences
#              with calculated molecular weight and isoelectric point.
#              Includes copy-to-clipboard functionality via JavaScript.

# Required packages
if (!require("shiny")) install.packages("shiny")
library(shiny)

# ---- Amino acid data ----
aa_masses <- c(
  A = 71.03711,  C = 103.00919, D = 115.02694, E = 129.04259, F = 147.06841,
  G = 57.02146,  H = 137.05891, I = 113.08406, K = 128.09496, L = 113.08406,
  M = 131.04049, N = 114.04293, P = 97.05276,  Q = 128.05858, R = 156.10111,
  S = 87.03203,  T = 101.04768, V = 99.06841,  W = 186.07931, Y = 163.06333
)

pKa <- list(
  Nterm = 9.69, Cterm = 2.34,
  R = 12.48, K = 10.54, H = 6.04,
  D = 3.90, E = 4.07, C = 8.37, Y = 10.46
)

# ---- Calculation functions ----
calculate_weight <- function(peptide) {
  sum(aa_masses[strsplit(peptide, NULL)[[1]]])
}

calculate_pI <- function(peptide) {
  aa_counts <- table(strsplit(peptide, NULL)[[1]])
  net_charge <- function(pH) {
    charge <- 10^(pKa$Nterm - pH) / (1 + 10^(pKa$Nterm - pH)) -
      10^(pH - pKa$Cterm) / (1 + 10^(pH - pKa$Cterm))
    for (res in names(aa_counts)) {
      n <- aa_counts[res]
      if (res %in% c("R", "K", "H")) {
        charge <- charge + n * 10^(pKa[[res]] - pH) / (1 + 10^(pKa[[res]] - pH))
      }
      if (res %in% c("D", "E", "C", "Y")) {
        charge <- charge - n * 10^(pH - pKa[[res]]) / (1 + 10^(pH - pKa[[res]]))
      }
    }
    charge
  }
  pH_low <- 0
  pH_high <- 14
  while (pH_high - pH_low > 0.01) {
    pH_mid <- (pH_low + pH_high) / 2
    if (net_charge(pH_mid) > 0) {
      pH_low <- pH_mid
    } else {
      pH_high <- pH_mid
    }
  }
  (pH_low + pH_high) / 2
}

generate_N_terminal_fragments <- function(seq) {
  n <- nchar(seq)
  data.frame(
    Fragment = sapply(1:n, function(i) substr(seq, 1, i)),
    Weight = sapply(1:n, function(i) calculate_weight(substr(seq, 1, i))),
    pI = sapply(1:n, function(i) calculate_pI(substr(seq, 1, i))),
    stringsAsFactors = FALSE
  )
}

generate_C_terminal_fragments <- function(seq) {
  n <- nchar(seq)
  data.frame(
    Fragment = sapply(1:n, function(i) substr(seq, i, n)),
    Weight = sapply(1:n, function(i) calculate_weight(substr(seq, i, n))),
    pI = sapply(1:n, function(i) calculate_pI(substr(seq, i, n))),
    stringsAsFactors = FALSE
  )
}

# ---- UI ----
ui <- fluidPage(
  titlePanel("Protein Fragment Generator"),
  sidebarLayout(
    sidebarPanel(
      textInput("sequence", "Enter Protein Sequence:", ""),
      actionButton("generate", "Generate Fragments"),
      actionButton("copy", "Copy Table to Clipboard", onclick = "copyTableToClipboard()"),
      tags$script(HTML("
        function copyTableToClipboard() {
          var table = document.getElementById('fragment_table');
          if (!table) {
            alert('Table not found.');
            return;
          }
          var range = document.createRange();
          range.selectNode(table);
          var sel = window.getSelection();
          sel.removeAllRanges();
          sel.addRange(range);
          try {
            document.execCommand('copy');
            sel.removeAllRanges();
            alert('Copied to clipboard!');
          } catch (err) {
            alert('Failed to copy: ' + err);
          }
        }
      "))
    ),
    mainPanel(
      htmlOutput("table_html")  # <- this is where we'll insert a full HTML table
    )
  )
)

# ---- Server ----
server <- function(input, output, session) {
  fragments_df <- reactiveVal()
  
  observeEvent(input$generate, {
    req(input$sequence)
    seq <- toupper(gsub("[^ACDEFGHIKLMNPQRSTVWY]", "", input$sequence))
    n_data <- generate_N_terminal_fragments(seq)
    c_data <- generate_C_terminal_fragments(seq)
    
    df <- data.frame(
      N_Fragment = n_data$Fragment,
      N_Weight = round(n_data$Weight, 2),
      N_pI = round(n_data$pI, 2),
      C_Fragment = c_data$Fragment,
      C_Weight = round(c_data$Weight, 2),
      C_pI = round(c_data$pI, 2),
      stringsAsFactors = FALSE
    )
    fragments_df(df)
  })
  
  output$table_html <- renderUI({
    req(fragments_df())
    df <- fragments_df()
    
    # Build HTML table manually with ID
    header <- paste0("<tr>", paste0("<th>", names(df), "</th>", collapse = ""), "</tr>")
    rows <- apply(df, 1, function(row) {
      paste0("<tr>", paste0("<td>", row, "</td>", collapse = ""), "</tr>")
    })
    HTML(paste0("<table id='fragment_table' class='table table-bordered table-sm'>", header, paste(rows, collapse = ""), "</table>"))
  })
}

# ---- Run App ----
shinyApp(ui = ui, server = server)
