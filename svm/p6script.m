## 1 KERNEL LINEAL

model = svmtrain(double(bcwdataX), double(bcwdataY), '-t 0 -c 1 -d 24 -g 1 -r 1 -q');
[v, tmp, dump] = svmpredict(ones(rows(bcwdataY),1), double(bcwdataY), model,'-q ');

tmp(isnan(tmp))=0;
tmp = sum(tmp);
#tmp = tmp == 10;

#tmp = sum(tmp == bcwdataY)*100/rows(bcwdataY);

printf("porcentaje de aciertos %f...\n", tmp);

#for i = 1:length(CJ)
#	for j = 1:length(CJ)
#		printf("Imprimiendo grafica para C = %f y sigma = %f\n", CJ(i), CJ(j));
#		visualizeBoundary(X, y, models(i,j));
#		input("Vuelvete loco y pulsa intro...:)");
#	end;
#end;

input("Vuelvete loco y pulsa intro...:)");
%{

printf("Conjunto de datos 1...\n");

fid = fopen('data.txt', 'w');
for i=1:rows(bcwdataX)
	if(bcwdataY(i) == 0)
		fprintf(fid, '1 ');
	else
		fprintf(fid, '2 ');
	end
	for j=1:columns(bcwdataX)
		    fprintf(fid, '%i:%f ', j, bcwdataX(i,j)/10);
	end
	fprintf(fid, '\n');   
end
fclose(fid);

printf("Conjunto de datos 3...\n");
CJ = [0.001,0.003,0.01,0.03,0.1,0.3,1,3,10,30,100,300,1000,3000,10000,30000];
total = rows(bcwdataX);
BEST_C = 0.001;
#BEST_SIGMA = 0.001;
prctj = 0;
for i = 1:length(CJ)
	for j = 1:length(CJ)
		
	end;
end;

printf("Calculo del modelo de SVM para C = 1\n");
modelC_1 = svmTrain(bcwdataX, bcwdataY, 1, @linearKernel, 1e-3, 20);
printf("Calculo del modelo de SVM para C = 100\n");
modelC_100 = svmTrain(bcwdataX, bcwdataY, 100, @linearKernel, 1e-3, 20);
printf("Imprimiendo grafica para C = 1\n");
visualizeBoundaryLinear(bcwdataX, bcwdataY, modelC_1);
input("Vuelvete loco y pulsa intro...:)");
printf("Imprimiendo grafica para C = 100\n");
visualizeBoundaryLinear(bcwdataX, bcwdataY, modelC_100);
input("Vuelvete loco y pulsa intro...:)");

## 2 KERNEL GAUSSIANO

load("ex6data2.mat");
printf("Conjunto de datos 2...\n");
printf("Calculo del modelo de SVM para C = 1 y sigma = 0.1\n");
modelC_1 = svmTrain(X, y, 1, @(x1,x2) gaussianKernel(x1,x2,0.1));
#printf("Imprimiendo grafica para C = 100 y sigma = 0.1\n");
#visualizeBoundary(X, y, modelC_1);
input("Vuelvete loco y pulsa intro...:)");

## 3 ELECCION PARAMETROS C Y SIGMA



## 4 DETECCION DE SPAM

printf("\nDETECCION DE SPAM\n");

entr_easy = [1,10,40,90,120,300,450,709,900,1400,1925,2045,2551];
entr_hard = [3,67,89,100,104,150,180,199,201,210,232,249];
entr_spam = [5,9,13,17,20,24,27,36,69,90,100,250,490,494];
val_easy = [2,3,4,5,22,25,27,28,56,58,67,340,467,678,2000,2001];
val_hard = [1,2,6,12,34,45,56,123,234,235,236,238,240,248];
val_spam = [1,3,6,8,14,18,26,29,37,45,91,92,260,367,480];

printf("Leyendo vocabulario...\n");
vocablist = getVocabList('vocab.txt');

printf("Creando tabla hash vocabulario...\n");
for i = 1:length(vocablist)
	vocabulario.(vocablist{i}) = i;
end

x_easy = zeros(length(entr_easy), length(vocablist));
x_hard = zeros(length(entr_hard), length(vocablist));
x_spam = zeros(length(entr_spam), length(vocablist));
xval_easy = zeros(length(val_easy), length(vocablist));
xval_hard = zeros(length(val_hard), length(vocablist));
xval_spam = zeros(length(val_spam), length(vocablist));
y_easy = zeros(length(entr_easy), 1);
y_hard = zeros(length(entr_hard), 1);
y_spam = ones(length(entr_spam), 1);
yval_easy = zeros(length(val_easy), 1);
yval_hard = zeros(length(val_hard), 1);
yval_spam = ones(length(val_spam), 1);

printf("\nLeyendo emails de spam...\n");
for i = 1:length(entr_spam)
	printf("Leyendo el archivo spam/%04i.txt\n", entr_spam(i));
	fflush(stdout);
	buffer = sprintf("spam/%04i.txt", i);
	file_contents = readFile(buffer);
	email = processEmail(file_contents);
	while ~isempty(email)
		[str, email] = strtok(email, [' ']);
		if isfield(vocabulario, str)
			x_spam(i, vocabulario.(str)) = 1;
		endif
	end
end

printf("\nLeyendo emails de easy_ham...\n");
for i = 1:length(entr_easy)
	printf("Leyendo el archivo easy_ham/%04i.txt\n", entr_easy(i));
	fflush(stdout);
	buffer = sprintf("easy_ham/%04i.txt", i);
	file_contents = readFile(buffer);
	email = processEmail(file_contents);
	while ~isempty(email)
		[str, email] = strtok(email, [' ']);
		if isfield(vocabulario, str)
			x_easy(i, vocabulario.(str)) = 1;
		endif
	end
end

printf("\nLeyendo emails de hard_ham...\n");
for i = 1:length(entr_hard)
	printf("Leyendo el archivo hard_ham/%04i.txt\n", entr_hard(i));
	fflush(stdout);
	buffer = sprintf("hard_ham/%04i.txt", i);
	file_contents = readFile(buffer);
	email = processEmail(file_contents);
	while ~isempty(email)
		[str, email] = strtok(email, [' ']);
		if isfield(vocabulario, str)
			x_hard(i, vocabulario.(str)) = 1;
		endif
	end
end

printf("\nLeyendo emails de validacion de spam...\n");
for i = 1:length(val_spam)
	printf("Leyendo el archivo spam/%04i.txt\n", val_spam(i));
	fflush(stdout);
	buffer = sprintf("spam/%04i.txt", i);
	file_contents = readFile(buffer);
	email = processEmail(file_contents);
	while ~isempty(email)
		[str, email] = strtok(email, [' ']);
		if isfield(vocabulario, str)
			xval_spam(i, vocabulario.(str)) = 1;
		endif
	end
end

printf("\nLeyendo emails de validacion de easy_ham...\n");
for i = 1:length(val_easy)
	printf("Leyendo el archivo easy_ham/%04i.txt\n", val_easy(i));
	fflush(stdout);
	buffer = sprintf("easy_ham/%04i.txt", i);
	file_contents = readFile(buffer);
	email = processEmail(file_contents);
	while ~isempty(email)
		[str, email] = strtok(email, [' ']);
		if isfield(vocabulario, str)
			xval_easy(i, vocabulario.(str)) = 1;
		endif
	end
end

printf("\nLeyendo emails de validacion de hard_ham...\n");
for i = 1:length(val_hard)
	printf("Leyendo el archivo hard_ham/%04i.txt\n", val_hard(i));
	fflush(stdout);
	buffer = sprintf("hard_ham/%04i.txt", i);
	file_contents = readFile(buffer);
	email = processEmail(file_contents);
	while ~isempty(email)
		[str, email] = strtok(email, [' ']);
		if isfield(vocabulario, str)
			xval_hard(i, vocabulario.(str)) = 1;
		endif
	end
end

printf("Calculo del modelo de SVM para la mejor C y la mejor sigma...\n");
model = svmTrain([x_hard;x_easy;x_spam], [y_hard;y_easy;y_spam], BEST_C, @(x1,x2) gaussianKernel(x1,x2,BEST_SIGMA));

printf("Validando resultado...\n");
prctj = sum(svmPredict(model, [xval_hard;xval_easy;xval_spam]) == [yval_hard;yval_easy;yval_spam])/total;

printf("El porcentaje de aciertos con esos datos de entrenamiento y validacion: %f\n", prctj);

