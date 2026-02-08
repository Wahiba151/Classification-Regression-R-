# Predicting Students’ Performance – Classification & Regression (R)

## Overview

This group project analyzes and predicts students’ academic performance in mathematics using statistical modeling in R.  
We use the Student Performance dataset (395 students, 33 variables) containing demographic characteristics, family background, behavioral indicators, and past grades.

The objective is to understand the main determinants of final performance (G3) and to predict the probability of passing the final exam using both linear and logistic models.

---

## Objectives

- Explore relationships between academic, socio-economic, and behavioral factors
- Predict final grades (G3) using linear regression
- Model pass/fail outcomes using logistic regression
- Compare academic determinants with socio-behavioral factors
- Provide policy-relevant interpretation for educational outcomes

---

## Data & Features

Main variable groups:

- **Academic:** G1, G2, G3, failures, studytime, absences  
- **Family background:** mother’s and father’s education (Medu, Fedu), family size  
- **Behavioral:** alcohol consumption (Dalc, Walc), health, going out, free time  
- **Demographic:** age, gender, address  

We construct:
- A binary variable *Pass/Fail* (G3 ≥ 10)
- A 5-category performance scale (A–F)

Observations with extreme absenteeism were removed to avoid distortion.

---

## Methods

### Exploratory Data Analysis
- Descriptive statistics and distributions
- Correlation analysis with final grade (G3)

### Regression Models
- Simple Linear Regressions (G3 on individual predictors)
- Multiple Linear Regression (academic model, socio-behavioral model, socio-economic model)
- Interaction model (early performance × past failures)

### Classification
- Logistic regression to estimate probability of passing

---

## Key Results

- Second-period grade (G2) is the strongest predictor of final performance (corr ≈ 0.90).
- Academic variables explain most of the variance in G3 (R² ≈ 83% in the academic MLR model).
- Past failures negatively affect outcomes, even after controlling for grades.
- Mother’s education has a positive but indirect effect on performance.
- Behavioral variables (alcohol, free time) have limited explanatory power once grades are included.
- Logistic regression confirms that recent grades and study effort largely determine the probability of passing.

Main insight: **academic performance is highly persistent over time—early and recent grades dominate socio-economic and behavioral factors.**

---

## Repository Structure

- `code/` – R scripts (data cleaning, EDA, regressions, logit models)
- `data/` – student dataset
- `outputs/` – figures and regression outputs
- `report/` – detailed written interpretation (PDF)

---

## Team

Group academic project:
- LAZRAQ Wahiba
- NAJM-SBAI Hiba

### My contribution (Wahiba Lazraq)

- Data cleaning and variable construction  
- EDA and correlation analysis  
- Linear and logistic regressions  
- Visualization and interpretation of results  

---

## Tools

- R (dplyr, readxl, lm, glm)
