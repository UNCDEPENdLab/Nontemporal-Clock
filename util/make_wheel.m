% load('wheel360')
fullcolormatrix = zeros(360,3);
for j = 1:6
    for i = 1:60
        k = i*j;
        if i < 31
            fullcolormatrix(k,:) = zeros(1,3);
        else
            fullcolormatrix(k,:) = repmat(255,1,3);
        end
    end
end
fullcolormatrix