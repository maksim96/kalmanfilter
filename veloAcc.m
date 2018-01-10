t = 1:420;
v = 300;
q = 9;

A = v^2 / q;

w = q/(2*v);

x = A*sin(w*t);
y = A*sin(2*w*t);
%Exercise 4.3
velox = v*cos(w*t)./2;
veloy = v*cos(2*w*t);
accx = -q*(sin(w*t)/4);
accy = -q*(sin(2*w*t));

tangentialx = 1./(sqrt(velox(t).^2 + veloy(t).^2)) .* velox(t);
tangentialy = 1./(sqrt(velox(t).^2 + veloy(t).^2)) .* veloy(t);

normalx = 1./(sqrt(velox(t).^2 + veloy(t).^2)) .* -veloy(t);
normaly = 1./(sqrt(velox(t).^2 + veloy(t).^2)) .* velox(t);

absvelo = sqrt(velox(t).^2 + veloy(t).^2);
absacc = sqrt(accx(t).^2 + accy(t).^2);

plot(t, absvelo);
legend('Absolut Velocity');
figure

plot(t, absacc);
    
hold on
    plot(t, accx.*tangentialx + accy.*tangentialy);
    plot(t, accx.*normalx + accy.*normaly);
hold off

legend('Absolut Acceleration', 'TangentialAcceleration', 'NormalAcceleration');
