function [] = learningCurve(X,y,lambda,Xval,yval,MaxConj)
    #m = rows(X); 
    for i = 1:MaxConj
        subconjuntoX = X(1:i,:);
        subconjuntoY = y(1:i,:);
	printf("Training the subgroup...");
        theta_final = training(subconjuntoX, subconjuntoY, lambda);
        errores(i,1) = lrCostFunction(theta_final,subconjuntoX,subconjuntoY,lambda);
        errores_val(i,1) = lrCostFunction(theta_final,Xval,yval,lambda);
    end
    errores(isnan(errores))=0;
    errores_val(isnan(errores_val))=0;
    #for i = 1:MaxConj
    #    fprintf("Mistake for the training example %i:\n",i);
    #    fprintf("Training: %f   Validation: %f\n",errores(i,1),errores_val(i,1));
    #end
    plot([1:MaxConj], errores, ";training;", [1:MaxConj], errores_val, ";validation;");
    title("Learning Curve");
    xlabel("Numero de ejemplos");
    ylabel("Error");
    input("Press intro to continue.\n");
endfunction;
