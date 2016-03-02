%%
% If you want to add new data, you have to do 4 steps
%
% 1. Add the folder name to 'folders'
% 2. Add the file prefix to 'prefixes'
% 3. Add a new variable in the nest of 'if recalcFlag'
% 4. Add the variable to 'cells'
%
% After running the scrpt, you can check the result in 'result'
% (See the excel file if you want to use 'result' to analyze it)
%%
close all hidden

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
    './csv/5_20160202_iinuma/3/';
    './csv/6_20160202_maeda/1/';
    './csv/6_20160202_maeda/2/'; 
    './csv/7_20160225_cho/1/'; 
    './csv/7_20160225_cho/2/'; 
    './csv/8_20160229_yamamoto/1/'; 
    './csv/8_20160229_yamamoto/2/'; 
    './csv/9_20160301_katsumoto/1/'; 
    './csv/9_20160301_katsumoto/2/'; 
    './csv/10_20160301_hayakawa/1/'; 
    './csv/10_20160301_hayakawa/2/'
    };
dataNum = size(folders, 1);
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
    {'20160205_194610_iinuma3_js', '20160205_194116_iinuma3_av'};
    {'20160202_211608_maeda1_js3', '20160202_214519_maeda1_av5'};
    {'20160202_220735_maeda2_js1', '20160202_221352_maeda2_av2'};
    {'20160225_203016_cho1_js2', '20160225_201353_cho1_av2'};
    {'20160225_213755_cho2_js2', '20160225_212753_cho2_av3'};
    {'20160229_182148_yamamoto1-1_js1', '20160229_183311_yamamoto1-1_av1'};
    {'20160229_195612_yamamoto2-1_js1', '20160229_201419_yamamoto2-1_av1'};
    {'20160301_152030_katsumoto1_js1', '20160301_151503_katsumoto1_av1'};
    {'20160301_155229_katsumoto2_js2', '20160301_154745_katsumoto2_av2'};
    {'20160301_215134_hayakawa_js1', '20160301_220055_hayakawa1_av1'};
    {'20160301_222625_hayakawa2_js1', '20160301_223916_hayakawa2_av2'}
    };

virtualFlag = true;
realFlag = true;
jsFlag = true;
avFlag = true;
figFlag = true;
recalcFlag = true;

if recalcFlag
    kato1 = getAnalyzedData( folders{1}, prefixes{1}, virtualFlag, realFlag, jsFlag, avFlag, true);
    kato2 = getAnalyzedData( folders{2}, prefixes{2}, virtualFlag, realFlag, jsFlag, avFlag, true);
    take1 = getAnalyzedData( folders{3}, prefixes{3}, virtualFlag, realFlag, jsFlag, avFlag, false);
    take2 = getAnalyzedData( folders{4}, prefixes{4}, virtualFlag, realFlag, jsFlag, avFlag, false);
    kawa1 = getAnalyzedData( folders{5}, prefixes{5}, virtualFlag, realFlag, jsFlag, avFlag, true);
    kawa2 = getAnalyzedData( folders{6}, prefixes{6}, virtualFlag, realFlag, jsFlag, avFlag, true);
    kami1 = getAnalyzedData( folders{7}, prefixes{7}, virtualFlag, realFlag, jsFlag, avFlag, false);
    kami2 = getAnalyzedData( folders{8}, prefixes{8}, virtualFlag, realFlag, jsFlag, avFlag, false);
    iinu1 = getAnalyzedData( folders{9}, prefixes{9}, virtualFlag, realFlag, jsFlag, avFlag, true);
    iinu2 = getAnalyzedData( folders{10}, prefixes{10}, virtualFlag, realFlag, jsFlag, avFlag, true);
    maed1 = getAnalyzedData( folders{11}, prefixes{11}, virtualFlag, realFlag, jsFlag, avFlag, false);
    maed2 = getAnalyzedData( folders{12}, prefixes{12}, virtualFlag, realFlag, jsFlag, avFlag, false);
    chou1 = getAnalyzedData( folders{13}, prefixes{13}, virtualFlag, realFlag, jsFlag, avFlag, true);
    chou2 = getAnalyzedData( folders{14}, prefixes{14}, virtualFlag, realFlag, jsFlag, avFlag, true);
    yama1 = getAnalyzedData( folders{15}, prefixes{15}, virtualFlag, realFlag, jsFlag, avFlag, false);
    yama2 = getAnalyzedData( folders{16}, prefixes{16}, virtualFlag, realFlag, jsFlag, avFlag, false);
    kats1 = getAnalyzedData( folders{17}, prefixes{17}, virtualFlag, realFlag, jsFlag, avFlag, true);
    kats2 = getAnalyzedData( folders{18}, prefixes{18}, virtualFlag, realFlag, jsFlag, avFlag, true);
    haya1 = getAnalyzedData( folders{19}, prefixes{19}, virtualFlag, realFlag, jsFlag, avFlag, false);
    haya2 = getAnalyzedData( folders{20}, prefixes{20}, virtualFlag, realFlag, jsFlag, avFlag, false);

    cells = {kato1, kato2, take1, take2, kawa1, kawa2, kami1, kami2, iinu1, iinu2, maed1, maed2, chou1, chou2, yama1, yama2, kats1, kats2, haya1, haya2};
end

for i=1:dataNum
    data = cells{i};
    trackingRadius.average(1, i) = mean(data.av.virtualEETraj.offsetedPosition.tracking.pol(:, 1));
    trackingRadius.average(2, i) = mean(data.js.virtualEETraj.offsetedPosition.tracking.pol(:, 1));
    trackingRadius.averageRate(1, i) = trackingRadius.average(1, i)/0.175;
    trackingRadius.averageRate(2, i) = trackingRadius.average(2, i)/0.175;
    trackingRadius.error(1, i) = 100*trackingRadius.average(1, i)-0.175;
    trackingRadius.error(2, i) = 100*trackingRadius.average(2, i)-0.175;
    trackingRadius.errorRate(1, i) = 100*trackingRadius.error(1, i)/0.175;
    trackingRadius.errorRate(2, i) = 100*trackingRadius.error(2, i)/0.175;
    trackingRadius.var(1, i) = var(data.av.virtualEETraj.offsetedPosition.tracking.pol(:, 1));
    trackingRadius.var(2, i) = var(data.js.virtualEETraj.offsetedPosition.tracking.pol(:, 1));
    trackingRadius.std(1, i) = std(data.av.virtualEETraj.offsetedPosition.tracking.pol(:, 1));
    trackingRadius.std(2, i) = std(data.js.virtualEETraj.offsetedPosition.tracking.pol(:, 1));    
end



%% Set data to 'result'
result = zeros(15, dataNum*2);
for i = 1:dataNum
    data = cells{i};
    j = i*2 - 1;
    if data.av2js
        result(:, j) = data.av.summary;
        result(:, j+1) = data.js.summary;
    else
        result(:, j) = data.js.summary;
        result(:, j+1) = data.av.summary;
    end    
end


%%
figNum = 0;

%%
% 
% for i = 1:12
%     figure();
%     targetData = cells{i};
%     subplot(4, 1, 1)
%     plot(1:size(targetData.av.virtualEETraj.transformedPosition.tracking.pol(:,2), 1), targetData.av.virtualEETraj.transformedPosition.tracking.pol(:,2));
%     subplot(4, 1, 2)
%     plot(1:size(targetData.av.realEETraj.transformedPosition.tracking.pol(:,2), 1), targetData.av.realEETraj.transformedPosition.tracking.pol(:,2));
%     subplot(4, 1, 3)
%     plot(1:size(targetData.js.virtualEETraj.transformedPosition.tracking.pol(:,2), 1), targetData.js.virtualEETraj.transformedPosition.tracking.pol(:,2));
%     subplot(4, 1, 4)
%     plot(1:size(targetData.js.realEETraj.transformedPosition.tracking.pol(:,2), 1), targetData.js.realEETraj.transformedPosition.tracking.pol(:,2));
% end


% figNum = figNum + 1;
% figure('name', 'Tracking Example (Top: Proposed Method, Bottom: Compared Method)');
% targetData = iinu2;
% subplot(2, 1, 1)
% drawTrackingHorizon(figNum, targetData.refVirtualCircleTraj, targetData.av.virtualEETraj);
% subplot(2, 1, 2)
% drawTrackingHorizon(figNum, targetData.refVirtualCircleTraj, targetData.js.virtualEETraj);


%
figNum = figNum + 1;
plcNum = 1;
rowNum = 4;
colNum = dataNum/2;
figure('name', 'TrackingHorizon@AVVR-AVRE-JSVR-JSRE');
for i = 1:colNum
    targetData = cells{i};
    subplot(rowNum, colNum, plcNum)
    drawTrackingHorizon(figNum, targetData.refVirtualCircleTraj, targetData.av.virtualEETraj);
    subplot(rowNum, colNum, plcNum + colNum)
    drawTrackingHorizon(figNum, targetData.refRealCircleTraj, targetData.av.realEETraj);
    subplot(rowNum, colNum, plcNum + 2*colNum)
    drawTrackingHorizon(figNum, targetData.refVirtualCircleTraj, targetData.js.virtualEETraj);
    subplot(rowNum, colNum, plcNum + 3*colNum)
    drawTrackingHorizon(figNum, targetData.refRealCircleTraj, targetData.js.realEETraj);
    plcNum = plcNum + 1;
end

figNum = figNum + 1;
plcNum = 1;
rowNum = 4;
colNum = dataNum/2;
figure('name', 'TrackingHorizon@AVVR-AVRE-JSVR-JSRE');
for i = colNum+1:dataNum
    targetData = cells{i};
    subplot(rowNum, colNum, plcNum)
    drawTrackingHorizon(figNum, targetData.refVirtualCircleTraj, targetData.av.virtualEETraj);
    subplot(rowNum, colNum, plcNum + colNum)
    drawTrackingHorizon(figNum, targetData.refRealCircleTraj, targetData.av.realEETraj);
    subplot(rowNum, colNum, plcNum + 2*colNum)
    drawTrackingHorizon(figNum, targetData.refVirtualCircleTraj, targetData.js.virtualEETraj);
    subplot(rowNum, colNum, plcNum + 3*colNum)
    drawTrackingHorizon(figNum, targetData.refRealCircleTraj, targetData.js.realEETraj);
    plcNum = plcNum + 1;
end




















