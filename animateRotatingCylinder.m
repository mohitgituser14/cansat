function animateRotatingCylinder(rotationAngles)
    % Parameters for the cylinder
    radius = 1;
    height = 4;
    rectangleWidth = 0.5;
    rectangleHeight = 0.2;

    % Create a figure
    figure;
    axis equal;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('Rotating Cylinder with Attached Rectangle');
    xlim([-5, 5]); % Set X-axis limits
    ylim([-5, 5]); % Set Y-axis limits
    zlim([0, height+2]); % Set Z-axis limits

    % Rotate the cylinder about each axis
    axes = [1, 0, 0; 0, 1, 0; 0, 0, 1];

    for i = 1:size(axes, 1)
        % Create a new cylinder and rectangle
        theta = linspace(0, 2*pi, 100);
        z = linspace(0, height, 20);
        [thetaGrid, zGrid] = meshgrid(theta, z);
        x = radius * cos(thetaGrid);
        y = radius * sin(thetaGrid);
        z = zGrid;

        % Combine the coordinates to create the cylinder vertices
        vertices = [x(:), y(:), z(:)];

        axis_direction = axes(i, :);
        angle_deg = rotationAngles(i);

        for angle = 0:2:angle_deg
            rotated_vertices = rotatePointsAboutAxis(vertices, [0, 0, height/2], axis_direction, angle);

            % Reshape rotated vertices back to grid
            x = reshape(rotated_vertices(:, 1), size(thetaGrid));
            y = reshape(rotated_vertices(:, 2), size(thetaGrid));
            z = reshape(rotated_vertices(:, 3), size(thetaGrid));

            % Calculate rectangle coordinates
            rectangle_x = [x(1, end) x(1, end) x(1, end) x(1, end)];
            rectangle_y = [y(1, end) y(1, end) y(1, end) y(1, end)];
            rectangle_z = [z(1, end) z(1, end)+rectangleWidth z(1, end)+rectangleWidth z(1, end)];

            % Update the plot
            if exist('h', 'var') && ishandle(h)
                delete(h);
            end
            h = surf(x, y, z);
            hold on;
            h_rectangle = fill3(rectangle_x, rectangle_y, rectangle_z, 'r');
            hold off;

            axis equal;
            xlabel('X');
            ylabel('Y');
            zlabel('Z');
            title('Rotating Cylinder with Attached Rectangle');
            xlim([-5, 5]); % Set X-axis limits
            ylim([-5, 5]); % Set Y-axis limits
            zlim([0, height+2]); % Set Z-axis limits

            drawnow;
            pause(0.05);
        end

        pause(1); % Pause between axis rotations
    end

    function rotated_points = rotatePointsAboutAxis(points, axis_origin, axis_direction, angle_deg)
        angle_rad = deg2rad(angle_deg);
        R = [cos(angle_rad) + axis_direction(1)^2 * (1 - cos(angle_rad)), ...
             axis_direction(1) * axis_direction(2) * (1 - cos(angle_rad)) - axis_direction(3) * sin(angle_rad), ...
             axis_direction(1) * axis_direction(3) * (1 - cos(angle_rad)) + axis_direction(2) * sin(angle_rad); ...
             axis_direction(2) * axis_direction(1) * (1 - cos(angle_rad)) + axis_direction(3) * sin(angle_rad), ...
             cos(angle_rad) + axis_direction(2)^2 * (1 - cos(angle_rad)), ...
             axis_direction(2) * axis_direction(3) * (1 - cos(angle_rad)) - axis_direction(1) * sin(angle_rad); ...
             axis_direction(3) * axis_direction(1) * (1 - cos(angle_rad)) - axis_direction(2) * sin(angle_rad), ...
             axis_direction(3) * axis_direction(2) * (1 - cos(angle_rad)) + axis_direction(1) * sin(angle_rad), ...
             cos(angle_rad) + axis_direction(3)^2 * (1 - cos(angle_rad))];

        rotated_points = (R * (points - axis_origin)')' + axis_origin;
    end
end
