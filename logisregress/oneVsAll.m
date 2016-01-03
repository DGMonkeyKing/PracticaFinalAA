function [all_theta] = oneVsAll(x, y, num_etiquetas, lambda)
	initial_theta = zeros(columns(x), num_etiquetas);
        
	options = optimset('GradObj','on','MaxIter',50);
	for i = 1:num_etiquetas
		theta(:,i) = fmincg (@(t)(lrCostFunction(t , x,  (y == i-1) , lambda)) ,initial_theta(:,i) , options);
	end
	all_theta = theta;
endfunction