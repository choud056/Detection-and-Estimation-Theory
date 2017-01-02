# Detection-and-Estimation-Theory
Detection and Estimation Theory_UMN Course Project

This repository contains the mini project 1 of Detection and Estimation Theory (University of Minnesota) Course. The objective 
of this project is to implement particle filter to detect and follow a red coke can in a video sequence.

1. **EE-8581-S16-MiniProject-1_v2.pdf** Is the problem statement pdf file.
2. **Task1.m** is a matlab code for implementing particle filter to find out the posterier density based on prior and likelihood function.Hence,
detecting an object in a image or video sequence using the mean of posterie as the location of the object.
3. **Task1Video_Output.avi** is the output video where the desired object is followed around by a blue square.
4. **plotstep.m** plots the step followed in **Task1.m** file.
5. **redlikelihood.m** is a matlab code for quantifying the desired object in a video. In my case redlikelihood quantifies the amount 
of redness in a image (since my coke can is of red color)
6. **resample.m** resamples the particles based on their CDF.


