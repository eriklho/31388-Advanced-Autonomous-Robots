function [qOut] = add2Q(qIn, cp)

	qOut = qIn;
	
	qOut(size(qIn,1)+1,:) = cp;
	
	
end

