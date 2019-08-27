x = camera_get_view_width(view_camera[0]) / 2;
y = camera_get_view_height(view_camera[0]) - (size_info_y / 2);

//Info Box
x_info      = x;
y_info      = y - 115;
size_info_x = 500;
size_info_y = 85;

//timeline
x_bar      = (x - 220);
y_bar      = y;
size_bar_x = (size_info_x - 120);
size_bar_y = 0.25;
    
btn        = x_bar;

//Buttons
x_play = x_bar - 200;
x_prev = x_play - 40;
x_next = x_play + 40;
x_loop = x_next + 60;
y_loop = y_bar;
x_vol  = (x_bar + size_bar_x) + 100;
y_vol  = y_bar;
    
x_cover = x_vol + 70;