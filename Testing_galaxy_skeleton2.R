# Load the necessary library
library(tidyverse)

# Step 1: Read the entire data file into memory
raw_file <- readLines(con = "suites_dw_Table1.txt")

# Step 2: Identify the line number L of the separator line
L <- which(substr(x = raw_file, start = 1, stop = 2) == "--")[1]

# Step 3: Save variable descriptions
variable_descriptions <- raw_file[1:(L - 2)]
cat(variable_descriptions, sep = "\n", file = "variable_descriptions.txt")

# Step 4: Extract variable names
variable_names <- raw_file[L - 1] %>%
  str_split(pattern = "\\|") %>%
  unlist() %>%
  str_trim()

# Step 5: Read the data
data_lines <- raw_file[(L + 1):length(raw_file)]
comma_separated_values <- data_lines %>%
  gsub("\\|", ",", .) %>%
  gsub(" ", "", .)

# Create a CSV file with variable names and data
data_with_header <- c(paste(variable_names, collapse = ","), comma_separated_values)
cat(data_with_header, sep = "\n", file = "galaxies_data.csv")

# Step 6: Read the CSV file into a tidy data frame
galaxies <- read_csv("galaxies_data.csv")

# View the first few rows of the data frame
head(galaxies)


# Problem 3

galaxies %>% 
  ggplot(aes(x = log_lk)) +
  geom_histogram()


# As we see the histogram is quite right skewed. This can support the argument
# that the smaller objects are under-represented in the sample


