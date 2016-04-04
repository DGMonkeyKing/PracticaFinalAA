intro

#WE START WITH THE LOGISTIC REGRESSION

printf("Starting with a logistic regression...\n\n");

BESTprc = 0;

for i=1:length(lambda)
		#printf("Parting the dataset:\ntrain=%f\nvalidation=%f\ntesting=%f\n\n", parts(j,1), parts(j,2), parts(j,3));
		#[Xtrain,Xval,Xtest,ytrain,yval,ytest] = datasetPart(bcwdataX, bcwdataY, parts(j,1), parts(j,2), parts(j,3));
		#learningCurve(Xtrain, ytrain, lambda(i), Xval, yval, 100);
		printf("For lambda=%f...\n", lambda(i));
		[theta, cost] = logReg(bcwdataX, bcwdataY, lambda(i));
	  	printf("\nCalculating the porcentaje of good-classified examples...\n");
	  	prc = check(bcwdataX, bcwdataY, theta);
	  	printf("The porcentaje of good-clasiffied examples is %f\n\n", prc);
	  	fflush(stdout);
		if BESTprc <= prc 
			BESTprc = prc;
			BESTlambda = lambda(i);
		endif
	end

printf("We use lambda = %f as the best lambda.\n\n", BESTlambda);
fflush(stdout);

[theta, cost] = logReg(bcwdataX, bcwdataY, BESTlambda);
for i=[1,32,33,34,45,43,46,89,12,78,123,134,133,156]
	equis = bcwdataX(i,:);
	r = sigmoide(theta, [1,equis]);
	if r < 0.5 
		printf("You're not recurrent!\n");
	else
		printf("You're recurrent...");
		tetaOptima = pinv(transpose(bcwdataX)*bcwdataX)*transpose(bcwdataX)*months;
		tiempo = (hipotesis(tetaOptima, equis));
		printf("Just in %f months\n", tiempo);
	end
end

%{
[theta, cost] = logReg(bcwdataX, bcwdataY, 0);

input("Press intro to continue...\n");
#CURVA DE APRENDIZAJE PARA NUESTRA REGRESION LOGISTICA SIN REGULARIZAR NI NADA
[Xtrain,Xval,Xtest,ytrain,yval,ytest] = datasetPart(bcwdataX, bcwdataY, 0.7, 0.3, 0.0);
learningCurve(Xtrain, ytrain, 0, Xval, yval, 100);

input("Press intro to continue...\n");

#TRY ADDING POLYNOMIAL FEATURES
degrees=[2, 3, 4, 5];

for i=1:length(degrees)
	Xaux = multinom(bcwdataX, degrees(i));
	[Xfin, mu, sigma] =featureNormalize(Xaux);
	[Xtrain,Xval,Xtest,ytrain,yval,ytest] = datasetPart(Xfin, bcwdataY, 0.7, 0.3, 0.0);
	Xtrain = bsxfun(@minus, Xtrain, mu);
	Xtrain = bsxfun(@rdivide, Xtrain, sigma);
	Xval = bsxfun(@minus, Xval, mu);
	Xval = bsxfun(@rdivide, Xval, sigma);
	learningCurve(Xtrain, ytrain, 0, Xval, yval, 100);
end

#CURVA DE APRENDIZAJE PARA DISTINTOS PORCENTAJES DE EJEMPLOS DE ENTRENAMIENTO/VALIDACION Y LAMBDA
#parts=[0.6,0.2,0.2];

#for j=1:rows(parts)
	
end





#pos = find(bcwdataY==1); neg = find(bcwdataY == 0);


name = ["Clump Thickness"; "Uniformity of Cell Size"; "Uniformity of Cell Shape"; "Marginal Adhesion";"Single Epithelial Cell Size"; "Bare Nuclei"; "Bland Chromatin"; "Normal Nucleoli"; "Mitoses"];
name = cellstr(name);

#PLOTTING BY FEATURES
for i=2:columns(bcwdataX)
	for j=1:i-1
		#plotDecisionBoundary(theta, bcwdataX, bcwdataY, i, j, name);
		plot(bcwdataX(pos,i), bcwdataX(pos,j), '+','linewidth', 2, bcwdataX(neg,i), bcwdataX(neg,j), 'o','linewidth', 2);
    		title("FEATURES DEPENDENCES");
    		xlabel(name(i-1,1));
    		ylabel(name(j,1));
		input("Press intro to continue...\n");
	end
end
%}
input("Press intro to continue...\n");
