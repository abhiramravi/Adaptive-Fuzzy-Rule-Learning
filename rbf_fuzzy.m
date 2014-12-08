% We first generate the data points
%no of splits
clear
k = 10;

%no of points
n = 1000;
sigma = 0.7

% Limits
xmin = 0
xmax = 10
ymin = 0
ymax = 6

[train_x, train_y, test_x, test_y] = gen_spline_data(xmin, xmax,n);
%[train_x, train_y, test_x, test_y] = gen_spline_data(xmin, xmax,200,1);
[IDX, C] = kmeans (train_x, k);

for i = 1:k
    Phi(:,i)=normpdf(train_x, C(i), sigma);
end


w = inv(Phi' * Phi) * (Phi' * train_y')

d = size(test_y);
for i =1:d(2)  
    answers(i) = w' * normpdf(test_x(i), C, sigma);
end

%ezplot('x.^2', [xmin, xmax]);
%ezplot('x.^3 - 9*x.^2 + 23*x - 15', [xmin, xmax]);
hold on;
plot(test_x', answers', 'r.')
hold on;
% mu=20;
% sigma=5;

for i=1:k
    pdf = @(x) exp(( -(x-C(i)).^2)./(2*sigma^2) );
    ezplot( pdf, [C(i) - 3*sigma, C(i) + 3*sigma] );
    hold on;
end

axis([xmin xmax ymin ymax]);
title('')
