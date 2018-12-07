function lab2()
    img = double(imread('blurrymoon.tif'));
    maskX = [-1 0 1; -2 0 2; -1 0 1];
    maskY = [1 2 1; 0 0 0; -1 -2 -1];
    filtered_imageX = IPfilter(img, maskX);
    filtered_imageY = IPfilter(img, maskY);
    edges = filtered_imageX + filtered_imageY;
    subplot(1,2,1), imshow(uint8(img))
    title("Original image");
    subplot(1,2,2), imshow(edges)
    title("Stretched image");
end

function filteredvalue = g_new(row,column, mask,image)
    image_part = image(row-1:row+1,column-1:column+1);
    filteredvalue = sum(sum(image_part .* mask));
end

function filteredvalue = g(row,column, mask, image)
    image_part = zeros(3,3);
    if column-1 == 0
        if row-1 == 0
            image_part(2:3,2:3) = image(row:row+1,column:column+1);
        elseif row+1 == 0
            image_part(1:2,2:3) = image(row-1:row,column:column+1);
        else
            image_part(1:3,2:3) = image(row-1:row+1,column:column+1);
        end
    elseif column+1 == size(image,2)+1
        if row-1 == 0
            image_part(2:3,1:2) = image(row:row+1,column-1:column);
        elseif row+1 == 0
            image_part(1:2,1:2) = image(row-1:row,column-1:column);
        else
            image_part(1:3,1:2) = image(row-1:row+1,column-1:column);
        end
    elseif row-1 == 0
        image_part(2:3,1:3) = image(row:row+1, column-1:column+1);
    elseif row+1 == 0
        image_part(1:2,1:3) = iamge(row-1:row,column-1:column+1);
    else
        image_part = image(row-1:row+1,column-1:column+1);
    end
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

function gradient_magnitude=IPgradient(img)

 x = imread('blurrymoon.tif');
    imshow();


end