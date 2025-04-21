DNA Transcription Explorer 🧬
A Shiny web app in R to teach DNA-to-RNA transcription. Enter DNA and RNA sequences, get real-time validation, and see formatted results. Built for students, it’s interactive with color-coded inputs and a refresh option. This is a work-in-progress, with plans to add protein translation.
Features

Validate Inputs: DNA must use A, T, C, G and have length divisible by 3; RNA must match DNA’s transcription.
Color Feedback: Green borders for valid inputs, red for invalid via shinyjs::toggleCssClass.
Transcription: Converts DNA to RNA (A→U, T→A, C→G, G→C).
Random DNA: Generates 15-base sequences.
Codon Table: Ready for future RNA-to-protein translation (e.g., ATG → Methionine).
Clear Display: Shows sequences (e.g., A T G) with emojis (🧬, 📜).

Setup

Install R: Get R (≥3.4.0) from CRAN.
Install Packages:install.packages(c("shiny", "shinyjs"))


Clone Repo:git clone https://github.com/SakibHussen/C_MOOR_Project.git
cd C_MOOR_Project


Run App:shiny::runApp("app_transcription.R")



Usage

Enter DNA: Type a sequence (e.g., TACACC). Green border if valid (A/T/C/G, length 3/6/9...), red if not.
Enter RNA: Type matching RNA (e.g., AUGUGG). Green if correct, red if wrong.
Transcribe: Click to see results (e.g., T A C A C C, A U G U G G) or errors.
Refresh: Get a new 15-base DNA sequence.

Example:

Valid: DNA TACACC, RNA AUGUGG → DNA 🧬: T A C A C C, RNA 📜: A U G U G G, ✅ Great job!
Invalid: DNA ATGX → Error: DNA sequence must contain only A, T, C, G

Code Breakdown

Functions:
codon_table: Maps codons to amino acids (e.g., ATG → MET). For future translation.
validate_dna: Ensures DNA is valid.
transcribe_dna: Converts DNA to RNA.
validate_rna: Checks RNA matches DNA.
format_sequence: Spaces sequences (e.g., ATG → A T G).
generate_dna: Makes random DNA.


Shiny App:
UI: Text inputs, buttons, styled outputs with CSS (valid/invalid classes).
Server: Cleans inputs, validates, updates borders with toggleCssClass, shows results.


toggleCssClass: Adds/removes valid (green) or invalid (red) styles to inputs based on validation.

What I Learned

Biology: DNA-to-RNA transcription and codon rules.
Shiny: Building interactive apps with reactive updates.
shinyjs: Using toggleCssClass for visual feedback.
R: Writing and testing functions.

What’s Next

Add protein translation using codon_table.
Highlight specific invalid letters.
Create a tutorial mode.
Allow sequence downloads.

Resources

Biology: C_MOOR Biology Basics, 16s rRNA sequencing.
Shiny: Shiny Tutorial, Reference.
shinyjs: GitHub, CRAN.
Learning Aid: Grok (xAI) for code explanations and validation.

Contribute
Try the app and share ideas via issues or pull requests.
Thanks
By Sakib Hussen ([sakib.hussen@goucher.com]). Feedback welcome!
