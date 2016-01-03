printf("Adding paths to the project...\n");
addpath ./logisregress

#CREATING THE VARIABLE WE'LL USE ALONG THE EXECUTION OF THE PROGRAM

printf("Creating usefull variables for the project...\n");
bcwdata = dlmread("breast-cancer-wisconsin.data",",");
bcwdataC = columns(bcwdata);
bcwdata = bcwdata(:,[2:bcwdataC]);
bcwdataC = columns(bcwdata);
bcwdataR = rows(bcwdata);
bcwdataX = bcwdata(:,[1:bcwdataC-1]);
bcwdataY = bcwdata(:,bcwdataC);
bcwdataX = [ones(bcwdataR,1),bcwdataX];
lambda = 0.01;
num_et = length(unique(bcwdataY));

#WE STABLISH THE BENING TO 0 AND THE MALIGN TO 1

bcwdataY = (bcwdataY == 4);

######################input("Press intro to continue...\n");
#WE START WITH THE LOGISTIC REGRESSION

printf("Starting with a logistic regression...\n");
[allTheta] = oneVsAll(bcwdataX, bcwdataY, num_et, lambda);

#KNOW, WE GOING TO CHECK HOW GOOD IS OUR CLASSIFICATION
printf("\nCalculating the porcentaje of good-classified examples...\n");
prc = check(bcwdataX, bcwdataY, allTheta);

printf("The porcentaje of good-clasiffied examples is %d\n", prc);
######################input("Press intro to continue...\n");
printf("Plotting the decision boundary...");
plotDecisionBoundary(allTheta, bcwdataX, bcwdataY);