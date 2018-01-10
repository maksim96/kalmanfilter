function y = p0( x )
%PDF
    m = 0.1; %µ
    o = 0.01 %sigma
    
    if (m <= x && x <= (m+o)) 
        y = 2/(o^2) * (x-m);
    else
        y = 0*x;
    end
    
end

