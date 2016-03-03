function figNum = drawAllTrajectory( figNum, data, avFlag, virtualFlag)
    
    if avFlag
        if virtualFlag
            eeTrajIns = data.av.virtualEETraj;
            circleTrajIns = data.refVirtualCircleTraj;
        else
            eeTrajIns = data.av.realEETraj;
            circleTrajIns = data.refRealCircleTraj;
        end
    else
        if virtualFlag
            eeTrajIns = data.js.virtualEETraj;
            circleTrajIns = data.refVirtualCircleTraj;
        else
            eeTrajIns = data.js.realEETraj;
            circleTrajIns = data.refRealCircleTraj;
        end
    end

    grid on;hold on;
    circleTrajIns.drawCircle(figNum);
    circleTrajIns.drawEdges(figNum);
    eeTrajIns.drawAllTrajectory(figNum);
    axis equal


end


