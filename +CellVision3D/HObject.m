classdef HObject < handle
    %base class template for everything
    properties
    end
    
    methods
        % parameter setter
        function setParam(obj,varargin)
            n=floor(nargin/2);
            for i=1:n
                obj.(varargin{2*i-1})=varargin{2*i};
            end
        end
        

        
        
    end
    
    methods (Static)
                % search for string
        function found=check(strings,string)
            found=false;
            for i=1:length(strings)
                if strcmp(strings{i},string)
                    found=true;
                    return;
                end
            end
        end
    end
end    
