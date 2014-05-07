function y = getPredictions(x, centroids, output, N)
    
    mem_vector = 1:N;
    for i=1:N
        mem_vector(i) = membership_x(0, 10, x, i, N);
    end
    
    ordered_centroids = 1:N;
    for i=1:N
        idx_y = output(i)
        ordered_centroids(i) = centroids(idx_y);
    end
    
    y = sum(mem_vector*ordered_centroids')/sum(mem_vector);
    
end

