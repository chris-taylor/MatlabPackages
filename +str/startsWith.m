function res = startsWith(s, prefix)
%STARTSWITH Return true if string starts with the prefix, otherwise return false.
res = strncmp(s, prefix, length(prefix));