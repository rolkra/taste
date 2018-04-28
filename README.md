# taste
R code to prepare and process sensory analysis (taste the difference between food-products using an trinagle test and other)

## Learn Data Science with Beer

**Basic Question**: can you taste the difference between "Gösser" and "Ottakringer" (Austrian beer brands)

**Experimental Design**: first taste and rate each beer unblinded (you know what you are drinken). Then test if any difference can be detected in a double blinded test (trinagle test: one out ouf three is different, try to find out which one). The double blinded setup ensures that neither the person testing the beer, nor the person serving the beer knows which beer brand is in which glas. Which beer is in which glas is randomized (but one beer must be always different).

**Data Collection**: Beer testing took place at the end of the VDSG Cafe IV in March 2018. We used beer in cans. They were bought at the same supermarket at the same day, and all had the same temperature. A questionnaire was used to collect data. Ratings are coded as numbers from 1 to 5 (e.g. 1 = taste bad, 5 = taste very good). Yes/No answers are coded as 1/0.

![Example Questionnaire](https://github.com/rolkra/taste/blob/master/beer_test_questionnaire.jpg)

* raw data general: https://raw.githubusercontent.com/rolkra/taste/master/beer_test_data_general.csv
* raw data unblinded: https://raw.githubusercontent.com/rolkra/taste/master/beer_test_data_unblinded.csv
* preprocessed data: https://raw.githubusercontent.com/rolkra/taste/master/beer_test_data_all.csv

**Data Exploration**: Started at VDSG Cafe V in April 2018. For basic data exploration the R package explore was used (https://github.com/rolkra/explore)

