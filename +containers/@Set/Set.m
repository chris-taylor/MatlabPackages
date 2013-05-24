classdef Set < containers.Container
% SET A mathematical set, backed by a Java HashSet.

    properties (Access = private)
        set_
    end
    
    methods (Access = public)
       
        function obj = Set(varargin)
            obj.set_ = java.util.HashSet;
            for i = 1:length(varargin)
                obj.set_.add(varargin{i});
            end
        end
        
        function res = contains(obj,x)
            res = obj.set_.contains(x);
        end
        
        function add(obj,varargin)
            for i = 1:length(varargin)
                obj.set_.add(varargin{i});
            end
        end
        
        function clear(obj)
            obj.set_.clear();
        end
        
        function res = isEmpty(obj)
            res = obj.set_.isEmpty();
        end
        
        function remove(obj,varargin)
            for i = 1:length(varargin)
                obj.set_.remove(varargin{i});
            end
        end
        
        function res = size(obj)
            res = obj.set_.size();
        end
        
        function res = values(obj)
            res = cell(1,obj.size);
            itr = obj.set_.iterator();
            n = 0;
            while itr.hasNext();
                n = n + 1;
                res{n} = itr.next();
            end
        end
        
        function itr = iterator(obj)
            itr = obj.set_.iterator();
        end
        
        function disp(obj)
            disp(obj.set_.toString());
        end
        
    end
    
end