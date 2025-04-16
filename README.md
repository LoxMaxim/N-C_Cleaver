# Protein Fragment Analyzer (Shiny App)

A Shiny web application for analyzing protein sequences by generating all possible **N-terminal** and **C-terminal fragments**, along with their **monoisotopic mass** and **isoelectric point (pI)** values. This tool is useful for researchers and students working in **biochemistry**, **proteomics**, or **bioinformatics**.

For use go to the following website: [N-C_Cleaver](https://loxmaxim.github.io/N-C_Cleaver/)

---

## 🚀 Features

- 🔬 Calculates **monoisotopic masses** of each peptide fragment
- 📈 Computes **isoelectric point (pI)** based on amino acid composition
- 🧩 Generates all possible **N-terminal** and **C-terminal fragments**
- 📋 **(Planned)** Clipboard export for easy data sharing
- 💻 Interactive **Shiny interface**

---

## 🧪 Example

**Input Sequence**: `MKWVTFISLLFLFSSAYSRGVFRR`

The app will generate:

| N-Terminal Fragment | Mass (Da) | pI | C-Terminal Fragment | Mass (Da) | pI |
|---------------------|------------|-----|----------------------|------------|-----|
| M | 131.04 | 9.64 | R | 156.10 | 12.48 |
| MK | 259.13 | 9.89 | RR | 284.20 | 12.49 |
| ... | ... | ... | ... | ... | ... |

---
