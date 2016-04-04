function theta = trainingRN(X, y, lambda, num_entradas, num_ocultas, num_etiquetas)
    theta1 = pesosAleatorios(num_entradas, num_ocultas);
    theta2 = pesosAleatorios(num_ocultas, num_etiquetas);
    options = optimset('MaxIter', 50, 'GradObj', 'on');
    coste = @(p) costeRN(p, num_entradas, num_ocultas, num_etiquetas , X, y, lambda);
    matriz_enrollada = rolling(theta1,theta2);
    theta = fmincg(coste, matriz_enrollada, options);
endfunction;
