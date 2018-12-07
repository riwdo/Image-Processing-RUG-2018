function reducedimage = IPreduce(image, numoflevels)
    denominator = 256 / numoflevels;
    reducedimage = double(floor(double(image)./(denominator)));
    reducedimage = uint8(reducedimage ./ max(reducedimage(:)) .* 255);
end