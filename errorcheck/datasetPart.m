function [Xtrain, Xval, Xtest, ytrain, yval, ytest] = datasetPart(X, y, trainPrc, valPrc, testPrc)
	if(ceil(trainPrc+valPrc+testPrc) != 1)
		printf("ERROR: trainPrc, valPrc & testPrc must sum 1.\n");
	else
		XtrainL = (trainPrc)*rows(X);
		XvalL = (valPrc)*rows(X);
		XtestL = (testPrc)*rows(X);

		if(ceil(XtrainL)-XtrainL < 0.5) XtrainL = ceil(XtrainL);
		else XtrainL = floor(XtrainL);
		endif 

		if(ceil(XvalL)-XvalL < 0.5) XvalL = ceil(XvalL);
		else XvalL = floor(XvalL);
		endif

		if(ceil(XtestL)-XtestL < 0.5) XtestL = ceil(XtestL);
		else XtestL = floor(XtestL);
		endif

		Xtrain = X(1:XtrainL,:);
		Xval = X(XtrainL+1:(XtrainL+XvalL),:);
		Xtest = X((XtrainL+1+XvalL):(XtrainL+XvalL)+XtestL,:);
		ytrain = y(1:XtrainL,:);
		yval = y(XtrainL+1:(XtrainL+XvalL),:);
		ytest = y((XtrainL+1+XvalL):(XtrainL+XvalL)+XtestL,:);
	endif
endfunction
