function [ fimg ] = my_gaussFilter( img, w , sigma )

fimg = zeros(size(img));
[row, column, rgb] = size(img); % get the sizes of the 3d matrix % copy the 3d matrix one time



rowNew = row + (w * 2) + 1; %extend the row boudaries such that every pixel can be used as a window center
columnNew = column + (w * 2) + 1;% same goes for column
newimg = zeros(rowNew, columnNew, rgb);%create a new dummy image with only zero values 
newimg(w + 1:rowNew - w - 1, w + 1:columnNew - w - 1 , 1:rgb) = img; % insert the given image (img) into the dummy image
kernel = my_kernel(w, sigma); %create the gauss kernel with our own my_kernel function

% we loop over the dummy image, but we start at the first pixel of the
% actual image and end at the last pixel of the image
% inside the 3 for loops we cut out a window of the size w*2 + 1 X w*2 + 1
% 
for i = w+1: rowNew - w
    for k = w+1: columnNew - w
        for z = 1: rgb
            window = newimg(i - w:i + w, k - w:k + w, z:z);
            gauss_vector = window.*kernel;
            gauss_value = sum(gauss_vector, 'all');
            fimg(i - w,k - w,z) = gauss_value;
        end
    end
end

end

function [kernel] = my_kernel(w , sigma)

% to apply a gauss filter to an image we need a gauss kernel
% this kernel is the normalized normal distribution of the given "meshgrid"
% which is a matrix containing values from -w to +w in ascending order from
% left to right for the x Matrix and from top to bottom for the y matrix

[x,y] = meshgrid(-w:w, -w:w);% initialize the 2 grids
exponent = -(x.^2 + y.^2) / (2*sigma^2); %calculate the exponent values
kernel = exp(exponent)/(2*sigma^2); % calculate the actual kernel --> used the wikipedia equation!
kernel = kernel./sum(kernel, 'all');% normalize the kernel
end
