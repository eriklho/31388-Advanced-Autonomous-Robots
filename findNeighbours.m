function [neighbours] = findNeighbours(map,x, y)
	neighbours = zeros(3,3);
	
	nx = 1;
	
	for i=x-1:1:x+1
		ny = 1;
		for j=y-1:1:y+1
			if map(i,j) == 1
				neighbours(nx,ny) = 1;
			else
				neighbours(nx,ny) = map(i,j);
			end	
			ny = ny + 1;
		end
		nx = nx + 1;
	end
end

