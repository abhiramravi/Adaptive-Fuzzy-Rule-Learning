function [train_x, train_y, test_x, test_y] = gen_two_spline_data(a, b, numpts)
    
    train_pts = numpts*2 / 3;
    test_pts = numpts - train_pts;
    
    train_x = 1:train_pts;
    train_y = 1:train_pts;
    test_x = 1:test_pts;
    test_y = 1:test_pts;
    
    g = @(x) pchip([0 2 3 4 5 6 7 8 10], [0.5 1 6 1 0.7 1 6 1 0.5], x);
    
    for i = 1:train_pts
        train_x(i) = unifrnd(a, b);
        train_y(i) = g(train_x(i));
    end

    for i = 1:test_pts
        test_x(i) = unifrnd(a, b);
        test_y(i) = g(test_x(i));
    end
    
     fplot (g, [0,10], 'g')    
    
end