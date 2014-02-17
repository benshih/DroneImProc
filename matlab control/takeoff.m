% Place takeoff.m and ARDrone.m in same directory. 
% Set file path to point to the directory containing both files. 

% Takeoff/Land sequence.
drone = ARDrone
drone.takeoff
pause
drone.land


% Collect sensor data
