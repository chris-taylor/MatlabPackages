function username = username()
% USERNAME Return the current user name.
if ispc
    username = getenv('USERNAME');
elseif isunix || ismac
    username = getenv('USER');
end