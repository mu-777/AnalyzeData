function figNum = drawGraphs( figNum, winTitle, circleTrajIns, eeTrajIns)
    
    figure('name', winTitle);
    grid on;hold on;
    
    circleTrajIns.drawCircle(figNum);
    circleTrajIns.drawEdges(figNum);
    eeTrajIns.drawAllTrajectory(figNum);
    axis equal

    figNum = figNum + 1;

    figure('name', winTitle);
    grid on;hold on;
    plot3(eeTrajIns.transformedPosition.tracking.cart(:,1), eeTrajIns.transformedPosition.tracking.cart(:,2), eeTrajIns.transformedPosition.tracking.cart(:,3),'Color', 'b', 'LineWidth', 1, 'Marker', 'o', 'MarkerSize', 2)
    
%     outerPol = [eeTrajIns.transformedPosition.tracking.pol(:,1) + 0.025,  eeTrajIns.transformedPosition.tracking.pol(:,2), eeTrajIns.transformedPosition.tracking.pol(:,3)];
%     plot3(outerPol(:,1).*cos(outerPol(:,2)), outerPol(:,1).*sin(outerPol(:,2)), outerPol(:,3),'Color', 'g', 'LineWidth', 1);
%     innerPol = [eeTrajIns.transformedPosition.tracking.pol(:,1) - 0.025,  eeTrajIns.transformedPosition.tracking.pol(:,2), eeTrajIns.transformedPosition.tracking.pol(:,3)];
%     plot3(innerPol(:,1).*cos(innerPol(:,2)), innerPol(:,1).*sin(innerPol(:,2)), innerPol(:,3),'Color', 'g', 'LineWidth', 1);
    
    plot3(circleTrajIns.outerLocalCircle(1,:), circleTrajIns.outerLocalCircle(2,:), circleTrajIns.outerLocalCircle(3,:),'Color', 'r', 'LineWidth', 3)
    plot3(circleTrajIns.innerLocalCircle(1,:), circleTrajIns.innerLocalCircle(2,:), circleTrajIns.innerLocalCircle(3,:),'Color', 'r', 'LineWidth', 3)
    axis equal

%     subplot(2,2,3);    
%     grid on;hold on;
%     plot(eeTrajIns.transformedPosition.tracking.pol(:,1).*cos(eeTrajIns.transformedPosition.tracking.pol(:,2)), eeTrajIns.transformedPosition.tracking.pol(:,1).*sin(eeTrajIns.transformedPosition.tracking.pol(:,2)),'Color', 'b', 'LineWidth', 1, 'Marker', 'x', 'MarkerSize', 3)
%     plot(circleTrajIns.outerLocalCircle(1,:), circleTrajIns.outerLocalCircle(2,:),'Color', 'r', 'LineWidth', 3)
%     plot(circleTrajIns.innerLocalCircle(1,:), circleTrajIns.innerLocalCircle(2,:),'Color', 'r', 'LineWidth', 3)
%     axis equal

%     subplot(2,2,4);    
%     grid on;hold on;
%     plot(eeTrajIns.transformedPosition.tracking.cart(:,3), eeTrajIns.transformedPosition.tracking.cart(:,2),'Color', 'b', 'LineWidth', 1, 'Marker', 'x', 'MarkerSize', 3)
%     plot(circleTrajIns.outerLocalCircle(3,:), circleTrajIns.outerLocalCircle(2,:),'Color', 'r', 'LineWidth', 3)
%     plot(circleTrajIns.innerLocalCircle(3,:), circleTrajIns.innerLocalCircle(2,:),'Color', 'r', 'LineWidth', 3)
%     axis equal

    figNum = figNum + 1;

end


