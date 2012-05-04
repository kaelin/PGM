function [LAYOUT] = vlayout(vector)
%VLAYOUT Return a rectangular matrix of the indices of vector.
%   This is intended for laying out subplots so that they fit nicely on a
%   wide-screen display. If the LAYOUT matrix has more elements than the
%   input vector does, the extras are filled with zeros.
%
%   Example:
%   
%     >> vlayout(1:13)
% 
%     ans =
% 
%          1     2     3     4     5     6     7
%          8     9    10    11    12    13     0
%
%   Copyright © 2012 Kaelin Colclasure, all rights reserved.

len = length(vector);
if len <= 5
    LAYOUT = 1:len;
    return;
end

while isprime(len)
    % Round up to a number we can get more than one factor from
    len = len + 1;
end

unused = len - length(vector);
vector = 1:len;
vector(end - (unused - 1):end) = 0;

factors = factor(len);
split = floor(length(factors) / 2);
dims = [prod(factors(split + 1:end)) prod(factors(1:split))];

LAYOUT = reshape(vector, dims)';

end
