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

## Used packages:
 R Core Team (2023). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna,
  Austria. URL https://www.R-project.org/.

Chang W, Cheng J, Allaire J, Sievert C, Schloerke B, Xie Y, Allen J, McPherson J, Dipert A, Borges B (2024). _shiny: Web
  Application Framework for R_. R package version 1.9.1, <https://CRAN.R-project.org/package=shiny>.

Schloerke B, Chang W (2023). _shinylive: Run 'shiny' Applications in the Browser_. R package version 0.1.1,
  <https://CRAN.R-project.org/package=shinylive>.

Wickham H (2024). _httr2: Perform HTTP Requests and Process the Responses_. R package version 1.0.1,
  <https://CRAN.R-project.org/package=httr2>.
