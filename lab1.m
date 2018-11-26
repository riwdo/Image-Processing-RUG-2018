function lab1()
    assignment1();
    assignment2();
end

function assignment1()
    x = imread('ImageProcessing/images/ctskull-256.tif');
    imshow(IPreduce(x,2));
end

function assignment2()
    trui = imread('ImageProcessing/images/trui.tif');
    s = IPcontraststretch(trui)
    subplot(2,2,1), imshow(trui)
    title("Original image");
    subplot(2,2,2), imshow(s)
    title("Stretched image");
    subplot(2,2,3), histogram(trui);
    title("Original histogram");
    xlabel("Intensity level");
    ylabel("Number of pixels");
    subplot(2,2,4), histogram(s);
    title("Stretched histogram");
    xlabel("Intensity level");
    ylabel("Number of pixels");
 
end

function simage = IPcontraststretch(img)
    M = max(img(:));
    m = min(img(:));
    simage = ((2^8 - 1) / (M-m)) * (img - m);
end

function rimage = IPreduce(img, ilevel)
    denominator = 256 / ilevel;
    rimage = double(floor(double(img)./(denominator)));
    rimage = uint8(rimage ./ max(rimage(:)) .* 255);
end