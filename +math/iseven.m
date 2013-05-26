function iseven = iseven(x)
% ISEVEN Return a logical array indicating whether the elements of the
% array X are even.
iseven = ~rem(x,2);