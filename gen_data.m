function [train_x, train_y, test_x, test_y] = gen_data(a, b, numpts, type)
    
    train_pts = numpts*2 / 3;
    test_pts = numpts - train_pts;
    
    train_x = 1:train_pts;
    train_y = 1:train_pts;
    test_x = 1:test_pts;
    test_y = 1:test_pts;
    
    if type == 1
        for i = 1:train_pts
            train_x(i) = unifrnd(a, b);
            train_y(i) = train_x(i)*train_x(i);
        end

        for i = 1:test_pts
            test_x(i) = unifrnd(a, b);
            test_y(i) = test_x(i)*test_x(i);
        end
    else if type == 2
        for i = 1:train_pts
            train_x(i) = unifrnd(a, b);
            train_y(i) = train_x(i)*train_x(i)*train_x(i) - 9 * train_x(i)*train_x(i) + 23*train_x(i) - 15;
        end

        for i = 1:test_pts
            test_x(i) = unifrnd(a, b);
            test_y(i) = test_x(i)*test_x(i)*test_x(i) - 9 * test_x(i)*test_x(i) + 23*test_x(i) - 15;
        end
        end
    end
    
end