function [rotX, rotY, rotZ] = calculate_rotation_angles(alpha,timer)
    %% Given Parameters
    Ft = 50;        % Total applied force in newtons
    r = 0.1;        % Distance from the central axis
    dt = 0.01;       % Time step
    n = 4;
    
    %% Initialize Variables
    F1 = zeros(3, n);
    M1 = zeros(3, n);
    omega = zeros(3).';
    rot = zeros(3).';
    I = [7;7;2];  
    %% Calculate Forces and Moments
    F1(1, :) = Ft * sind(alpha);
    F1(3, :) = Ft * cosd(alpha);
    M1(1, 1:2) = -r * F1(3, 1:2);
    M1(2, 3:4) = -r * F1(3, 3:4);
    M1(3, [1,2,4]) = r * F1(1, [1,2,4]);
    M1(3, 3) = r * F1(2, 3);

    %% Individual Axis omega
    for l=1:3
        omega(l) = sum(M1(l,:)) / I(l);
    end
    %% Calculate Rotation
    total_time = 0; 
    while total_time < timer
        total_time = total_time + dt;
        for l1=1:3
            rot_change = omega(l1) * dt; % Calculate rotation change
            rot(l1) = rot(l1) + rad2deg(rot_change); % Update rotation in degrees
        end
    end
    rotX = rot(1);
    rotY = rot(2);
    rotZ = rot(3);
end
