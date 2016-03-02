classdef PoseTrajectory < handle
    %PoseTrajectory
    %  self.position = [[x1, y1, z1];[x2, y2, z2];...;[xn, yn, zn]]
    %  self.rotation = [[x1, y1, z1, w1];[x2, y2, z2, w2];...;[xn, yn, zn, wn]]
    %  self.trajectory = horzcat(self.position, self.rotation)
    
    properties(GetAccess = public, SetAccess = private)
        trajectory;
        position;
        rotation;
        transformedPosition;
        offsetedPosition;
        trackingRadius;
        comOffset;
        all;
    end
    
    methods
        %%
        function self = PoseTrajectory(file_name, timeRange, csv_start_cell, pos_start_col, ori_start_col)
            trajectory_alldata = csvread( file_name, csv_start_cell(1), csv_start_cell(2));
            startCnt = 1;
            startNavigationCnt = 1;
            endNavigationCnt = 1;
            startPointingCnt = 1;
            endPointingCnt = 1;
            startTrackingCnt = 1;
            endTrackingCnt = 1;
            endCnt = 1;
            for i = 1:size(trajectory_alldata,1)
                time = trajectory_alldata(i, 1);
                startCnt = self.setTimeCnt(time, timeRange(1), startCnt, i);
                startNavigationCnt = self.setTimeCnt(time, timeRange(2), startNavigationCnt, i);
                endNavigationCnt = self.setTimeCnt(time, timeRange(3), endNavigationCnt, i);
                startPointingCnt = self.setTimeCnt(time, timeRange(4), startPointingCnt, i);
                endPointingCnt = self.setTimeCnt(time, timeRange(5), endPointingCnt, i);
                startTrackingCnt = self.setTimeCnt(time, timeRange(6), startTrackingCnt, i);
                endTrackingCnt = self.setTimeCnt(time, timeRange(7), endTrackingCnt, i);
                endCnt = self.setTimeCnt(time, timeRange(8), endCnt, i);
                if (endCnt > 1)
                    break;
                end
            end
            self.position.navi = trajectory_alldata(startNavigationCnt:endNavigationCnt, pos_start_col:pos_start_col+2);
            self.rotation.navi = trajectory_alldata(startNavigationCnt:endNavigationCnt, ori_start_col:ori_start_col+3);
            
            self.position.pointing = trajectory_alldata(startPointingCnt:endPointingCnt, pos_start_col:pos_start_col+2);
            self.rotation.pointing = trajectory_alldata(startPointingCnt:endPointingCnt, ori_start_col:ori_start_col+3);
            
            self.position.tracking = trajectory_alldata(startTrackingCnt:endTrackingCnt, pos_start_col:pos_start_col+2);
            self.rotation.tracking = trajectory_alldata(startTrackingCnt:endTrackingCnt, ori_start_col:ori_start_col+3);
            
            self.position.all = vertcat(self.position.navi, self.position.pointing, self.position.tracking);
            self.rotation.all = vertcat(self.rotation.navi, self.rotation.pointing, self.rotation.tracking);

            self.trajectory.navi = horzcat(self.position.navi, self.rotation.navi);
            self.trajectory.pointing = horzcat(self.position.pointing, self.rotation.pointing);
            self.trajectory.tracking = horzcat(self.position.tracking, self.rotation.tracking);
            self.trajectory.all = horzcat(self.position.all, self.rotation.all);
        end
        %%
        function trajectoryPos = transformTracking(self, T)
            self.transformedPosition.tracking = self.transform(self.position.tracking, T);
            trajectoryPos = self.transformedPosition.tracking;
        end
        function trajectoryPos = offsetCOMTracking(self)
            [x, y, z] = self.calcCOM(self.transformedPosition.tracking.cart);
            T=[[1,0,0,-x];
                [0,1,0,-y];
                [0,0,1,-z];
                [0,0,0, 1]];
            self.comOffset = [x; y; z];
            self.offsetedPosition.tracking = self.transform(self.transformedPosition.tracking.cart, T);
            self.trackingRadius = sum(self.offsetedPosition.tracking.pol(:, 1))/size(self.offsetedPosition.tracking.pol(:, 1), 1); 
            trajectoryPos = self.offsetedPosition.tracking;
        end
        function figObj = drawAllTrajectory(self, figNum)
            self.drawNaviTrajectory(figNum);
            self.drawPointingTrajectory(figNum);
            figObj = self.drawTrackingTrajectory(figNum);
        end
        function figObj = drawNaviTrajectory(self, figNum)
            figObj = self.drawTrajectory(figNum, self.position.navi, 'c', 5);
        end
        function figObj = drawPointingTrajectory(self, figNum)
            figObj = self.drawTrajectory(figNum, self.position.pointing, 'g', 5);
        end
        function figObj = drawTrackingTrajectory(self, figNum)
            figObj = self.drawTrajectory(figNum, self.position.tracking, 'b', 5);
        end
    end
    methods(Access = private)
        function timeCnt = setTimeCnt(self, currTime, limitTime, cnt, idx)
            if (currTime > limitTime) && (cnt==1)
                timeCnt = idx;
            else
                timeCnt = cnt;
            end 
        end
        function trajectoryPos = transform(self, position, T)
            pos = horzcat(position, ones(size(position, 1),1));
            transformed = (T * pos')';
            trajectoryPos.cart = [transformed(:,1), transformed(:,2), transformed(:,3)];
            
            [th, r, z] = cart2pol(transformed(:,1), transformed(:,2), transformed(:,3));
            trajectoryPos.pol = [r, th, z];
            
            [azimuth,elevation,r] = cart2sph(transformed(:,1), transformed(:,2), transformed(:,3));
            trajectoryPos.sph = [r, azimuth,elevation];                
        end    
        function figObj = drawTrajectory(self, figNum, position, color, lineWidth)
            if isempty(figNum)
                figObj = figure();
                figure(figObj);
            else
                figObj = figure(figNum);
            end
            grid on;hold on;
            plot3(position(:,1), position(:,2), position(:,3), 'Color', color, 'LineWidth', lineWidth);          
        end
        function [x, y, z] = calcCOM(self, position)
            function xCom = calcLineCOM(xList)
                resolution = 0.005;
                xSortedList = sort(xList);
                xRepresentedDataList = [];
                i = 1;
                N = size(xSortedList, 2);
                while i <= N
                    xSum = 0;
                    xEdge = xSortedList(i);
                    n = 0;
                    while i <= N && abs(xSortedList(i) - xEdge) < resolution
                        xSum = xSum + xSortedList(i);
                        n = n + 1;
                        i = i + 1;  
                    end
                    if n > 0
                        xRepresentedDataList = [xRepresentedDataList, xSum/n];
                    end
                end
                N = size(xRepresentedDataList,2);
                xCom = sum(xRepresentedDataList)/N;
            end
            
            com = [0,0,0];
            for idx =1:3
                com(idx) = calcLineCOM(position(:, idx)');
            end
            x = com(1);
            y = com(2);
            z = com(3);
        end
        function [x, y, z] = calcCOM_simple(self, position)
            com = [0,0,0];
            n = size(position,1);
            if n > 0
                for i = 1:n
                    com = com + position(i, 1:3);
                end      
                com = com/n;
            end
            x = com(1);
            y = com(2);
            z = com(3);
        end
    end
end


