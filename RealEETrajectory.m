classdef RealEETrajectory < PoseTrajectory
    methods
        function self = RealEETrajectory(folder, prefix, timeRange)
            self@PoseTrajectory(strcat(folder, prefix, '_mocap_tooltip.csv'), timeRange, [1,0], 6, 9);
        end
    end
end

