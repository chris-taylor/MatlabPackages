classdef Queue < containers.Container & iterator.Iterable
   
    methods (Abstract)
        
        %========================
        % Queue methods
        %========================
        
        push(q,e)
        e = pop(q)
        e = peek(q)
        
    end
    
    methods
        
        %========================
        % Iterable methods
        %========================
        
        function res = hasNext(q)
            res = not(q.isEmpty);
        end
        
        function e = next(q)
            e = q.pop;
        end
        
    end
    
end