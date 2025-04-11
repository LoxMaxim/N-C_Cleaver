# NC-cleaver
This Shiny application allows you to generate and analyze the N-terminal and C-terminal fragments of a given protein sequence. The application calculates the molecular weight and isoelectric point (pI) for each fragment.

# Using the Application Interface
Input the Protein Sequence: Enter your protein sequence in the text input box labeled "Enter Protein Sequence".
Generate Fragments: Click the "Generate Fragments" button to calculate and display the N-terminal and C-terminal fragments along with their molecular weights and pI values.
Copy to Clipboard: Use the "Copy to Clipboard" button to copy the generated fragment data to your clipboard for easy use in other applications.

# Understanding the Output
The application generates a table with the following columns:
* N_Terminal_Fragment: The fragment of the protein starting from the N-terminal.
* N_Terminal_Weight: The molecular weight of the N-terminal fragment.
* N_Terminal_pI: The isoelectric point of the N-terminal fragment.
* C_Terminal_Fragment: The fragment of the protein starting from the C-terminal.
* C_Terminal_Weight: The molecular weight of the C-terminal fragment.
* C_Terminal_pI: The isoelectric point of the C-terminal fragment.

# Additional Information
The application uses predefined monoisotopic masses and pKa values for amino acids to perform calculations. These values ensure accurate results for molecular weight and pI. By following these steps, you can effectively use the Protein Sequence Fragment Generator to analyze protein sequences and obtain valuable insights into their fragment properties.
