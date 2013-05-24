classdef File < handle & iterator.Iterable
    
    properties
        abspath = '';
        relpath = '';
        permission = '';
        fid
    end
    
    methods (Static)
       
        function f = open(filename, permission)
            
            % First open the file with the specified permission.
            if nargin == 1
                [fid, message] = fopen(filename);
            else
                [fid, message] = fopen(filename, permission);
            end
            
            if fid > -1
                % Read back the filename and permission that have been granted.
                [relpath, permission] = fopen(fid);
                % Find the absolute file path (bit of a hack)
                abspath = which(relpath);
            else
                error('file:File:CannotOpenFile', '%s: %s\n', message, filename);
            end
            
            % Create the file object
            f = file.File(fid, relpath, abspath, permission);
            
        end
        
    end
    
    methods (Access = public)
        
        %========================
        % File methods
        %========================
        
        function close(f)
            % CLOSE Close the file. A closed file cannot be read or written any more. Any operation that
            % requires the file be open will raise an exception after the file has been closed. Calling
            % close() more than once is allowed.
            if f.fid > -1
                fclose(f.fid);
                f.fid = -1;
            end
        end
        
        function isopen = isopen(f)
            % ISOPEN Returns true if the file is open, otherwise false.
            isopen = f.fid > -1;
        end
        
        function iseof = iseof(f)
            % ISEOF Returns true if the file pointer is at the end of the file.
            iseof = feof(f.fid);
        end
        
        function a = read(f, sz)
            % READ Read at most 'sz' bytes from the file.
            f.openchk;
            if nargin == 1
                a = fread(f.fid);
            else
                a = fread(f.fid, sz);
            end
            a = char(a');
        end
        
        function a = readline(f,sz)
            % READLINE Read an entire line from the file. Trailing newline characters are NOT kept
            % in the string. If an EOF is encountered then -1 is returned.
            f.openchk;
            if nargin == 1
                a = fgetl(f.fid);
            else
                a = fgetl(f.fid,sz);
            end
        end
        
        function a = readlines(f)
            % READLINES Read until EOF and return a cell array containing the lines read.
            f.openchk;
            a = {};
            line = f.readline;
            while ischar(line)
                a{end+1} = line; %#ok<AGROW>
                line = f.readline;
            end
        end
        
        function seek(f, offset, origin)
            % SEEK Set the file's current position. Sets the file's position indicator to the byte
            % with the specified offset relative to origin. Valid origin values are
            %
            %   'bof' or -1     Beginning of file
            %   'cof' or  0     Current position in file
            %   'eof' or  1     End of file
            %
            % The origin is optional, and defaults to 'bof'. There is no return value.
            f.openchk;
            if nargin == 2
                fseek(f.fid, offset, -1);
            else
                fseek(f.fid, offset, origin);
            end
        end
        
        function position = tell(f)
            % TELL Get the file position indicator. Position is indicated in bytes from the
            % beginning of the file.
            f.openchk;
            position = ftell(f.fid);
        end
        
        function write(f, s)
            % WRITE Write a string to the file.
            f.openchk;
            fwrite(f.fid, s);
        end
        
        function writelines(f, s)
            % WRITELINES Write a sequence of strings to the file. Currently, S must be a cell
            % array of strings. In the future I hope to make the function accept any iterable class
            % that returns strings. A newline character is added between each write.
            f.openchk;
            newline = os.newline;
            if isa(s, 'cell')
                for i = 1:length(s)
                    fwrite(f.fid, s{i});
                    fwrite(f.fid, newline);
                end
            elseif isa(s, 'char')
                for i = 1:size(s,1)
                    fwrite(f.fid, s(i,:));
                    fwrite(f.fid, newline);
                end
            elseif iterator.isIterable(s)
                while s.hasNext
                    fwrite(f.fid, s.next);
                    fwrite(f.fid, newline);
                end
            else
                error('file:File:NotIterable','Argument S must be a cell, char, or iterable')
            end
        end
        
        %========================
        % Iterable methods
        %========================
        
        function line = next(f)
            line = f.readline;
            if ~ischar(line)
                error('file:File:EOFError','Reached end of file')
            end
        end
        
        function hasNext = hasNext(f)
            hasNext = ~f.iseof;
        end
        
    end
    
    methods (Access = private)
       
        function f = File(fid, relpath, abspath, permission)
            f.fid = fid;
            f.relpath = relpath;
            f.abspath = abspath;
            f.permission = permission;
        end
        
        function delete(f)
            f.close;
        end
        
        function openchk(f)
            % OPENCHK Throws an error if the file is not open.
            if ~f.isopen
                error('file:File:FileNotOpen','File is not open')
            end
        end
        
    end
    
end
