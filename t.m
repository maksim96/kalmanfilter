function y = t(x)
if (0 <= x) && (x < 1/2)
    y = 2*x;
elseif x < 1
    y = 2*(1-x);
else
    y = x;
end

end

    
    
