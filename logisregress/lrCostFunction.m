function [J, grad] = lrCostFunction(theta, x, y, lambda)
	m = rows(x);
	grad = ((1/m) * transpose(sum( ( sigmoide(theta,x) - y ) .* x))) + (lambda/m).*theta;
	J = ((1/m) * sum( -y .* log(sigmoide(theta,x)) - (1-y) .* log(1 - sigmoide(theta,x)) )) + (lambda/(2*m)) * sum(theta.^2);
endfunction
