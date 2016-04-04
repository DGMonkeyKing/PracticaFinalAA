function [X_norm, mu, sigma] = normalizaAtributo(X)
    mu = mean(X);
    sigma = std(X);
    media = ones(rows(X), columns(X));
    media = mu .* media;
    desvi = ones(rows(X), columns(X));
    desvi = sigma .* desvi;
    X_norm = (X .- media) ./ desvi;
endfunction
