function [ FP ] = FactorPermutation( F, var )
%FACTORPERMUTATION Permute the variable order in a factor.
%   This fuction will re-arrange the variables in factor F into the order
%   specified in the variable name vector var. The factor must be in the
%   format used in the Stanford PGM class, and this function also relies on
%   the IndexToAssignment and AssignmentToIndex functions proviede with the
%   homework assignments
%   
%   Copyright © 2012 Kaelin Colclasure, all rights reserved.

FP.var = var;
[ok, cmap] = ismember(var, F.var);
assert(all(ok), 'Factor does not contain all of the specified variables');
FP.card = F.card(cmap);
[ok, vmap] = ismember(F.var, var);
assert(all(ok), 'Factor contains more variables than were specified');
assignments = IndexToAssignment(1:prod(FP.card), FP.card);
assignments = assignments(:, vmap);
permutation = AssignmentToIndex(assignments, F.card);
FP.val = F.val(permutation);
% vfactor([F, FP]);

end
