
alpha = [200.7091   ,  -37.51772   ,  -82.04904   ,   99.86707];


[rotX, rotY, rotZ]= calculate_rotation_angles(alpha,100);


disp(['Final rotation angle about X: ', num2str(rotX), ' degrees']);
disp(['Final rotation angle about Y: ', num2str(rotY), ' degrees']);
disp(['Final rotation angle about Z: ', num2str(rotZ), ' degrees']);