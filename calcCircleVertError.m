function [ error ] = calcCircleVertError( polPosition, mergin )
%CALCCIRCLEHORIZERROR ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
    error = 0;
    for i = 2:size(polPosition, 1)
        posPrev = polPosition(i-1, :);
        posCurr = polPosition(i, :);
        dth = abs(posPrev(2) - posCurr(2));
        if dth > pi
            dth = abs(2*pi - dth);
        end
        dl = (posPrev(1) + posCurr(1))/2.0 * dth;
        error = error + calcArea(posPrev(3), posCurr(3), dl, mergin);
    end
end

function area = calcArea(z1, z2, dl, mergin)
    area = abs(abs(z1 + z2)*0.5 - mergin)*dl;
end

function [ error ] = calcCircleVertError_simple( polPosition )
% �_�̐��������Ȃ炱�ꂪ�g����
% Real vs Virtual�Ȃ�g����Ƃ������邪�CJS vs Avatar�ɂ͎g���Ȃ�

    error = 0;
    for i = 1:size(polPosition, 1)
        posCurr = abs(polPosition(i, :));
        error = error + posCurr(3);
    end
end

function [ error ] = calcCircleVertError_old( polPosition )
    error = 0;
    posPrev = abs(polPosition(1, :));
    for i = 2:size(polPosition, 1)
        posCurr = abs(polPosition(i, :));
        z1 = abs(posPrev(3));
        z2 = abs(posCurr(3));
        dl = (posPrev(1) + posCurr(1))/2.0 * abs(posPrev(2) - posCurr(2));
        error = error + calcArea(z1, z2, dl);
        posPrev = posCurr;
    end
end



