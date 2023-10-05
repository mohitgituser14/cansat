clear; clc;

test = zeros(200, 1);
i = 1;




%% Given Parameters
Ft = 50;        % Total applied force in newtons

r = 0.1;        % Distance from the central axis

dt = 0.01;       % Time step
n = 4;

%% Initialize Variables
F1 = zeros(3, n);
M1 = zeros(3, n);
omega = zeros(3);
rot = zeros(3);
I = zeros(3);
I(1) = 7;
I(2) = 7;
I(3) = 2;

alpha = zeros(4);      % Angle range in degrees

%% Calculate Forces and Moments
alpha(1) = 0;
alpha(2) = 0;
alpha(3) = 0;
alpha(4) = 0;
    % Calculate Forces
    F1(1, 1) = Ft * sind(alpha(1));
    F1(2, 1) = 0;
    F1(3, 1) = Ft * cosd(alpha(1));
    
    F1(1, 2) = Ft * sind(alpha(2));
    F1(2, 2) = 0;
    F1(3, 2) = Ft * cosd(alpha(2));
    
    F1(1, 3) = 0;
    F1(2, 3) = Ft * sind(alpha(3));
    F1(3, 3) = Ft * cosd(alpha(3));
    
    F1(1, 4) = 0;
    F1(2, 4) = Ft * sind(alpha(4));
    F1(3, 4) = Ft * cosd(alpha(4));
    
    % Calculate Moments
    M1(1, 1) = F1(3, 1) * r;
    M1(2, 1) = F1(2, 1) * r;
    M1(3, 1) = F1(1, 1) * r;
    
    M1(1, 2) = -(F1(3, 2) * r);
    M1(1, 2) = -(F1(2, 2) * r);
    M1(3, 2) = -(F1(1, 2) * r);
    
    M1(1, 3) = -(F1(1, 3) * r);
    M1(2, 3) = -(F1(3, 3) * r);
    M1(3, 3) = (F1(2, 3) * r);
    
    M1(1, 4) = (F1(1, 4) * r);
    M1(2, 4) = (F1(3, 4) * r);
    M1(3, 4) = -(F1(2, 4) * r);

%% Individual Axis omega
for l=1:3
    omega(l) = sum(M1(l,:)) / I(l);
end
    %% Calculate Rotation
target_rotation = 90; % Desired rotation angle in degrees
total_time = 0;


while total_time < 1
    total_time = total_time + dt;
    for l1=1:3
    rot_change = omega(l1) * dt; % Calculate rotation change
    rot(l1) = rot(l1) + rad2deg(rot_change); % Update rotation in degrees
    end
    if i <= 200
        test(i, 1) = rot(3);
        i = i + 1;
    end
end
disp(['Final rotation angle about X: ', num2str(rot(1)), ' degrees']);
disp(['Final rotation angle about Y: ', num2str(rot(2)), ' degrees']);
disp(['Final rotation angle about Z: ', num2str(rot(3)), ' degrees']);

