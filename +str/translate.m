function s = translate(s, table)
% TRANSLATE Translate the characters in 's' using 'table', which must be a
% 256-character string giving the translation for each character value,
% indexed by its ordinal.

if length(table) ~= 256
    error('str:translate:badTable', 'TABLE must be a char array with 256 entries')
end

s = table(s);