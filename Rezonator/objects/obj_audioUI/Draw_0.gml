//===================| DRAW |======================

    //Rectangles
   draw_set_color($f2f2f2);
    draw_rectangle((x_info-size_info_x),(y_bar-size_bar_y) - 25,(x_info+size_info_x),(y_bar+size_bar_y) + 25,0); //Player Base
   draw_set_color($cdcdcd);
    draw_rectangle(x_bar, y_bar-size_bar_y, (x_bar + size_bar_x), y_bar + size_bar_y, 0); //Bar Base 

    
    
    draw_set_color($0054ff);
    draw_rectangle(x_bar, y_bar - size_bar_y, btn, y_bar + size_bar_y, 0); //Bar
    draw_set_color(c_black);
   draw_set_alpha(1);
    
    //Text
    draw_set_color(c_gray);
    
    var 
    str_minutes = string(floor(position/60)),
    str_seconds = string(floor(position%60)),
    total_minutes = string(floor(length / 60)),
    total_seconds = string(floor(length % 60));
    if(string_length(str_minutes) < 2){str_minutes = "0"+string(floor(position/60))}
    if(string_length(str_seconds) < 2){str_seconds = "0"+string(floor(position%60))}
    if(string_length(total_minutes) < 2){total_minutes = "0"+string(floor(length / 60))}
    if(string_length(total_seconds) < 2){total_seconds = "0"+string(floor(length % 60))}    
    
    draw_set_font(global.fontMain);
    draw_set_valign(fa_middle);
    draw_text(((x_bar+size_bar_x)+10),y_bar, string_hash_to_newline(total_minutes + ":" + total_seconds));
    draw_set_color($0054ff);
    draw_text(x_bar - 50,y_bar,string_hash_to_newline(str_minutes + ":" + str_seconds));
    draw_set_color(c_black);
    draw_set_valign(fa_top);
    draw_set_font(-1);
    
    //TEST
    /*
    draw_text(15,15,'Percent: '+string(p));
    draw_text(15,65,'Length: '+string(length));
    draw_text(15,90,'A0: '+string(a0));
    draw_text(15,115,'P2: '+string(p2));
    draw_text(15,140,'Sound: '+string(sound[current]));
    draw_text(15,165,'SND: '+string(snd));
    draw_text(15,190,'Loop: '+string(loop));
    draw_text(15,215,'Alpha Volume: '+string(alp_vol));
    draw_text(15,240,'Mute: '+string(mute));
    draw_text(15,265,'b0: '+string(b0));
    */
    
    
    
//////////////////////////// |AUDIO GUI INFO| ////////////////////////////////

    
    
    //Title && Author
    draw_set_font(global.fontMain);
    draw_set_color($333354);
    draw_text(x_cover + 30, y_bar,string_hash_to_newline(title[current]));
    
    
    draw_set_alpha(0.7);
    draw_set_alpha(1);
    
    draw_set_font(global.fontMainBold);
    draw_text((x_cover +30), y_bar - 16,string_hash_to_newline(author[current]));
    draw_set_color(c_black);
    draw_set_font(-1);

//Draw buttons
    draw_sprite(spr_button,0,btn,y_bar);  //Button timeline
    draw_sprite_ext(spr_play,img_play,x_play,y_bar,1,1,0,c_white,1); //Button Play
    draw_sprite_ext(spr_next,img_prev,x_prev,y_bar,-1,1,0,c_white,1); //Button Previous
    draw_sprite_ext(spr_next,img_next,x_next,y_bar,1,1,0,c_white,1); //Button Next
    draw_sprite_ext(spr_loop,img_loop,x_loop,y_loop,1,1,0,blend_loop,1); //Button Loop / Repeat
    draw_sprite_ext(spr_vol,img_vol,x_vol,y_vol,1,1,0,blend_vol,1); //Button Volume


//==============================|Volume Bar|===========================\

    draw_set_alpha(alp_vol);

draw_sprite (sVol_Base_minimalist, 0, xb, yvol);

//Draw Bars
draw_set_color($0054ff);
draw_rectangle(xb-size_x,yvol+size_y,xb+size_x,yb,0);

draw_set_color($cdcdcd);
draw_rectangle(xb-size_x,yvol-size_y,xb+size_x,yb,0);


//Draw percent volume
     /*
     draw_set_color (c_black);
     draw_set_halign(fa_center);
     draw_set_valign(fa_middle);
     draw_set_font(global.fontMain);
        draw_text(xb+50,yb,string(round(pv*100)))
     draw_set_font(-1);
     draw_set_halign(fa_left);
     draw_set_valign(fa_top);
     draw_set_color(c_black);
     */
    

//Draw bar Buttons
draw_sprite (spr_button_vol, 0, xb, yb);

draw_set_alpha(1);
draw_set_color(c_black);



/* */
/*  */

draw_text(100, 100, "p2: " + string(p2));
draw_text(100, 120, "xx: " + string(xx));
draw_text(100, 140, "btn: " + string(btn));