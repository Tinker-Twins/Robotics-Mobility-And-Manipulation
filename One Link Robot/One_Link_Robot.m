%% Clear Workspace

clear;
clc;

%% CoppeliaSim Remote API Connection

vrep = remApi('remoteApi');
vrep.simxFinish(-1);

clientID = vrep.simxStart('127.0.0.1', 19999, true, true, 5000, 5);

if clientID > -1
    disp('Connected to CoppeliaSim!');
    % Get Data From Simulator
    [r, joint] = vrep.simxGetObjectHandle(clientID, 'J1', vrep.simx_opmode_blocking);
    % Command Robot Joint
    while true
        % Test joint motion with constant velocity
        % [r] = vrep.simxSetJointTargetVelocity(clientID, joint, deg2rad(120), vrep.simx_opmode_streaming);

        % Test joint motion with sinusoidal velocity
        [Time]=vrep.simxGetLastCmdTime(clientID);
        A = 30;
        w = 2;
        t = Time/1000;
        W = A*sin(w*t);
        [r] = vrep.simxSetJointTargetVelocity(clientID, joint, deg2rad(W), vrep.simx_opmode_streaming);
    end

else
    disp('ERROR Connecting to CoppeliaSim!');
end

vrep.delete();
disp('Simulation Finished Successfully!');