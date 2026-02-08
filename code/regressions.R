library(readxl)

#1. Load the data 
student_mat <- read_excel("C:/Users/user/OneDrive/Bureau/student_mat.xlsx")
(student_mat) 

# Useful packages
library(dplyr)

vars <- c("sex","school", "address", "famsize","Pstatus", "Mjob","Fjob", "reason", "guardian", "failures", "schoolsup", "famsup", "paid","activities","nursery", "higher", "internet", "romantic", "famrel", "freetime", "age","goout","health", "absences","G1","G2","G3","studytime","traveltime","Walc","Dalc","Medu","Fedu")
summary(student_mat[ , vars])

# Correlations with G3
numeric_vars <- sapply(student_mat, is.numeric)
cor(student_mat[ , numeric_vars], student_mat$G3, use = "complete.obs")


#SLR models

m_mat_G1  <- lm(G3 ~ G1, data = student_mat)
m_mat_G2  <- lm(G3 ~ G2, data = student_mat)
m_mat_medu <- lm(G3 ~ Medu, data = student_mat)
m_mat_fail <- lm(G3 ~ failures, data = student_mat)
m_mat_study <- lm(G3 ~ studytime, data = student_mat)

summary(m_mat_G1)
summary(m_mat_G2)
summary(m_mat_medu)
summary(m_mat_fail)
summary(m_mat_study)

#MLR models

# MLR academic
mlr1_mat <- lm(G3 ~ G1 + G2 + failures + absences + studytime, data = student_mat)
summary(mlr1_mat)

# MLR socio-behavioral
mlr2_mat <- lm(G3 ~ failures + absences + studytime + Walc + Dalc + Medu + Fedu, data = student_mat)
summary(mlr2_mat)


# MLR socio-economic
mlr3_mat <- lm(G3 ~ Medu + Fedu + famsize + internet + activities , data = student_mat)
summary(mlr3_mat)

# Interaction term
mlr5 <- lm(G3 ~ G1 + failures + G1:failures + Medu + studytime, data = student_mat)
summary (mlr5)



# LOGIT model

student_mat$PassFail <- ifelse(student_mat$G3 >= 10, "Pass", "Fail")
student_mat$PassFail <- factor(student_mat$PassFail, levels = c("Pass", "Fail"))
table(student_mat$PassFail)



logit_model <- glm(PassFail ~ G1 + G2 + failures + absences + studytime + sex + age + Medu + Fedu + internet + famsup, data = student_mat, family = binomial(link = "logit"))
summary(logit_model)



#Visualizing the results using plots : 

par(mfrow = c(1,2))

#G3 vs G1 

plot(student_mat$G1, student_mat$G3,xlab = "G1", ylab = "G3",main = "G3 vs G1", pch = 16, col = "skyblue")
abline(lm(G3 ~ G1, data = student_mat), col = "navy", lwd = 2)

#G3 vs G2

plot(student_mat$G2, student_mat$G3,xlab = "G2", ylab = "G3", main = "G3 vs G2", pch = 16, col = "skyblue")
abline(lm(G3 ~ G2, data = student_mat), col = "navy", lwd = 2)

par(mfrow = c(1,1))

#G3 by number of failures

boxplot(G3 ~ failures, data = student_mat, col = "skyblue", xlab = "Number of past failures", ylab = "G3", main = "Final grade by failures")


#Probability of passing as a function of G2

model_logit <- glm(PassFail ~ G1 + G2 + failures + absences + studytime, data = student_mat, family = binomial)

G2_seq <- seq(min(student_mat$G2), max(student_mat$G2), length.out = 100)

newdata <- data.frame(G2 = G2_seq, G1 = mean(student_mat$G1), failures = 0, absences = mean(student_mat$absences), studytime = mean(student_mat$studytime))

pred_prob <- predict(model_logit, newdata = newdata, type = "response")

plot(G2_seq, pred_prob, type = "l", lwd = 2, xlab = "G2", ylab = "Probability of passing", main = "Predicted probability of passing by G2")
abline(h = 0.5, lty = 2)
