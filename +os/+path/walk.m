function walk(path, visit, arg)
% WALK Call the function VISIT with arguments (ARG, DIRNAME, NAMES) for each directory in the
% directory tree rooted at PATH (including PATH itself, if it is a directory). The argument DIRNAME
% specifies the visited directory, the argument NAMES lists the files in the directory (from
% os.listdir(DIRNAME)). The VISIT function may modify NAMES to influence the set of directories
% visited below DIRNAME, e.g. to avoid visiting certain parts of the tree.