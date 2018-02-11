function temp = two_opt_swap(cities, size, a, b)
temp = cities(1:a-1, :);
temp = [temp; cities(b:-1:a,:)];
temp = [temp; cities(b+1:size,:)];
end