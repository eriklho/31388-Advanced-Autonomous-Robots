function [alpha,r] = lsqline(points)

	n = length(points);
	
	x = points(1,:);
	y = points(2,:);
	
	
	x_sum = sum(x);
	x_x = x*x';
	x_avg = x_sum/n;
	y_sum = sum(y);
	y_y = y*y';
	y_avg = y_sum/n;
	xy_sum = x*y';
	
	
	alpha = atan2((2*x_sum*y_sum)-(2*n*xy_sum),x_sum^2-y_sum^2-n*x_x+n*y_y)/2;	
	
	
	r = x_avg*cos(alpha)+y_avg*sin(alpha);
	
	if r < 0
		r = r*-1;

		if alpha < 0
			alpha = alpha+pi;
		else 
			alpha = alpha-pi;
		end
	end
end

