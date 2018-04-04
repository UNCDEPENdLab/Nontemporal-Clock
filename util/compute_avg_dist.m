%https://www.mathworks.com/matlabcentral/answers/44782-pairwise-difference-between-values-of-a-vector
function [avgprobdist, dv] = compute_avg_dist(v)

% Number of elements
nv = numel(v);
% Absolute pairwise differences
dv = abs(bsxfun(@minus,v,v'));
% Sum the differences (This double-counts, but we'll double-count the denominator, too)
sdtv = sum(dv(:));
% Number pairs (also double-counted)
np = nv^2 - nv;
% The mean
avgprobdist = sdtv/np;

end