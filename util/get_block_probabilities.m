function [probs, H] = get_block_probabilities(num_segments, minprob, maxprob, avgprob, enforce_entropy)
if nargin < 2, minprob=0.35; end
if nargin < 3, maxprob=0.65; end
if nargin < 4, avgprob=0.5; end
if nargin < 5, enforce_entropy=false; end

getrand=0; %whether to sample a vector randomly. Tabling for now until we want to manipulate entropy directly

if ~getrand
    %used a fixed vector across blocks
    if num_segments == 4
        %so: best 4 is exactly the same for best 4. Since it is a smaller action space, there is a shelf.
        %suggests just using the best across runs and permuting it.
        best4 = [ 0.4300    0.5600    0.3600    0.6500 ];
        
        probs = best4(randperm(length(best4)));
    elseif num_segments == 8
        %best fixed 8 with ~50% relative entropy and minimum sd of differences across adjacent pairs (maximize equal spacing)
        best8 =  [ 0.6400    0.3400    0.4600    0.3800    0.4200    0.5600    0.6900    0.5100 ];
        
        probs = best8(randperm(length(best8)));
    end
else
    
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
        
        if ~enforce_entropy
            entropy_satisfied=true; %don't worry about chopping the entropy
        elseif num_segments == 4 && minprob == 0.35 && maxprob == 0.65 && avgprob == 0.5
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

H = ventropy(probs, true); %calculate value entropy

end