function W = pesosAleatorios(L_in, L_out)
	#W = (L_out)x(1+L_in)
	#Random numbers between A and B numbers : A + (B-A)*rand(rows,columns);
	ep_ini = sqrt(6)/sqrt(L_in+L_out);
	W = ((ep_ini+ep_ini)*rand(L_out,1+L_in))-ep_ini ;
endfunction
