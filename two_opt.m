%{
clear;
%define tour tr from .tsp file
file = fopen('pcb442.txt','r');
tr = fscanf(file, '%f', [3 Inf]);
fclose(file);
tr = tr(2:3, :)';
%tr = [0,0;2,2;2,0;0,2];
%=======%
r = randperm(length(tr));
tr = tr(r,:);
%=======%
tour_obj = tour(tr);
%}

function tour_obj = two_opt(tour_obj)
iterations = 5;
%tour_obj = tour_obj.recost();
newtour = tour_obj;
bestcost = tour_obj.cost;
no_improvement = 0;
for iter=1: iterations
    for i = 1:tour_obj.size-2
        for j = i+1:tour_obj.size-1
            if crosscheck(tour_obj.cities(i,:),tour_obj.cities(i+1,:),tour_obj.cities(j,:),tour_obj.cities(j+1,:))
                newtour.cities = two_opt_swap(tour_obj.cities, tour_obj.size, i+1, j);
                newtour = newtour.recost();
                %newtour.cost
                %bestcost
                if(newtour.cost < bestcost)
                    tour_obj = newtour;
                    %tour_obj = tour_obj.recost();
                    bestcost = tour_obj.cost;
                    fprintf('\ntwo_opt:iter:%d bestcost= %d', iter, bestcost);
                    no_improvement = 0;
                else no_improvement = no_improvement+1;
                end
                %fprintf('%d',no_improvement);
            %{
            else
                newtour.cities = two_opt_swap(tour.cities, tour.size, i, j);
                if(newtour.cost()<bestcost)
                    tour = newtour;
                    bestcost = tour.cost();
                end
                %}
            end
        end
        %if no_improvement>80
            %break;
        %end
    %if no_improvement>80
        %break;
    %end
    end
    %if no_improvement>80
        %break;
    %end
end
%tr = tour_obj.cities;

%{
figure;
scatter(tour.cities(:,1),tour.cities(:,2))
txt=(1:tour.size)';
txt=num2str(txt);
txt=cellstr(txt);
text(tour.cities(:,1),tour.cities(:,2),txt)
hold on;
for li=1:tour.size-1
    plot([tour.cities(li,1),tour.cities(li+1,1)],[tour.cities(li,2),tour.cities(li+1,2)])
end
%}
end