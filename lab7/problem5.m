clc; clear all;

x1 = 5;
y1 = 3;
x= [];
y= [];

for i=1:1:10
	x(i) = i;
	y(i) = -x(i) - 3;
% 	lines(i,:) = [x1 y1 x(i) y(i)];

end


hei = lsqline(x,y);
