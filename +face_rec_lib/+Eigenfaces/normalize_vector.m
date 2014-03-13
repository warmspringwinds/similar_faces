function N = normalize_vector(I, l, h)
    % Use it when you want to visualize eigenfaces. This function scales it
    % to be displayed.
    minI = min(I);
    maxI = max(I);
    %% normalize between [0...1]
    N = I - minI;
    N = N ./ (maxI - minI);
    %% scale between [l...h]
    N = N .* (h-l);
    N = N + l;
end