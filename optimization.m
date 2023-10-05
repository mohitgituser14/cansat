for i=1:100
timer = i;

% Desired rotation angles
    desired_rotX = -134.7;
    desired_rotY = -163.7;
    desired_rotZ = 300;

% Initial guess for alpha
initial_alpha = [0, 0, 0, 0];

% Optimize using fminsearch
optimized_alpha = fminsearch(@(alpha) iteration_inverse(alpha, desired_rotX, desired_rotY, desired_rotZ, timer), initial_alpha);

% Calculate the final rotation angles using the optimized alpha
[final_rotX, final_rotY, final_rotZ] = calculate_rotation_angles(optimized_alpha,timer);

% Display results
disp(['Optimized alpha: ', num2str(optimized_alpha)]);
disp(['Final rotation angle about X: ', num2str(final_rotX), ' degrees']);
disp(['Final rotation angle about Y: ', num2str(final_rotY), ' degrees']);
disp(['Final rotation angle about Z: ', num2str(final_rotZ), ' degrees']);
end
