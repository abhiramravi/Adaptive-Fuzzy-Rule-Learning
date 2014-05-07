function mem = membership_y(a, b, x, idx, N)
    
    del = (b-a)/N;
    l = a+del/2 + (idx-2)*del;
    r = l + 2*del;

    if x < l || x > r
        mem = 0;
        return
    end
    
        if x - l > r - x
            mem = (r-x)/((r-l)/2);
        else
            mem = (x-l)/((r-l)/2);
        end
    
end