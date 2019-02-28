# Code Book

>This script will check if the data file is present in your working directory and if not, it'll download and unzip the file.

## 1. Read data and Merge

* **subject_test :** Subject IDs for test
* **subject_train :** Subject IDs for train
* **X_test :** Values of variables in test
* **X_train :** Values of variables in train
* **y_test :** Activity ID in test
* **y_train :** Activity ID in train
* **activity_labels :** Description of activity IDs in y_test and y_train
* **features :** Description(label) of each variables in X_test and X_train
* **dataSet :** Bind of X_train and X_test

## 2. Extract only mean() and std()

>Create a vector of only mean and std labels, then use the vector to subset dataSet.

* **indexMeanStd :** a vector of only mean and std labels extracted from 2nd column of features.
* **dataSet :** At the end of this step, dataSet will only contain mean and std variables

## 3. Changing Column label of dataSet

>Create a vector of Get Clean feature names Vector: First replace `"()"` by `""` and after change `","` by `"_"`. Then, will apply that to the dataSet to rename column labels.

* **CleanFeatureNames :** A vector of "clean" feature labels name

## 4. Adding Subject and Activity to the dataSet

>Merged test data and train data of subject and activity, then give descriptive lables. Finally, bind with dataSet. At the end of this step, dataSet has 2 additonal columns 'subject' and 'activity' in the left side.

* **subject :** Bind of subject_train and subject_test
* **activity :** Bind of y_train and y_test

## 5. Rename ID to activity name

>The activity column of dataSet was renamed each levels with 2nd column of activity_levels. Finally apply the renamed `dataSet$activity` to dataSet's activity column.

* **dataSet$activity :** factored activity column of dataSet

## 6. Output tidy data

>In this part, dataSet is melted to create tidy data. It will also add [mean of] to each column labels for better description. Finally output the data as `"tidyData.txt"`

* **dataMelt :** melted tall and skinny dataSet
* **meanDataMelt :** casete dataMelt which has means of each variables
