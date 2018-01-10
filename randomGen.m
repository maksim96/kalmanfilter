count = 500;
y = zeros(1, count);
y(1) = 1/pi;
y(2) = t(y(1));
i = 3;
while i < count
    temp = t(y(i-1));
    y(i) = round(temp*precision)/precision;
    
    i = i + 1;
end

x = 1:count;
y = ceil(y * precision)/(precision);
%plot(x,y);
%figure
p0plot = arrayfun(@p0,(0:0.001:1));
plot(0:0.001:1, p0plot);
hold on
p0plotTent = zeros(10, 1001);
for i =1:1001
    p0plotTent(1,i) = tentTransform(@p0, (i - 1)/1000);
end
for j = 2:10
    for i = 1:1001
        p0plotTent(j,i) = tentTransform(@p0, p0plotTent(j-1,i));
    end
end
plot(0:0.001:1, p0plotTent(1,:))
plot(0:0.001:1, p0plotTent(2,:))
plot(0:0.001:1, p0plotTent(3,:))
plot(0:0.001:1, p0plotTent(4,:))
plot(0:0.001:1, p0plotTent(9,:))
plot(0:0.001:1, p0plotTent(10,:))
legend('p0','1','2','3','4','5', '6');
hold off
mean(y)
var(y)
%hist(y, precision/1000);