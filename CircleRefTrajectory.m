classdef CircleRefTrajectory < handle
    %CircleRefTrajectory
    % cornerUpRight, UpLeft, LowRight, LowLeft are the corners of a
    % rectangle where there is a ref_trajectory circle which center is the
    % center of the rectangle
   
    properties(GetAccess = public, SetAccess = private)
        outerR;
        innerR;
        outerCircle;
        innerCircle;
        outerLocalCircle;
        innerLocalCircle;
        cornerUpRight;
        cornerUpLeft;
        cornerLowRight;
        cornerLowLeft;
        Torigin2center;
    end
    
    methods
        %% 
        function self = CircleRefTrajectory(folder, prefix, outerR, innerR)
            self.outerR = outerR;
            self.innerR = innerR;
            
            corners = csvread( strcat(folder, prefix, '_ref_trajectory.csv'), 1, 0);
            self.cornerUpLeft = corners(1, 1:3)';
            self.cornerUpRight = corners(2, 1:3)';
            self.cornerLowLeft = corners(3, 1:3)';
            self.cornerLowRight = corners(4, 1:3)';
            self.Torigin2center = eye(4);
            
            self.calcCircle();
        end
        %%
        function calcCircle(self)
            self.calcTranslation();
            self.calcRotation();
            
            [self.outerCircle, self.outerLocalCircle] = self.calcCircleTrajectory(self.outerR);
            [self.innerCircle, self.innerLocalCircle] = self.calcCircleTrajectory(self.innerR);
        end
        %%
        function figObj = drawCircle(self, figNum)
            if isempty(figNum)
                figObj = figure();
                figure(figObj);
            else
                figObj = figure(figNum);
            end
            grid on;    
            hold on;
            plot3(self.outerCircle(1,:), self.outerCircle(2,:), self.outerCircle(3,:), 'Color', 'r', 'LineWidth', 3);
            plot3(self.innerCircle(1,:), self.innerCircle(2,:), self.innerCircle(3,:), 'Color', 'r', 'LineWidth', 3);            
        end
        function figObj = drawEdges(self, figNum)
            if isempty(figNum)
                figObj = figure();
                figure(figObj);
            else
                figObj = figure(figNum);
            end
            grid on;    
            hold on;
            edges = self.getEdges();
            plot3(edges(1,:), edges(2,:), edges(3,:), 'Color', 'black', 'LineWidth', 1);            
        end

    end
    methods(Access = private)
        %%
        function calcTranslation(self)
            vecCenter = (self.cornerUpRight + self.cornerLowLeft)/2.0;
            self.Torigin2center(1:3, 4) = vecCenter;
        end
        function calcRotation(self)
            ex = (self.cornerUpRight - self.cornerUpLeft) / norm(self.cornerUpRight - self.cornerUpLeft);
            ey_temp = (self.cornerUpLeft - self.cornerLowLeft) / norm(self.cornerUpLeft - self.cornerLowLeft);
            ez_temp = cross(ex, ey_temp);
            ez = ez_temp/norm(ez_temp);
            ey = cross(ez, ex);
            self.Torigin2center(1:3, 1) = ex;
            self.Torigin2center(1:3, 2) = ey;
            self.Torigin2center(1:3, 3) = ez;
        end
        function [circle, localCircle] = calcCircleTrajectory(self, radius)
            theta = [0:0.001:2*pi];
            localCircle = [
                radius*cos(theta);
                radius*sin(theta);
                zeros(1, size(theta, 2));
                ones(1, size(theta, 2))];
            circle = self.Torigin2center * localCircle;
        end
        function edges = getEdges(self)
            edges = [[self.cornerUpLeft(1), self.cornerUpRight(1), self.cornerLowRight(1), self.cornerLowLeft(1), self.cornerUpLeft(1)];
                [self.cornerUpLeft(2), self.cornerUpRight(2), self.cornerLowRight(2), self.cornerLowLeft(2), self.cornerUpLeft(2)];
                [self.cornerUpLeft(3), self.cornerUpRight(3), self.cornerLowRight(3), self.cornerLowLeft(3), self.cornerUpLeft(3)]];
        end
    end
    
end

