function output  = genRules(train_x, train_y, N, M)
    % train_x, train_y are column vectors
    % N is the number of fuzzy sets defined on x
    % M is the number of fuzzy sets defined on y
    rule_count = ones(N,M);
    mem_count = zeros(N,M);
    [r,c] = size(train_x)
    
    for i=1:1:c
        max_x = 0;
        idx_x = 1;
        for j=1:1:N
           res = membership_x(0, 10, train_x(i), j, N);
           if (max_x < res)
               max_x = res;
               idx_x = j;
           end
        end
        
        max_y = 0;
        idx_y = 1;
        for j=1:1:M
           res = membership_y(0, 6, train_y(i), j, M);
           if (max_y < res)
               max_y = res;
               idx_y = j;
           end
        end
        
        mem_count(idx_x, idx_y) = mem_count(idx_x, idx_y) + max_x*max_y;
        rule_count(idx_x, idx_y) = rule_count(idx_x, idx_y) + 1;
        
    end

    output= zeros(1, N);
    for i=1:1:N
        max = 0;
        idx = 1;
        for j=1:1:M
            res = mem_count(i,j)/rule_count(i,j);
            if(max < res)
                max = res;
                idx = j;
            end
        end
        output(i) = idx;
    end
end

