function prctj = check(x, y, theta) 
	resul = sigmoide(theta, x);
  m = length(resul);
	right = 0;
	for i=1:m
		if(resul(i,1)>=0.5 && y(i,1)==1.0) right++; endif; ##ITS BETTER A FALSE TRUE THAN A FALSE FALSE
		if(resul(i,1)<0.5 && y(i,1)==0.0) right++; endif;
	end,
	prctj = (right*100)/m;
endfunction
