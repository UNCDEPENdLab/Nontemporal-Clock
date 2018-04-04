function H = ventropy(rewprobs, normalize)

if nargin < 2, normalize=1; end %whether to put entropy in 0..1 units based on maximum possible entropy: log2(#options)
rewprobs = rewprobs(rewprobs > 0); %don't include zero prob options (if any)

pnorm = rewprobs/sum(rewprobs); %normalize probabilities to 1

H = sum(-pnorm .* log2(pnorm));
if normalize, H = H/log2(length(pnorm)); end

end