function [BW,maskedImage] = segment_Car(X)
%segmentImage Segment image using auto-generated code from Image Segmenter app
%  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
%  code from the Image Segmenter app. The final segmentation is returned in
%  BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 03-Feb-2025
%----------------------------------------------------

X = rgb2gray(X);
F = fspecial("average",12);
X = imfilter(X, F);
X = imadjust(X);

% Threshold image with manual threshold
BW = im2gray(X) > 2.524500e+02;

% Dilate mask with default
radius = 21;
decomposition = 0;
se = strel('disk', radius, decomposition);
BW = imdilate(BW, se);

% Draw ROIs

xPos = [299.5822 500.5191 535.3636 474.9664 297.2593];
yPos = [459.8475 421.5202 467.9776 508.6278 515.5964];
m = size(BW, 1);
n = size(BW, 2);
addedRegion = poly2mask(xPos, yPos, m, n);
BW = BW & ~addedRegion;
BW = bwpropfilt(BW,'Area',[10100, 24000]);
BW = ~BW;
% Create masked image.
maskedImage = X;
maskedImage(~BW) = 0;

end
