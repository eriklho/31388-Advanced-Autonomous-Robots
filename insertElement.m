function [newMap] = insertElement(map, x, y, value)
	newMap = map;
	newMap(x,y) = value;
end

