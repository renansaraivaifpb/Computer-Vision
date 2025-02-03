function [BW,maskedImage] = segment_CarBlack(X)
%segmentImage Segment image using auto-generated code from Image Segmenter app
%  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
%  code from the Image Segmenter app. The final segmentation is returned in
%  BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 03-Feb-2025
%----------------------------------------------------

X = rgb2gray(X);

F = fspecial("average",12);
X = imfilter(X, F);

% Adjust data to span data range.
X = imadjust(X);

% Threshold image with manual threshold
BW = im2gray(X) > 5.355000e+01;

% Draw ROIs

xPos = [618.9905 1156.7578 1158.5000];
yPos = [516.7578 307.6996 518.5000];
m = size(BW, 1);
n = size(BW, 2);
addedRegion = poly2mask(xPos, yPos, m, n);
BW = BW | addedRegion;
BW = bwpropfilt(BW,'Area',[5600, 24000]);
BW = ~BW;
% Create masked image.
maskedImage = X;
maskedImage(~BW) = 0;
end


