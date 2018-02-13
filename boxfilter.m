% x=boxfilter(imgname,u_range,v_range)
% imgname string giving the name of the RGB input image
% u_range [u_min u_max]
% v_range [v_min v_max]
% the function will show a picture where the pixels fulfilling the range
% requirements will be white and the rest black
% 
function x=boxfilter(imgname,u_range,v_range)
clf
m=imread(imgname);
subplot(1,2,1)
imshow(m)
m2=int32(m);
YUV(:,:,1)=((19592*m2(:,:,1)+38480*m2(:,:,2)+7468*m2(:,:,3))/65536);
YUV(:,:,2)=((-9713*m2(:,:,1)-19068*m2(:,:,2)+28787*m2(:,:,3))/65536)+128;
YUV(:,:,3)=((28787*m2(:,:,1)-24107*m2(:,:,2)-4674*m2(:,:,3))/65536)+128;
t1=YUV(:,:,2)<u_range(2) & YUV(:,:,2)>u_range(1); 
t2=YUV(:,:,3)<v_range(2) & YUV(:,:,3)>v_range(1);
t=t1&t2;
imshow(t)
end