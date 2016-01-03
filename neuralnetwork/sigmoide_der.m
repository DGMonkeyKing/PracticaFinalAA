function [sig] = sigmoide_der(theta, X)
	sig = sigmoide(theta,X).*(1-sigmoide(theta,X));
endfunction
