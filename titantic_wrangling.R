#0 Load the data into RStudio
titanic_original <- read_csv("C:/Users/Ben.Kronk/Desktop/titanic_original.csv")

#1 Replace missing values with "S"
titanic_original$embarked[is.na(titanic_original$embarked)] <- "S"

#2a Impute missing values in Age column with the mean 
#2b Alternative: Random values from a distribution that fits the age range, e.g. normal.  This 
# could be better because it would give a better likelihood of the actual age, rather than the 
# mean which is arbitrary and may be based on skewed data, providing an inaccurate representation.
titanic_original$age <- round(with(titanic_original, impute(age, mean)), 0)

#3 Add NA to missing values in boat column
titanic_original$boat[titanic_original$boat==NA] <- NA 

#4 Cabin numbers - it does not make sense to fill these with a value because this is a 
#  categorical variable.  No cabin number could mean that the person did not have an actual cabin.
one_or_zero <- function(x){
  ifelse(!is.na(x), 1, 0)
}
has_cabin_number <- one_or_zero(titanic_original$cabin)
titanic_clean <- cbind(titanic_original, has_cabin_number)


