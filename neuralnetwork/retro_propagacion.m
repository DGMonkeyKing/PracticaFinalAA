function [theta1_grad, theta2_grad] = retro_propagacion(x, y, theta1, theta2, num_etiquetas, lambda)
	
	yt = zeros(rows(y), num_etiquetas);
	for i = 1:rows(yt)
		yt(i,y(i,1)) = 1;
	end,	
	
	m = rows(x);
	theta1_grad = zeros(size(theta1));
	theta2_grad = zeros(size(theta2));

	for i = 1:m
		a1 = [1;x(i,:)'];
		a2 = [1;sigmoide(a1,theta1)];
		a3 = sigmoide(a2,theta2);

		d3 = (a3 - yt(i,:)');

		v = (theta2'*d3);
	  
    d2 = v([2:rows(v)],1).*sigmoide_der(a1,theta1);

		theta1_grad = theta1_grad + d2*a1';
		theta2_grad = theta2_grad + d3*a2';
	end,
	theta1_grad = theta1_grad ./ m;	
	theta2_grad = theta2_grad ./ m;

	theta1_grad(:,[2:end]) += (lambda/m) * theta1(:,[2:end]);
	theta2_grad(:,[2:end]) += (lambda/m) * theta2(:,[2:end]); 
	
endfunction
