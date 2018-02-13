%function x=getyuv(imgname)
% imgname string giving the name of the RGB input image
% A click on the left button in the shown picture will plot the u,v value
% of the indicated pixel
% a click on the right button will stop the function
function x=getyuv(imgname)
clf
m=imread(imgname);
subplot(1,2,1)
imshow(m)
m2=int32(m);
YUV(:,:,1)=((19592*m2(:,:,1)+38480*m2(:,:,2)+7468*m2(:,:,3))/65536);
YUV(:,:,2)=((-9713*m2(:,:,1)-19068*m2(:,:,2)+28787*m2(:,:,3))/65536)+128;
YUV(:,:,3)=((28787*m2(:,:,1)-24107*m2(:,:,2)-4674*m2(:,:,3))/65536)+128;
hold on
button=0;
while (button ~= 3)
    subplot(1,2,1)
    [y x,button]=ginput(1);    
    yc =YUV(round(x),round(y),1);
    uc =YUV(round(x),round(y),2);
    vc =YUV(round(x),round(y),3);
    outp=['(y,u,v)=(',num2str(yc),',', num2str(uc),',', num2str(vc),')'],
    subplot(1,2,2)
    plot(uc,vc,'.')
    title(outp)
    xlabel('u')
    ylabel('v')
    axis([0 256 0 256])
    grid on
 
    hold on
end