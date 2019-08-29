if (not visible) {
	exit;
}
//if (window_get_width() != windowWidthPrev or window_get_height() != windowHeightPrev) {
	scr_audioUIResize();
//}

 
//===================| STEP |======================

        length   = audio_sound_length(sound[current]);
    
    //Activation
    if (mouse_check_button(mb_left) && colli_button0) {
		a0 = true;
	}
    if (mouse_check_button_released(mb_left)) {
		a0 = false;
	}
        
if(play){

  if(audio_is_paused(snd)){
    audio_resume_sound(snd); 
  
  }else{
     if(loop){
        //Sound
        if!(audio_is_playing(sound[current])){ snd = audio_play_sound(sound[current],0,1);}
     }else{
        if((floor(position) >= floor(length))){
			
			show_message("here1");
         audio_sound_set_track_position(sound[current],0);
         snd = sound[current];
         audio_stop_sound(snd);
         play = false;
        }
    }
  }


}else{
    
    if(audio_is_playing(snd)){audio_pause_sound(snd);}

}

position = audio_sound_get_track_position(snd);
        
        

scr_audioUIMouseMov(); //<<<Get mouse Speed

    //Colision mouse with buttons
        //Timeline Buton  && Area
        colli_button0=point_in_rectangle(mouse_x,mouse_y,btn-sprite_get_xoffset(spr_button),y_bar-sprite_get_yoffset(spr_button),btn+sprite_get_xoffset(spr_button),y_bar+sprite_get_yoffset(spr_button));
        colli_area0 = point_in_rectangle(mouse_x, mouse_y,x_bar,(y_bar-size_bar_y) -10,x_bar+size_bar_x,(y_bar+size_bar_y) +10);
        //Play Button 
        colli_btn_play=point_in_rectangle(mouse_x,mouse_y,x_play-sprite_get_xoffset(spr_play),y_bar-sprite_get_yoffset(spr_play),x_play+sprite_get_xoffset(spr_play),y_bar+sprite_get_yoffset(spr_play));
        //Previous Button 
        colli_btn_prev=point_in_rectangle(mouse_x,mouse_y,x_prev-sprite_get_xoffset(spr_next),y_bar-sprite_get_yoffset(spr_next),x_prev+sprite_get_xoffset(spr_next),y_bar+sprite_get_yoffset(spr_next));
        //Next Button 
        colli_btn_next=point_in_rectangle(mouse_x,mouse_y,x_next-sprite_get_xoffset(spr_next),y_bar-sprite_get_yoffset(spr_next),x_next+sprite_get_xoffset(spr_next),y_bar+sprite_get_yoffset(spr_next));
        //Loop Button
        colli_btn_loop=point_in_rectangle(mouse_x,mouse_y,x_loop-sprite_get_xoffset(spr_loop),y_loop-sprite_get_yoffset(spr_loop),x_loop+sprite_get_xoffset(spr_loop),y_loop+sprite_get_yoffset(spr_loop));
        //Volume Button
        colli_btn_vol=point_in_rectangle(mouse_x,mouse_y,x_vol-sprite_get_xoffset(spr_vol),y_vol-sprite_get_yoffset(spr_vol),x_vol+sprite_get_xoffset(spr_vol),y_vol+sprite_get_yoffset(spr_vol));
        //Volume BAR Button && Area
        colli_v = point_in_rectangle(mouse_x,mouse_y,xb-sprite_get_xoffset(spr_button_vol),yb-sprite_get_yoffset(spr_button_vol),xb+sprite_get_xoffset(spr_button_vol),yb+sprite_get_yoffset(spr_button_vol));
        colli_areav = point_in_rectangle(mouse_x, mouse_y,(xb-size_x)-15,yvol-size_y,(xb+size_x)+15,yvol+size_y);

    //Play
    img_play = play;
    if(colli_btn_play){
        blend_play = c_gray;
        if(mouse_check_button_pressed(mb_left)){
          play = !play; 
          if(play){if!(audio_is_playing(sound[current])){snd = audio_play_sound(sound[current],0,1);}}//Sound
        }
    }else{blend_play = c_white;}
    
    //Previous
    if(colli_btn_prev){
        if(mouse_check_button_pressed(mb_left)){
            if!(current == 0){
                    //image_index buttons "Previous sound" and "Next sound"
                    if(current == 1){img_prev = 0 }else{ img_prev = 1}
                    img_next = 1;
                
				show_message("here2");
                audio_stop_sound(sound[current]);
                audio_sound_set_track_position(sound[current],0);
                current--;
            
                snd = sound[current];
                
                if(play){if!(audio_is_playing(sound[current])){snd = audio_play_sound(sound[current],0,1);}}//Sound
            
            }
        }
    }
    
    //Next
    if(colli_btn_next){
        if(mouse_check_button_pressed(mb_left)){
            if!(current == size_sys){
                    //image_index buttons "Previous sound" and "Next sound"
                    if!(current == size_sys-1){img_next = 1 }else{ img_next = 0}
                    img_prev = 1;
                    
				show_message("here3");
                audio_stop_sound(sound[current]);
                audio_sound_set_track_position(sound[current],0);
                current++;
                snd = sound[current];
        
                if(play){if!(audio_is_playing(sound[current])){snd = audio_play_sound(sound[current],0,1);}}//Sound
            
            }
        }
    }
    
    //Loop
    
    img_loop = loop;
    if(colli_btn_loop){
        blend_loop = c_gray;
        if(mouse_check_button_pressed(mb_left)){loop = !loop;} 
    }else{blend_loop = c_white;} 

    
    //Volume (BUTTON Player)
    
    if(colli_btn_vol){
        vol = true;
        blend_vol = c_gray;
        if(mouse_check_button_pressed(mb_left)){
          if(mute){yb = yb_prev }else{ yb_prev = yb; yb = yvol + size_y;}
          mute = !mute;
        }
    }else{
        blend_vol = c_white;
        //Temporal Area collision
        var colli_vol_temp = point_in_rectangle(mouse_x, mouse_y,(xb-size_x)-15,y_vol-192,(xb+size_x)+15,y_vol);   
        //Disable volume bar when the mouse cursor is outside the area
        if!(b0 || colli_vol_temp){vol = false} 
    }
    
    
    //Deactivation
    if (mouse_check_button_pressed(mb_left) && colli_area0) {
        btn = mouse_x;
		a0 = true;
        p = (btn - x_bar) / (size_bar_x);
        var avoid = length * p; //AVOID BUG (more information on the "INSTRUCTIONS" script)
        if (avoid != 0) {
			if (mouse_check_button_released(mb_left)) {
				audio_sound_set_track_position(snd, length * p);
			}
        }
		else {
			show_message("here4");
            audio_sound_set_track_position(sound[current], 0);
            audio_stop_sound(snd);
			snd = audio_play_sound(sound[current], 0, 1);
        }
    }
	
	
	if (mouse_check_button_released(mb_left)) {
			btn = clamp(mouse_x, x_bar, x_bar + size_bar_x);
			p = (btn - x_bar) / (size_bar_x);
			//show_message("p: " + string(p));
		//var avoid = length * p; //AVOID BUG (more information on the "INSTRUCTIONS" script)
		//if (avoid != 0) {
			audio_sound_set_track_position(snd, length * p);
		//}
	}

    
p = (btn - x_bar) / (size_bar_x);


if(a0){
 //Slip for each button
 btn = clamp(mouse_x, x_bar, x_bar + size_bar_x);        
     

    var avoid = length * p; //AVOID BUG (more information on the "INSTRUCTIONS" script)
    if (mouse_hspeed != 0) {
		/*
      if (avoid == 0) {
        show_message("here5");
		audio_sound_set_track_position(sound[current], 0);
        audio_stop_sound(snd);
        snd = audio_play_sound(sound[current], 0, 1);
        a0 = false;
	  }
	  */
	  //else {
	  if (mouse_check_button_released(mb_left)) {
		  audio_sound_set_track_position(snd, length * p);
	}
      //}
	  
    }
  
  
    if((floor(position) >= floor(length))){
     snd = sound[current];
	 show_message("here6");
     audio_sound_set_track_position(sound[current],0);
     audio_stop_sound(snd);
     play = false;
     a0 = false;
    }

}
else {
	
	//if (mouse_check_button_released(mb_left)) {
		p2 = (position) / (length);
		//xx = clamp(mouse_x, x_bar, x_bar + size_bar_x); 
		xx = lerp(x_bar, x_bar + size_bar_x, p2);
		btn = xx;
	//}
}



//==============================|Volume Bar|===========================\


if(mode == 1){ //If the volume bar is activated


    //Activation Volume
    if( (mouse_check_button(mb_left) && colli_v) || (mouse_check_button_pressed(mb_left) && colli_areav)){b0=true;}


    if(b0){
      //Slip Volume
      yb = clamp (mouse_y, yvol-size_y, yvol + size_y);
      if(yb == yvol + size_y){mute =true }else{ mute = false}
    }
    
    //Deactivation Glide each button
    if(mouse_check_button_released(mb_left)){b0=false;}
}

//Percent Volume
pv = ((yvol + size_y)- yb) / (size_y *2);
audio_sound_gain(sound[current],pv,0); //Volume         

//Mute
if(mute){img_vol = 2; }else{ img_vol = pv}
    





///Volume Bar Switch

if(vol){

    mode = 1; //Active
    
    var xrest,xdest;
    xdest = 1;
    xrest = alp_vol-xdest;
    alp_vol = xrest*0.9+xdest;
    
}else{

    mode = 0; //Deactivate
    b0 = false;
    
    var xrest,xdest;
    xrest = alp_vol;
    alp_vol = xrest*0.8;
}



