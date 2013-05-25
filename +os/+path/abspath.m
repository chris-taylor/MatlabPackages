function path = abspath(path)
% ABSPATH Return a normalized, absolute version of the pathname PATH.
path = os.path.normpath(fullfile(pwd, path));