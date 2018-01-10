function plotEllipse( xCenter,yCenter,xRadius,yRadius)
theta = 0 : 0.01 : 2*pi;
x = xRadius * cos(theta) + xCenter;
y = yRadius * sin(theta) + yCenter;
plot(x, y, 'LineWidth', 3);
end

