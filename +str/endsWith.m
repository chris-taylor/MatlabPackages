function res = endsWith(s, suffix)
%ENDSWITH Return true if the string ends with suffix, else return false.
if length(s) < length(suffix)
    res = false;
else
    res = strcmp(s(end-n+1:end), suffix);
end