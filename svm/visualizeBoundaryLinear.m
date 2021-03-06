function visualizeBoundaryLinear(X, y, model)
%VISUALIZEBOUNDARYLINEAR plots a linear decision boundary learned by the
%SVM
%   VISUALIZEBOUNDARYLINEAR(X, y, model) plots a linear decision boundary 
%   learned by the SVM and overlays the data on it

w = model.w;
b = model.b;
xp = linspace(min(X(:,1)), max(X(:,1)), 100);
if w(2) == 0
	yp = 0;
else
	yp = - (w(1)*xp + b)/w(2);
end

plotData(X, y);
hold on;
plot(xp, yp, '-b'); 
hold off

end
