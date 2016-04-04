function prctj = checkNeural(x, y, grad1, grad2, entradas, capa_oculta, salidas) 
	a1 = ones(rows(x), entradas+1);
  a2 = ones(rows(x), capa_oculta+1);
  a3 = ones(rows(x), salidas);

X = [ones(rows(x),1),x];

  a1(:,[2:entradas+1]) = X;
  a2(:,[2:capa_oculta+1]) = sigmoide(grad1',a1);
  a3 = sigmoide(grad2',a2);
  
  idx = (a3(:,2) >= a3(:,1)); #ITS BETTER A FALSE RIGHT THAN A FALSE FALSE IN THIS CASE
	cont = sum(idx==y);
	prctj = (cont*100)/rows(x);
endfunction
