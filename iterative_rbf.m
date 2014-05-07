% We first generate the data points
%no of splits
k = 10;

%no of points
n = 200;
%sigma = 1.5

% Limits
xmin = 0
xmax = 20
ymin = 0
ymax = 400

[train_x, train_y, test_x, test_y] = gen_data(xmin, xmax,200,1);
[IDX, C] = kmeans (train_x, k);
sigma = 1.5 * ones(k,1)

for l = 1:1000
    for i = 1:k
        Phi(:,i)=normpdf(train_x, C(i), sigma(i));
    end


    w = inv(Phi' * Phi) * (Phi' * train_y')

    
    
    Fi = zeros(n-d(2)-1,k);
    for i = 1:k
       Fi(:,i)= - (train_x' -  C(i)).*(train_x' -  C(i));
       Fi(:,i)= exp(Fi(:,i)) * w(i);
    end
    
    H = Fi' * Fi;
    f = Fi' * train_y';
    A = -1 * eye(k);
    b = -1.1 * ones(k,1);
    
    options = optimset('Algorithm', 'interior-point-convex');
    v = quadprog(H,f,A,b,[],[],-inf,+inf,[],options)
    
    
%     v = inv(Fi' * Fi)* (Fi' * train_y');
%     
    for i = 1:k
        sigma(i) = sqrt(1/log(v(i)));
    end
    
    sigma

    
    
end

d = size(test_y);
for i =1:d(2)  
    answers(i) = w' * normpdf(test_x(i), C, sigma);
end




ezplot('x.^2', [xmin, xmax]);
%ezplot('x.^3 - 9*x.^2 + 23*x - 15', [xmin, xmax]);
hold on;
plot(test_x', answers', 'r.')
hold on;
% mu=20;
% sigma=5;

for i=1:k
    pdf = @(x) w(i) * exp(( -(x-C(i)).^2)./2*sigma(i)^2 )./(sqrt(2*pi*sigma(i)^2));
    ezplot( pdf, [C(i) - 3*sigma(i), C(i) + 3*sigma(i)] );
    hold on;
end

axis([xmin xmax ymin ymax]);
