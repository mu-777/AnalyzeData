function [ error ] = calcCircleHorzError( outerRadius, innerRadius, polPosition )
%CALCCIRCLEHORIZERROR この関数の概要をここに記述
%   詳細説明をここに記述
    
    error = 0;
    for i = 2:size(polPosition, 1)
        posPrev = polPosition(i-1, :);
        posCurr = polPosition(i, :);
        dth = abs(posPrev(2) - posCurr(2));
        if dth > pi
            dth = abs(2*pi - dth);
        end
        rAvrg = 0.5*(posPrev(1) + posCurr(1));
        if rAvrg > outerRadius
            error = error + calcArea(rAvrg, outerRadius, dth);
        elseif rAvrg < innerRadius
            error = error + calcArea(rAvrg, innerRadius, dth);
        end
    end
end

function area = calcArea(r, rRef, dth)
    area = 0.5*abs(r^2 - rRef^2)*dth;
end

function [ error ] = calcCircleHorzError_simple( outerRadius, innerRadius, polPosition )
    error = 0;
    n = 0;
    for i = 2:size(polPosition, 1)
        posCurr = polPosition(i, :);
        r = posCurr(1);
        if r > outerRadius
            n = n + 1;
            error = error + abs(r - outerRadius);
        elseif r < innerRadius
            n = n + 1;
            error = error + abs(r - innerRadius);
        end
    end
    if n > 0
        error = error/n;
    end
end

function [ errorArea ] = calcCircleHorzError_old( outerRadius, innerRadius, polPosition )
    
    errorArea = 0;
    posPrev = polPosition(1,:);
    for i = 2:size(polPosition, 1)
        dError = 0;
        posCurr = polPosition(i, :);
        dTheta = abs(posPrev(2) - posCurr(2));
        rAvrg = 0.5*(posPrev(1) + posCurr(1));
        if rAvrg > outerRadius
            dError = calcArea(rAvrg, outerRadius, dTheta);
        elseif rAvrg < innerRadius
            dError = calcArea(rAvrg, innerRadius, dTheta);
        end
        errorArea = errorArea + dError;
        posPrev = posCurr;
    end

end

