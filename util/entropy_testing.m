%thinking: since we currently don't manipulated entropy (e.g., low, medium, high), we should probably be careful not to allow
%occasional contingencies that fall at the tails of the entropy sampling distribution. On the low entropy side, these have an
%overrepresentation of the tails (e.g., 35 and 65) and less in the middle. On the high entropy side, the tails are not expressed and we have
%a lot of options in the middle. Could be cool once we manipulate this, but in the mean time, my thinking is to discard a candidate vector
%if it falls at the tails of the entropy distribution < 5th %ile or > 95 %ile

%compute population distribution of entropy
nreps=100000;
num_segments=4;
y=NaN(nreps,1);
p=NaN(nreps, num_segments);
for k=1:nreps
  %[p(k,:), y(k)] = get_block_probabilities(8, 0.4, 0.6, 0.5); %this yields an odd distribution of contingencies and entropy is non-Gaussian
  [p(k,:), y(k)] = get_block_probabilities(num_segments, 0.35, 0.65, 0.5); %entropy becomes beautifully Gaussian
end

%notes about 35--65 8 segments: 
[qs] = quantile(y, [.05 .5 .95])

hist(y)
lowe = p(find(y < qs(1)),:);
lowe = lowe(:); %flatten
hist(lowe) %easy contingencies pull at the tails

highe = p(find(y > qs(3)),:);
highe = highe(:);
hist(highe)

mide = p(find(y > qs(1) & y < qs(3)),:);
mide = mide(:);
hist(mide)

%compute average pairwise differences among probabilities in a contingency
mide = p(find(y > qs(1) & y < qs(3)),:);

%for 35--65
dists = zeros(size(mide,1), 1);
for i = 1:size(dists,1)
dists(i) = compute_avg_dist(mide(i,:));
end

hist(dists)

%[d, pairx] = compute_avg_dist(mide(1,:));
%hist(pairx(find(tril(pairx,-1))))

%entropy distribution for 35--65 50% avg 8 segments
% 
% [qs] = quantile(y, [.05 .5 .95])
% 
% qs =
% 
%          0.988650805863917         0.992503879524424         0.996053423084588

%mean pairwise distance between segments is .11199

%entropy distribution for 35--65 50% avg 4 segments
% [qs] = quantile(y, [.05 .5 .95])
% 
% qs =
% 
%          0.979818835167326         0.989365268662485         0.997594536965164

