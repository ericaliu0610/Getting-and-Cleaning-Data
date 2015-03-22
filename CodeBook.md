## CodeBook for project in getting and cleaning data
Step 1: read training data file and test data files, merge them together to formulate a 10299x561 data frame; read labels and subjects into variable "laber" and"S" respectively.
Step 2: read features.txt into variable "features", extract measurements on the mean and standard deviation by grep(), return the column number of variables
Step 3: read activity_labels.txt, and replace the values in "label" by related activity
Step 4: combine variables "S" "label" "data" together as a tidy dataset
Step 5: calculate the average of each suject and activity by subsetting the new tidy data and averages the values by columns.  
