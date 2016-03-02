function data = getAnalyzedData( folder, prefixes, virtualFlag, realFlag, jsFlag, avFlag, av2js)


%%
data.av2js = av2js;
refPrefix = prefixes{1};

if jsFlag
    jsPrefix = prefixes{1};
    jsTimeRange = csvread( strcat(folder, jsPrefix, '_time.csv'), 1, 1);
    navigationTime = jsTimeRange(3) - jsTimeRange(2);
    pointingTime = jsTimeRange(5) - jsTimeRange(4);
    trackingTime = jsTimeRange(7) - jsTimeRange(6);
    data.js.time = [navigationTime; pointingTime; trackingTime; navigationTime+pointingTime; navigationTime+pointingTime+trackingTime];
end
if avFlag
    avPrefix = prefixes{2};
    avTimeRange = csvread( strcat(folder, avPrefix, '_time.csv'), 1, 1);
    navigationTime = avTimeRange(3) - avTimeRange(2);
    pointingTime = avTimeRange(5) - avTimeRange(4);
    trackingTime = avTimeRange(7) - avTimeRange(6);
    data.av.time = [navigationTime; pointingTime; trackingTime; navigationTime+pointingTime; navigationTime+pointingTime+trackingTime];
end

tooltipRadius = 0.025;
outerRefRadius = 0.400/2.0;
innerRefRadius = 0.300/2.0;
centerRefRadius = (outerRefRadius + innerRefRadius)/2.0;
outerCalcRefRadius = centerRefRadius;
innerCalcRefRadius = centerRefRadius;
zMergin = 0;
% outerCalcRefRadius = outerRefRadius + tooltipRadius;
% innerCalcRefRadius = innerRefRadius - tooltipRadius;
% zMergin = tooltipRadius;
offsetCancelFlag = true;

%%
if virtualFlag
    data.refVirtualCircleTraj = CircleRefTrajectory(folder, refPrefix, outerRefRadius, innerRefRadius);
    T = data.refVirtualCircleTraj.Torigin2center;
    T(1:3, 1:3) = inv(T(1:3, 1:3));
    T(1:3, 4) = -T(1:3, 1:3)*T(1:3, 4);
    
    if jsFlag
        data.js.virtualEETraj = VirtualEETrajectory(folder, jsPrefix, jsTimeRange);
        polarTransformed = data.js.virtualEETraj.transformTracking(T).pol;
        polarTransformedCoMOffseted = data.js.virtualEETraj.offsetCOMTracking().pol;
        if offsetCancelFlag
            polPosition = polarTransformedCoMOffseted;
        else
            polPosition = polarTransformed;
        end
        data.js.virtualHorzError = calcCircleHorzError(outerCalcRefRadius, innerCalcRefRadius, polPosition);
        data.js.virtualVertError = calcCircleVertError(polarTransformedCoMOffseted, zMergin);
    end
    if avFlag
        data.av.virtualEETraj = VirtualEETrajectory(folder, avPrefix, avTimeRange);
        polarTransformed = data.av.virtualEETraj.transformTracking(T).pol;
        polarTransformedCoMOffseted = data.av.virtualEETraj.offsetCOMTracking().pol;
         if offsetCancelFlag
            polPosition = polarTransformedCoMOffseted;
        else
            polPosition = polarTransformed;
        end
        data.av.virtualHorzError = calcCircleHorzError(outerCalcRefRadius, innerCalcRefRadius, polPosition);
        data.av.virtualVertError = calcCircleVertError(polarTransformedCoMOffseted, zMergin);
    end
end

%%
if realFlag
    data.refRealCircleTraj = CircleRefTrajectory(folder, strcat(refPrefix,'_real'), outerRefRadius, innerRefRadius);
    T = data.refRealCircleTraj.Torigin2center;
    T(1:3, 1:3) = inv(T(1:3, 1:3));
    T(1:3, 4) = -T(1:3, 1:3)*T(1:3, 4);
    
    if jsFlag
        data.js.realEETraj = RealEETrajectory(folder, jsPrefix, jsTimeRange);
        polarTransformed = data.js.realEETraj.transformTracking(T).pol;
        polarTransformedCoMOffseted = data.js.realEETraj.offsetCOMTracking().pol;
        if offsetCancelFlag
            polPosition = polarTransformedCoMOffseted;
        else
            polPosition = polarTransformed;
        end
        data.js.realHorzError = calcCircleHorzError(outerCalcRefRadius, innerCalcRefRadius, polPosition);
        data.js.realVertError = calcCircleVertError(polarTransformedCoMOffseted, zMergin);
    end
    if avFlag
        data.av.realEETraj = RealEETrajectory(folder, avPrefix, avTimeRange);
        polarTransformed = data.av.realEETraj.transformTracking(T).pol;
        polarTransformedCoMOffseted = data.av.realEETraj.offsetCOMTracking().pol;
        if offsetCancelFlag
            polPosition = polarTransformedCoMOffseted;
        else
            polPosition = polarTransformed;
        end
        data.av.realHorzError = calcCircleHorzError(outerCalcRefRadius, innerCalcRefRadius, polPosition);
        data.av.realVertError = calcCircleVertError(polarTransformedCoMOffseted, zMergin);
    end
end

data.av.summary = vertcat(data.av.time, data.av.virtualHorzError, data.av.virtualVertError, data.av.realHorzError, data.av.realVertError, data.av.virtualEETraj.comOffset, data.av.realEETraj.comOffset);
data.js.summary = vertcat(data.js.time, data.js.virtualHorzError, data.js.virtualVertError, data.js.realHorzError, data.js.realVertError, data.js.virtualEETraj.comOffset, data.js.realEETraj.comOffset);

%%
% if figFlag
%     figNum = 1;
%     if jsFlag
%         if virtualFlag
%             figNum = drawGraphs(figNum, 'JS-Virtual', refVirtualCircleTraj, jsVirtualEETraj);
%         end
%         if realFlag
%             figNum = drawGraphs(figNum, 'JS-Real', refRealCircleTraj, jsRealEETraj);
%         end
%     end
%     if avFlag
%         if virtualFlag
%             figNum = drawGraphs(figNum, 'AV-Virtual', refVirtualCircleTraj, avVirtualEETraj);
%         end
%         if realFlag
%             figNum = drawGraphs(figNum, 'AV-Real', refRealCircleTraj, avRealEETraj);
%         end
%     end
% end

end
