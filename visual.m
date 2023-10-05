% Desired rotation angles
desired_rotX = -134.7;
desired_rotY = -163.7;
desired_rotZ = 300;

% Initial guess for alpha
initial_alpha = [0, 0, 0, 0];

% Optimize using fminsearch
optimized_alpha = fminsearch(@(alpha) iteration_inverse(alpha, desired_rotX, desired_rotY, desired_rotZ), initial_alpha);

% Calculate the final rotation angles using the optimized alpha
[final_rotX, ~, ~] = calculate_rotation_angles(optimized_alpha);

% Display results
disp(['Optimized alpha: ', num2str(optimized_alpha)]);
disp(['Final rotation angle about X: ', num2str(final_rotX), ' degrees']);

% Plot desired X rotation angles vs. optimized alpha(1) values
desired_X_angles = linspace(0, 90, 100); % Generate desired X angles from 0 to 90 degrees
optimized_alpha_values = zeros(size(desired_X_angles));

for i = 1:length(desired_X_angles)
    desired_rotX = desired_X_angles(i);
    optimized_alpha = fminsearch(@(alpha) iteration_inverse(alpha, desired_rotX, desired_rotY, desired_rotZ), initial_alpha);
    optimized_alpha_values(i) = optimized_alpha(1);
end

figure;
plot(desired_X_angles, optimized_alpha_values, 'b', 'LineWidth', 2);
xlabel('Desired X Rotation Angle (degrees)');
ylabel('Optimized alpha(1)');
title('Desired X Rotation Angle vs. Optimized alpha(1)');
grid on;