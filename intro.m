warning("off", "Octave:broadcast");
#CREATING THE VARIABLE WE'LL USE ALONG THE EXECUTION OF THE PROGRAM

printf("Creating usefull variables for the project...\n");
bcwdata = dlmread("wpbc.data",",");
bcwdataC = columns(bcwdata);
bcwdata = bcwdata(:,[2:bcwdataC]);
bcwdataC = columns(bcwdata);
bcwdataR = rows(bcwdata);
#[bcwdata,media,desv] = normalizaAtributo(bcwdata);
bcwdataX = bcwdata(:,[2:bcwdataC]);
months = bcwdata(:,2);
bcwdataY = bcwdata(:,1);
lambda = [0,0.00001,0.00003,0.0001,0.0003,0.001,0.003,0.01,0.03,0.1,0.3,1,3,10,30,100,300];
BESTlambda = 0;
BESTprc = 0;
num_et = length(unique(bcwdataY));

#WE STABLISH THE BENING TO 0 AND THE MALIGN TO 1
input("Press intro to continue...\n"); 
