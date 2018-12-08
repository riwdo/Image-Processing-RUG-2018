function lab2()
    img = double(imread('blurrymoon.tif'));
    
    sharpeningfilter = [0 -1 0; -1 5 -1; 0 -1 0];
    meanfilter = [1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];
    maskX = [-1 0 1; -2 0 2; -1 0 1];
    maskY = [1 2 1; 0 0 0; -1 -2 -1];
    filtered_imageX = IPfilter(img, maskX);
    filtered_imageY = IPfilter(img, maskY);
    
    mean_image = IPfilter(img,meanfilter);
    final1 = uint8(IPfilter(mean_image, sharpeningfilter));
    
    %sharp_image = IPfilter(img,sharpeningfilter);
    %final2 = uint8(IPfilter(sharp_image, meanfilter));
    %subplot(1,2,1), imshow(uint8(final1))
    %title("Average first");
    %subplot(1,2,2), imshow(uint8(final2))
    %title("Sharpen first");
    %disp(isequal(final1,final2))
    [Gx,Gy] = (IPgradient(img));
    imshowpair(Gx,Gy,'montage');
    title("Gradient X and Gradient Y");
end

function filteredvalue = g_new(row,column, mask,image)
    image_part = image(row-1:row+1,column-1:column+1);
    filteredvalue = sum(sum(image_part .* mask));
end

function padded_image = add_padding(img)
    padded_image = [zeros(1,size(img,2)); img];
    padded_image = [padded_image; zeros(1,size(padded_image,2))];
    padded_image = [zeros(size(padded_image,1),1) padded_image zeros(size(padded_image,1),1)];
end

function filtered_image = IPfilter(img, mask)
    padded_image = add_padding(img);
    filtered_image = zeros(size(img));
    for row = 2 : size(padded_image,1)-2
        for column = 2 :size(padded_image,2)-2
            filtered_image(row-1,column-1) = g_new(row,column, mask, padded_image);
        end
    end
end

function gradient = secondorderderivativeX(f, column)
    gradient = f(column-1)+f(column+1) - 2*f(column);
end

function gradient = secondorderderivativeY(f, row)
    gradient = f(row-1)+f(row+1) - 2*f(row);
end

function [gradientY,gradientX] = IPgradient(img)
    gradientX = zeros(size(img));
    gradientY = zeros(size(img));
    for row=1:size(img,1)-1
        padded_row = [img(row,size(img(row,:),2)) img(row,:) img(row,1)];
        for column=2:size(padded_row,2)-2
            gradientX(row,column-1) = secondorderderivativeX(padded_row,column);
        end
    end
    for column=1:size(img,2)-1
        padded_column = [img(size(img(:,column),1),column); img(:,column); img(1,column)];
        for row=2:size(padded_column,1)-2
            gradientY(row-1,column) = secondorderderivativeY(padded_column,row);
        end
    end
end