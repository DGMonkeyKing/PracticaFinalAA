function [matriz] = rolling(theta1, theta2)
	r1 = rows(theta1);
	r2 = rows(theta2);
	c1 = columns(theta1);
	c2 = columns(theta2);
	Theta1 = reshape(theta1,r1*c1,1);
	Theta2 = reshape(theta2,r2*c2,1);
	matriz = [Theta1; Theta2];
endfunction