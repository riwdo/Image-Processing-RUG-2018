clc;                                  % clear the command window
close all;                            % close open figure windows      
clear all;                            % remove items from workspace

imname='plant';                       % name of the input image
sigma=5.0;   			      % width of Gaussian filter

inputfile = [imname,'.tif'];          
f=imread(inputfile);                  % read input image
M = size(f,1);
N = size(f,2);

x=im2double(f);			      % convert to double
g=imgaussfilt(x,sigma); 	      % filter the input image

% Write output to file
outputfile = [imname, '_sigma=' num2str(sigma), '.png'];
imwrite(g, outputfile);
fprintf('\nFiltered image saved in file %s\n', outputfile);

% Compute error between original and reconstruction
x=im2double(f);
error=sum(sum(abs(g-x)))/(M*N);
fprintf('\nerror=%f\n',error);

% Write output to file
dif_file = [imname,'_dif','_sigma=',num2str(sigma),'.png'];
dif_im=abs(g-x);
imwrite(dif_im, dif_file);
fprintf('\nDifference image has been saved in file %s\n', dif_file);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot images

% Plot the input image
figure;
subplot(131);
colormap(gray(256));
imagesc(f);
axis equal;
axis tight;
title('INPUT IMAGE')

% Plot the output image
subplot(132);
colormap(gray(256));
imagesc(g);
axis equal;
axis tight;
title('OUTPUT IMAGE')

% Plot the difference image
dif_fig=im2uint8(dif_im);
  
subplot(133);
colormap(gray(256));
imagesc(dif_fig);
axis equal;
axis tight;
title('DIFFERENCE IMAGE')

% Write current figure to file
all_file = [imname,'_all','_sigma=',num2str(sigma),'.png'];
saveas(gcf,all_file);

fprintf('\nComplete image has been saved in file %s\n', all_file);

