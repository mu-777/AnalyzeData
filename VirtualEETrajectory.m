classdef VirtualEETrajectory < PoseTrajectory
    methods
        function self = VirtualEETrajectory(folder, prefix, timeRange)
            self@PoseTrajectory(strcat(folder, prefix, '_link_peg_tip_robot.csv'), timeRange, [1,0], 6, 9);
        end
    end
end

