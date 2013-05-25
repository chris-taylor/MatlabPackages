classdef PathWalker
   
    properties (Access = private)
        tovisit = java.util.LinkedList;
    end
    
    methods
        
        %===================
        % Constructor
        %===================
        
        function p = PathWalker(top)
            p.tovisit.add(top);
        end
        
        %===================
        % Iterable methods
        %===================
        
        function hn = hasNext(p)
            hn = ~p.tovisit.isEmpty;
        end
        
        function val = next(p)
            dirpath  = p.tovisit.pop;
            contents = dir(dirpath);
            
            val.dirpath   = dirpath;
            val.dirnames  = {};
            val.filenames = {};
            
            for ii = 1:length(contents)
                relpath = contents(ii).name;
                abspath = fullfile(dirpath, relpath);
                if exist(abspath,'dir') && ~strcmp(relpath,'.') && ~strcmp(relpath,'..')
                    val.dirnames{end+1} = abspath;
                    p.tovisit.add(abspath);
                elseif exist(abspath,'file')
                    val.filenames{end+1} = abspath;
                end
            end
        end
        
        %===================
        % Other methods
        %===================
        
        function remove(p,dirpath)
            p.tovisit.removeFirstOccurrence(dirpath);
        end
        
    end
    
end