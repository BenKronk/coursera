
#1 Clean up the brand names
company <- refine_original$company %>%
  tolower() %>%
  str_replace("^\\w*p[Ss]$", "philips") %>%
  str_replace("^[Aa].*$", "akzo") %>%
  str_replace("^[Uu].*r$", "unilever")
refine_original$company <- company
  
# 2: Separate product code and number
refine_original <- refine_original %>%
  separate(`Product code / number`, c("product_code", "product_number"), "-")

# 3 Add product categories
product_code_table <- tibble("product_code" = c('p', 'x', 'v', 'q'),
product_category = c('Smartphone','TV','Laptop','Tablet'))

refine_original <- product_code_table %>% right_join(refine_original, by = "product_code")

# 4: Add full address for geocoding
address <- paste0(refine_original$address,", ",refine$city,", ",refine$country)
refine_original$address <- address

# 5 Create dummy variables
company_ <- factor(refine_orginal$company)
dummies <- model.matrix(~company_ +0)
product_ <- factor(refine_original$product_category)
dummies1 <- model.matrix(~product_ +0)
dummies <- as.data.frame(dummies)
dummies <- as.tbl(dummies)
dummies1 <- as.data.frame(dummies1)
dummies1 <- as.tbl(dummies1)
refine_clean <- cbind(refine_original, dummies)
refine_clean <- cbind(refine_clean, dummies1)

names(refine_clean)[13:16] <- tolower(names(refine_clean)[13:16])

