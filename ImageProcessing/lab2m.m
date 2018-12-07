function lab2()
    img = double(imread('chronometer1250dpi.tif'));
    mask =[0 1 0; 0 -1 0; 0 0 0];
    
    filtered_image = uint8(IPfilter(img, mask));
    subplot(1,2,1), imshow(uint8(img))
    title("Original image");
    subplot(1,2,2), imshow(filtered_image)
    title("Stretched image");
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
    filteredvalue = sum(sum(image_part*mask));
end

function filtered_image = IPfilter(img, mask)
    filtered_image = zeros(size(img));
    for row = 1 : size(img,1)-1
        for column = 1 :size(img,2)-1
            filtered_image(row,column) = g(row,column, mask, img); 
        end
    end
end

function gradient_magnitude=IPgradient(img)

 x = imread('blurrymoon.tif');
    imshow();


end