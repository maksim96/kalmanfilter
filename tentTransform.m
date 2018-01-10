function y = tentTransform( f, x )
    y = 0.5*(f(0.5*x) + f(1-0.5*x));
end

