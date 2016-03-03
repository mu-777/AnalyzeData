function figNum = drawTrackingHorizon( figNum, data, avFlag, virtualFlag)
    
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
    plot3(eeTrajIns.transformedPosition.tracking.cart(:,1), eeTrajIns.transformedPosition.tracking.cart(:,2), eeTrajIns.transformedPosition.tracking.cart(:,3),'Color', 'b', 'LineWidth', 1, 'Marker', 'o', 'MarkerSize', 2)    
    plot3(eeTrajIns.offsetedPosition.tracking.cart(:,1), eeTrajIns.offsetedPosition.tracking.cart(:,2), eeTrajIns.offsetedPosition.tracking.cart(:,3),'Color', 'g', 'LineWidth', 1, 'Marker', 'o', 'MarkerSize', 2)    
    plot3(circleTrajIns.outerLocalCircle(1,:), circleTrajIns.outerLocalCircle(2,:), circleTrajIns.outerLocalCircle(3,:),'Color', 'r', 'LineWidth', 3)
    plot3(circleTrajIns.innerLocalCircle(1,:), circleTrajIns.innerLocalCircle(2,:), circleTrajIns.innerLocalCircle(3,:),'Color', 'r', 'LineWidth', 3)
    axis equal

end


