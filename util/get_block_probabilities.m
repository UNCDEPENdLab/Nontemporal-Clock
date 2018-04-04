function [probs, H] = get_block_probabilities(num_segments, minprob, maxprob, avgprob)
if nargin < 2, minprob=0.35; end
if nargin < 3, maxprob=0.65; end
if nargin < 4, avgprob=0.5; end

entropy_satisfied = false;
while ~entropy_satisfied
    
    %generate a vector of num_segments reward probabilities in which the average probability is matched
    probs = zeros(num_segments,1);
    
    %brute force runs much faster (and don't need to get into machine tolerance) if we sample a vector of discrete probabilities
    possible_vals = minprob:.01:maxprob;
    while mean(probs) ~= avgprob %if using truly random numbers, need to do abs(mean(probs) - avgprob) < .005 or something
        probs=randsample(possible_vals, num_segments, false); %randomly sample without replacement
        %mean(probs);
        %probs = minprob + (maxprob - minprob)*rand(num_segments,1);
    end
    
    H = ventropy(probs, true); %calculate value entropy
    
    if num_segments == 4 && minprob == 0.35 && maxprob == 0.65 && avgprob == 0.5
        %look at entropy_testing.m script for details
        mine=0.979818835167326; %5th percentile
        maxe=0.997594536965164; %95th percentile
        if H > mine & H < maxe, entropy_satisfied=true; end
    elseif num_segments == 8 && minprob == 0.35 && maxprob == 0.65 && avgprob == 0.5
        %look at entropy_testing.m script for details
        mine=0.988650805863917; %5th percentile
        maxe=0.996053423084588; %95th percentile
        if H > mine & H < maxe, entropy_satisfied=true; end
    else
        entropy_satisfied = true; %skip this check if we haven't pre-computed the entropy distribution
    end
    
end

end