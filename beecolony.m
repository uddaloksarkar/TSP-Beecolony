classdef beecolony
   
    properties
        colonysize;
        dimension;
        colony;
        employed;
        onlookers;
        scout;
    end
    
    methods
        function obj = beecolony(instance, colonysize)
            sz = length(instance);
            obj.colonysize = colonysize;
            obj.dimension = sz;
            obj.colony = [];
            for i=1:colonysize
                obj.colony = [obj.colony tour(instance(randperm(obj.dimension),:))];
            end
        end
        
        function obj = sendemployed(obj)
            obj.employed = obj.colony;
        end
        
        function obj = sendonlookers(obj)
            cost = [];
            for i = 1:obj.colonysize
                cost(i) = obj.employed(i).cost;
            end
            probability = cost/sum(cost);%probability of *not* getting selected 
            probability = (probability - min(probability))/(max(probability) - min(probability)); %scaling onto [0,1]
            obj.onlookers = [];
            obj.scout = [];
            for i=1:obj.colonysize
                r = rand();    
                if r>probability(i)
                    %probability based determination of onlookers
                    obj.onlookers = [obj.onlookers obj.employed(i)];
                else obj.scout=[obj.scout obj.employed(i)]; %failed bees turned into scouts
                end
            end
        end
        
        function obj = sendscouts(obj)
            ln = length(obj.scout);
            instance = obj.colony(1).cities;
            obj.scout = [];
            for i=1:ln
                obj.scout = [obj.scout tour(instance(randperm(obj.dimension),:))];
            end
        end
        
        function obj = waggledance(obj)
            obj.colony = [obj.onlookers obj.scout];
        end
        
        function obj = updt_employed(obj,string)
            for i =1:obj.colonysize
                obj.employed(i) = local_search(obj.employed(i),string);
            end
        end
        
    end
    
end

function solution = local_search(solution, search_algorithm)
    if nargin>0
        if nargin<2
            search_algorithm = 'two_opt'; %default algorithm
        end
        if strcmp(search_algorithm, 'two_opt')
            solution = two_opt(solution);
        end
        if strcmp(search_algorithm, 'tabusearch')
            solution = tabusearch(solution);
        end
    else error('not enough input arguements');
    end
end