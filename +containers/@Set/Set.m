classdef Set < containers.Container
% SET A mathematical set, backed by a Java HashSet. It implements the
% Container abstract class.

    properties (Access = private)
        set
    end
    
    methods (Access = public)
       
        function obj = Set(varargin)
            obj.set = java.util.HashSet;
            for i = 1:length(varargin)
                obj.set.add(varargin{i});
            end
        end
        
        %========================
        % Container methods
        %========================
        
        function res = contains(obj,x)
            res = obj.set.contains(x);
        end
        
        function add(obj,varargin)
            for i = 1:length(varargin)
                obj.set.add(varargin{i});
            end
        end
        
        function clear(obj)
            obj.set.clear();
        end
        
        function res = isEmpty(obj)
            res = obj.set.isEmpty();
        end
        
        function remove(obj,varargin)
            for i = 1:length(varargin)
                obj.set.remove(varargin{i});
            end
        end
        
        function res = size(obj)
            res = obj.set.size();
        end
        
        function itr = iterator(obj)
            itr = obj.set.iterator();
        end
        
        %========================
        % Convenience methods
        %========================
        
        function str = toString(obj)
            str = char(obj.set.toString);
        end
        
    end
    
end