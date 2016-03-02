function figNum = drawAllTrajectory( figNum, circleTrajIns, eeTrajIns)
    
    grid on;hold on;
    circleTrajIns.drawCircle(figNum);
    circleTrajIns.drawEdges(figNum);
    eeTrajIns.drawAllTrajectory(figNum);
    axis equal


end


