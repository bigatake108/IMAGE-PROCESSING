function [ fimg ] = my_meanFilter( img, w )
%MY_MEANFILTER Summary of this function goes here

fimg = zeros(size(img));
[row, column, rgb] = size(img); % get the sizes of the 3d matrix


elements = (w*2 + 1)^2; %sum of all elements of the window
rowNew = row + (w * 2) + 1; %extend the row boudaries such that every pixel can be used as a window center
columnNew = column + (w * 2) + 1;% same goes for column
newimg = zeros(rowNew, columnNew, rgb);%create a new dummy image with only zero values 
newimg(w + 1:rowNew - w - 1, w + 1:columnNew - w - 1 , 1:rgb) = img; % insert the given image (img) into the dummy image

% we loop over the dummy image, but we start at the first pixel of the
% actual image and end at the last pixel of the image
% inside the 3 for loops we cut out a window of the size w*2 + 1 X w*2 + 1
% we then calculate for each r,g,b value the sum of all elements inside the window 
% After that we simly take the average of the sum and the current pixel value of the output/filtered image with it
for i = w+1: rowNew - w
    for k = w+1: columnNew - w
        for z = 1: rgb
            window = newimg(i - w:i + w, k - w:k + w, z:z);
            summe = sum(window, 'all');
            fimg(i - w,k - w,z) = summe/elements;
        end
    end
end
end


