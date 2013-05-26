classdef FifoQueue < containers.Queue
% QUEUE A first in/first out (FIFO) queue, backed by a Java LinkedList.

    properties (Access = private)
        queue;
    end
    
    methods (Access = public)
        
        function q = FifoQueue(varargin)
            q.queue = java.util.LinkedList;
            for ii = 1:length(varargin)
                q.queue.add(varargin{ii});
            end
        end
        
        %========================
        % Container methods
        %========================
        
        function res = contains(q,e)
            res = q.queue.contains(e);
        end
        
        function add(q,varargin)
            for ii = 1:length(varargin)
                q.queue.add(varargin{ii});
            end
        end
        
        function clear(q)
            q.queue.clear;
        end
        
        function res = isEmpty(q)
            res = q.queue.isEmpty;
        end
        
        function remove(q,e)
            i = q.queue.indexOf(e);
            if i > -1
                q.queue.remove(i);
            end
        end
        
        function sz = size(q)
            sz = q.queue.size;
        end
        
        function it = iterator(q)
            it = q.queue.iterator;
        end
        
        %========================
        % Convenience methods
        %========================
        
        function str = toString(q)
            str = char(q.queue.toString);
        end
        
        %========================
        % Queue methods
        %========================
        
        function push(q,e)
            q.queue.add(e);
        end
        
        function e = pop(q)
            e = q.queue.pop;
        end
        
        function e = peek(q)
            e = q.queue.peek;
        end
        
    end
    
    methods (Static)
        function newobj = new()
            newobj = containers.FifoQueue;
        end
    end
    
end