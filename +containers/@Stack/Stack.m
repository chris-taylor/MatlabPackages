classdef Stack < containers.Queue
% STACK A last in/first out (LIFO) stack, backed by a Java Stack.

    properties (Access = private)
        stack;
    end
    
    methods (Access = public)
        
        function s = Stack(varargin)
            s.stack = java.util.LinkedList;
            for ii = 1:length(varargin)
                s.stack.add(varargin{ii});
            end
        end
        
        %========================
        % Container methods
        %========================
        
        function res = contains(s,e)
            res = s.stack.contains(e);
        end
        
        function add(s,varargin)
            for ii = 1:length(varargin)
                s.stack.add(varargin{ii});
            end
        end
        
        function clear(s)
            s.stack.clear;
        end
        
        function res = isEmpty(s)
            res = s.stack.isEmpty;
        end
        
        function remove(s,e)
            i = s.stack.indexOf(e);
            if i > -1
                s.stack.remove(i);
            end
        end
        
        function sz = size(s)
            sz = s.stack.size;
        end
        
        function it = iterator(s)
            it = s.stack.iterator;
        end
        
        %========================
        % Convenience methods
        %========================
        
        function str = toString(s)
            str = char(s.stack.toString);
        end
        
        %========================
        % stack methods
        %========================
        
        function push(s,e)
            s.stack.add(e);
        end
        
        function e = pop(s)
            e = s.stack.pop;
        end
        
        function e = peek(s)
            e = s.stack.peek;
        end
        
    end
    
end