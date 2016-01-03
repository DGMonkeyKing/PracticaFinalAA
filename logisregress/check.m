function prctj = check(x, y, all_theta) 
	m = rows(x);
	n = columns(all_theta);
	resul = x*all_theta;
  idx = (resul(:,2) >= resul(:,1)); #ITS BETTER A FALSE RIGHT THAN A FALSE FALSE IN THIS CASE
	cont = sum(idx==y);
	prctj = (cont*100)/m;
endfunction
