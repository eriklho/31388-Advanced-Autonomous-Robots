function [alpha,r] = lsqline(x,y)
%LSQLINE Summary of this function goes here
%   Detailed explanation goes here
	n = length(x);
	x_line = 1/n * sum(x);
	x_x = x*x';
	y_line = 1/n * sum(y);
	y_y = y*y';
	x_y = x*y';
	tan_2alpha = (2*sum(x)*sum(y)-2*n*x_y)/(((sum(x)^2)-(sum(y)^2)-n*x_x)+n*y_y);
	alpha = atan2(tan_2alpha,1);
	r = x_line*cos(alpha)+y_line*sin(alpha);
end

