/*
    DEVELOPED BY Clavos Studios 
    This simple script returns the speed, hspeed and vspeed of the mouse cursor
        Note: Must declare variables: mouse_xprevious and mouse_yprevious 
        in the create event where the object is to use the script
*/


mouse_hspeed = point_distance(mouse_xprevious, mouse_y, mouse_x, mouse_y);
mouse_vspeed = point_distance(mouse_x, mouse_yprevious, mouse_x, mouse_y);
mouse_speed = mouse_hspeed + mouse_vspeed;
mouse_direction = point_direction(mouse_xprevious, mouse_yprevious, mouse_x, mouse_y);

mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;

