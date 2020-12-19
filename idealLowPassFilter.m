function [ lpimg ] = my_idealLowPassFilter( img, maxFrequency )

lpimg = zeros(size(img));

[rows, columns] = size(img);

% Using fft2(), to get into the frequency-domain of our image.
fourier = fft2(double(img));    

% Creating filter-vector, x-direction.
i = 0:(rows - 1);                  
xscale = find(i > (rows/2));
i(xscale) = i(xscale) - rows;

% Creating filter-vector, y-direction.
k = 0:(columns - 1);
yscale = find(k > (columns/2));
k(yscale) = k(yscale) - columns;

% Using meshgrid() to create Matrices utilizing the i and k vectors. 
[I, K] = meshgrid(i, k);
% Calculating the euclidean distance. 
euclid = sqrt(K.^2 + I.^2);
% Creating a filter-mask in dependence of the given max-frequency.
mask = double(euclid <= maxFrequency);
% Filtering the fourier-image using said mask.
filtfour = mask.*fourier;

% Using ifft2(), to inverse-fourier-transform the now filtered image. 
lpimg = ifft2(double(filtfour));

end

