function solution = local_search(solution, search_algorithm)
    if nargin>0
        if nargin<2
            search_algorithm = 'two_opt'; %default algorithm
        end
        if strcmp(search_algorithm, 'two_opt')
            solution = two_opt(solution);
        end
    else error('not enough input arguements');
    end
end