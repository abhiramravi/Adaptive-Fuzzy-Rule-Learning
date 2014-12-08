%no of splits
N = 10;

%no of points
n = 1000

%ranges
xmin = 0;
xmax = 10;
ymin = 0;
ymax = 6;

%data generation
[train_x, train_y, test_x, test_y] = gen_spline_data(xmin, xmax, n);

%centroids
centroids = 1:N;
for i = 1:N
    centroids(i) = cog(ymin, ymax, i, N);
end

centroids

%generating fuzzy rules
rules = genRules(train_x, train_y, N, N);

%make predictions
preds = 1:(n - 2*n/3);

for i = 1:(n - 2*n/3)
    genout = getPredictions(test_x(i), centroids, rules, N)
    preds(i) = genout;
end

rules
%ezplot('x.^3 - 9*x.^2 + 23*x - 15', [xmin, xmax]);
%plot results
fplot(@(x) pchip([0 4 5 6 10], [0.5 1 6 1 0.5], x), [0,10], 'g');
%ezplot('x.^2', [0, 10]); 
title('')

hold on;
plot(test_x, preds, 'r.');
centroids
