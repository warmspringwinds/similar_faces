function N = normalize_vector(I, l, h)
    minI = min(I);
    maxI = max(I);
    %% normalize between [0...1]
    N = I - minI;
    N = N ./ (maxI - minI);
    %% scale between [l...h]
    N = N .* (h-l);
    N = N + l;
end