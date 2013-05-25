function path = expandvars(path)
% EXPANDVARS Return the argument with the argument variables expanded.
% Substrings of the form ${name} are replaced with the value of the
% environment variable name. Malformed variable names and references to
% non-existing variables are left unchanged.

toks = regexp(path, '\${(\w+)}', 'tokens');

vars = [toks{:}];
vals = cell(1, length(vars));

for ii = 1:length(vars)
    vals{ii} = getenv(vars{ii});
end

for ii = 1:length(vars)
    path = regexprep(path, ['\${' vars{ii} '}'], vals{ii});
end
    