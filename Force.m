classdef Force
    properties
        fx
        fy
        fz
    end
    
    methods
        function obj = Force(fx, fy, fz)
            if nargin == 3
                obj.fx = fx;
                obj.fy = fy;
                obj.fz = fz;
            end
        end
        
        function magnitude = getMagnitude(obj)
            magnitude = norm([obj.fx, obj.fy, obj.fz]);
        end
    end
end
