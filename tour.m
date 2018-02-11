classdef tour
    %'tour' Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
      cities;
      size;
      cost;
    end
    
    methods
        function obj = tour(tr)
            if nargin>0
                if isnumeric(tr)
                    obj.cities = tr;
                    obj.cities = [obj.cities;obj.cities(1,:)];
                    obj.size = length(tr)+1;
                    obj.cost = cal_cost(obj);
                else error('dTypeError: values must be numeric');
                end
            end
        end
        
        function obj = recost(obj)
            cst = 0;
            for i=1:obj.size-1
                cst = cst + pdist2(obj.cities(i,:),obj.cities(i+1,:));
            end
            obj.cost=cst;
            
            %cst = cst + pdist2(obj.cities(obj.size,:),obj.cities(1,:));
        end
        
    end
    
end

function cst = cal_cost(obj)
    cst = 0;
    for i=1:obj.size-1
        cst = cst + pdist2(obj.cities(i,:),obj.cities(i+1,:));
    end
end