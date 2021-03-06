function [J, grad] = lrCostFunction(theta, x, y, lambda)
	m = rows(x);
    	X = [ones(m,1),x];
	grad = ((1/m) .* transpose(sum( ( sigmoide(theta,X) .- y ) .* X))) + (lambda/m).*theta;
	#grad(1,1) = ((1/m) .* transpose(sum( ( sigmoide(theta,x) .- y ) .* x(:,1))));
	J = ((1/m) * sum( -y .* log(sigmoide(theta,X)) .- (1-y) .* log(1 - sigmoide(theta,X)))) + (lambda/(2*m)) * sum(theta.^2);
endfunction
