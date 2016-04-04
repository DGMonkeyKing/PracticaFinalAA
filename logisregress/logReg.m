function [theta, cost] = logReg(x, y, lambda)
  theta_inicial = zeros(columns(x)+1, 1);
  opciones = optimset("GradObj","on","MaxIter",400);
  [theta, cost] = fminunc(@(t)(lrCostFunction(t, x, y, lambda)), theta_inicial , opciones);
endfunction
