function vfactor(F)
%VFACTOR Show a figure with tables of the factors in the input vector F.
%   This is useful for visually examining and comparing lists of factors.
%   The factors must be in the format used in the Stanford PGM class, and
%   this also relies on the IndexToAssignment function provided with the
%   homework assignments.
%   
%   Copyright © 2012 Kaelin Colclasure, all rights reserved.

f = figure;
LAYOUT = flipud(vlayout(F)); % flipud b/c origin is at bottom left

NC = [1 1 1; .9 1 1];
UC = [1 1 1; 1 .9 .9];

[nrow, ncol] = size(LAYOUT);
for r = 1:nrow
    for c = 1:ncol
        k = LAYOUT(r, c);
        if k == 0
            return;
        end
        n = length(F(k).val);
        m = length(F(k).var);
        D = zeros(n, m + 1);
        
        for i = 1:n
            D(i, :) = [IndexToAssignment(i, F(k).card) F(k).val(i)];
        end
        
        if abs(sum(F(k).val) - 1) > 0.00001
            NCorUC = UC;
        else
            NCorUC = NC;
        end
        
        uitable(f, 'Data', D, 'ColumnName', [num2cell(F(k).var) 'weight'], ...
            'ColumnWidth', [repmat({25}, 1, m) 'auto'], 'RowName', [], ...
            'BackgroundColor', NCorUC, ...
            'Units', 'normalized', 'Pos', [(c-1)/ncol (r-1)/nrow 1/ncol 1/nrow]);
    end
end

end

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
