library(tidyverse)
library(dslabs)
data(gapminder)

# Subset a tidy data frame to create and inspect a new, smaller, tidy data frame

  tidy_data <- gapminder %>% 
    filter(country %in% c("South Korea", "Germany")) %>%
    select(country, year, fertility)
  head(tidy_data)

# Plotting tidy data is simple
  
  tidy_data %>% 
  ggplot(aes(year, fertility, color = country)) +
  geom_point()

# However, the original Gapminder data was in wide format

  path <- system.file("extdata", package="dslabs")
  filename <- file.path(path,  "fertility-two-countries-example.csv")
  wide_data <- read_csv(filename)
  select(wide_data, country, `1960`:`1967`)

# gather wide data to make new tidy data

  new_tidy_data <- wide_data %>%
    gather(year, fertility, `1960`:`2015`)
  head(new_tidy_data)

  # note how it works:
    # the first arguemnt in "gather" gives a name for data store in 
    # the header of the wide data

    # the second argument gives a name for the other variable in the
    # data set, because in this simple example the only two variables
    # we have are year and fertility rates, for Germany and South Korea

    # the third argument tells gather which columns to gather: all
    # the columns with data, but not the first column, with the country
    # names

# We can instead tall gather which colums NOT to gather

  new_tidy_data <- wide_data %>%
    gather(year, fertility, -country)
  head(new_tidy_data)

# Note however that in our new tidy data, year has been stored as a character
# variable, not as an integer.  We can avoid this like so:
  
  new_tidy_data <- wide_data %>%
    gather(year, fertility, -country, convert = TRUE)
  head(new_tidy_data)

# If we wanted, we could use simple graphing code as before

