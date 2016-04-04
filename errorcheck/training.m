function theta = training(X, y, lambda)
    theta_inicial = zeros(columns(X)+1,1);
    options = optimset('MaxIter', 50, 'GradObj', 'on');
    coste = @(p) lrCostFunction(p, X, y, lambda);
    theta = fmincg(coste, theta_inicial, options);
endfunction;
