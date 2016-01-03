printf("Adding paths to the project...\n");
addpath ./logisregress
addpath ./neuralnetwork

#CREATING THE VARIABLE WE'LL USE ALONG THE EXECUTION OF THE PROGRAM

printf("Creating usefull variables for the project...\n");
bcwdata = dlmread("breast-cancer-wisconsin.data",",");
bcwdataC = columns(bcwdata);
bcwdata = bcwdata(:,[2:bcwdataC]);
bcwdataC = columns(bcwdata);
bcwdataR = rows(bcwdata);
bcwdataX = bcwdata(:,[1:bcwdataC-1]);
bcwdataY = bcwdata(:,bcwdataC);
bcwdataXones = [ones(bcwdataR,1),bcwdataX];
lambda = 0.01;
num_et = length(unique(bcwdataY));

#WE STABLISH THE BENING TO 0 AND THE MALIGN TO 1

bcwdataY = (bcwdataY == 4);
input("Press intro to continue...\n");

#WE START WITH THE LOGISTIC REGRESSION

printf("Starting with a logistic regression...\n");
[theta, cost] = logReg(bcwdataXones, bcwdataY, lambda);

#KNOW, WE GOING TO CHECK HOW GOOD IS OUR CLASSIFICATION

printf("\nCalculating the porcentaje of good-classified examples...\n");
prc = check(bcwdataXones, bcwdataY, theta);
printf("The porcentaje of good-clasiffied examples is %d\n", prc);

#RESERVED SPACE FOR PLOTTING
#
#
###########################

input("Press intro to continue...\n");

#WE CONTINUE NOW WITH A NEURAL NETWORK

entradas = 9;
capa_oculta = 4;
salidas = 2;

theta1 = pesosAleatorios(entradas,capa_oculta);
theta2 = pesosAleatorios(capa_oculta,salidas);

options = optimset('MaxIter', 200);
coste = @(p) costeRN(p, entradas, capa_oculta, num_et, bcwdataX, bcwdataY, lambda);
matriz_enrollada = rolling(theta1,theta2);
gradiente = fmincg(coste, matriz_enrollada, options);
grad1 = reshape(gradiente(1:capa_oculta * (entradas + 1)), ...
                 capa_oculta, (entradas + 1));

grad2 = reshape(gradiente((1 + (capa_oculta * (entradas + 1))):end), ...
                 salidas, (capa_oculta + 1));

printf("\nCalculating the porcentaje of good-classified examples...\n");
prc = checkNeural(bcwdataX, bcwdataY, grad1, grad2, entradas, capa_oculta, salidas);
printf("The porcentaje of good-clasiffied examples is %d\n", prc);
