audioPanelPaneInst = -1;



//Sizes and positions
     
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



//Buttons Switchs
play   = true;
loop   = true;
vol    = false;

    

//Mouse Movements
mouse_xprevious = 0;
mouse_yprevious = 0;
    a0 = false; //Drag

//Audio
snd      = 0;
current  = 0;//Current Sound
length   = 0;
position = 0;



//GUI
spr_button = sBtn_Minimalist;
spr_play   = sBtn_Play_Minimalist;
spr_loop   = sLoop_minimalist;
spr_vol    = sBtn_Vol_minimalist;
spr_next   = sBtn_next;

scr_audioUISoundsConfig();


    //image_index buttons "Previous sound" and "Next sound"
    if!(current == 0){img_prev = 1  }else{  img_prev = 0}
    if!(current == size_sys){img_next = 1  }else{  img_next = 0} 

//==============================|Volume Bar|===========================\
mode = 0;
mute = false;

//Appearance
spr_button_vol = sBtn_Minimalist;
alp_vol = 0;

//Bars Size
size_x = 0.5;
size_y = 70;

 //Activate Glide
 b0=false; 
       
//Button Positions
    yvol = y_vol - 110; //Position Bar
xb = x_vol-2;
yb= yvol - size_y;
yb_prev = yb;



img_play = 0;
img_next = 0;
img_loop = 0;
img_vol = 0;
img_prev = 0;
blend_play = 0;
blend_loop = 0;
blend_vol = 0;
p2 = 0;
xx = 0;
btn = 0;


windowWidthPrev = window_get_width();
windowHeightPrev = window_get_height();