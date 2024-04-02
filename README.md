# Auschwitz Death Certificates Analysis

## Overview

This repository provides a foundation for analyzing Auschwitz death certificates data through an interactive Shiny web application. Users can explore and visualize the number of people murdered based on different categories such as birthplace, residence, and religion.

## File Structure

The repo is structured as follows:

- `app`: Contains the Shiny web application files.
  - `ui.R`: User interface definition.
  - `server.R`: Server-side logic.
- `data`: Contains the raw data used in the analysis.
  - `Auschwitz_Death_Raw_Data.csv`: Raw dataset containing information about individuals who died in Auschwitz.
- `README.md`: This readme file providing an overview of the repository and instructions for usage.
  
## Usage

To use this repository:

1. Clone or download this repository to your local machine.
2. Ensure you have R and RStudio installed.
3. Open the RStudio project file (`Auschwitz_Death_Analysis.Rproj`).
4. Install the required packages using `install.packages(c("shiny", "DT", "ggplot2", "dplyr"))`.
5. Run the Shiny app by executing `shiny::runApp("app")` in the RStudio console.
6. Explore the data using the interactive interface in your web browser.

## LLM USage 
Aspects of this repo were created with the assistance of ChatGPT3.5. 