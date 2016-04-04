printf("\nDETECCION DE SPAM\n");

entr_easy = [1,2,3,4,5,6,7,8,9,10,40,90,120,300,450,709,900,1400,1925,2045,2551];
entr_hard = [3,67,89,100,104,150,180,199,201,210,232,249];
entr_spam = [5,9,13,17,20,24,27,36,69,90,100,250,490,494];
val_easy = [21,22,25,27,28,56,58,67,340,467,678,2000,2001];
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
