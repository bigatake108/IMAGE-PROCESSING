function my_plotHist( hist )
%MY_PLOTHIST Plots the histogram.
% we define a range from 0 to 255 for the histogram
level = 0:255;
% we then plot the values from the histogram along the 0:255 axis
bar(level,hist);


end

