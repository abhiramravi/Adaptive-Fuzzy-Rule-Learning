function cg = cog(a, b, idx, N)
    
    l = a + (idx-1)*(b-a)/N;
    r = a + idx*(b-a)/N;
    cg = (l+r)/2;
        
end