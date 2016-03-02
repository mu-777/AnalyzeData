
close all hidden

%%
foldersIDX = 12;
folders = {
    './csv/1_20160128_kato/1/'; 
    './csv/1_20160128_kato/2/';
    './csv/2_20160128_takemori/1/'; 
    './csv/2_20160128_takemori/2/'; 
    './csv/3_20160129_kawai/1/'; 
    './csv/3_20160129_kawai/2/'; 
    './csv/4_20160129_kamimura/1/'; 
    './csv/4_20160129_kamimura/2/'; 
    './csv/5_20160202_iinuma/1/'; 
    './csv/5_20160202_iinuma/2/'; 
    './csv/6_20160202_maeda/1/'; 
    './csv/6_20160202_maeda/2/'; 
    './csv/7_20160225_cho/1/'; 
    './csv/7_20160225_cho/2/'
    };
prefixes = {
    {'20160128_203123_kato_js3', '20160128_200537_kato_av4'};
    {'20160128_210601_kato2_js', '20160128_210112_kato2_av2'};
    {'20160128_225707_takemori_js2', '20160128_232138_takemori_av3'};
    {'20160128_235247_takemori2_js2', '20160129_000514_takemori2_av3'};
    {'20160129_153332_kawai_js2', '20160129_152748_kawai_av2'};
    {'20160129_155712_kawai2_js', '20160129_155155_kawai2_av'};
    {'20160129_195839_kamimura_js10', '20160129_200809_kamimura_av10'};
    {'20160129_202254_kamimura2_js1', '20160129_204351_kamimura2_av3'};
    {'20160202_182528_iinuma_js2', '20160202_181025_iinuma_av3'};
    {'20160202_190221_iinuma2_js', '20160202_185446_iinuma2_av4'};
    {'20160202_211608_maeda1_js3', '20160202_214519_maeda1_av5'};
    {'20160202_220735_maeda2_js1', '20160202_221352_maeda2_av2'};
    {'20160225_203016_cho1_js2', '20160225_201353_cho1_av2'};
    {'20160225_213755_cho2_js2', '20160225_212753_cho2_av3'}
    };

folder = folders{foldersIDX};
refPrefix = prefixes{foldersIDX}{1}; 

virtualFlag = true;
realFlag = true;
jsFlag = true;
avFlag = true;
figFlag = true;

if jsFlag
    jsPrefix = prefixes{foldersIDX}{1};
    jsTimeRange = csvread( strcat(folder, jsPrefix, '_time.csv'), 1, 1);
    navigationTime = jsTimeRange(3) - jsTimeRange(2);
    pointingTime = jsTimeRange(5) - jsTimeRange(4);
    trackingTime = jsTimeRange(7) - jsTimeRange(6);    
    jsTime = [navigationTime; pointingTime; trackingTime; navigationTime+pointingTime; navigationTime+pointingTime+trackingTime]
end
if avFlag
    avPrefix = prefixes{foldersIDX}{2};
    avTimeRange = csvread( strcat(folder, avPrefix, '_time.csv'), 1, 1);
    navigationTime = avTimeRange(3) - avTimeRange(2);
    pointingTime = avTimeRange(5) - avTimeRange(4);
    trackingTime = avTimeRange(7) - avTimeRange(6);    
    avTime = [navigationTime; pointingTime; trackingTime; navigationTime+pointingTime; navigationTime+pointingTime+trackingTime]
end

outerRefRadius = 0.400/2.0;
innerRefRadius = 0.300/2.0;
centerRefRadius = (outerRefRadius + innerRefRadius)/2.0;

%%
if virtualFlag
    refVirtualCircleTraj = CircleRefTrajectory(folder, refPrefix, outerRefRadius, innerRefRadius);
    T = refVirtualCircleTraj.Torigin2center;
    T(1:3, 1:3) = inv(T(1:3, 1:3));
    T(1:3, 4) = -T(1:3, 1:3)*T(1:3, 4);
    
    if jsFlag
        jsVirtualEETraj = VirtualEETrajectory(folder, jsPrefix, jsTimeRange);
        polarTransformed = jsVirtualEETraj.transformTracking(T).pol;
        jsVirtualHorzError = calcCircleHorzError(centerRefRadius, centerRefRadius, polarTransformed)
%         jsVirtualHorzError = calcCircleHorzError(outerRefRadius, innerRefRadius, polarTransformed)
        jsVirtualVertError = calcCircleVertError(polarTransformed)
    end
    if avFlag
        avVirtualEETraj = VirtualEETrajectory(folder, avPrefix, avTimeRange);
        polarTransformed = avVirtualEETraj.transformTracking(T).pol;
        avVirtualHorzError = calcCircleHorzError(centerRefRadius, centerRefRadius, polarTransformed)
%         avVirtualHorzError = calcCircleHorzError(outerRefRadius, innerRefRadius, polarTransformed)
        avVirtualVertError = calcCircleVertError(polarTransformed)
    end
end

%%
if realFlag
    refRealCircleTraj = CircleRefTrajectory(folder, strcat(refPrefix,'_real'), outerRefRadius, innerRefRadius);
    T = refRealCircleTraj.Torigin2center;
    T(1:3, 1:3) = inv(T(1:3, 1:3));
    T(1:3, 4) = -T(1:3, 1:3)*T(1:3, 4);
    
    if jsFlag
        jsRealEETraj = RealEETrajectory(folder, jsPrefix, jsTimeRange);
        polarTransformed = jsRealEETraj.transformTracking(T).pol;
        jsRealHorzError = calcCircleHorzError(centerRefRadius, centerRefRadius, polarTransformed)
%         jsRealHorzError = calcCircleHorzError(outerRefRadius, innerRefRadius, polarTransformed)
        jsRealVertError = calcCircleVertError(polarTransformed)
    end
    if avFlag
        avRealEETraj = RealEETrajectory(folder, avPrefix, avTimeRange);
        polarTransformed = avRealEETraj.transformTracking(T).pol;
        avRealHorzError = calcCircleHorzError(centerRefRadius, centerRefRadius, polarTransformed)
%         avRealHorzError = calcCircleHorzError(outerRefRadius, innerRefRadius, polarTransformed)
        avRealVertError = calcCircleVertError(polarTransformed)
    end
end

A_data4copyAV = vertcat(avTime, avVirtualHorzError, avVirtualVertError, avRealHorzError, avRealVertError)
A_data4copyJS = vertcat(jsTime, jsVirtualHorzError, jsVirtualVertError, jsRealHorzError, jsRealVertError)

%%
if figFlag
    figNum = 1;
    if jsFlag
        if virtualFlag
            figNum = drawGraphs(figNum, 'JS-Virtual', refVirtualCircleTraj, jsVirtualEETraj);
        end
        if realFlag
            figNum = drawGraphs(figNum, 'JS-Real', refRealCircleTraj, jsRealEETraj);
        end
    end
    if avFlag
        if virtualFlag
            figNum = drawGraphs(figNum, 'AV-Virtual', refVirtualCircleTraj, avVirtualEETraj);
        end
        if realFlag
            figNum = drawGraphs(figNum, 'AV-Real', refRealCircleTraj, avRealEETraj);
        end
    end
end


