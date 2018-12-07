function lab1()
    exercise1();
    exercise2();
end

function exercise1()
    x = imread('ctskull-256.tif');
    %show 8 different intensity levels
    for i=1:8
        fig = subplot(2,4,i); imshow(IPreduce(x,2^i));
        title(sprintf("ctskull-%02d",2^i));
        saveas(fig, (sprintf('ctskull-%02d.png',2^i)));
    end
end

function exercise2()
    trui = imread('trui.tif');
    s = IPcontraststretch(trui);
    %plot images and corresponding histograms over intensity levels
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
%Apply function for contrast stretching to image
function simage = IPcontraststretch(img)
    M = max(img(:));
    m = min(img(:));
    simage = uint8((double(255)/double(M-m)) .* (img - m));
end
%Apply function for reduction of intensity levels to image
function rimage = IPreduce(img, ilevel)
    denominator = 256 / ilevel;
    rimage = double(floor(double(img)./(denominator)));
    rimage = uint8(rimage ./ max(rimage(:)) .* 255);
end