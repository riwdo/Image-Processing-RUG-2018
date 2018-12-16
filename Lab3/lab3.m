function lab3() 
    f = [1 4 -3 0];
    d = IPdwt(f,2);
    disp(d);
end
function inversedwt = IPidwt
    
end

function dwt = IPdwt(f,j)
    dwt = f;
    scale = size(f,2);
    for i=1:j
        sum = size(dwt,2)/2;
        neg = size(dwt,2)/2;
        for adddif=1:2
            k = 1;
            for s=1:2:scale
                if adddif == 1  
                    sum(k) = dwt(s)+dwt(s+1);
                else 
                    neg(k) = dwt(s)-dwt(s+1);
                end
                k = k + 1;
            end
        end
        sumneg = [sum neg];
        disp(sumneg);
        dwt(1:size(sumneg,2)) = sumneg;
        dwt(1:scale) = dwt(1:scale) ./ sqrt(2);
        scale = scale/2;
    end
end