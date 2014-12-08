% We first generate the data points
%no of splits
clearvars;
k = 7;

%no of points
n = 1000;
nu = 10 * [0.0001 0.0001 0.0001];
niter = 1000;
lambda = 0.3;

% Limits
xmin = 0
xmax = 10
ymin = 0
ymax = 6

% We first generate the training data
[train_x, train_y, test_x, test_y] = gen_two_spline_data(xmin, xmax, n);

% We perform kmeans on the training data to get N centers. 
[IDX, T, D] = kmeans (train_x, k);

% Calculating the average distance between two clusters
distances = 0;
for i = 1:k
    for j = i+1:k
        distances = distances + abs (T(i) - T(j));
    end
end
distances = distances / ( k*(k-1)/2 );

% Initializing the sigmas
C = (k/(distances^2)) * ones(k,1);

% We now evaluate the features necessary to do linear regression
for i = 1:k
    Phi(:,i)=normpdf(train_x, T(i), 1./sqrt(2*C(i)));
end

% We calculate the pseudo inverse to get the weights
w = inv(Phi' * Phi) * (Phi' * train_y')

d = size(train_y);
error = 100 * ones(1,d(2));

% Now for a number of iterations we perform the update
while sum (error) > 11
    
    % First we calculate the errors ej(n) on the training data
    d = size(train_y);
    for j =1:d(2)  
        answers(j) = w' * normpdf(train_x(j), T, 1./sqrt(2*C));
        error(j) = (train_y(j) - answers (j))^2;
    end
    
    % Calculating the updated weights
    for i = 1:k
        diffw(i) = - (train_y - answers) * exp( -(train_x - T(i)).^2 .* C(i))';
    end
    
    % Calculating the updated centers
    for i = 1:k
        difft(i) = -2 * C(i) * w(i) * ( (train_y - answers) * (exp( -(train_x - T(i)).^2 .* C(i)).*(train_x - T(i)))');
    end
    
    % Calculating the updated variances
    for i = 1:k
        diffc(i) = w(i) * ( (train_y - answers) * (exp( -(train_x - T(i)).^2 .* C(i)).*(train_x - T(i)))');
    end
    
    diffw(isnan(diffw)) = 0;
    difft(isnan(difft)) = 0;
    diffc(isnan(diffc)) = 0;
    
    % Now we perform the updates
    for i = 1:k
        w(i) = w(i) - nu(1) * diffw(i);
        T(i) = T(i) - nu(2) * difft(i);
        if C(i) - nu(3) * diffc(i) > 0
            C(i) = C(i) - nu(3) * diffc(i);
        end
    end
    [diffw difft diffc]
    [w T C]
    
    % We now evaluate the features necessary to do linear regression
    for i = 1:k
        Phi(:,i)=normpdf(train_x, T(i), 1./sqrt(2*C(i)));
    end

    % We calculate the pseudo inverse to get the weights
    w = inv(Phi' * Phi ) * (Phi' * train_y') %+ lambda * eye(size(Phi, 2))
    
    sum (error)
end



% We now evaluate the features necessary to do linear regression
for i = 1:k
    Phi(:,i)=normpdf(train_x, T(i), 1./sqrt(2*C(i)));
end

% We calculate the pseudo inverse to get the weights
w = inv(Phi' * Phi ) * (Phi' * train_y') %+ lambda * eye(size(Phi, 2))

% This is the answer on the final test data
d = size(test_y);
for i =1:d(2)  
    test_answers(i) = w' * normpdf(test_x(i), T, 1./sqrt(2*C)); 
end
%%
%ezplot('x.^2', [xmin, xmax]);
g = @(x) pchip([0 2 3 4 5 6 7 8 10], [0.5 1 6 1 0.7 1 6 1 0.5], x);
fplot(g, [0,10], 'g');

%ezplot('x.^3 - 9*x.^2 + 23*x - 15', [xmin, xmax]);
hold on;
plot(test_x', test_answers', 'r.')
hold on;
% mu=20;
% sigma=5;
sigma = 1./sqrt(2*C);
for i=1:k
    pdf = @(x)  exp(( -(x-T(i)).^2)./(2*sigma(i)^2) );%./(sqrt(2*pi*sigma(i)^2)); % * w(i)
    ezplot( pdf, [T(i) - 4*sigma(i), T(i) + 4*sigma(i)] );
    hold on;
end

axis([xmin xmax ymin ymax]);
