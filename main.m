clear;
%define tour tr from .tsp file

file = fopen('att48.txt','r');
tr = fscanf(file, '%f', [2 Inf]);
fclose(file);
tr = tr(1:2, :)';

%file = fopen('pcb442.txt','r');
%tr = fscanf(file, '%f', [3 Inf]);
%fclose(file);
%tr = tr(2:3, :)';

%tr = [0,0;2,2;2,0;0,2];
%=======%

%=======%
colonysize = 10;
tours = beecolony(tr, colonysize);

start_time = tic();
iterations = 30;
count = 1;
for iter = 1:iterations
    fprintf('\nArtificial Bee Colony :: iteration number: %d', count);
    tours = tours.sendemployed();
    now = tic();
    tours = tours.updt_employed('two_opt');
    updt_time = toc(now);
    fprintf('\nEmployed Bees Update Time = %d', updt_time);
    tours = tours.sendonlookers();
    fprintf('\nOnlookers : %d', length(tours.onlookers));
    fprintf('\nScouts : %d', length(tours.scout));
    tours = tours.sendscouts();
    tours = tours.waggledance();
    count = count+1;
end

bestcost = Inf;
for i=1:length(tours.onlookers)
    cost = tours.onlookers(i).cost;
    if cost<bestcost
        besttour = tours.onlookers(i);
        bestcost = cost;
    end
end

runtime = toc(start_time);
fprintf('\ntotal runtime = %d\n', runtime);

figure;
scatter(besttour.cities(:,1),besttour.cities(:,2))
txt=(1:besttour.size)';
txt=num2str(txt);
txt=cellstr(txt);
text(besttour.cities(:,1),besttour.cities(:,2),txt)
hold on;
for li=1:besttour.size-1
    plot([besttour.cities(li,1),besttour.cities(li+1,1)],[besttour.cities(li,2),besttour.cities(li+1,2)])
end