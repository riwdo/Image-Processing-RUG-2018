function stretchedimage = IPcontraststretch(image)
    M = max(image(:));
    m = min(image(:));
    stretchedimage = ((2^8 - 1) / (M-m)) * (image - m);
end