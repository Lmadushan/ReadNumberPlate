close all;
clear all;

image = imread('Images/1.jpeg');
imgray = rgb2gray(image);
imbin =  im2bw(imgray);
im = edge(imgray, 'prewitt');


Iprops = regionprops(im,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa = area;
boundingBox = Iprops.BoundingBox;
for i = 1:count
   if maxa <= Iprops(i).Area
       maxa = Iprops(i).Area;
       boundingBox = Iprops(i).BoundingBox;
   end
end    

im = imcrop(imbin, boundingBox);
im = bwareaopen(~im, 100);
Ifill = imfill(im,'holes');
B = bwboundaries(Ifill);
stat = regionprops(Ifill,'Centroid');

imshow(~im); hold on
for k = 1 : length(B)
    b = B{k};
    c = stat(k).Centroid;
    plot(b(:,2),b(:,1),'r','linewidth',2);
    text(c(1),c(2),num2str(k),'backgroundcolor','r');
end
