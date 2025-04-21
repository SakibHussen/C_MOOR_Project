DNA Transcription Explorer 🧬
Welcome to the DNA Transcription Explorer, a Shiny web app built in R to help students and learners understand DNA-to-RNA transcription, a core process in molecular biology. This app lets you input DNA and RNA sequences, checks if they’re correct, and shows the results in a clear, visual way. It’s designed to be fun, interactive, and educational, with features like color-coded inputs and a refresh button to try new sequences.
This project is a work in progress, and I’m adding new features to make it even better (like translating RNA to proteins). This README explains what the app does, how to use it, and what I’ve learned so far. It’ll be updated as I add more parts to the project.
What Does It Do? 🌟
The app helps you explore how DNA is transcribed into RNA, a key step in the Central Dogma of biology. You:

Enter a DNA sequence (e.g., TACACC) and its RNA match (e.g., AUGUGG).
Get instant feedback: green borders for correct inputs, red for mistakes.
Click Transcribe to see formatted DNA and RNA sequences (e.g., T A C A C C and A U G U G G).
Click Refresh to try a new random DNA sequence.

It’s built for students, so it’s easy to use and shows clear error messages if something’s wrong (like using invalid letters or incorrect RNA).
Features

Real-Time Validation: Checks if DNA has only A, T, C, G and a length divisible by 3 (for codons). RNA is checked to match DNA’s transcription.
Color-Coded Inputs: Green borders for valid inputs, red for invalid, using shinyjs::toggleCssClass.
Transcription Logic: Converts DNA to RNA (A→U, T→A, C→G, G→C).
Random DNA: Generates new DNA sequences (15 bases) for practice.
Codon Table: Ready for future protein translation (e.g., ATG → Methionine).
Pretty Display: Shows sequences with spaces (e.g., A T G) and emojis (🧬 for DNA, 📜 for RNA).

How to Run It
Prerequisites

Install R:

Download R (version 3.4.0 or higher) from CRAN.
Add R to your system PATH.


Install R Packages:Open R (e.g., in RStudio or VS Code) and run:
install.packages(c("shiny", "shinyjs"))


Get the Code:Clone this repository:
git clone https://github.com/SakibHussen/C_MOOR_Project.git
cd C_MOOR_PROJECT



Running the App

Open app.R in RStudio, VS Code (with R extension), or any R environment.
Run the app:shiny::runApp("app_transcription.R")


The app will open in your browser (e.g., http://127.0.0.1:port).

How to Use It

Enter DNA:

Type a DNA sequence (e.g., TACACCGAAGGCTAA) in the DNA box.
It must use only A, T, C, G and have a length like 3, 6, 9, etc. (for codons).
The box turns green if correct, red if wrong (e.g., ATGCT is invalid).


Enter RNA:

Type the RNA sequence that matches the DNA (e.g., AUGUGGCUUCCGAUU).
It must follow transcription rules (DNA T→A, A→U, C→G, G→C).
The box turns green if it matches, red if not.


Click Transcribe:

If both inputs are correct, you’ll see:DNA 🧬: T A C A C C G A A G G C T A A
RNA 📜: A U G U G G C U U C C G A U U
✅ Great job! The RNA matches the DNA.


If something’s wrong, you’ll see an error (e.g., “Error: RNA does not match DNA”).


Click Refresh:

Get a new random DNA sequence (15 letters) to try again.
The RNA box and results clear out.



Example

Valid Input:
DNA: TACACC
RNA: AUGUGG
Result:DNA 🧬: T A C A C C
RNA 📜: A U G U G G
✅ Great job! The RNA matches the DNA.




Invalid Input:
DNA: ATGX
Result: Error: DNA sequence must contain only A, T, C, G
DNA box turns red.



What’s Inside the Code
The app is built with R, Shiny, and shinyjs. Here’s how it works, explained simply:
1. Helper Functions
These do the biology and formatting:

codon_table: A list mapping RNA codons to amino acids (e.g., ATG → MET for Methionine). Not used yet, but ready for adding protein translation later.
validate_dna: Checks if DNA is valid (only A, T, C, G; length like 3, 6, 9, etc.). Returns the clean sequence or an error.
transcribe_dna: Turns DNA into RNA (e.g., TAC → AUG) using base-pairing rules.
validate_rna: Makes sure RNA matches the DNA’s transcription and has the same length.
format_sequence: Adds spaces to sequences (e.g., ATG → A T G) for nice display.
generate_dna: Creates a random 15-letter DNA sequence (e.g., ATCGTAGCTACCGAT).

2. Shiny App

Interface (UI):

A title (“DNA Transcription Explorer 🧬”) and welcome text for students.
Two text boxes for DNA and RNA, styled to look clear (monospace font, spaced letters).
Buttons: Transcribe to check inputs, Refresh to get a new DNA.
Results area showing DNA/RNA or errors, with emojis and shadows for style.
CSS styles make valid inputs green and invalid ones red.


Logic (Server):

Cleans Inputs: Removes wrong letters (e.g., ATGx → ATG) as you type.
Checks Inputs: Uses validate_dna and validate_rna to see if inputs are correct.
Updates Colors: Uses toggleCssClass to change box borders (green for okay, red for errors).
Shows Results: Displays sequences or errors when you click Transcribe.
Refreshes: Generates a new DNA sequence when you click Refresh.



3. Color-Coding with toggleCssClass

What It Does: Changes the look of the DNA and RNA boxes by adding or removing CSS styles (valid for green, invalid for red).
How It Works:
When you type, the app checks if the DNA and RNA are correct.
If DNA is valid (e.g., ATGCTT), toggleCssClass adds the valid style (green border) and removes invalid.
If invalid (e.g., ATGCT), it adds invalid (red border) and removes valid.




What I’ve Learned

Biology: How DNA turns into RNA (A→U, T→A, etc.) and why codons matter (3 letters each).
R and Shiny: How to build a web app with inputs, buttons, and live updates.
shinyjs: Using toggleCssClass to make the app interactive and visual.
Coding: Writing clean functions (like validate_dna) and organizing code.
Testing: Trying different DNA/RNA inputs to make sure everything works.

What’s Next
I’m planning to add:

Protein Translation: Use codon_table to show amino acids from RNA (e.g., AUG → MET).
Better Feedback: Point out exactly which letters - Protein Translation: Use codon_table to show amino acids from RNA (e.g., AUG → MET).
Better Feedback: Point out exactly which letters are wrong in the inputs.
Tutorial Mode: A step-by-step guide for new users.
Save Option: Download your sequences as a file.

This README will be updated as I add these features, so check back for the latest!
Documentation and Resources
I used these to build and understand the app:

Biology:
C_MOOR Biology Basics
C_MOOR 16s rRNA sequencing



R and Shiny:
Shiny Tutorial for building the app.
Shiny Reference for coding details.


shinyjs:
shinyjs GitHub for toggleCssClass and styling.
shinyjs CRAN for official docs.


Try It Out
Clone the repo, run app.R, and start exploring transcription! If you have ideas to make it better, open an issue or pull request on GitHub.
Thanks
Made by Sakib Hussen. Email me at [sakib.hussen@goucher.com] with questions or feedback. Happy learning! 
