t = 1:420;
v = 300;
q = 9;

A = v^2 / q;

w = q/(2*v);

x = A*sin(w*t);
y = A*sin(2*w*t);

xpred = zeros(6,420);

o = 200;

vmax = v*sqrt(5)/2;

whereQIsMax = pi/4 / w;
qmax = q*sqrt(sin(w*whereQIsMax)^2 / 16 + sin(2*w*whereQIsMax)^2);

P = zeros(6);
P(1,1) = o;
P(2,2) = o;
P(3,3) = vmax*vmax;
P(4,4) = vmax*vmax;
P(5,5) = qmax*qmax;
P(6,6) = qmax*qmax;

deltat = 5;
theta = 60;

F = eye(6);
F(1,3) = deltat;
F(2,4) = deltat;
F(1,5) = 0.5 * deltat^2;
F(2,6) = 0.5 * deltat^2;
F(3,5) = deltat;
F(4,6) = deltat;
F(5,5) = exp(-deltat/60);
F(6,6) = exp(-deltat/60);

Sigma = qmax;
D = zeros(6);
D(5,5) = 1;
D(6,6) = 1;
D = Sigma^2*(1- exp(-2*deltat/60))*D;

vdiff = zeros(1,6);

H = zeros(2,6);
H(1,1) = 1;
H(2,2) = 1;

S = zeros(6);

R = o^2*eye(2);

sensor = zeros(2, 1000);



while true
    s = 1;
    for i = 1:420
        plot(x,y);
        hold on
        plot(0,0, 'or','MarkerSize',10,'MarkerFaceColor','k')
        plot(x(i), y(i),'or','MarkerSize',10,'MarkerFaceColor','r')
        if (mod(i,5) == 0) 
            sensor(1,s) = o*randn() + x(i);
            sensor(2,s) = o*randn() + y(i);
            
            if s == 1 %init
               xpred(1,1) = sensor(1,1);
               xpred(2,1) = sensor(2,1);
               %prediction
               xpred(:,2) = F*xpred(:,1);
               P = F*P*F' + D;
            else
                % filtering
                vdiff = sensor(:,s) - H*xpred(:,s);

                S = H*P*H' + R;

                W = P*H'*S^(-1);
                
                xpred(:,s) =  xpred(:,s) + W*vdiff;
                P = P - W*S*W';

                %Hierhin error ellipsen
                 %error ellipses
                %eigenvalues = eig(P(1:2,1:2));
                %plotEllipse(x(i), y(i), eigenvalues(1), eigenvalues(2));
                
                %prediction
                xpred(:,s+1) = F*xpred(:,s);
                P = F*P*F' + D;
            end
            s = s + 1;
        end
        
        plot(sensor(1,1:(s-1)), sensor(2,1:(s-1)),'or','MarkerSize',3,'MarkerFaceColor','g')
        plot(xpred(1,1:s), xpred(2,1:s), 'or', 'MarkerSize',3,'MarkerFaceColor','k'); 
        axis([min(x)-1000 max(x)+1000 min(y)-1000 max(y)+1000]);
        hold off
        pause(1)
    end
end