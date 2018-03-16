function scan_carth = polar2carth(scan_pol)

alpha = scan_pol(1,:);
rho = scan_pol(2,:);

for i = 1: 1: length(scan_pol)

x_l = cos(alpha(i))*rho(i);
y_l = sin(alpha(i))*rho(i);

scan_carth(:,i) = [x_l ; y_l];

i = i+1;

end
end

