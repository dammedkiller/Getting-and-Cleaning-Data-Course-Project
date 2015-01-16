# Getting-and-Cleaning-Data-Course-Project

This project contains the script fulfilling the requirements of the Course Project.

The script is quoted step by step, so here what I am just goin to do is describe the basic functioning mode.

The first part of the script consist of charging the necessary libraries and datasets.

In the second part I merge the data, with rbind (they have the same columns and the only thing to do is put one dataset after the other). Rbind does this whitout reordering the data, which is an important point. Then, I set the names of the columns, which are those in the dataset "features", so that I can extract from that dataset the columns concerning the mean and the std (they all have "mean" and "std" in their names, according to the codebook) and save them in a data.frame called meanAndStd.

In the third part, I convert the activities to a factor vector and change its names so that they are in lowercase. In this way, they are more easily readable. I also bind the activities vector and the subjects one with the meanAndStd data.frame and fix the names of the columns of that dataset, following the codebook specified below. When binding, it is important to point out that this task has to be performed in the same order as done when binding both datasets, so that the data, the activities and the subjects coincide (first train, second test or the other way around).

Finally, I obtain the mean of all columns with lapply grouped by subject and activity. To do this, I convert the meanAndStd to data.table so that it be easier to manipulate and to perform that task. To conclude, I export it to a .txt.



###Codebook

The codebook used to name the variables is similar to that used originally, but with some fixes. I have eliminated the "/" and the "-" in all the names and the "()" in the names that are not related to the angle measure.

I have also change the std to uppercase and capitalized the "mean" in all names.

The rest is left as it was:
  -"t" represents that the measures are in time domain and "f" that the measure is the FFT of the measure.
  -The axis is specified at the end of the name with "X", "Y" or "Z".
  -Whether the measure comes from the accelerometer or the gyroscope is specified with "acc" or "gyro".
  -The acceleration signal is separated into body and gravity acceleration signals ((tBodyAccXYZ and tGravityAccXYZ)).
  -The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerkXYZ and tBodyGyroJerkXYZ).
  - The variables tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag are the measures of the euclidean norm of those three-dimentional signals.
  
