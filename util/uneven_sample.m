function svec = uneven_sample(rewprobs)
    if length(rewprobs) == 4
        freqs = [2 1 1 0];
    elseif length(rewprobs) == 8
        freqs = [3 2 1 1 1];
    else
        error('only support 4 or 8 segments at the moment.');
    end
    
    %do not allow the best option to be chosen the most
    nobest=false;
    [~, posmax] = max(rewprobs);
    while ~nobest
        tochoose = randsample(1:length(rewprobs), length(freqs), false);
        svec = repelem(tochoose, freqs);
        svec = svec(randperm(length(svec))); %shuffle order
        if tochoose(1) ~= posmax, nobest=true; end
    end 
end