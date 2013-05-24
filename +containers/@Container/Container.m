classdef Container
    
    methods (Abstract)
        
        %===================
        % Container methods
        %===================
        
        % Ensure that the container contains the element e
        add(obj,e)
        
        % Remove a single instance of the specified element from the container
        remove(obj,e)
        
        % Return 'true' if the container contains the specified element
        res = contains(obj,e)
        
        % Return 'true' if the container contains no elements
        isEmpty(obj)
        
        % Return the number of elements in the container
        size(obj)
        
        % Return an iterator over the objects in the container. This is mainly used to implement
        % the class methods 'filter', 'map', 'traverse' and 'traverse1', however it may sometimes be
        % useful to users of the class, so it is exposed here.
        iterator(obj)
        
    end
    
    methods (Access = public)
        
        function filter(obj, pred)
            % FILTER Filters the elements of the container that do not satisfy the supplied
            % predicate.
            it = obj.iterator;
            while it.hasNext
                if ~pred(it.next)
                    it.remove;
                end
            end
        end
        
        function map(obj, fun)
            % MAP Applies the supplied function to every object in the container.
            it = obj.iterator;
            while it.hasNext
                e = it.next;
                it.remove;
                obj.add(fun(e));
            end
        end
        
        function x = traverse(obj, fun, x)
            % TRAVERSE Traverses the container, applying a folding function FUN as it goes.
            % TODO: Better documentation!
            it = obj.iterator;
            if nargout == 1
                while it.hasNext
                    x = fun(x,it.next);
                end
            else
                while it.hasNext
                    fun(x,it.next);
                end
            end
        end
        
        function x = traverse1(obj, fun)
            % TRAVERSE1 Simplified traverse which doesn't require an initial object (fails if the
            % container is empty.)
            if obj.isEmpty
                error('containers:Collection:traverse1:EmptyCollection','Collection is empty!')
            else
                it = obj.iterator;
                x  = it.next;
                while it.hasNext
                    x = fun(x,it.next);
                end
            end
        end
        
    end
    
end