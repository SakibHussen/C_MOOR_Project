DNA Transcription Explorer 🧬
A Shiny R app to learn DNA-to-RNA transcription. Input DNA/RNA, get instant validation, and see results. Built for students with color-coded inputs and random DNA. Work-in-progress, aiming to add protein translation.
Features

Validates DNA (A/T/C/G, length 3/6/9...) and RNA (matches DNA transcription).
Green/red input borders via shinyjs::toggleCssClass.
Transcribes DNA to RNA (A→U, T→A, C→G, G→C).
Generates random 15-base DNA.
Codon table for future translation (e.g., ATG → Methionine).
Shows sequences (e.g., A T G) with emojis (🧬, 📜).

Setup

Install R (≥3.4.0) from CRAN.

Install packages:
install.packages(c("shiny", "shinyjs"))


Clone repo:
git clone https://github.com/SakibHussen/C_MOOR_Project.git
cd C_MOOR_Project


Run:
shiny::runApp("app_transcription.R")



Usage

DNA: Enter sequence (e.g., TACACC). Green if valid, red if not.
RNA: Enter match (e.g., AUGUGG). Green if correct, red if wrong.
Transcribe: See results (e.g., T A C A C C, A U G U G G) or errors.
Refresh: Get new DNA.

Example: DNA TACACC, RNA AUGUGG → DNA 🧬: T A C A C C, RNA 📜: A U G U G G, ✅ Success!
Code

Functions:
codon_table: Maps codons (e.g., ATG → MET).
validate_dna, transcribe_dna, validate_rna: Handle validation, transcription.
format_sequence, generate_dna: Format and randomize.


Shiny:
UI: Inputs, buttons, styled outputs.
Server: Validates, updates borders with toggleCssClass, shows results.


toggleCssClass: Toggles valid (green)/invalid (red) input styles.

Learned

Biology: Transcription, codons.
Shiny: Interactive apps.
shinyjs: Visual feedback.
R: Function design.

Next

Translate RNA to proteins.
Highlight invalid letters.
Add tutorial, downloads.

Resources

Biology: C_MOOR Biology Basics, 16s rRNA.
Shiny: Shiny Tutorial, Reference.
shinyjs: GitHub, CRAN.
Aid: Grok (xAI) for explanations.

Contribute
Share ideas via issues/pull requests.
Thanks
By Sakib Hussen ([sakib.hussen@goucher.com]). Feedback welcome!
