classdef Datetime < datetime.Date
   
    properties (SetAccess = private)
        hour = 0;
        minute = 0;
        second = 0;
        millisecond = 0;
    end
    
    methods
        function obj = Datetime(y, m, d, h, mn, s, ms)
            
            % Initialize Date fields
            obj = obj@datetime.Date(y, m, d);
            
            % Datetime fields
            if nargin > 3
                if h < 0 || h > 23
                    error('datetime:Datetime:BadHour', 'Hour must be between 0 and 23')
                end
            else
                h = 0;
            end
            if nargin > 4
                if mn < 0 || mn > 59
                    error('datetime:Datetime:BadMinute', 'Minute must be between 0 and 59')
                end
            else
                mn = 0;
            end
            if nargin > 5
                if s < 0 || s > 59
                    error('datetime:Datetime:BadSecond', 'Second must be between 0 and 59')
                end
            else
                s = 0;
            end
            if nargin > 6
                if ms < 0 || ms > 999
                    error('datetime:Datetime:BadMilli', 'Milliseconds must be between 0 and 999')
                end
            else
                ms = 0;
            end
            
            obj.hour = h;
            obj.minute = mn;
            obj.second = s;
            obj.millisecond = ms;
            
        end
        
        function d = asDatenum(obj)
            d = datenum(obj.year, obj.month, obj.day, ...
                obj.hour, obj.minute, obj.second) + ...
                obj.millisecond / (24 * 60 * 60 * 1000);
        end
        
        function [y, m, d, h, mn, s, ms] = asDatevec(obj)
            if nargout < 1
                y = [obj.year, obj.month, obj.day, ...
                    obj.hour, obj.minute, obj.second];
            else
                y = obj.year;
                m = obj.month;
                d = obj.day;
                h = obj.hour;
                mn = obj.minute;
                s = obj.second;
                ms = obj.millisecond;
            end
        end
        
        function disp(obj)
            str = sprintf('datetime.Datetime(%d,%d,%d,%d,%d,%d,%d)',...
                obj.year,obj.month,obj.day,obj.hour,obj.minute,...
                obj.second,obj.millisecond);
            disp(str);
        end
    end
    
end