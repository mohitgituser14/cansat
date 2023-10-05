function error = iteration_inverse(alpha, desired_rotX, desired_rotY, desired_rotZ,timer)

    
    [rotX, rotY, rotZ] = calculate_rotation_angles(alpha,timer);
    
     error = (rotX - desired_rotX)^2 + (rotY - desired_rotY)^2 + (rotZ - desired_rotZ)^2;
    
end
