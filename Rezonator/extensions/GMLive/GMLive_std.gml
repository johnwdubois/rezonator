#define live_preinit_api
// Generated at 2019-10-18 15:40:14 (36095ms) for v2.2.1+
globalvar f___lnc__lf;f___lnc__lf=asset_get_index("__lnc__lf");
globalvar f___lnc__lf1;f___lnc__lf1=asset_get_index("__lnc__lf1");
globalvar f___lnc__lf2;f___lnc__lf2=asset_get_index("__lnc__lf2");
globalvar f___lnc__lf3;f___lnc__lf3=asset_get_index("__lnc__lf3");
globalvar f___lnc__lf4;f___lnc__lf4=asset_get_index("__lnc__lf4");
globalvar f___lnc__lf5;f___lnc__lf5=asset_get_index("__lnc__lf5");
gml_func_add("min(...values:number)",f___lnc__lf);
gml_func_add("max(...values:number)",f___lnc__lf1);
gml_func_add("choose(...values)",f___lnc__lf2);
gml_func_add("::script_execute(script:index, ...values)",f___lnc__lf3);
gml_func_add(":instance_destroy(...values)",f___lnc__lf4);
gml_func_add("gml_pragma(setting, ...)",f___lnc__lf5);
var l_gmlFuncs="";
var l_gmlVars="";
l_gmlFuncs="0=is_real(val)#:\n1=is_string(val)#:\n2=is_array(val)#:\n3=is_undefined(val)#:\n4=is_int32(val)#:\n5=is_int64(val)#:\n6=is_ptr(val)#:\n7=is_vec3(val)#:\n8=is_vec4(val)#:\n9=is_matrix(val)#:\n10=is_bool(val)#:\n11=is_nan(val)\n12=is_infinity(val)\n13=typeof(val)#:\n14=variable_global_exists(name):\n15=variable_global_get(name):\n16=variable_global_set(name,val)\n17=variable_instance_exists(id,name):\n18=variable_instance_get(id,name):\n19=variable_instance_set(id,name,val)\n20=variable_instance_get_names(id):\n21=array_length_1d(value):\n22=array_length_2d(value, index:number):\n23=array_height_2d(value):\n24=array_equals(one, two):\n25=array_create(size:number, ?value:any):\n26=array_copy(dest,dest_index,src,src_index,length)\n27=array_get(variable,index):\n28=array_set(variable,index,val)\n29=random(x:number):\n30=random_range(:number,:number):\n31=irandom(x:number):\n32=irandom_range(:number,:number):\n33=random_set_seed(seed)\n34=random_get_seed():\n35=randomize():\n36=randomise()£\n37=abs(x:number)#:\n38=round(x:number)#:\n39=floor(x:number)#:\n40=ceil(x:number)#:\n41=sign(x:number)#:\n42=frac(x:number)#:\n43=sqrt(x:number)#:\n44=sqr(x:number)#:\n45=exp(x:number)#:\n46=ln(x:number)#:\n47=log2(x:number)#:\n48=log10(x:number)#:\n49=sin(radian_angle:number)#:\n50=cos(radian_angle:number)#:\n51=tan(radian_angle:number)#:\n52=arcsin(x:number)#:\n53=arccos(x:number)#:\n54=arctan(x:number)#:\n55=arctan2(y:number, x:number)#:\n56=dsin(degree_angle:number)#:\n57=dcos(degree_angle:number)#:\n58=dtan(degree_angle:number)#:\n59=darcsin(x:number)#:\n60=darccos(x:number)#:\n61=darctan(x:number)#:\n62=darctan2(y:number, x:number)#:\n63=degtorad(x:number)#:\n64=radtodeg(x:number)#:\n65=power(x:number, n:number)#:\n66=logn(n:number, x:number)#:\n67=mean(...:number)#:\n68=median(...:any)#:\n69=clamp(val:number, min:number, max:number)#:\n70=lerp(val1:number, val2:number, amount:number)#:\n71=dot_product(x1:number, y1:number, x2:number, y2:number)#:\n72=dot_product_3d(x1:number, y1:number, z1:number, x2:number, y2:number, z2:number)#:\n73=dot_product_normalised(x1:number, y1:number, x2:number, y2:number)£#:\n74=dot_product_3d_normalised(x1:number, y1:number, z1:number, x2:number, y2:number, z2:number)£#:\n75=dot_product_normalized(x1:number, y1:number, x2:number, y2:number)$#:\n76=dot_product_3d_normalized(x1:number, y1:number, z1:number, x2:number, y2:number, z2:number)$#:\n77=math_set_epsilon(new_epsilon)\n78=math_get_epsilon():\n79=angle_difference(src:number, dest:number)#:\n80=point_distance_3d(x1:number, y1:number, z1:number, x2:number, y2:number, z2:number)#:\n81=point_distance(x1:number, y1:number, x2:number, y2:number)#:\n82=point_direction(x1:number, y1:number, x2:number, y2:number)#:\n83=lengthdir_x(len:number, dir:number)#:\n84=lengthdir_y(len:number, dir:number)#:\n85=real(val)#:\n86=bool(val)\n87=string(val)#:\n88=int64(val)#:\n89=ptr(val):\n90=string_format(val:number,total:number,dec:number)#:\n91=chr(val:int)#:\n92=ansi_char(val)#:\n93=ord(char:string)#:\n94=string_length(str:string)#:\n95=string_byte_length(str:string)#:\n96=string_pos(substr:string, str:string)#:\n97=string_copy(str:string, index:int, count:int)#:\n98=string_char_at(str:string, index:int)#:\n99=string_ord_at(str:string, index:int)#:\n100=string_byte_at(str:string, index:int)#:\n101=string_set_byte_at(str:string, index:int, val:int)#:\n102=string_delete(str:string, index:int, count:int)#:\n103=string_insert(substr:string, str:string, index:int)#:\n104=string_lower(str:string)#:\n105=string_upper(str:string)#:\n106=string_repeat(str:string, count:int)#:\n107=string_letters(str:string)#:\n108=string_digits(str:string)#:\n109=string_lettersdigits(str:string)#:\n110=string_replace(str:string, substr:string, newstr:string)#:\n111=string_replace_all(str:string, substr:string, newstr:string)#:\n112=string_count(substr:string, str:string)#:\n113=string_hash_to_newline(:string)#:\n114=clipboard_has_text():\n115=clipboard_set_text(str)\n116=clipboard_get_text():\n117=date_current_datetime():\n118=date_create_datetime(year,month,day,hour,minute,second):\n119=date_valid_datetime(year:int,month:int,day:int,hour:int,minute:int,second:int):\n120=date_inc_year(:date,amount):\n121=date_inc_month(:date,amount):\n122=date_inc_week(:date,amount):\n123=date_inc_day(:date,amount):\n124=date_inc_hour(:date,amount):\n125=date_inc_minute(:date,amount):\n126=date_inc_second(:date,amount):\n127=date_get_year(date):\n128=date_get_month(date):\n129=date_get_week(date):\n130=date_get_day(date):\n131=date_get_hour(date):\n132=date_get_minute(date):\n133=date_get_second(date):\n134=date_get_weekday(date):\n135=date_get_day_of_year(date):\n136=date_get_hour_of_year(date):\n137=date_get_minute_of_year(date):\n138=date_get_second_of_year(date):\n139=date_year_span(date1:date,date2:date):\n140=date_month_span(date1:date,date2:date):\n141=date_week_span(date1:date,date2:date):\n142=date_day_span(date1:date,date2:date):\n143=date_hour_span(date1:date,date2:date):\n144=date_minute_span(date1:date,date2:date):\n145=date_second_span(date1:date,date2:date):\n146=date_compare_datetime(date1:date,date2:date):\n147=date_compare_date(date1:date,date2:date):\n148=date_compare_time(date1:date,date2:date):\n149=date_date_of(:date):\n150=date_time_of(:date):\n151=date_datetime_string(:date):\n152=date_date_string(:date):\n153=date_time_string(:date):\n154=date_days_in_month(:date):\n155=date_days_in_year(:date):\n156=date_leap_year(:date):\n157=date_is_today(:date):\n158=date_set_timezone(timezone)\n159=date_get_timezone():\n160=game_set_speed(value,type)\n161=game_get_speed(type):\n162=:motion_set(dir:number, speed:number)\n163=:motion_add(dir:number, speed:number)\n164=:place_free(x:number, y:number):\n165=:place_empty(x:number, y:number):\n166=:place_meeting(x:number, y:number, obj:index):\n167=:place_snapped(hsnap:number, vsnap:number):\n168=:move_random(hsnap:number, vsnap:number)\n169=:move_snap(hsnap:number, vsnap:number)\n170=:move_towards_point(x:number, y:number, sp:number)\n171=:move_contact_solid(dir:number, maxdist:number)\n172=:move_contact_all(dir:number, maxdist:number)\n173=:move_outside_solid(dir:number, maxdist:number)\n174=:move_outside_all(dir:number, maxdist:number)\n175=:move_bounce_solid(advanced:bool)\n176=:move_bounce_all(advanced:bool)\n177=:move_wrap(hor:bool, vert:bool, margin:number)\n178=:distance_to_point(x:number, y:number):\n179=:distance_to_object(obj:index):\n180=:position_empty(x:number, y:number):\n181=:position_meeting(x:number, y:number, obj:index):\n182=:path_start(path,speed,endaction,absolute)\n183=:path_end()\n184=:mp_linear_step(x:number,y:number,speed:number,checkall:bool):\n185=:mp_potential_step(x:number,y:number,speed:number,checkall:bool):\n186=:mp_linear_step_object(x:number,y:number,speed:number,obj:index):\n187=:mp_potential_step_object(x:number,y:number,speed:number,obj:index):\n188=:mp_potential_settings(maxrot,rotstep,ahead,onspot)\n189=:mp_linear_path(path:index,x:number,y:number,step:number,checkall:bool):\n190=:mp_potential_path(path:index,x:number,y:number,step:number,factor:number,checkall:bool):\n191=:mp_linear_path_object(path:index,x:number,y:number,step:number,obj:index):\n192=:mp_potential_path_object(path:index,x:number,y:number,step:number,factor:number,obj:index):\n193=mp_grid_create(left,top,hcells,vcells,cellwidth,cellheight):\n194=mp_grid_destroy(id)\n195=mp_grid_clear_all(id)\n196=mp_grid_clear_cell(id,h,v)\n197=mp_grid_clear_rectangle(id,left,top,right,bottom)\n198=mp_grid_add_cell(id,h,v)\n199=mp_grid_get_cell(id,h,v):\n200=mp_grid_add_rectangle(id,left,top,right,bottom)\n201=:mp_grid_add_instances(id,obj,prec)\n202=:mp_grid_path(:index,path:index,xstart:number,ystart:number,xgoal:number,ygoal:number,allowdiag:bool):\n203=mp_grid_draw(id)\n204=mp_grid_to_ds_grid(src,dest)\n205=:collision_point(x:number, y:number, obj:index, prec:bool, notme:bool):\n206=:collision_rectangle(x1:number, y1:number, x2:number, y2:number, obj:index, prec, notme):\n207=:collision_circle(x1:number, y1:number, radius, obj:index, prec, notme):\n208=:collision_ellipse(x1:number, y1:number, x2:number, y2:number, obj:index, prec, notme):\n209=:collision_line(x1:number, y1:number, x2:number, y2:number, obj:index, prec, notme):\n210=collision_point_list(x,y,obj,prec,notme,list,ordered):\n211=collision_rectangle_list(x1,y1,x2,y2,obj,prec,notme,list,ordered):\n212=collision_circle_list(x1,y1,radius,obj,prec,notme,list,ordered):\n213=collision_ellipse_list(x1,y1,x2,y2,obj,prec,notme,list,ordered):\n214=collision_line_list(x1,y1,x2,y2,obj,prec,notme,list,ordered):\n215=instance_position_list(x,y,obj,list,ordered)\n216=instance_place_list(x,y,obj,list,ordered)\n217=point_in_rectangle(px, py, x1:number, y1:number, x2:number, y2:number):\n218=point_in_triangle(px, py, x1:number, y1:number, x2:number, y2:number, x3:number, y3:number):\n219=point_in_circle(px, py, cx, cy, rad):\n220=rectangle_in_rectangle(sx1:number, sy1:number, sx2:number, sy2:number, dx1:number, dy1:number, dx2:number, dy2:number):\n221=rectangle_in_triangle(sx1:number, sy1:number, sx2:number, sy2:number, x1:number, y1:number, x2:number, y2:number, x3:number, y3:number):\n222=rectangle_in_circle(sx1:number, sy1:number, sx2:number, sy2:number, cx:number, cy:number, rad:number):\n223=instance_find(obj:id, n:int):\n224=instance_exists(obj:id):\n225=instance_number(obj:id):\n226=instance_position(x:number, y:number, obj:id):\n227=:instance_nearest(x:number, y:number, obj:id):\n228=:instance_furthest(x:number, y:number, obj:id):\n229=:instance_place(x:number, y:number, obj:id):\n230=instance_create_depth(x,y,depth,obj):\n231=instance_create_layer(x,y,layer_id_or_name,obj):\n232=:instance_copy(performevent:bool):\n233=:instance_change(obj,performevents)\n234=:instance_destroy(?what:id, ?performevent:bool)\n235=:position_destroy(x,y)\n236=:position_change(x,y,obj,performevents)\n237=instance_id_get(index):\n238=:instance_deactivate_all(notme)\n239=:instance_deactivate_object(obj)\n240=:instance_deactivate_region(left,top,width,height,inside,notme)\n241=:instance_activate_all()\n242=:instance_activate_object(obj)\n243=:instance_activate_region(left,top,width,height,inside)\n244=room_goto(numb)\n245=room_goto_previous()\n246=room_goto_next()\n247=room_previous(numb):\n248=room_next(numb):\n249=room_restart()\n250=game_end()\n251=game_restart()\n252=game_load(filename):\n253=game_save(filename)\n254=game_save_buffer(buffer)\n255=game_load_buffer(buffer):\n256=:event_perform(type,numb)\n257=:event_user(numb)\n258=:event_perform_object(obj,type,numb)\n259=:event_inherited()\n260=show_debug_message(str)\n261=show_debug_overlay(enable)\n262=debug_event(str)\n263=debug_get_callstack():\n264=:alarm_get(:int):\n265=:alarm_set(:int, value:int)\n266=keyboard_set_map(key1,key2)\n267=keyboard_get_map(key):\n268=keyboard_unset_map()\n269=keyboard_check(key:index):\n270=keyboard_check_pressed(key:index):\n271=keyboard_check_released(key:index):\n272=keyboard_check_direct(key:index):\n273=keyboard_get_numlock():\n274=keyboard_set_numlock(on)\n275=keyboard_key_press(key)\n276=keyboard_key_release(key)\n277=keyboard_clear(key:index)\n278=io_clear()\n279=mouse_check_button(button:index):\n280=mouse_check_button_pressed(button:index):\n281=mouse_check_button_released(button:index):\n282=mouse_wheel_up():\n283=mouse_wheel_down():\n284=mouse_clear(button)\n285=:draw_self()\n286=:draw_sprite(sprite,subimg,x,y)\n287=:draw_sprite_pos(sprite,subimg,x1,y1,x2,y2,x3,y3,x4,y4,alpha)\n288=:draw_sprite_ext(sprite,subimg,x,y,xscale,yscale,rot,col,alpha)\n289=:draw_sprite_stretched(sprite,subimg,x,y,w,h)\n290=:draw_sprite_stretched_ext(sprite,subimg,x,y,w,h,col,alpha)\n291=:draw_sprite_tiled(sprite,subimg,x,y)\n292=:draw_sprite_tiled_ext(sprite,subimg,x,y,xscale,yscale,col,alpha)\n293=:draw_sprite_part(sprite,subimg,left,top,width,height,x,y)\n294=:draw_sprite_part_ext(sprite,subimg,left,top,width,height,x,y,xscale,yscale,col,alpha)\n295=:draw_sprite_general(sprite,subimg,left,top,width,height,x,y,xscale,yscale,rot,c1,c2,c3,c4,alpha)\n296=draw_clear(col)\n297=draw_clear_alpha(col,alpha)\n298=draw_point(x,y)\n299=draw_line(x1,y1,x2,y2)\n300=draw_line_width(x1,y1,x2,y2,w)\n301=draw_rectangle(x1,y1,x2,y2,outline)\n302=draw_roundrect(x1,y1,x2,y2,outline)\n303=draw_roundrect_ext(x1,y1,x2,y2,radiusx,radiusy,outline)\n304=draw_triangle(x1,y1,x2,y2,x3,y3,outline)\n305=draw_circle(x,y,r,outline)\n306=draw_ellipse(x1,y1,x2,y2,outline)\n307=draw_set_circle_precision(precision)\n308=draw_arrow(x1,y1,x2,y2,size)\n309=draw_button(x1,y1,x2,y2,up)\n310=draw_path(path,x,y,absolute)\n311=draw_healthbar(x1,y1,x2,y2,amount,backcol,mincol,maxcol,direction,showback,showborder)\n312=draw_getpixel(x,y):\n313=draw_getpixel_ext(x,y):\n314=draw_set_colour(:color)\n315=draw_set_color(:color)\n316=draw_set_alpha(alpha:number)\n317=draw_get_colour():\n318=draw_get_color():\n319=draw_get_alpha():\n320=merge_colour(col1:color, col2:color, amount:number)#:\n321=make_colour_rgb(red:number, green:number, blue:number)#:\n322=make_colour_hsv(hue:number, saturation:number, value:number)#:\n323=colour_get_red(:color)#:\n324=colour_get_green(:color)#:\n325=colour_get_blue(:color)#:\n326=colour_get_hue(:color)#:\n327=colour_get_saturation(:color)#:\n328=colour_get_value(:color)#:\n329=merge_color(col1:color, col2:color, amount:number)#:\n330=make_color_rgb(red:number, green:number, blue:number)#:\n331=make_color_hsv(hue:number, saturation:number, value:number)#:\n332=color_get_red(:color)#:\n333=color_get_green(:color)#:\n334=color_get_blue(:color)#:\n335=color_get_hue(:color)#:\n336=color_get_saturation(:color)#:\n337=color_get_value(:color)#:\n338=screen_save(fname)\n339=screen_save_part(fname,x,y,w,h)\n340=gif_open(width,height,...)\n341=gif_add_surface(gifindex,surfaceindex,delaytime,...)\n342=gif_save(gif, filename)\n343=gif_save_buffer(gif)\n344=draw_set_font(:font)\n345=draw_get_font():\n346=draw_set_halign(halign:int)\n347=draw_get_halign():\n348=draw_set_valign(valign:int)\n349=draw_get_valign():\n350=draw_text(x,y,string)\n351=draw_text_ext(x,y,string,sep,w)\n352=string_width(:string):\n353=string_height(:string):\n354=string_width_ext(:string, sep:number, w:number):\n355=string_height_ext(:string, sep:number, w:number):\n356=draw_text_transformed(x,y,string,xscale,yscale,angle)\n357=draw_text_ext_transformed(x,y,string,sep,w,xscale,yscale,angle)\n358=draw_text_colour(x,y,string,c1,c2,c3,c4,alpha)£\n359=draw_text_ext_colour(x,y,string,sep,w,c1,c2,c3,c4,alpha)£\n360=draw_text_transformed_colour(x,y,string,xscale,yscale,angle,c1,c2,c3,c4,alpha)£\n361=draw_text_ext_transformed_colour(x,y,string,sep,w,xscale,yscale,angle,c1,c2,c3,c4,alpha)£\n362=draw_text_color(x,y,string,c1,c2,c3,c4,alpha)$\n363=draw_text_ext_color(x,y,string,sep,w,c1,c2,c3,c4,alpha)$\n364=draw_text_transformed_color(x,y,string,xscale,yscale,angle,c1,c2,c3,c4,alpha)$\n365=draw_text_ext_transformed_color(x,y,string,sep,w,xscale,yscale,angle,c1,c2,c3,c4,alpha)$\n366=draw_point_colour(x,y,col1)£\n367=draw_line_colour(x1,y1,x2,y2,col1,col2)£\n368=draw_line_width_colour(x1,y1,x2,y2,w,col1,col2)£\n369=draw_rectangle_colour(x1,y1,x2,y2,col1,col2,col3,col4,outline)£\n370=draw_roundrect_colour(x1,y1,x2,y2,col1,col2,outline)£\n371=draw_roundrect_colour_ext(x1,y1,x2,y2,radiusx,radiusy,col1,col2,outline)£\n372=draw_triangle_colour(x1,y1,x2,y2,x3,y3,col1,col2,col3,outline)£\n373=draw_circle_colour(x,y,r,col1,col2,outline)£\n374=draw_ellipse_colour(x1,y1,x2,y2,col1,col2,outline)£\n375=draw_point_color(x,y,col1)$\n376=draw_line_color(x1,y1,x2,y2,col1,col2)$\n377=draw_line_width_color(x1,y1,x2,y2,w,col1,col2)$\n378=draw_rectangle_color(x1,y1,x2,y2,col1,col2,col3,col4,outline)$\n379=draw_roundrect_color(x1,y1,x2,y2,col1,col2,outline)$\n380=draw_roundrect_color_ext(x1,y1,x2,y2,radiusx,radiusy,col1,col2,outline)$\n381=draw_triangle_color(x1,y1,x2,y2,x3,y3,col1,col2,col3,outline)$\n382=draw_circle_color(x,y,r,col1,col2,outline)$\n383=draw_ellipse_color(x1,y1,x2,y2,col1,col2,outline)$\n384=draw_primitive_begin(kind)\n385=draw_vertex(x,y)\n386=draw_vertex_colour(x,y,col,alpha)£\n387=draw_vertex_color(x,y,col,alpha)$\n388=draw_primitive_end()\n389=sprite_get_uvs(spr:index, subimg:number):\n390=font_get_uvs(font:index):\n391=sprite_get_texture(spr:index, subimg:number):\n392=font_get_texture(font:index):\n393=texture_get_width(texid):\n394=texture_get_height(texid):\n395=texture_get_uvs(texid):\n396=draw_primitive_begin_texture(kind,texid)\n397=draw_vertex_texture(x,y,xtex,ytex)\n398=draw_vertex_texture_colour(x,y,xtex,ytex,col,alpha)£\n399=draw_vertex_texture_color(x,y,xtex,ytex,col,alpha)$\n400=texture_global_scale(pow2integer)\n401=surface_create(w,h):\n402=surface_create_ext(name,w,h):\n403=surface_resize(id,width,height)\n404=surface_free(id)\n405=surface_exists(id):\n406=surface_get_width(id):\n407=surface_get_height(id):\n408=surface_get_texture(id):\n409=surface_set_target(id)\n410=surface_set_target_ext(index,id)\n411=surface_get_target():\n412=surface_get_target_ext(index):\n413=surface_reset_target()\n414=surface_depth_disable(disable)\n415=surface_get_depth_disable():\n416=draw_surface(id,x,y)\n417=draw_surface_stretched(id,x,y,w,h)\n418=draw_surface_tiled(id,x,y)\n419=draw_surface_part(id,left,top,width,height,x,y)\n420=draw_surface_ext(id,x,y,xscale,yscale,rot,col,alpha)\n421=draw_surface_stretched_ext(id,x,y,w,h,col,alpha)\n422=draw_surface_tiled_ext(id,x,y,xscale,yscale,col,alpha)\n423=draw_surface_part_ext(id,left,top,width,height,x,y,xscale,yscale,col,alpha)\n424=draw_surface_general(id,left,top,width,height,x,y,xscale,yscale,rot,c1,c2,c3,c4,alpha)\n425=surface_getpixel(id,x,y):\n426=surface_getpixel_ext(id,x,y):\n427=surface_save(id,fname)\n428=surface_save_part(id,fname,x,y,w,h)\n429=surface_copy(destination,x,y,source)\n430=surface_copy_part(destination,x,y,source,xs,ys,ws,hs)\n431=application_surface_draw_enable(on_off)\n432=application_get_position():\n433=application_surface_enable(enable)\n434=application_surface_is_enabled():\n435=display_get_width():\n436=display_get_height():\n437=display_get_orientation():\n438=display_get_gui_width():\n439=display_get_gui_height():\n440=display_reset(aa, vsync):\n441=display_mouse_get_x():\n442=display_mouse_get_y():\n443=display_mouse_set(x,y)\n444=display_set_ui_visibility(flags)\n445=window_set_fullscreen(full)\n446=window_get_fullscreen():\n447=window_set_caption(caption)\n448=window_set_min_width(minwidth)\n449=window_set_max_width(maxwidth)\n450=window_set_min_height(minheight)\n451=window_set_max_height(maxheight)\n452=window_get_visible_rects(startx,starty,endx,endy):\n453=window_get_caption():\n454=window_set_cursor(curs)\n455=window_get_cursor():\n456=window_set_colour(colour)£\n457=window_get_colour()£:\n458=window_set_color(color)$\n459=window_get_color()$:\n460=window_set_position(x,y)\n461=window_set_size(w,h)\n462=window_set_rectangle(x,y,w,h)\n463=window_center()\n464=window_get_x():\n465=window_get_y():\n466=window_get_width():\n467=window_get_height():\n468=window_mouse_get_x():\n469=window_mouse_get_y():\n470=window_mouse_set(x,y)\n471=window_view_mouse_get_x(id):\n472=window_view_mouse_get_y(id):\n473=window_views_mouse_get_x():\n474=window_views_mouse_get_y():\n475=audio_listener_position(x,y,z)\n476=audio_listener_velocity(vx,vy,vz)\n477=audio_listener_orientation(lookat_x,lookat_y,lookat_z,up_x,up_y,up_z)\n478=audio_emitter_position(emitterid,x,y,z)\n479=audio_emitter_create():\n480=audio_emitter_free(emitterid)\n481=audio_emitter_exists(emitterid):\n482=audio_emitter_pitch(emitterid,pitch)\n483=audio_emitter_velocity(emitterid,vx,vy,vz)\n484=audio_emitter_falloff(emitterid, falloff_ref_dist,falloff_max_dist,falloff_factor)\n485=audio_emitter_gain(emitterid,gain)\n486=audio_play_sound(soundid:index,priority:number,loops:bool):\n487=audio_play_sound_on(em:index,soundid:index,priority:number,loops:bool):\n488=audio_play_sound_at(soundid:index,x:number,y:number,z:number, falloff_ref_dist:number,falloff_max_dist:number,falloff_factor:number,loops:bool, priority:number):\n489=audio_stop_sound(soundid)\n490=audio_resume_sound(soundid)\n491=audio_pause_sound(soundid)\n492=audio_channel_num(numchannels)\n493=audio_sound_length(sound:index):\n494=audio_get_type(soundid):\n495=audio_falloff_set_model(falloffmode)\n496=audio_master_gain(gain)\n497=audio_sound_gain(index,level,time)\n498=audio_sound_pitch(index,pitch)\n499=audio_stop_all()\n500=audio_resume_all()\n501=audio_pause_all()\n502=audio_is_playing(soundid):\n503=audio_is_paused(soundid):\n504=audio_exists(soundid):\n505=audio_system_is_available():\n506=audio_sound_is_playable(soundid):\n507=audio_emitter_get_gain(emitterid):\n508=audio_emitter_get_pitch(emitterid):\n509=audio_emitter_get_x(emitterid):\n510=audio_emitter_get_y(emitterid):\n511=audio_emitter_get_z(emitterid):\n512=audio_emitter_get_vx(emitterid):\n513=audio_emitter_get_vy(emitterid):\n514=audio_emitter_get_vz(emitterid):\n515=audio_listener_set_position(index, x,y,z)\n516=audio_listener_set_velocity(index, vx,vy,vz)\n517=audio_listener_set_orientation(index, lookat_x,lookat_y,lookat_z,up_x,up_y,up_z)\n518=audio_listener_get_data(index):\n519=audio_set_master_gain(listenerIndex, gain)\n520=audio_get_master_gain(listenerIndex):\n521=audio_sound_get_gain(index):\n522=audio_sound_get_pitch(index):\n523=audio_get_name(index):\n524=audio_sound_set_track_position(index, time)\n525=audio_sound_get_track_position(index):\n526=audio_create_stream(filename)!:\n527=audio_destroy_stream(stream_sound_id)!\n528=audio_create_sync_group(looping):\n529=audio_destroy_sync_group(sync_group_id)\n530=audio_play_in_sync_group(sync:index, snd:index):\n531=audio_start_sync_group(sync_group_id)\n532=audio_stop_sync_group(sync_group_id)\n533=audio_pause_sync_group(sync_group_id)\n534=audio_resume_sync_group(sync_group_id)\n535=audio_sync_group_get_track_pos(sync_group_id):\n536=audio_sync_group_debug(sync_group_id)\n537=audio_sync_group_is_playing(sync_group_id):\n538=audio_debug(enable)\n539=audio_group_load(groupId):\n540=audio_group_unload(groupId)\n541=audio_group_is_loaded(groupId):\n542=audio_group_load_progress(groupId):\n543=audio_group_name(group:index):\n544=audio_group_stop_all(groupId)\n545=audio_group_set_gain(groupId, volume, time)\n546=audio_create_buffer_sound(bufferId, format, rate, offset, length, channels)!:\n547=audio_free_buffer_sound(soundId)!\n548=audio_create_play_queue(bufferFormat, sampleRate, channels)!:\n549=audio_free_play_queue(queueId)!\n550=audio_queue_sound(queueId, buffer_id, offset, length)!\n551=audio_get_recorder_count():\n552=audio_get_recorder_info(recorder_num):\n553=audio_start_recording(rec:number):\n554=audio_stop_recording(channel_index)\n555=audio_sound_get_listener_mask(soundid):\n556=audio_emitter_get_listener_mask(emitterid):\n557=audio_get_listener_mask():\n558=audio_sound_set_listener_mask(soundid,mask)\n559=audio_emitter_set_listener_mask(emitterid,mask)\n560=audio_set_listener_mask(mask)\n561=audio_get_listener_count():\n562=audio_get_listener_info(index):\n563=show_message(str)\n564=show_message_async(str)\n565=clickable_add(x,y,spritetpe,URL,target,params):\n566=clickable_add_ext(x,y,spritetpe,URL,target,params,scale,alpha):\n567=clickable_change(buttonid,spritetpe,x,y)\n568=clickable_change_ext(buttonid,spritetpe,x,y,scale,alpha)\n569=clickable_delete(buttonid)\n570=clickable_exists(index):\n571=clickable_set_style(buttonid,map)\n572=show_question(str:string):\n573=show_question_async(:string):\n574=get_integer(:string,:number):\n575=get_string(:string,:string):\n576=get_integer_async(:string,:number):\n577=get_string_async(:string,:string):\n578=get_login_async(:string,:string):\n579=get_open_filename(:string,:string):\n580=get_save_filename(:string,:string):\n581=get_open_filename_ext(:string,:string,:string,:string):\n582=get_save_filename_ext(:string,:string,:string,:string):\n583=show_error(str,abort)\n584=highscore_clear()\n585=highscore_add(str,numb)\n586=highscore_value(:index):\n587=highscore_name(:index):\n588=draw_highscore(x1,y1,x2,y2)\n589=sprite_exists(ind):\n590=sprite_get_name(ind):\n591=sprite_get_number(ind):\n592=sprite_get_width(ind):\n593=sprite_get_height(ind):\n594=sprite_get_xoffset(ind):\n595=sprite_get_yoffset(ind):\n596=sprite_get_bbox_mode(ind):\n597=sprite_get_bbox_left(ind):\n598=sprite_get_bbox_right(ind):\n599=sprite_get_bbox_top(ind):\n600=sprite_get_bbox_bottom(ind):\n601=sprite_set_bbox_mode(ind,mode)\n602=sprite_set_bbox(ind,left,top,right,bottom)\n603=sprite_save(ind,subimg,fname)\n604=sprite_save_strip(ind,fname)\n605=sprite_set_cache_size(ind, max)\n606=sprite_set_cache_size_ext(ind, image, max)\n607=sprite_get_tpe(index,subindex):\n608=sprite_prefetch(ind)\n609=sprite_prefetch_multi(indarray)\n610=sprite_flush(ind)\n611=sprite_flush_multi(indarray)\n612=sprite_set_speed(ind,speed,type)\n613=sprite_get_speed_type(ind):\n614=sprite_get_speed(ind):\n615=texture_is_ready(tex_id):\n616=texture_prefetch(tex_id_or_groupname)\n617=texture_flush(tex_id_or_groupname)\n618=texturegroup_get_textures(groupname):\n619=texturegroup_get_sprites(groupname):\n620=texturegroup_get_fonts(groupname):\n621=texturegroup_get_tilesets(groupname):\n622=texture_debug_messages(debug_level)\n623=font_exists(ind):\n624=font_get_name(ind):\n625=font_get_fontname(ind):\n626=font_get_bold(ind):\n627=font_get_italic(ind):\n628=font_get_first(ind):\n629=font_get_last(ind):\n630=font_get_size(ind):\n631=font_set_cache_size(font,max)\n632=path_exists(ind):\n633=path_get_name(ind):\n634=path_get_length(ind):\n635=path_get_time(ind,speed):\n636=path_get_kind(ind):\n637=path_get_closed(ind):\n638=path_get_precision(ind):\n639=path_get_number(ind):\n640=path_get_point_x(ind,n):\n641=path_get_point_y(ind,n):\n642=path_get_point_speed(ind,n):\n643=path_get_x(ind,pos):\n644=path_get_y(ind,pos):\n645=path_get_speed(ind,pos):\n646=script_exists(ind):\n647=script_get_name(:id):\n648=timeline_add()!:\n649=timeline_delete(ind)!\n650=timeline_clear(ind)\n651=timeline_exists(ind):\n652=timeline_get_name(ind):\n653=timeline_moment_clear(ind,step)\n654=timeline_moment_add_script(ind,step,script)\n655=timeline_size(ind):\n656=timeline_max_moment(:index):\n657=object_exists(ind):\n658=object_get_name(o:id):\n659=object_get_sprite(ind):\n660=object_get_solid(ind):\n661=object_get_visible(ind):\n662=object_get_persistent(ind):\n663=object_get_mask(ind):\n664=object_get_parent(ind):\n665=object_get_physics(ind):\n666=object_is_ancestor(ind_child,ind_parent):\n667=room_exists(ind):\n668=room_get_name(ind):\n669=sprite_set_offset(ind,xoff,yoff)\n670=sprite_duplicate(:index):\n671=sprite_assign(ind,source)\n672=sprite_merge(ind1,ind2)\n673=sprite_add(fname:string,imgnumb:int,removeback:bool,smooth:bool,xorig:number,yorig:number)!:\n674=sprite_replace(ind,fname,imgnumb,removeback,smooth,xorig,yorig)!\n675=sprite_create_from_surface(:index,x:number,y:number,w:number,h:number,removeback:bool,smooth:bool,xorig:number,yorig:number)!:\n676=sprite_add_from_surface(ind:index,id:index,x:number,y:number,w:number,h:number,removeback:bool,smooth:bool)!:\n677=sprite_delete(ind)!\n678=sprite_set_alpha_from_sprite(ind,spr)\n679=sprite_collision_mask(ind,sepmasks,bboxmode,bbleft,bbtop,bbright,bbbottom,kind,tolerance)\n680=font_add_enable_aa(enable)\n681=font_add_get_enable_aa():\n682=font_add(:string,:number,:bool,:bool,:int,:int)!:\n683=font_add_sprite(spr:index,first:int,prop:bool,sep:number)!:\n684=font_add_sprite_ext(spr:index,:string,:bool,:number)!:\n685=font_replace_sprite(ind,spr,first,prop,sep)!\n686=font_replace_sprite_ext(font,spr,string_map,prop,sep)!\n687=font_delete(ind)!\n688=path_set_kind(ind,kind)\n689=path_set_closed(ind,closed)\n690=path_set_precision(ind,prec)\n691=path_add()!:\n692=path_assign(ind,path)\n693=path_duplicate(:index)!:\n694=path_append(ind,path)\n695=path_delete(ind)\n696=path_add_point(ind,x,y,speed)\n697=path_insert_point(ind,n,x,y,speed)\n698=path_change_point(ind,n,x,y,speed)\n699=path_delete_point(ind,n)!\n700=path_clear_points(ind)\n701=path_reverse(ind)\n702=path_mirror(ind)\n703=path_flip(ind)\n704=path_rotate(ind,angle)\n705=path_rescale(ind,xscale,yscale)\n706=path_shift(ind,xshift,yshift)\n707=object_set_sprite(ind,spr)\n708=object_set_solid(ind,solid)\n709=object_set_visible(ind,vis)\n710=object_set_persistent(ind,pers)\n711=object_set_mask(ind,spr)\n712=room_set_width(ind,w)\n713=room_set_height(ind,h)\n714=room_set_persistent(ind,pers)\n715=room_set_viewport(ind,vind,vis,xport,yport,wport,hport)\n716=room_get_viewport(ind,vind):\n717=room_set_view_enabled(ind,val)\n718=room_add()!:\n719=room_duplicate(:index)!:\n720=room_assign(ind,source)\n721=room_instance_add(:index,:number,:number,:index):\n722=room_instance_clear(ind)\n723=room_get_camera(ind,vind):\n724=room_set_camera(ind,vind,camera)\n725=asset_get_index(name):\n726=asset_get_type(name):\n727=file_text_open_from_string(:string):\n728=file_text_open_read(fname):\n729=file_text_open_write(:string):\n730=file_text_open_append(:string):\n731=file_text_close(file)\n732=file_text_write_string(file,str)\n733=file_text_write_real(file,val)\n734=file_text_writeln(file)\n735=file_text_read_string(file):\n736=file_text_read_real(file):\n737=file_text_readln(file):\n738=file_text_eof(:index):\n739=file_text_eoln(:index):\n740=file_exists(fname):\n741=file_delete(fname)\n742=file_rename(oldname,newname)\n743=file_copy(fname,newname)\n744=directory_exists(dname):\n745=directory_create(dname):\n746=directory_destroy(dname)\n747=file_find_first(mask,attr):\n748=file_find_next():\n749=file_find_close():\n750=file_attributes(:string,:int):\n751=filename_name(:string):\n752=filename_path(:string):\n753=filename_dir(:string):\n754=filename_drive(:string):\n755=filename_ext(:string):\n756=filename_change_ext(:string,:string):\n757=file_bin_open(:string,mode):\n758=file_bin_rewrite(file)\n759=file_bin_close(file)\n760=file_bin_position(:index):\n761=file_bin_size(file):\n762=file_bin_seek(file,pos)\n763=file_bin_write_byte(file,byte)\n764=file_bin_read_byte(file):\n765=parameter_count():\n766=parameter_string(:index):\n767=environment_get_variable(name):\n768=ini_open_from_string(content)\n769=ini_open(fname)\n770=ini_close():\n771=ini_read_string(section,key,default):\n772=ini_read_real(section,key,default):\n773=ini_write_string(section,key,str)\n774=ini_write_real(section,key,value)\n775=ini_key_exists(section,key):\n776=ini_section_exists(section):\n777=ini_key_delete(section,key)\n778=ini_section_delete(section)\n779=ds_set_precision(prec)\n780=ds_exists(id, type):\n781=ds_stack_create():\n782=ds_stack_destroy(id)\n783=ds_stack_clear(id)\n784=ds_stack_copy(id,source)\n785=ds_stack_size(id):\n786=ds_stack_empty(id)\n787=ds_stack_push(id,value,...)\n788=ds_stack_pop(id)\n789=ds_stack_top(:index):\n790=ds_stack_write(:index):\n791=ds_stack_read(:index,:string,?legacy):\n792=ds_queue_create():\n793=ds_queue_destroy(id)\n794=ds_queue_clear(id)\n795=ds_queue_copy(id,source)\n796=ds_queue_size(id):\n797=ds_queue_empty(:index):\n798=ds_queue_enqueue(id,value,...)\n799=ds_queue_dequeue(:index):\n800=ds_queue_head(:index):\n801=ds_queue_tail(:index):\n802=ds_queue_write(:index):\n803=ds_queue_read(:index,:string,?legacy):\n804=ds_list_create():\n805=ds_list_destroy(:id)\n806=ds_list_clear(:id)\n807=ds_list_copy(:id,source:id)\n808=ds_list_size(:id):\n809=ds_list_empty(:id):\n810=ds_list_add(:id,...:any)\n811=ds_list_insert(:id,pos:int,value:any)\n812=ds_list_replace(:id,pos:int,value:any)\n813=ds_list_delete(:id,pos:int)\n814=ds_list_find_index(:id,value:any):\n815=ds_list_find_value(:id,pos:int):\n816=ds_list_mark_as_list(:id,pos:int)\n817=ds_list_mark_as_map(:id,pos:int)\n818=ds_list_sort(:id,ascending:bool)\n819=ds_list_shuffle(:id)\n820=ds_list_write(:id):\n821=ds_list_read(:id,:string,?legacy:bool):\n822=ds_list_set(:id,pos:int,value:any)\n823=ds_map_create():\n824=ds_map_destroy(:index)\n825=ds_map_clear(:index)\n826=ds_map_copy(:index,:index)\n827=ds_map_size(:index):\n828=ds_map_empty(:index):\n829=ds_map_add(:index,:any,:any)\n830=ds_map_add_list(:index,:any,value)\n831=ds_map_add_map(:index,:any,value)\n832=ds_map_replace(:index,:any,value)\n833=ds_map_replace_map(:index,:any,value)\n834=ds_map_replace_list(:index,:any,value)\n835=ds_map_delete(:index,:any)\n836=ds_map_exists(:index,:any):\n837=ds_map_find_value(:index,:any):\n838=ds_map_find_previous(:index,:any):\n839=ds_map_find_next(:index,:any):\n840=ds_map_find_first(:index):\n841=ds_map_find_last(:index):\n842=ds_map_write(:index):\n843=ds_map_read(:index,:string,?legacy:bool):\n844=ds_map_secure_save(:index, path:string)\n845=ds_map_secure_load(path:string):\n846=ds_map_secure_load_buffer(:id):\n847=ds_map_secure_save_buffer(:index,:id)\n848=ds_map_set(:index,:any,:any)\n849=ds_priority_create():\n850=ds_priority_destroy(id)\n851=ds_priority_clear(id)\n852=ds_priority_copy(id,source)\n853=ds_priority_size(id):\n854=ds_priority_empty(:index):\n855=ds_priority_add(id,value,priority)\n856=ds_priority_change_priority(id,value,priority)\n857=ds_priority_find_priority(id,value):\n858=ds_priority_delete_value(id,value)\n859=ds_priority_delete_min(:index):\n860=ds_priority_find_min(:index):\n861=ds_priority_delete_max(:index):\n862=ds_priority_find_max(:index):\n863=ds_priority_write(:index):\n864=ds_priority_read(:index,:string,?legacy):\n865=ds_grid_create(w,h):\n866=ds_grid_destroy(id)\n867=ds_grid_copy(id,source)\n868=ds_grid_resize(id,w,h)\n869=ds_grid_width(:index):\n870=ds_grid_height(:index):\n871=ds_grid_clear(id,val)\n872=ds_grid_set(id,x,y,val)\n873=ds_grid_add(id,x,y,val)\n874=ds_grid_multiply(id,x,y,val)\n875=ds_grid_set_region(id,x1,y1,x2,y2,val)\n876=ds_grid_add_region(id,x1,y1,x2,y2,val)\n877=ds_grid_multiply_region(id,x1,y1,x2,y2,val)\n878=ds_grid_set_disk(id,xm,ym,r,val)\n879=ds_grid_add_disk(id,xm,ym,r,val)\n880=ds_grid_multiply_disk(id,xm,ym,r,val)\n881=ds_grid_set_grid_region(id,source,x1,y1,x2,y2,xpos,ypos)\n882=ds_grid_add_grid_region(id,source,x1,y1,x2,y2,xpos,ypos)\n883=ds_grid_multiply_grid_region(id,source,x1,y1,x2,y2,xpos,ypos)\n884=ds_grid_get(id,x,y):\n885=ds_grid_get_sum(id,x1,y1,x2,y2):\n886=ds_grid_get_max(id,x1,y1,x2,y2):\n887=ds_grid_get_min(id,x1,y1,x2,y2):\n888=ds_grid_get_mean(id,x1,y1,x2,y2):\n889=ds_grid_get_disk_sum(id,xm,ym,r):\n890=ds_grid_get_disk_min(id,xm,ym,r):\n891=ds_grid_get_disk_max(id,xm,ym,r):\n892=ds_grid_get_disk_mean(id,xm,ym,r):\n893=ds_grid_value_exists(id,x1,y1,x2,y2,val):\n894=ds_grid_value_x(:index,x1:number,y1:number,x2:number,y2:number,val):\n895=ds_grid_value_y(:index,x1:number,y1:number,x2:number,y2:number,val):\n896=ds_grid_value_disk_exists(id,xm,ym,r,val):\n897=ds_grid_value_disk_x(:index,xm:number,ym:number,r:number,val):\n898=ds_grid_value_disk_y(:index,xm:number,ym:number,r:number,val):\n899=ds_grid_shuffle(id)\n900=ds_grid_write(:index):\n901=ds_grid_read(:index,:string,?legacy):\n902=ds_grid_sort(id,column,ascending)\n903=effect_create_below(kind,x,y,size,col):\n904=effect_create_above(kind,x,y,size,col):\n905=effect_clear()\n906=part_type_create():\n907=part_type_destroy(ind)\n908=part_type_exists(ind):\n909=part_type_clear(ind)\n910=part_type_shape(ind,shape)\n911=part_type_sprite(ind,sprite,animat,stretch,random)\n912=part_type_size(ind,size_min,size_max,size_incr,size_wiggle):\n913=part_type_scale(ind,xscale,yscale)\n914=part_type_orientation(ind,ang_min,ang_max,ang_incr,ang_wiggle,ang_relative)\n915=part_type_life(ind,life_min,life_max)\n916=part_type_step(ind,step_number,step_type)\n917=part_type_death(ind,death_number,death_type)\n918=part_type_speed(ind,speed_min,speed_max,speed_incr,speed_wiggle)\n919=part_type_direction(ind,dir_min,dir_max,dir_incr,dir_wiggle)\n920=part_type_gravity(ind,grav_amount,grav_dir)\n921=part_type_colour1(ind,colour1)£\n922=part_type_colour2(ind,colour1,colour2)£\n923=part_type_colour3(ind,colour1,colour2,colour3)£\n924=part_type_colour_mix(ind,colour1,colour2)£\n925=part_type_colour_rgb(ind,rmin,rmax,gmin,gmax,bmin,bmax)£\n926=part_type_colour_hsv(ind,hmin,hmax,smin,smax,vmin,vmax)£\n927=part_type_color1(ind,color1)$\n928=part_type_color2(ind,color1,color2)$\n929=part_type_color3(ind,color1,color2,color3)$\n930=part_type_color_mix(ind,color1,color2)$\n931=part_type_color_rgb(ind,rmin,rmax,gmin,gmax,bmin,bmax)$\n932=part_type_color_hsv(ind,hmin,hmax,smin,smax,vmin,vmax)$\n933=part_type_alpha1(ind,alpha1)\n934=part_type_alpha2(ind,alpha1,alpha2)\n935=part_type_alpha3(ind,alpha1,alpha2,alpha3)\n936=part_type_blend(ind,additive)\n937=part_system_create():\n938=part_system_create_layer(layer,persistent):\n939=part_system_destroy(ind)\n940=part_system_exists(ind):\n941=part_system_clear(ind)\n942=part_system_draw_order(ind,oldtonew)\n943=part_system_depth(ind,depth)\n944=part_system_position(ind,x,y)\n945=part_system_automatic_update(ind,automatic)\n946=part_system_automatic_draw(ind,draw)\n947=part_system_update(ind)\n948=part_system_drawit(ind)\n949=part_system_get_layer(ind):\n950=part_system_layer(ind,layer)\n951=part_particles_create(ind,x,y,parttype,number):\n952=part_particles_create_colour(ind,x,y,parttype,colour,number)£:\n953=part_particles_create_color(ind,x,y,parttype,color,number)$:\n954=part_particles_clear(ind)\n955=part_particles_count(ind)\n956=part_emitter_create(ps):\n957=part_emitter_destroy(ps,ind)\n958=part_emitter_destroy_all(ps)\n959=part_emitter_exists(ps,ind):\n960=part_emitter_clear(ps,ind)\n961=part_emitter_region(ps,ind,xmin,xmax,ymin,ymax,shape,distribution)\n962=part_emitter_burst(ps,ind,parttype,number)\n963=part_emitter_stream(ps,ind,parttype,number)\n964=window_handle():\n965=window_device():\n966=matrix_get(type):\n967=matrix_set(type,matrix)\n968=matrix_build_identity():\n969=matrix_build(x,y,z,xrotation,yrotation,zrotation,xscale,yscale,zscale):\n970=matrix_build_lookat(xfrom,yfrom,zfrom,xto,yto,zto,xup,yup,zup):\n971=matrix_build_projection_ortho(width,height,znear,zfar):\n972=matrix_build_projection_perspective(width,height,znear,zfar):\n973=matrix_build_projection_perspective_fov(fov_y,aspect,znear,zfar):\n974=matrix_multiply(a, b):\n975=matrix_transform_vertex(matrix, x, y, z):\n976=matrix_stack_push(...)\n977=matrix_stack_pop():\n978=matrix_stack_set(matrix)\n979=matrix_stack_clear()\n980=matrix_stack_top():\n981=matrix_stack_is_empty():\n982=browser_input_capture(enable)\n983=os_get_config():\n984=os_get_info():\n985=os_get_language():\n986=os_get_region():\n987=os_check_permission(permission)\n988=os_request_permission(permission)\n989=os_lock_orientation(flag)\n990=display_get_dpi_x():\n991=display_get_dpi_y():\n992=display_set_gui_size(width,height)\n993=display_set_gui_maximise(xscale,yscale,xoffset,yoffset,...)£\n994=display_set_gui_maximize(xscale,yscale,xoffset,yoffset,...)$\n995=device_mouse_dbclick_enable(enable)\n996=display_set_timing_method(method)\n997=display_get_timing_method():\n998=display_set_sleep_margin(milliseconds)\n999=display_get_sleep_margin():\n1000=virtual_key_add(x,y,w,h,keycode)\n1001=virtual_key_hide(id)\n1002=virtual_key_delete(id)\n1003=virtual_key_show(id)\n1004=draw_enable_drawevent(enable)\n1005=draw_texture_flush()\n1006=draw_flush()\n1007=gpu_set_blendenable(enable)\n1008=gpu_set_ztestenable(enable)\n1009=gpu_set_zfunc(cmp_func)\n1010=gpu_set_zwriteenable(enable)\n1011=gpu_set_fog(data_or_enable,?color,?start,?end)\n1012=gpu_set_cullmode(cullmode)\n1013=gpu_set_blendmode(mode)\n1014=gpu_set_blendmode_ext(src,dest)\n1015=gpu_set_blendmode_ext_sepalpha(src,dest,srcalpha,destalpha)\n1016=gpu_set_colorwriteenable(red,green,blue,alpha)$\n1017=gpu_set_colourwriteenable(red,green,blue,alpha)£\n1018=gpu_set_alphatestenable(enable)\n1019=gpu_set_alphatestref(value)\n1020=gpu_set_alphatestfunc(cmp_func)\n1021=gpu_set_texfilter(linear)\n1022=gpu_set_texfilter_ext(sampler_id,linear)\n1023=gpu_set_texrepeat(repeat)\n1024=gpu_set_texrepeat_ext(sampler_id,repeat)\n1025=gpu_set_tex_filter(linear)\n1026=gpu_set_tex_filter_ext(sampler_id,linear)\n1027=gpu_set_tex_repeat(repeat)\n1028=gpu_set_tex_repeat_ext(sampler_id,repeat)\n1029=gpu_set_tex_mip_filter(filter)\n1030=gpu_set_tex_mip_filter_ext(sampler_id,filter)\n1031=gpu_set_tex_mip_bias(bias)\n1032=gpu_set_tex_mip_bias_ext(sampler_id,bias)\n1033=gpu_set_tex_min_mip(minmip)\n1034=gpu_set_tex_min_mip_ext(sampler_id,minmip)\n1035=gpu_set_tex_max_mip(maxmip)\n1036=gpu_set_tex_max_mip_ext(sampler_id,maxmip)\n1037=gpu_set_tex_max_aniso(maxaniso)\n1038=gpu_set_tex_max_aniso_ext(sampler_id,maxaniso)\n1039=gpu_set_tex_mip_enable(setting)\n1040=gpu_set_tex_mip_enable_ext(sampler_id,setting)\n1041=gpu_get_blendenable():\n1042=gpu_get_ztestenable():\n1043=gpu_get_zfunc():\n1044=gpu_get_zwriteenable():\n1045=gpu_get_fog():\n1046=gpu_get_cullmode():\n1047=gpu_get_blendmode():\n1048=gpu_get_blendmode_ext():\n1049=gpu_get_blendmode_ext_sepalpha():\n1050=gpu_get_blendmode_src():\n1051=gpu_get_blendmode_dest():\n1052=gpu_get_blendmode_srcalpha():\n1053=gpu_get_blendmode_destalpha():\n1054=gpu_get_colorwriteenable()$:\n1055=gpu_get_colourwriteenable()£:\n1056=gpu_get_alphatestenable():\n1057=gpu_get_alphatestref():\n1058=gpu_get_alphatestfunc():\n1059=gpu_get_texfilter():\n1060=gpu_get_texfilter_ext(sampler_id):\n1061=gpu_get_texrepeat():\n1062=gpu_get_texrepeat_ext(sampler_id):\n1063=gpu_get_tex_filter():\n1064=gpu_get_tex_filter_ext(sampler_id):\n1065=gpu_get_tex_repeat():\n1066=gpu_get_tex_repeat_ext(sampler_id):\n1067=gpu_get_tex_mip_filter():\n1068=gpu_get_tex_mip_filter_ext(sampler_id):\n1069=gpu_get_tex_mip_bias():\n1070=gpu_get_tex_mip_bias_ext(sampler_id):\n1071=gpu_get_tex_min_mip():\n1072=gpu_get_tex_min_mip_ext(sampler_id):\n1073=gpu_get_tex_max_mip():\n1074=gpu_get_tex_max_mip_ext(sampler_id):\n1075=gpu_get_tex_max_aniso():\n1076=gpu_get_tex_max_aniso_ext(sampler_id):\n1077=gpu_get_tex_mip_enable():\n1078=gpu_get_tex_mip_enable_ext(sampler_id):\n1079=gpu_push_state()\n1080=gpu_pop_state()\n1081=gpu_get_state():\n1082=gpu_set_state(map)\n1083=draw_light_define_ambient(col)\n1084=draw_light_define_direction(ind,dx,dy,dz,col)\n1085=draw_light_define_point(ind,x,y,z,range,col)\n1086=draw_light_enable(ind,enable)\n1087=draw_set_lighting(enable)\n1088=draw_light_get_ambient():\n1089=draw_light_get(ind):\n1090=draw_get_lighting():\n1091=shop_leave_rating(text_string,yes_string,no_string,url)\n1092=url_get_domain():\n1093=url_open(url)\n1094=url_open_ext(url,target)\n1095=url_open_full(url,target,options)\n1096=get_timer():\n1097=device_get_tilt_x():\n1098=device_get_tilt_y():\n1099=device_get_tilt_z():\n1100=device_is_keypad_open():\n1101=device_mouse_check_button(:index,:index):\n1102=device_mouse_check_button_pressed(:index,:index):\n1103=device_mouse_check_button_released(:index,:index):\n1104=device_mouse_x(:index):\n1105=device_mouse_y(:index):\n1106=device_mouse_raw_x(:index):\n1107=device_mouse_raw_y(:index):\n1108=device_mouse_x_to_gui(:index):\n1109=device_mouse_y_to_gui(:index):\n1110=gamepad_is_supported():\n1111=gamepad_get_device_count():\n1112=gamepad_is_connected(device):\n1113=gamepad_get_description(device):\n1114=gamepad_get_button_threshold(device):\n1115=gamepad_set_button_threshold(device, threshold)\n1116=gamepad_get_axis_deadzone(device):\n1117=gamepad_set_axis_deadzone(device, deadzone)\n1118=gamepad_button_count(device:index):\n1119=gamepad_button_check(device:index, buttonIndex:index):\n1120=gamepad_button_check_pressed(device:index, buttonIndex:index):\n1121=gamepad_button_check_released(device:index, buttonIndex:index):\n1122=gamepad_button_value(device:index, buttonIndex:index):\n1123=gamepad_axis_count(axis:index):\n1124=gamepad_axis_value(device:index, axisIndex:index):\n1125=gamepad_set_vibration(device, leftMotorSpeed, rightMotorSpeed)\n1126=gamepad_set_colour(index,colour)£\n1127=gamepad_set_color(index,color)$\n1128=gamepad_hat_count(axis)\n1129=gamepad_hat_value(device, axisIndex)\n1130=gamepad_remove_mapping(device)\n1131=gamepad_test_mapping(device, mapping_string)\n1132=gamepad_get_mapping(device):\n1133=gamepad_get_guid(device):\n1134=gamepad_set_option(gamepad_id, option_key, option_value)\n1135=gamepad_get_option(gamepad_id, option_key):\n1136=os_is_paused():\n1137=window_has_focus():\n1138=code_is_compiled():\n1139=http_get(url):\n1140=http_get_file(url, dest):\n1141=http_post_string(:string,:string):\n1142=http_request(url:string, method, header_map, body):\n1143=http_get_request_crossorigin():\n1144=http_set_request_crossorigin(crossorigin_type)\n1145=json_encode(:id):\n1146=json_decode(:string):\n1147=zip_unzip(file, destPath)\n1148=load_csv(:string):\n1149=base64_encode(:string):\n1150=base64_decode(:string):\n1151=md5_string_unicode(:string):\n1152=md5_string_utf8(:string):\n1153=md5_file(:string):\n1154=os_is_network_connected():\n1155=sha1_string_unicode(:string):\n1156=sha1_string_utf8(:string):\n1157=sha1_file(:string):\n1158=os_powersave_enable(enable)\n1159=uwp_livetile_tile_clear()\n1160=uwp_livetile_badge_notification(id)\n1161=uwp_livetile_badge_clear()\n1162=uwp_livetile_queue_enable(flag)\n1163=uwp_secondarytile_pin(tileId, displayName, cmdLineArgs, tileImage, wideTileImage, largeTileImage, textCol, tileSize)\n1164=uwp_secondarytile_badge_notification(id, tileId)\n1165=uwp_secondarytile_delete(tileId)\n1166=uwp_secondarytile_badge_clear(tileId)\n1167=uwp_secondarytile_tile_clear(tileId)\n1168=uwp_livetile_notification_begin(template)\n1169=uwp_livetile_notification_secondary_begin(template, tileId)\n1170=uwp_livetile_notification_expiry(expiryTime)\n1171=uwp_livetile_notification_tag(tag)\n1172=uwp_livetile_notification_text_add(text)\n1173=uwp_livetile_notification_image_add(image)\n1174=uwp_livetile_notification_end()\n1175=uwp_livetile_notification_template_add(template)\n1176=uwp_appbar_enable(flag)\n1177=uwp_appbar_add_element(id, type, icon, label, section, toolTip, callback)\n1178=uwp_appbar_remove_element(id)\n1179=uwp_device_touchscreen_available()\n1180=physics_world_create(PixelToMetreScale):\n1181=physics_world_gravity(gx, gy)\n1182=physics_world_update_speed(speed)\n1183=physics_world_update_iterations(iterations)\n1184=physics_world_draw_debug(draw_flags)\n1185=physics_pause_enable(pause)\n1186=physics_fixture_create():\n1187=physics_fixture_set_kinematic(fixture)\n1188=physics_fixture_set_density(fixture, density)\n1189=physics_fixture_set_awake(fixture, flag)\n1190=physics_fixture_set_restitution(fixture, restitution)\n1191=physics_fixture_set_friction(fixture,friction)\n1192=physics_fixture_set_collision_group(fixture, group)\n1193=physics_fixture_set_sensor(fixture, sensorState)\n1194=physics_fixture_set_linear_damping(fixture, damping)\n1195=physics_fixture_set_angular_damping(fixture, damping)\n1196=physics_fixture_set_circle_shape(fixture, circleRadius)\n1197=physics_fixture_set_box_shape(fixture, halfWidth, halfHeight)\n1198=physics_fixture_set_edge_shape(fixture, x1,y1,x2,y2)\n1199=physics_fixture_set_polygon_shape(fixture)\n1200=physics_fixture_set_chain_shape(fixture, loop)\n1201=physics_fixture_add_point(fixture, local_x, local_y)\n1202=:physics_fixture_bind(fixture, obj)\n1203=:physics_fixture_bind_ext(fixture, obj, xo, yo)\n1204=physics_fixture_delete(fixture)\n1205=:physics_apply_force(xpos, ypos, xforce, yforce)\n1206=:physics_apply_impulse(xpos, ypos, ximpulse, yimpulse)\n1207=:physics_apply_angular_impulse(impulse)\n1208=:physics_apply_local_force(xlocal, ylocal, xforce_local, yforce_local)\n1209=:physics_apply_local_impulse(xlocal, ylocal, ximpulse_local, yimpulse_local)\n1210=:physics_apply_torque(torque)\n1211=:physics_mass_properties(mass, local_centre_of_mass_x, local_centre_of_mass_y, inertia)\n1212=:physics_draw_debug()\n1213=:physics_test_overlap(x, y, angle, obj)\n1214=physics_remove_fixture(inst, id)\n1215=:physics_set_friction(fixture, friction)\n1216=:physics_set_density(fixture, density)\n1217=:physics_set_restitution(fixture, restitution)\n1218=:physics_get_friction(fixture):\n1219=:physics_get_density(fixture):\n1220=:physics_get_restitution(fixture):\n1221=physics_joint_distance_create(inst1, inst2, anchor_1_x, anchor_1_y, anchor_2_x, anchor_2_y, collideInstances):\n1222=physics_joint_rope_create(inst1, inst2, anchor_1_x, anchor_1_y, anchor_2_x, anchor_2_y, maxLength, collideInstances):\n1223=physics_joint_revolute_create(inst1, inst2, anchor_x, anchor_y, lower_angle_limit, upper_angle_limit, enable_limit, max_motor_torque, motor_speed, enable_motor, collideInstances):\n1224=physics_joint_prismatic_create(inst1, inst2, anchor_x, anchor_y, axis_x, axis_y, lower_translation_limit, upper_translation_limit, enable_limit, max_motor_force, motor_speed, enable_motor, collideInstances):\n1225=physics_joint_pulley_create(inst1, inst2, anchor_1_x, anchor_1_y, anchor_2_x, anchor_2_y, local_anchor_1_x, local_anchor_1_y, local_anchor_2_x, local_anchor_2_y, ratio, collideInstances):\n1226=physics_joint_wheel_create(inst1, inst2, anchor_x, anchor_y, axis_x, axis_y, enableMotor, max_motor_torque, motor_speed, freq_hz, damping_ratio, collideInstances):\n1227=physics_joint_weld_create(inst1, inst2, anchor_x, anchor_y, ref_angle, freq_hz, damping_ratio, collideInstances):\n1228=physics_joint_friction_create(inst1, inst2, anchor_x, anchor_y, max_force, max_torque, collideInstances):\n1229=physics_joint_gear_create(inst1, inst2, revoluteJoint, prismaticJoint, ratio):\n1230=physics_joint_enable_motor(joint, motorState)\n1231=physics_joint_get_value(joint, field):\n1232=physics_joint_set_value(joint, field, value)\n1233=physics_joint_delete(joint)\n1234=physics_particle_create(typeflags, x, y, xv, yv, col, alpha, category):\n1235=physics_particle_delete(ind)\n1236=physics_particle_delete_region_circle(x, y, radius)\n1237=physics_particle_delete_region_box(x, y, halfWidth, halfHeight)\n1238=physics_particle_delete_region_poly(pointList)\n1239=physics_particle_set_flags(ind, typeflags)\n1240=physics_particle_set_category_flags(category, typeflags)\n1241=physics_particle_draw(typemask, category, sprite, subimg)\n1242=physics_particle_draw_ext(typemask, category, sprite, subimg, xscale, yscale, angle, col, alpha)\n1243=physics_particle_count()\n1244=physics_particle_get_data(buffer, dataFlags):\n1245=physics_particle_get_data_particle(ind, buffer, dataFlags):\n1246=physics_particle_group_begin(typeflags, groupflags, x, y, ang, xv, yv, angVelocity, col, alpha, strength, category)\n1247=physics_particle_group_circle(radius)\n1248=physics_particle_group_box(halfWidth, halfHeight)\n1249=physics_particle_group_polygon()\n1250=physics_particle_group_add_point(x, y)\n1251=physics_particle_group_end()\n1252=physics_particle_group_join(to, from)\n1253=physics_particle_group_delete(ind)\n1254=physics_particle_group_count(group)\n1255=physics_particle_group_get_data(group, buffer, dataFlags):\n1256=physics_particle_group_get_mass(group):\n1257=physics_particle_group_get_inertia(group):\n1258=physics_particle_group_get_centre_x(group):\n1259=physics_particle_group_get_centre_y(group):\n1260=physics_particle_group_get_vel_x(group):\n1261=physics_particle_group_get_vel_y(group):\n1262=physics_particle_group_get_ang_vel(group):\n1263=physics_particle_group_get_x(group):\n1264=physics_particle_group_get_y(group):\n1265=physics_particle_group_get_angle(group):\n1266=physics_particle_set_group_flags(group, groupflags)\n1267=physics_particle_get_group_flags(group):\n1268=physics_particle_get_max_count():\n1269=physics_particle_get_radius():\n1270=physics_particle_get_density():\n1271=physics_particle_get_damping():\n1272=physics_particle_get_gravity_scale():\n1273=physics_particle_set_max_count(count)\n1274=physics_particle_set_radius(radius)\n1275=physics_particle_set_density(density)\n1276=physics_particle_set_damping(damping)\n1277=physics_particle_set_gravity_scale(scale)\n1278=network_create_socket(type:int):\n1279=network_create_socket_ext(type:int, port:int):\n1280=network_create_server(type:int, port:int, maxclients:int):\n1281=network_create_server_raw(type:int, port:int, maxclients:int):\n1282=network_connect(:id, url:string, port:int):\n1283=network_connect_raw(:id, url:string, port:int):\n1284=network_send_packet(:id, :id, size:int):\n1285=network_send_raw(:id, :id, size:int):\n1286=network_send_broadcast(:id, port:int, :id, size:int):\n1287=network_send_udp(:id, URL:string, port:int, data:id, size:int):\n1288=network_send_udp_raw(:id, URL:string, port:int, data:id, size:int):\n1289=network_set_timeout(:id, read:number, write:number)\n1290=network_set_config(parameter, value)\n1291=network_resolve(url:string):\n1292=network_destroy(:id)\n1293=buffer_create(size:int, buffer_type:int, alignment:int):\n1294=buffer_write(:id, type:int, value)\n1295=buffer_read(:id, type:int):\n1296=buffer_seek(:id, base:int, offset:int)\n1297=buffer_get_surface(:id, :id, mode:int, offset:int, modulo:int):\n1298=buffer_set_surface(:id, :id, mode:int, offset:int, modulo:int)\n1299=buffer_delete(:id)\n1300=buffer_exists(:id):\n1301=buffer_get_type(:id):\n1302=buffer_get_alignment(:id):\n1303=buffer_poke(:id, offset:int, type:int, value)\n1304=buffer_peek(:id, offset:int, type:int)\n1305=buffer_save(:id, filename:string)\n1306=buffer_save_ext(:id, filename:string, offset:int, size:int)\n1307=buffer_load(filename:string):\n1308=buffer_load_ext(:id, filename:string, offset:int):\n1309=buffer_load_partial(:id, filename:string, src_offset:int, src_len:int, dest_offset:int):\n1310=buffer_copy(src_buffer, src_offset:int, size:int, dest:id, dest_offset:int)\n1311=buffer_fill(:id, offset:int, type:int, value, size:int)\n1312=buffer_get_size(:id):\n1313=buffer_tell(:id):\n1314=buffer_resize(:id, newsize:int)\n1315=buffer_md5(:id, offset:int, size:int):\n1316=buffer_sha1(:id, offset:int, size:int):\n1317=buffer_base64_encode(:id, offset:int, size:int):\n1318=buffer_base64_decode(string):\n1319=buffer_base64_decode_ext(:id, :string, offset:int)\n1320=buffer_sizeof(type:int):\n1321=buffer_get_address(:id):\n1322=buffer_create_from_vertex_buffer(:id, type, alignment):\n1323=buffer_create_from_vertex_buffer_ext(:id, type, alignment, start_vertex, num_vertices):\n1324=buffer_copy_from_vertex_buffer(vertex_buffer, start_vertex, num_vertices, dest_buffer, dest_offset)\n1325=buffer_async_group_begin(groupname)\n1326=buffer_async_group_option(optionname,optionvalue)\n1327=buffer_async_group_end()\n1328=buffer_load_async(:id,filename:string,offset:int,size:int):\n1329=buffer_save_async(:id,filename:string,offset:int,size:int)\n1330=buffer_compress(bufferid,offset,size)\n1331=buffer_decompress(bufferId)\n1332=gml_release_mode(enable)\n1333=steam_activate_overlay(overlayIndex)\n1334=steam_is_overlay_enabled():\n1335=steam_is_overlay_activated():\n1336=steam_get_persona_name():\n1337=steam_initialised():\n1338=steam_is_cloud_enabled_for_app():\n1339=steam_is_cloud_enabled_for_account():\n1340=steam_file_persisted(:string):\n1341=steam_get_quota_total():\n1342=steam_get_quota_free():\n1343=steam_file_write(:string, data, :number):\n1344=steam_file_write_file(:string, :string):\n1345=steam_file_read(filename):\n1346=steam_file_delete(filename)\n1347=steam_file_exists(filename):\n1348=steam_file_size(filename):\n1349=steam_file_share(filename)\n1350=steam_is_screenshot_requested():\n1351=steam_send_screenshot(filename,width,height)\n1352=steam_is_user_logged_on():\n1353=steam_get_user_steam_id():\n1354=steam_user_owns_dlc(_id):\n1355=steam_user_installed_dlc(_id):\n1356=steam_set_achievement(ach_name)\n1357=steam_get_achievement(ach_name):\n1358=steam_clear_achievement(ach_name)\n1359=steam_set_stat_int(stat_name,value)\n1360=steam_set_stat_float(stat_name,value)\n1361=steam_set_stat_avg_rate(stat_name,session_count,session_length)\n1362=steam_get_stat_int(stat_name):\n1363=steam_get_stat_float(stat_name):\n1364=steam_get_stat_avg_rate(stat_name):\n1365=steam_reset_all_stats()\n1366=steam_reset_all_stats_achievements()\n1367=steam_stats_ready():\n1368=steam_create_leaderboard(lb_name,sort_method,display_type):\n1369=steam_upload_score(:string, :number):\n1370=steam_upload_score_ext(:string, :number, :bool):\n1371=steam_download_scores_around_user(lb_name,range_start,range_end):\n1372=steam_download_scores(lb_name,start_idx,end_idx):\n1373=steam_download_friends_scores(lb_name):\n1374=steam_upload_score_buffer(lb_name, score, buffer_id):\n1375=steam_upload_score_buffer_ext(lb_name, score, buffer_id, forceupdate):\n1376=steam_current_game_language():\n1377=steam_available_languages():\n1378=steam_activate_overlay_browser(url)\n1379=steam_activate_overlay_user(dialog_name, steamid)\n1380=steam_activate_overlay_store(app_id)\n1381=steam_get_user_persona_name(steam_id):\n1382=steam_get_app_id():\n1383=steam_get_user_account_id():\n1384=steam_ugc_download(ugc_handle, dest_filename):\n1385=steam_ugc_create_item(consumer_app_id, file_type):\n1386=steam_ugc_start_item_update(consumer_app_id, published_file_id)\n1387=steam_ugc_set_item_title(ugc_update_handle, title)\n1388=steam_ugc_set_item_description(ugc_update_handle, description)\n1389=steam_ugc_set_item_visibility(ugc_update_handle, visibility)\n1390=steam_ugc_set_item_tags(ugc_update_handle, tag_array)\n1391=steam_ugc_set_item_content(ugc_update_handle, directory)\n1392=steam_ugc_set_item_preview(ugc_update_handle, image_path)\n1393=steam_ugc_submit_item_update(ugc_update_handle, change_note):\n1394=steam_ugc_get_item_update_progress(ugc_update_handle, info_map):\n1395=steam_ugc_subscribe_item(published_file_id):\n1396=steam_ugc_unsubscribe_item(published_file_id):\n1397=steam_ugc_num_subscribed_items():\n1398=steam_ugc_get_subscribed_items(item_list):\n1399=steam_ugc_get_item_install_info(published_file_id, info_map):\n1400=steam_ugc_get_item_update_info(published_file_id, info_map):\n1401=steam_ugc_request_item_details(published_file_id, max_age_seconds):\n1402=steam_ugc_create_query_user(list_type, match_type, sort_order, page):\n1403=steam_ugc_create_query_user_ex(list_type, match_type, sort_order, page, account_id, creator_app_id, consumer_app_id):\n1404=steam_ugc_create_query_all(query_type, match_type, page):\n1405=steam_ugc_create_query_all_ex(query_type, match_type, page, creator_app_id, consumer_app_id):\n1406=steam_ugc_query_set_cloud_filename_filter(ugc_query_handle , match_cloud_filename):\n1407=steam_ugc_query_set_match_any_tag(ugc_query_handle, match_any_tag)\n1408=steam_ugc_query_set_search_text(ugc_query_handle, search_text)\n1409=steam_ugc_query_set_ranked_by_trend_days(ugc_query_handle , days)\n1410=steam_ugc_query_add_required_tag(ugc_query_handle, tag_name)\n1411=steam_ugc_query_add_excluded_tag(ugc_query_handle, tag_name)\n1412=steam_ugc_query_set_return_long_description(ugc_query_handle, return_long_desc)\n1413=steam_ugc_query_set_return_total_only(ugc_query_handle, return_total_only)\n1414=steam_ugc_query_set_allow_cached_response(ugc_query_handle, max_age_seconds)\n1415=steam_ugc_send_query(ugc_query_handle)\n1416=shader_set(shader)\n1417=shader_get_name(shader):\n1418=shader_reset()\n1419=shader_current():\n1420=shader_is_compiled(shader):\n1421=shader_get_sampler_index(shader,uniform_name):\n1422=shader_get_uniform(shader,uniform_name):\n1423=shader_set_uniform_i(uniform_id,val,....)\n1424=shader_set_uniform_i_array(uniform_id,array)\n1425=shader_set_uniform_f(uniform_id,val,....)\n1426=shader_set_uniform_f_array(uniform_id,array)\n1427=shader_set_uniform_matrix(uniform_id)\n1428=shader_set_uniform_matrix_array(uniform_id,array)\n1429=shader_enable_corner_id(enable)\n1430=texture_set_stage(sampled_id, texture_id)\n1431=texture_get_texel_width(texture_id):\n1432=texture_get_texel_height(texture_id):\n1433=shaders_are_supported():\n1434=vertex_format_begin()\n1435=vertex_format_end():\n1436=vertex_format_delete(format_id)\n1437=vertex_format_add_position()\n1438=vertex_format_add_position_3d()\n1439=vertex_format_add_colour()£\n1440=vertex_format_add_color()$\n1441=vertex_format_add_normal()\n1442=vertex_format_add_texcoord()\n1443=vertex_format_add_custom(type,usage)\n1444=vertex_create_buffer():\n1445=vertex_create_buffer_ext(size):\n1446=vertex_delete_buffer(vbuff)\n1447=vertex_begin(vbuff,format)\n1448=vertex_end(vbuff)\n1449=vertex_position(vbuff,x,y)\n1450=vertex_position_3d(vbuff,x,y,z)\n1451=vertex_colour(vbuff,colour,alpha)£\n1452=vertex_color(vbuff,color,alpha)$\n1453=vertex_argb(vbuff,argb)\n1454=vertex_texcoord(vbuff,u,v)\n1455=vertex_normal(vbuff,nx,ny,nz)\n1456=vertex_float1(vbuff,f1)\n1457=vertex_float2(vbuff,f1,f2)\n1458=vertex_float3(vbuff,f1,f2,f3)\n1459=vertex_float4(vbuff,f1,f2,f3,f4)\n1460=vertex_ubyte4(vbuff,b1,b2,b3,b4)\n1461=vertex_submit(vbuff,prim,texture)\n1462=vertex_freeze(vbuff)\n1463=vertex_get_number(vbuff):\n1464=vertex_get_buffer_size(vbuff):\n1465=vertex_create_buffer_from_buffer(src_buffer,format):\n1466=vertex_create_buffer_from_buffer_ext(src_buffer,format,src_offset,num_vertices):\n1467=:skeleton_animation_set(anim_name)!\n1468=:skeleton_animation_get()!:\n1469=:skeleton_animation_mix(anim_from,anim_to,duration)!\n1470=:skeleton_animation_set_ext(anim_name, track)!\n1471=:skeleton_animation_get_ext(track)!:\n1472=:skeleton_animation_get_duration(anim_name)!:\n1473=:skeleton_animation_get_frames(anim_name)!:\n1474=:skeleton_animation_clear(track)!\n1475=:skeleton_skin_set(skin_name)!\n1476=:skeleton_skin_get()!:\n1477=:skeleton_attachment_set(slot, attachment)!\n1478=:skeleton_attachment_get(slot)!:\n1479=:skeleton_attachment_create(name,sprite,ind,xo,yo,xs,ys,rot)!:\n1480=skeleton_attachment_create_colour(name,sprite,ind,xo,yo,xs,ys,rot,col,alpha)!£:\n1481=skeleton_attachment_create_color(name,sprite,ind,xo,yo,xs,ys,rot,col,alpha)!$:\n1482=:skeleton_collision_draw_set(val)!\n1483=:skeleton_bone_data_get(bone, map)!:\n1484=:skeleton_bone_data_set(bone, map)!\n1485=:skeleton_bone_state_get(bone, map)!:\n1486=:skeleton_bone_state_set(bone, map)!\n1487=skeleton_slot_colour_set(slot,col,alpha)!£\n1488=skeleton_slot_color_set(slot,col,alpha)!$\n1489=skeleton_slot_colour_get(slot)!£:\n1490=skeleton_slot_color_get(slot)!$:\n1491=skeleton_slot_alpha_get(slot)!:\n1492=skeleton_find_slot(x,y,list)!:\n1493=:skeleton_get_minmax()!:\n1494=:skeleton_get_num_bounds()!:\n1495=:skeleton_get_bounds(index)!:\n1496=:skeleton_animation_get_frame(track)!:\n1497=:skeleton_animation_set_frame(track,index)!\n1498=draw_skeleton(sprite,animname,skinname,frame,x,y,xscale,yscale,rot,col,alpha)!\n1499=draw_skeleton_time(sprite, animname,skinname, time, x,y, xscale,yscale, rot, col,alpha)!\n1500=draw_skeleton_instance(instance, animname,skinname,frame,x,y,xscale,yscale,rot,col,alpha)!\n1501=draw_skeleton_collision(sprite,animname,frame,x,y,xscale,yscale,rot,col)!\n1502=draw_enable_skeleton_blendmodes(enable)!\n1503=draw_get_enable_skeleton_blendmodes()!:\n1504=skeleton_animation_list(sprite, list)!\n1505=skeleton_skin_list(sprite, list)!\n1506=skeleton_bone_list(sprite, list)!\n1507=skeleton_slot_list(sprite, list)!\n1508=skeleton_slot_data(sprite, list)!\n1509=skeleton_slot_data_instance(list)!\n1510=layer_get_id(layer_name):\n1511=layer_get_id_at_depth(depth):\n1512=layer_get_depth(layer_id):\n1513=layer_create(depth:number, ?name:string):\n1514=layer_destroy(layer_id)\n1515=layer_destroy_instances(layer_id)\n1516=layer_add_instance(layer_id,instance)\n1517=layer_has_instance(layer_id,instance)\n1518=layer_set_visible(layer_id,visible)\n1519=layer_get_visible(layer_id):\n1520=layer_exists(layer_id):\n1521=layer_x(layer_id,x)\n1522=layer_y(layer_id,y)\n1523=layer_get_x(layer_id):\n1524=layer_get_y(layer_id):\n1525=layer_hspeed(layer_id,speed)\n1526=layer_vspeed(layer_id,speed)\n1527=layer_get_hspeed(layer_id):\n1528=layer_get_vspeed(layer_id):\n1529=layer_script_begin(layer_id,script)\n1530=layer_script_end(layer_id,script)\n1531=layer_shader(layer_id,shader)\n1532=layer_get_script_begin(layer_id):\n1533=layer_get_script_end(layer_id):\n1534=layer_get_shader(layer_id):\n1535=layer_set_target_room(room)\n1536=layer_get_target_room():\n1537=layer_reset_target_room()\n1538=layer_get_all():\n1539=layer_get_all_elements(layer_id):\n1540=layer_get_name(layer_id):\n1541=layer_depth(layer_id, depth)\n1542=layer_get_element_layer(element_id):\n1543=layer_get_element_type(element_id):\n1544=layer_element_move(element_id,layer_id)\n1545=layer_force_draw_depth(force,depth)\n1546=layer_is_draw_depth_forced():\n1547=layer_get_forced_depth():\n1548=layer_background_get_id(layer_id):\n1549=layer_background_exists(layer_id,background_element_id):\n1550=layer_background_create(layer_id,sprite):\n1551=layer_background_destroy(background_element_id)\n1552=layer_background_visible(background_element_id,visible)\n1553=layer_background_change(background_element_id,sprite)\n1554=layer_background_sprite(background_element_id,sprite)\n1555=layer_background_htiled(background_element_id,tiled)\n1556=layer_background_vtiled(background_element_id,tiled)\n1557=layer_background_stretch(background_element_id,stretch)\n1558=layer_background_yscale(background_element_id,yscale)\n1559=layer_background_xscale(background_element_id,xscale)\n1560=layer_background_blend(background_element_id,col)\n1561=layer_background_alpha(background_element_id,alpha)\n1562=layer_background_index(background_element_id,image_index)\n1563=layer_background_speed(background_element_id,image_speed)\n1564=layer_background_get_visible(background_element_id):\n1565=layer_background_get_sprite(background_element_id):\n1566=layer_background_get_htiled(background_element_id):\n1567=layer_background_get_vtiled(background_element_id):\n1568=layer_background_get_stretch(background_element_id):\n1569=layer_background_get_yscale(background_element_id):\n1570=layer_background_get_xscale(background_element_id):\n1571=layer_background_get_blend(background_element_id):\n1572=layer_background_get_alpha(background_element_id):\n1573=layer_background_get_index(background_element_id):\n1574=layer_background_get_speed(background_element_id):\n1575=layer_sprite_get_id(layer_id,sprite_element_name):\n1576=layer_sprite_exists(layer_id,sprite_element_id):\n1577=layer_sprite_create(layer_id,x,y,sprite):\n1578=layer_sprite_destroy(sprite_element_id)\n1579=layer_sprite_change(sprite_element_id,sprite)\n1580=layer_sprite_index(sprite_element_id,image_index)\n1581=layer_sprite_speed(sprite_element_id,image_speed)\n1582=layer_sprite_xscale(sprite_element_id,scale)\n1583=layer_sprite_yscale(sprite_element_id,scale)\n1584=layer_sprite_angle(sprite_element_id,angle)\n1585=layer_sprite_blend(sprite_element_id,col)\n1586=layer_sprite_alpha(sprite_element_id,alpha)\n1587=layer_sprite_x(sprite_element_id,x)\n1588=layer_sprite_y(sprite_element_id,y)\n1589=layer_sprite_get_sprite(sprite_element_id):\n1590=layer_sprite_get_index(sprite_element_id):\n1591=layer_sprite_get_speed(sprite_element_id):\n1592=layer_sprite_get_xscale(sprite_element_id):\n1593=layer_sprite_get_yscale(sprite_element_id):\n1594=layer_sprite_get_angle(sprite_element_id):\n1595=layer_sprite_get_blend(sprite_element_id):\n1596=layer_sprite_get_alpha(sprite_element_id):\n1597=layer_sprite_get_x(sprite_element_id):\n1598=layer_sprite_get_y(sprite_element_id):\n1599=layer_tilemap_get_id(layer_id):\n1600=layer_tilemap_exists(layer_id,tilemap_element_id):\n1601=layer_tilemap_create(layer_id,x,y,tileset,width,height):\n1602=layer_tilemap_destroy(tilemap_element_id)\n1603=tilemap_tileset(tilemap_element_id,tileset)\n1604=tilemap_x(tilemap_element_id,x)\n1605=tilemap_y(tilemap_element_id,y)\n1606=tilemap_set(tilemap_element_id,tiledata,cell_x,cell_y)\n1607=tilemap_set_at_pixel(tilemap_element_id,tiledata,x,y)\n1608=tileset_get_texture(tilemap_element_id):\n1609=tileset_get_uvs(tilemap_element_id):\n1610=tileset_get_name(tilemap_element_id):\n1611=tilemap_get_tileset(tilemap_element_id):\n1612=tilemap_get_tile_width(tilemap_element_id):\n1613=tilemap_get_tile_height(tilemap_element_id):\n1614=tilemap_get_width(tilemap_element_id):\n1615=tilemap_get_height(tilemap_element_id):\n1616=tilemap_set_width(tilemap_element_id, width)\n1617=tilemap_set_height(tilemap_element_id, height)\n1618=tilemap_get_x(tilemap_element_id):\n1619=tilemap_get_y(tilemap_element_id):\n1620=tilemap_get(tilemap_element_id,cell_x,cell_y):\n1621=tilemap_get_at_pixel(tilemap_element_id,x,y):\n1622=tilemap_get_cell_x_at_pixel(tilemap_element_id,x,y):\n1623=tilemap_get_cell_y_at_pixel(tilemap_element_id,x,y):\n1624=tilemap_clear(tilemap_element_id,tiledata)\n1625=draw_tilemap(tilemap_element_id,x,y)\n1626=draw_tile(tileset,tiledata,frame,x,y)\n1627=tilemap_set_global_mask(mask)\n1628=tilemap_get_global_mask():\n1629=tilemap_set_mask(tilemap_element_id, mask)\n1630=tilemap_get_mask(tilemap_element_id):\n1631=tilemap_get_frame(tilemap_element_id):\n1632=tile_set_empty(tiledata)\n1633=tile_set_index(tiledata,tileindex)\n1634=tile_set_flip(tiledata,flip)\n1635=tile_set_mirror(tiledata,mirror)\n1636=tile_set_rotate(tiledata,rotate)\n1637=tile_get_empty(tiledata):\n1638=tile_get_index(tiledata):\n1639=tile_get_flip(tiledata):\n1640=tile_get_mirror(tiledata):\n1641=tile_get_rotate(tiledata):\n1642=layer_tile_exists(layer_id,tile_element_id,...):\n1643=layer_tile_create(layer_id,x,y,tileset,left,top,width,height):\n1644=layer_tile_destroy(tile_element_id)\n1645=layer_tile_change(tile_element_id,sprite)\n1646=layer_tile_xscale(tile_element_id,scale)\n1647=layer_tile_yscale(tile_element_id,scale)\n1648=layer_tile_blend(tile_element_id,col)\n1649=layer_tile_alpha(tile_element_id,alpha)\n1650=layer_tile_x(tile_element_id,x)\n1651=layer_tile_y(tile_element_id,y)\n1652=layer_tile_region(tile_element_id,left,top,width,height)\n1653=layer_tile_visible(tile_element_id,visible)\n1654=layer_tile_get_sprite(tile_element_id):\n1655=layer_tile_get_xscale(tile_element_id):\n1656=layer_tile_get_yscale(tile_element_id):\n1657=layer_tile_get_blend(tile_element_id):\n1658=layer_tile_get_alpha(tile_element_id):\n1659=layer_tile_get_x(tile_element_id):\n1660=layer_tile_get_y(tile_element_id):\n1661=layer_tile_get_region(tile_element_id):\n1662=layer_tile_get_visible(tile_element_id):\n1663=layer_instance_get_instance(instance_element_id):\n1664=instance_activate_layer(layer_id)\n1665=instance_deactivate_layer(layer_id)\n1666=camera_create():\n1667=camera_create_view(room_x,room_y,width,height,[angle,object,x_speed,y_speed,x_border,y_border]):\n1668=camera_destroy(camera)\n1669=camera_apply(camera)\n1670=camera_get_active():\n1671=camera_get_default():\n1672=camera_set_default(camera)\n1673=camera_set_view_mat(camera,matrix)\n1674=camera_set_proj_mat(camera,matrix)\n1675=camera_set_update_script(camera,script)\n1676=camera_set_begin_script(camera,script)\n1677=camera_set_end_script(camera,script)\n1678=camera_set_view_pos(camera,x,y)\n1679=camera_set_view_size(camera,width,height)\n1680=camera_set_view_speed(camera,x_speed,y_speed)\n1681=camera_set_view_border(camera,x_border,y_border)\n1682=camera_set_view_angle(camera,angle)\n1683=camera_set_view_target(camera,object)\n1684=camera_get_view_mat(camera):\n1685=camera_get_proj_mat(camera):\n1686=camera_get_update_script(camera):\n1687=camera_get_begin_script(camera):\n1688=camera_get_end_script(camera):\n1689=camera_get_view_x(camera):\n1690=camera_get_view_y(camera):\n1691=camera_get_view_width(camera):\n1692=camera_get_view_height(camera):\n1693=camera_get_view_speed_x(camera):\n1694=camera_get_view_speed_y(camera):\n1695=camera_get_view_border_x(camera):\n1696=camera_get_view_border_y(camera):\n1697=camera_get_view_angle(camera):\n1698=camera_get_view_target(camera):\n1699=view_get_camera(view):\n1700=view_get_visible(view):\n1701=view_get_xport(view):\n1702=view_get_yport(view):\n1703=view_get_wport(view):\n1704=view_get_hport(view):\n1705=view_get_surface_id(view):\n1706=view_set_camera(view,camera)\n1707=view_set_visible(view,visible)\n1708=view_set_xport(view,xport)\n1709=view_set_yport(view,yport)\n1710=view_set_wport(view,wport)\n1711=view_set_hport(view,hport)\n1712=view_set_surface_id(view,surface_id)\n1713=gesture_drag_time(time)\n1714=gesture_drag_distance(distance)\n1715=gesture_flick_speed(speed)\n1716=gesture_double_tap_time(time)\n1717=gesture_double_tap_distance(distance)\n1718=gesture_pinch_distance(distance)\n1719=gesture_pinch_angle_towards(angle)\n1720=gesture_pinch_angle_away(angle)\n1721=gesture_rotate_time(time)\n1722=gesture_rotate_angle(angle)\n1723=gesture_tap_count(enable)\n1724=gesture_get_drag_time():\n1725=gesture_get_drag_distance():\n1726=gesture_get_flick_speed():\n1727=gesture_get_double_tap_time():\n1728=gesture_get_double_tap_distance():\n1729=gesture_get_pinch_distance():\n1730=gesture_get_pinch_angle_towards():\n1731=gesture_get_pinch_angle_away():\n1732=gesture_get_rotate_time():\n1733=gesture_get_rotate_angle():\n1734=gesture_get_tap_count():\n1735=keyboard_virtual_show(virtual_keyboard_type, virtual_return_key_type, auto_capitalization_type, predictive_text_enabled)\n1736=keyboard_virtual_hide()\n1737=keyboard_virtual_status()\n1738=keyboard_virtual_height()\n1739=extension_get_string(ext_name, option_name):\n1740=variable_instance_names_count(id)";
l_gmlVars="1741=room_speed\n1742=fps*\n1743=fps_real*\n1744=current_time*\n1745=current_year*\n1746=current_month*\n1747=current_day*\n1748=current_weekday*\n1749=current_hour*\n1750=current_minute*\n1751=current_second*\n1752=room*\n1753=room_first*\n1754=room_last*\n1755=room_width*\n1756=room_height*\n1757=room_persistent\n1758=score\n1759=lives\n1760=health\n1761=event_type*\n1762=event_number*\n1763=event_object*\n1764=event_action*\n1765=application_surface*\n1766=debug_mode*\n1767=font_texture_page_size\n1768=keyboard_key\n1769=keyboard_lastkey\n1770=keyboard_lastchar\n1771=keyboard_string\n1772=mouse_x*\n1773=mouse_y*\n1774=mouse_button\n1775=mouse_lastbutton\n1776=cursor_sprite\n1777=background_colour£\n1778=background_showcolour£\n1779=background_color$\n1780=background_showcolor$\n1781=view_enabled\n1782=view_current*\n1783=view_visible[]\n1784=view_xport[]\n1785=view_yport[]\n1786=view_wport[]\n1787=view_hport[]\n1788=view_surface_id[]\n1789=view_camera[]\n1790=game_id*\n1791=game_display_name*\n1792=game_project_name*\n1793=game_save_id*\n1794=working_directory*\n1795=temp_directory*\n1796=program_directory*\n1797=browser_width*\n1798=browser_height*\n1799=os_type*\n1800=os_device*\n1801=os_browser*\n1802=os_version*\n1803=display_aa*\n1804=async_load*\n1805=delta_time*\n1806=webgl_enabled*\n1807=event_data*";
var l_lines=file_text_open_from_string(l_gmlFuncs);
while(!file_text_eof(l_lines)){
	var l_line=file_text_read_string(l_lines);
	file_text_readln(l_lines);
	var l_sep=string_pos("=",l_line);
	gml_func_add(string_delete(l_line,1,l_sep),live_script_get_index("__lnc__f"+string_copy(l_line,1,l_sep-1)));
}
file_text_close(l_lines);
l_lines=file_text_open_from_string(l_gmlVars);
while(!file_text_eof(l_lines)){
	var l_line1=file_text_read_string(l_lines);
	file_text_readln(l_lines);
	var l_sep1=string_pos("=",l_line1);
	gml_var_add(string_delete(l_line1,1,l_sep1),live_script_get_index("__lnc__f"+string_copy(l_line1,1,l_sep1-1)));
}
file_text_close(l_lines);
__lnc_const_decl();

#define __lnc__std_Std_string
var l_value=argument[0];
if (live_enabled) {
	if(l_value==undefined)return "null";
	if(is_string(l_value))return l_value;
	if(is_real(l_value)){
		var l_s=string_format(l_value,0,16);
		var l_n,l_i;
		if(os_browser!=-1){
			l_n=string_length(l_s);
			l_i=l_n;
			while(l_i>0){
				switch(string_ord_at(l_s,l_i)){
					case 48:
						--l_i;
						continue;
					case 46:--l_i;break;
				}
				break;
			}
		} else {
			l_n=string_byte_length(l_s);
			l_i=l_n;
			while(l_i>0){
				switch(string_byte_at(l_s,l_i)){
					case 48:
						--l_i;
						continue;
					case 46:--l_i;break;
				}
				break;
			}
		}
		return string_copy(l_s,1,l_i);
	}
	return string(l_value);
} else return undefined;

#define __lnc__lf
if (live_enabled) {
	var l_n=argument_count;
	if(l_n==0)return 0;
	var l_r=argument[0];
	for(var l_i=1;l_i<l_n;++l_i){
		var l_v=argument[l_i];
		if(l_v<l_r)l_r=l_v;
	}
	return l_r;
} else return 0;

#define __lnc__lf1
if (live_enabled) {
	var l_n1=argument_count;
	if(l_n1==0)return 0;
	var l_r1=argument[0];
	for(var l_i1=1;l_i1<l_n1;++l_i1){
		var l_v1=argument[l_i1];
		if(l_v1>l_r1)l_r1=l_v1;
	}
	return l_r1;
} else return 0;

#define __lnc__lf2
if (live_enabled) {
	return argument[irandom(argument_count-1)];
} else return undefined;

#define __lnc__lf3
if (live_enabled) {
	switch(argument_count){
		case 0:return gml_thread_error("Too few arguments for script_execute.");
		case 1:return script_execute(argument[0]);
		case 2:return script_execute(argument[0],argument[1]);
		case 3:return script_execute(argument[0],argument[1],argument[2]);
		case 4:return script_execute(argument[0],argument[1],argument[2],argument[3]);
		case 5:return script_execute(argument[0],argument[1],argument[2],argument[3],argument[4]);
		case 6:return script_execute(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
		case 7:return script_execute(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
		case 8:return script_execute(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
		case 9:return script_execute(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
		case 10:return script_execute(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);
		case 11:return script_execute(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);
		case 12:return script_execute(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);
		case 13:return script_execute(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);
		case 14:return script_execute(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);
		case 15:return script_execute(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);
		default:return gml_thread_error("Too many arguments for script_execute.");
	}
} else return undefined;

#define __lnc__lf4
if (live_enabled) {
	switch(argument_count){
		case 0:instance_destroy();break;
		case 1:instance_destroy(argument[0]);break;
		case 2:instance_destroy(argument[0],argument[1]);break;
		default:gml_thread_error("Too many arguments for instance_destroy.");
	}
}

#define __lnc__lf5
if (live_enabled) {
	var l_setting=argument[0];
}

#define __lnc__f0
if (live_enabled) {
	return is_real(argument[0]);
} else return undefined;

#define __lnc__f1
if (live_enabled) {
	return is_string(argument[0]);
} else return undefined;

#define __lnc__f2
if (live_enabled) {
	return is_array(argument[0]);
} else return undefined;

#define __lnc__f3
if (live_enabled) {
	return is_undefined(argument[0]);
} else return undefined;

#define __lnc__f4
if (live_enabled) {
	return is_int32(argument[0]);
} else return undefined;

#define __lnc__f5
if (live_enabled) {
	return is_int64(argument[0]);
} else return undefined;

#define __lnc__f6
if (live_enabled) {
	return is_ptr(argument[0]);
} else return undefined;

#define __lnc__f7
if (live_enabled) {
	return is_vec3(argument[0]);
} else return undefined;

#define __lnc__f8
if (live_enabled) {
	return is_vec4(argument[0]);
} else return undefined;

#define __lnc__f9
if (live_enabled) {
	return is_matrix(argument[0]);
} else return undefined;

#define __lnc__f10
if (live_enabled) {
	return is_bool(argument[0]);
} else return undefined;

#define __lnc__f11
if (live_enabled) {
	is_nan(argument[0]);
}

#define __lnc__f12
if (live_enabled) {
	is_infinity(argument[0]);
}

#define __lnc__f13
if (live_enabled) {
	return typeof(argument[0]);
} else return undefined;

#define __lnc__f14
if (live_enabled) {
	return variable_global_exists(argument[0]);
} else return undefined;

#define __lnc__f15
if (live_enabled) {
	return variable_global_get(argument[0]);
} else return undefined;

#define __lnc__f16
if (live_enabled) {
	variable_global_set(argument[0],argument[1]);
}

#define __lnc__f17
if (live_enabled) {
	return variable_instance_exists(argument[0],argument[1]);
} else return undefined;

#define __lnc__f18
if (live_enabled) {
	return variable_instance_get(argument[0],argument[1]);
} else return undefined;

#define __lnc__f19
if (live_enabled) {
	variable_instance_set(argument[0],argument[1],argument[2]);
}

#define __lnc__f20
if (live_enabled) {
	return variable_instance_get_names(argument[0]);
} else return undefined;

#define __lnc__f21
if (live_enabled) {
	return array_length_1d(argument[0]);
} else return undefined;

#define __lnc__f22
if (live_enabled) {
	return array_length_2d(argument[0],argument[1]);
} else return undefined;

#define __lnc__f23
if (live_enabled) {
	return array_height_2d(argument[0]);
} else return undefined;

#define __lnc__f24
if (live_enabled) {
	return array_equals(argument[0],argument[1]);
} else return undefined;

#define __lnc__f25
if (live_enabled) {
	if(argument_count<1){
		return gml_thread_error("array_create needs at least 1 arguments, got "+string(argument_count));
	} else switch(argument_count){
		case 1:return array_create(argument[0]);
		case 2:return array_create(argument[0],argument[1]);
		default:return gml_thread_error("array_create takes at most 2 arguments, got "+string(argument_count));
	}
} else return undefined;

#define __lnc__f26
if (live_enabled) {
	array_copy(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f27
if (live_enabled) {
	return array_get(argument[0],argument[1]);
} else return undefined;

#define __lnc__f28
if (live_enabled) {
	array_set(argument[0],argument[1],argument[2]);
}

#define __lnc__f29
if (live_enabled) {
	return random(argument[0]);
} else return undefined;

#define __lnc__f30
if (live_enabled) {
	return random_range(argument[0],argument[1]);
} else return undefined;

#define __lnc__f31
if (live_enabled) {
	return irandom(argument[0]);
} else return undefined;

#define __lnc__f32
if (live_enabled) {
	return irandom_range(argument[0],argument[1]);
} else return undefined;

#define __lnc__f33
if (live_enabled) {
	random_set_seed(argument[0]);
}

#define __lnc__f34
if (live_enabled) {
	return random_get_seed();
} else return undefined;

#define __lnc__f35
if (live_enabled) {
	return randomize();
} else return undefined;

#define __lnc__f36
if (live_enabled) {
	randomise();
}

#define __lnc__f37
if (live_enabled) {
	return abs(argument[0]);
} else return undefined;

#define __lnc__f38
if (live_enabled) {
	return round(argument[0]);
} else return undefined;

#define __lnc__f39
if (live_enabled) {
	return floor(argument[0]);
} else return undefined;

#define __lnc__f40
if (live_enabled) {
	return ceil(argument[0]);
} else return undefined;

#define __lnc__f41
if (live_enabled) {
	return sign(argument[0]);
} else return undefined;

#define __lnc__f42
if (live_enabled) {
	return frac(argument[0]);
} else return undefined;

#define __lnc__f43
if (live_enabled) {
	return sqrt(argument[0]);
} else return undefined;

#define __lnc__f44
if (live_enabled) {
	return sqr(argument[0]);
} else return undefined;

#define __lnc__f45
if (live_enabled) {
	return exp(argument[0]);
} else return undefined;

#define __lnc__f46
if (live_enabled) {
	return ln(argument[0]);
} else return undefined;

#define __lnc__f47
if (live_enabled) {
	return log2(argument[0]);
} else return undefined;

#define __lnc__f48
if (live_enabled) {
	return log10(argument[0]);
} else return undefined;

#define __lnc__f49
if (live_enabled) {
	return sin(argument[0]);
} else return undefined;

#define __lnc__f50
if (live_enabled) {
	return cos(argument[0]);
} else return undefined;

#define __lnc__f51
if (live_enabled) {
	return tan(argument[0]);
} else return undefined;

#define __lnc__f52
if (live_enabled) {
	return arcsin(argument[0]);
} else return undefined;

#define __lnc__f53
if (live_enabled) {
	return arccos(argument[0]);
} else return undefined;

#define __lnc__f54
if (live_enabled) {
	return arctan(argument[0]);
} else return undefined;

#define __lnc__f55
if (live_enabled) {
	return arctan2(argument[0],argument[1]);
} else return undefined;

#define __lnc__f56
if (live_enabled) {
	return dsin(argument[0]);
} else return undefined;

#define __lnc__f57
if (live_enabled) {
	return dcos(argument[0]);
} else return undefined;

#define __lnc__f58
if (live_enabled) {
	return dtan(argument[0]);
} else return undefined;

#define __lnc__f59
if (live_enabled) {
	return darcsin(argument[0]);
} else return undefined;

#define __lnc__f60
if (live_enabled) {
	return darccos(argument[0]);
} else return undefined;

#define __lnc__f61
if (live_enabled) {
	return darctan(argument[0]);
} else return undefined;

#define __lnc__f62
if (live_enabled) {
	return darctan2(argument[0],argument[1]);
} else return undefined;

#define __lnc__f63
if (live_enabled) {
	return degtorad(argument[0]);
} else return undefined;

#define __lnc__f64
if (live_enabled) {
	return radtodeg(argument[0]);
} else return undefined;

#define __lnc__f65
if (live_enabled) {
	return power(argument[0],argument[1]);
} else return undefined;

#define __lnc__f66
if (live_enabled) {
	return logn(argument[0],argument[1]);
} else return undefined;

#define __lnc__f67
if (live_enabled) {
	switch(argument_count){
		case 0:return mean();
		case 1:return mean(argument[0]);
		case 2:return mean(argument[0],argument[1]);
		case 3:return mean(argument[0],argument[1],argument[2]);
		case 4:return mean(argument[0],argument[1],argument[2],argument[3]);
		case 5:return mean(argument[0],argument[1],argument[2],argument[3],argument[4]);
		case 6:return mean(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
		case 7:return mean(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
		case 8:return mean(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
		case 9:return mean(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
		case 10:return mean(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);
		case 11:return mean(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);
		case 12:return mean(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);
		case 13:return mean(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);
		case 14:return mean(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);
		case 15:return mean(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);
		default:return gml_thread_error("mean takes at most 16 arguments, got "+string(argument_count));
	}
} else return undefined;

#define __lnc__f68
if (live_enabled) {
	switch(argument_count){
		case 0:return median();
		case 1:return median(argument[0]);
		case 2:return median(argument[0],argument[1]);
		case 3:return median(argument[0],argument[1],argument[2]);
		case 4:return median(argument[0],argument[1],argument[2],argument[3]);
		case 5:return median(argument[0],argument[1],argument[2],argument[3],argument[4]);
		case 6:return median(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
		case 7:return median(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
		case 8:return median(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
		case 9:return median(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
		case 10:return median(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);
		case 11:return median(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);
		case 12:return median(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);
		case 13:return median(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);
		case 14:return median(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);
		case 15:return median(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);
		default:return gml_thread_error("median takes at most 16 arguments, got "+string(argument_count));
	}
} else return undefined;

#define __lnc__f69
if (live_enabled) {
	return clamp(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f70
if (live_enabled) {
	return lerp(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f71
if (live_enabled) {
	return dot_product(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f72
if (live_enabled) {
	return dot_product_3d(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f73
if (live_enabled) {
	return dot_product_normalised(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f74
if (live_enabled) {
	return dot_product_3d_normalised(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f75
if (live_enabled) {
	return dot_product_normalized(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f76
if (live_enabled) {
	return dot_product_3d_normalized(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f77
if (live_enabled) {
	math_set_epsilon(argument[0]);
}

#define __lnc__f78
if (live_enabled) {
	return math_get_epsilon();
} else return undefined;

#define __lnc__f79
if (live_enabled) {
	return angle_difference(argument[0],argument[1]);
} else return undefined;

#define __lnc__f80
if (live_enabled) {
	return point_distance_3d(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f81
if (live_enabled) {
	return point_distance(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f82
if (live_enabled) {
	return point_direction(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f83
if (live_enabled) {
	return lengthdir_x(argument[0],argument[1]);
} else return undefined;

#define __lnc__f84
if (live_enabled) {
	return lengthdir_y(argument[0],argument[1]);
} else return undefined;

#define __lnc__f85
if (live_enabled) {
	return real(argument[0]);
} else return undefined;

#define __lnc__f86
if (live_enabled) {
	bool(argument[0]);
}

#define __lnc__f87
if (live_enabled) {
	return string(argument[0]);
} else return undefined;

#define __lnc__f88
if (live_enabled) {
	return int64(argument[0]);
} else return undefined;

#define __lnc__f89
if (live_enabled) {
	return ptr(argument[0]);
} else return undefined;

#define __lnc__f90
if (live_enabled) {
	return string_format(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f91
if (live_enabled) {
	return chr(argument[0]);
} else return undefined;

#define __lnc__f92
if (live_enabled) {
	return ansi_char(argument[0]);
} else return undefined;

#define __lnc__f93
if (live_enabled) {
	return ord(argument[0]);
} else return undefined;

#define __lnc__f94
if (live_enabled) {
	return string_length(argument[0]);
} else return undefined;

#define __lnc__f95
if (live_enabled) {
	return string_byte_length(argument[0]);
} else return undefined;

#define __lnc__f96
if (live_enabled) {
	return string_pos(argument[0],argument[1]);
} else return undefined;

#define __lnc__f97
if (live_enabled) {
	return string_copy(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f98
if (live_enabled) {
	return string_char_at(argument[0],argument[1]);
} else return undefined;

#define __lnc__f99
if (live_enabled) {
	return string_ord_at(argument[0],argument[1]);
} else return undefined;

#define __lnc__f100
if (live_enabled) {
	return string_byte_at(argument[0],argument[1]);
} else return undefined;

#define __lnc__f101
if (live_enabled) {
	return string_set_byte_at(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f102
if (live_enabled) {
	return string_delete(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f103
if (live_enabled) {
	return string_insert(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f104
if (live_enabled) {
	return string_lower(argument[0]);
} else return undefined;

#define __lnc__f105
if (live_enabled) {
	return string_upper(argument[0]);
} else return undefined;

#define __lnc__f106
if (live_enabled) {
	return string_repeat(argument[0],argument[1]);
} else return undefined;

#define __lnc__f107
if (live_enabled) {
	return string_letters(argument[0]);
} else return undefined;

#define __lnc__f108
if (live_enabled) {
	return string_digits(argument[0]);
} else return undefined;

#define __lnc__f109
if (live_enabled) {
	return string_lettersdigits(argument[0]);
} else return undefined;

#define __lnc__f110
if (live_enabled) {
	return string_replace(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f111
if (live_enabled) {
	return string_replace_all(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f112
if (live_enabled) {
	return string_count(argument[0],argument[1]);
} else return undefined;

#define __lnc__f113
if (live_enabled) {
	return string_hash_to_newline(argument[0]);
} else return undefined;

#define __lnc__f114
if (live_enabled) {
	return clipboard_has_text();
} else return undefined;

#define __lnc__f115
if (live_enabled) {
	clipboard_set_text(argument[0]);
}

#define __lnc__f116
if (live_enabled) {
	return clipboard_get_text();
} else return undefined;

#define __lnc__f117
if (live_enabled) {
	return date_current_datetime();
} else return undefined;

#define __lnc__f118
if (live_enabled) {
	return date_create_datetime(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f119
if (live_enabled) {
	return date_valid_datetime(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f120
if (live_enabled) {
	return date_inc_year(argument[0],argument[1]);
} else return undefined;

#define __lnc__f121
if (live_enabled) {
	return date_inc_month(argument[0],argument[1]);
} else return undefined;

#define __lnc__f122
if (live_enabled) {
	return date_inc_week(argument[0],argument[1]);
} else return undefined;

#define __lnc__f123
if (live_enabled) {
	return date_inc_day(argument[0],argument[1]);
} else return undefined;

#define __lnc__f124
if (live_enabled) {
	return date_inc_hour(argument[0],argument[1]);
} else return undefined;

#define __lnc__f125
if (live_enabled) {
	return date_inc_minute(argument[0],argument[1]);
} else return undefined;

#define __lnc__f126
if (live_enabled) {
	return date_inc_second(argument[0],argument[1]);
} else return undefined;

#define __lnc__f127
if (live_enabled) {
	return date_get_year(argument[0]);
} else return undefined;

#define __lnc__f128
if (live_enabled) {
	return date_get_month(argument[0]);
} else return undefined;

#define __lnc__f129
if (live_enabled) {
	return date_get_week(argument[0]);
} else return undefined;

#define __lnc__f130
if (live_enabled) {
	return date_get_day(argument[0]);
} else return undefined;

#define __lnc__f131
if (live_enabled) {
	return date_get_hour(argument[0]);
} else return undefined;

#define __lnc__f132
if (live_enabled) {
	return date_get_minute(argument[0]);
} else return undefined;

#define __lnc__f133
if (live_enabled) {
	return date_get_second(argument[0]);
} else return undefined;

#define __lnc__f134
if (live_enabled) {
	return date_get_weekday(argument[0]);
} else return undefined;

#define __lnc__f135
if (live_enabled) {
	return date_get_day_of_year(argument[0]);
} else return undefined;

#define __lnc__f136
if (live_enabled) {
	return date_get_hour_of_year(argument[0]);
} else return undefined;

#define __lnc__f137
if (live_enabled) {
	return date_get_minute_of_year(argument[0]);
} else return undefined;

#define __lnc__f138
if (live_enabled) {
	return date_get_second_of_year(argument[0]);
} else return undefined;

#define __lnc__f139
if (live_enabled) {
	return date_year_span(argument[0],argument[1]);
} else return undefined;

#define __lnc__f140
if (live_enabled) {
	return date_month_span(argument[0],argument[1]);
} else return undefined;

#define __lnc__f141
if (live_enabled) {
	return date_week_span(argument[0],argument[1]);
} else return undefined;

#define __lnc__f142
if (live_enabled) {
	return date_day_span(argument[0],argument[1]);
} else return undefined;

#define __lnc__f143
if (live_enabled) {
	return date_hour_span(argument[0],argument[1]);
} else return undefined;

#define __lnc__f144
if (live_enabled) {
	return date_minute_span(argument[0],argument[1]);
} else return undefined;

#define __lnc__f145
if (live_enabled) {
	return date_second_span(argument[0],argument[1]);
} else return undefined;

#define __lnc__f146
if (live_enabled) {
	return date_compare_datetime(argument[0],argument[1]);
} else return undefined;

#define __lnc__f147
if (live_enabled) {
	return date_compare_date(argument[0],argument[1]);
} else return undefined;

#define __lnc__f148
if (live_enabled) {
	return date_compare_time(argument[0],argument[1]);
} else return undefined;

#define __lnc__f149
if (live_enabled) {
	return date_date_of(argument[0]);
} else return undefined;

#define __lnc__f150
if (live_enabled) {
	return date_time_of(argument[0]);
} else return undefined;

#define __lnc__f151
if (live_enabled) {
	return date_datetime_string(argument[0]);
} else return undefined;

#define __lnc__f152
if (live_enabled) {
	return date_date_string(argument[0]);
} else return undefined;

#define __lnc__f153
if (live_enabled) {
	return date_time_string(argument[0]);
} else return undefined;

#define __lnc__f154
if (live_enabled) {
	return date_days_in_month(argument[0]);
} else return undefined;

#define __lnc__f155
if (live_enabled) {
	return date_days_in_year(argument[0]);
} else return undefined;

#define __lnc__f156
if (live_enabled) {
	return date_leap_year(argument[0]);
} else return undefined;

#define __lnc__f157
if (live_enabled) {
	return date_is_today(argument[0]);
} else return undefined;

#define __lnc__f158
if (live_enabled) {
	date_set_timezone(argument[0]);
}

#define __lnc__f159
if (live_enabled) {
	return date_get_timezone();
} else return undefined;

#define __lnc__f160
if (live_enabled) {
	game_set_speed(argument[0],argument[1]);
}

#define __lnc__f161
if (live_enabled) {
	return game_get_speed(argument[0]);
} else return undefined;

#define __lnc__f162
if (live_enabled) {
	motion_set(argument[0],argument[1]);
}

#define __lnc__f163
if (live_enabled) {
	motion_add(argument[0],argument[1]);
}

#define __lnc__f164
if (live_enabled) {
	return place_free(argument[0],argument[1]);
} else return undefined;

#define __lnc__f165
if (live_enabled) {
	return place_empty(argument[0],argument[1]);
} else return undefined;

#define __lnc__f166
if (live_enabled) {
	return place_meeting(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f167
if (live_enabled) {
	return place_snapped(argument[0],argument[1]);
} else return undefined;

#define __lnc__f168
if (live_enabled) {
	move_random(argument[0],argument[1]);
}

#define __lnc__f169
if (live_enabled) {
	move_snap(argument[0],argument[1]);
}

#define __lnc__f170
if (live_enabled) {
	move_towards_point(argument[0],argument[1],argument[2]);
}

#define __lnc__f171
if (live_enabled) {
	move_contact_solid(argument[0],argument[1]);
}

#define __lnc__f172
if (live_enabled) {
	move_contact_all(argument[0],argument[1]);
}

#define __lnc__f173
if (live_enabled) {
	move_outside_solid(argument[0],argument[1]);
}

#define __lnc__f174
if (live_enabled) {
	move_outside_all(argument[0],argument[1]);
}

#define __lnc__f175
if (live_enabled) {
	move_bounce_solid(argument[0]);
}

#define __lnc__f176
if (live_enabled) {
	move_bounce_all(argument[0]);
}

#define __lnc__f177
if (live_enabled) {
	move_wrap(argument[0],argument[1],argument[2]);
}

#define __lnc__f178
if (live_enabled) {
	return distance_to_point(argument[0],argument[1]);
} else return undefined;

#define __lnc__f179
if (live_enabled) {
	return distance_to_object(argument[0]);
} else return undefined;

#define __lnc__f180
if (live_enabled) {
	return position_empty(argument[0],argument[1]);
} else return undefined;

#define __lnc__f181
if (live_enabled) {
	return position_meeting(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f182
if (live_enabled) {
	path_start(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f183
if (live_enabled) {
	path_end();
}

#define __lnc__f184
if (live_enabled) {
	return mp_linear_step(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f185
if (live_enabled) {
	return mp_potential_step(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f186
if (live_enabled) {
	return mp_linear_step_object(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f187
if (live_enabled) {
	return mp_potential_step_object(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f188
if (live_enabled) {
	mp_potential_settings(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f189
if (live_enabled) {
	return mp_linear_path(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f190
if (live_enabled) {
	return mp_potential_path(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f191
if (live_enabled) {
	return mp_linear_path_object(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f192
if (live_enabled) {
	return mp_potential_path_object(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f193
if (live_enabled) {
	return mp_grid_create(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f194
if (live_enabled) {
	mp_grid_destroy(argument[0]);
}

#define __lnc__f195
if (live_enabled) {
	mp_grid_clear_all(argument[0]);
}

#define __lnc__f196
if (live_enabled) {
	mp_grid_clear_cell(argument[0],argument[1],argument[2]);
}

#define __lnc__f197
if (live_enabled) {
	mp_grid_clear_rectangle(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f198
if (live_enabled) {
	mp_grid_add_cell(argument[0],argument[1],argument[2]);
}

#define __lnc__f199
if (live_enabled) {
	return mp_grid_get_cell(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f200
if (live_enabled) {
	mp_grid_add_rectangle(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f201
if (live_enabled) {
	mp_grid_add_instances(argument[0],argument[1],argument[2]);
}

#define __lnc__f202
if (live_enabled) {
	return mp_grid_path(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
} else return undefined;

#define __lnc__f203
if (live_enabled) {
	mp_grid_draw(argument[0]);
}

#define __lnc__f204
if (live_enabled) {
	mp_grid_to_ds_grid(argument[0],argument[1]);
}

#define __lnc__f205
if (live_enabled) {
	return collision_point(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f206
if (live_enabled) {
	return collision_rectangle(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
} else return undefined;

#define __lnc__f207
if (live_enabled) {
	return collision_circle(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f208
if (live_enabled) {
	return collision_ellipse(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
} else return undefined;

#define __lnc__f209
if (live_enabled) {
	return collision_line(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
} else return undefined;

#define __lnc__f210
if (live_enabled) {
	return collision_point_list(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
} else return undefined;

#define __lnc__f211
if (live_enabled) {
	return collision_rectangle_list(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
} else return undefined;

#define __lnc__f212
if (live_enabled) {
	return collision_circle_list(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
} else return undefined;

#define __lnc__f213
if (live_enabled) {
	return collision_ellipse_list(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
} else return undefined;

#define __lnc__f214
if (live_enabled) {
	return collision_line_list(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
} else return undefined;

#define __lnc__f215
if (live_enabled) {
	instance_position_list(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f216
if (live_enabled) {
	instance_place_list(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f217
if (live_enabled) {
	return point_in_rectangle(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f218
if (live_enabled) {
	return point_in_triangle(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
} else return undefined;

#define __lnc__f219
if (live_enabled) {
	return point_in_circle(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f220
if (live_enabled) {
	return rectangle_in_rectangle(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
} else return undefined;

#define __lnc__f221
if (live_enabled) {
	return rectangle_in_triangle(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);
} else return undefined;

#define __lnc__f222
if (live_enabled) {
	return rectangle_in_circle(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
} else return undefined;

#define __lnc__f223
if (live_enabled) {
	return instance_find(argument[0],argument[1]);
} else return undefined;

#define __lnc__f224
if (live_enabled) {
	return instance_exists(argument[0]);
} else return undefined;

#define __lnc__f225
if (live_enabled) {
	return instance_number(argument[0]);
} else return undefined;

#define __lnc__f226
if (live_enabled) {
	return instance_position(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f227
if (live_enabled) {
	return instance_nearest(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f228
if (live_enabled) {
	return instance_furthest(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f229
if (live_enabled) {
	return instance_place(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f230
if (live_enabled) {
	return instance_create_depth(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f231
if (live_enabled) {
	return instance_create_layer(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f232
if (live_enabled) {
	return instance_copy(argument[0]);
} else return undefined;

#define __lnc__f233
if (live_enabled) {
	instance_change(argument[0],argument[1]);
}

#define __lnc__f234
if (live_enabled) {
	switch(argument_count){
		case 0:instance_destroy();break;
		case 1:instance_destroy(argument[0]);break;
		case 2:instance_destroy(argument[0],argument[1]);break;
		default:gml_thread_error("instance_destroy takes at most 2 arguments, got "+string(argument_count));
	}
}

#define __lnc__f235
if (live_enabled) {
	position_destroy(argument[0],argument[1]);
}

#define __lnc__f236
if (live_enabled) {
	position_change(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f237
if (live_enabled) {
	return instance_id_get(argument[0]);
} else return undefined;

#define __lnc__f238
if (live_enabled) {
	instance_deactivate_all(argument[0]);
}

#define __lnc__f239
if (live_enabled) {
	instance_deactivate_object(argument[0]);
}

#define __lnc__f240
if (live_enabled) {
	instance_deactivate_region(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f241
if (live_enabled) {
	instance_activate_all();
}

#define __lnc__f242
if (live_enabled) {
	instance_activate_object(argument[0]);
}

#define __lnc__f243
if (live_enabled) {
	instance_activate_region(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f244
if (live_enabled) {
	room_goto(argument[0]);
}

#define __lnc__f245
if (live_enabled) {
	room_goto_previous();
}

#define __lnc__f246
if (live_enabled) {
	room_goto_next();
}

#define __lnc__f247
if (live_enabled) {
	return room_previous(argument[0]);
} else return undefined;

#define __lnc__f248
if (live_enabled) {
	return room_next(argument[0]);
} else return undefined;

#define __lnc__f249
if (live_enabled) {
	room_restart();
}

#define __lnc__f250
if (live_enabled) {
	game_end();
}

#define __lnc__f251
if (live_enabled) {
	game_restart();
}

#define __lnc__f252
if (live_enabled) {
	return game_load(argument[0]);
} else return undefined;

#define __lnc__f253
if (live_enabled) {
	game_save(argument[0]);
}

#define __lnc__f254
if (live_enabled) {
	game_save_buffer(argument[0]);
}

#define __lnc__f255
if (live_enabled) {
	return game_load_buffer(argument[0]);
} else return undefined;

#define __lnc__f256
if (live_enabled) {
	event_perform(argument[0],argument[1]);
}

#define __lnc__f257
if (live_enabled) {
	event_user(argument[0]);
}

#define __lnc__f258
if (live_enabled) {
	event_perform_object(argument[0],argument[1],argument[2]);
}

#define __lnc__f259
if (live_enabled) {
	event_inherited();
}

#define __lnc__f260
if (live_enabled) {
	show_debug_message(argument[0]);
}

#define __lnc__f261
if (live_enabled) {
	show_debug_overlay(argument[0]);
}

#define __lnc__f262
if (live_enabled) {
	debug_event(argument[0]);
}

#define __lnc__f263
if (live_enabled) {
	return debug_get_callstack();
} else return undefined;

#define __lnc__f264
if (live_enabled) {
	return alarm_get(argument[0]);
} else return undefined;

#define __lnc__f265
if (live_enabled) {
	alarm_set(argument[0],argument[1]);
}

#define __lnc__f266
if (live_enabled) {
	keyboard_set_map(argument[0],argument[1]);
}

#define __lnc__f267
if (live_enabled) {
	return keyboard_get_map(argument[0]);
} else return undefined;

#define __lnc__f268
if (live_enabled) {
	keyboard_unset_map();
}

#define __lnc__f269
if (live_enabled) {
	return keyboard_check(argument[0]);
} else return undefined;

#define __lnc__f270
if (live_enabled) {
	return keyboard_check_pressed(argument[0]);
} else return undefined;

#define __lnc__f271
if (live_enabled) {
	return keyboard_check_released(argument[0]);
} else return undefined;

#define __lnc__f272
if (live_enabled) {
	return keyboard_check_direct(argument[0]);
} else return undefined;

#define __lnc__f273
if (live_enabled) {
	return keyboard_get_numlock();
} else return undefined;

#define __lnc__f274
if (live_enabled) {
	keyboard_set_numlock(argument[0]);
}

#define __lnc__f275
if (live_enabled) {
	keyboard_key_press(argument[0]);
}

#define __lnc__f276
if (live_enabled) {
	keyboard_key_release(argument[0]);
}

#define __lnc__f277
if (live_enabled) {
	keyboard_clear(argument[0]);
}

#define __lnc__f278
if (live_enabled) {
	io_clear();
}

#define __lnc__f279
if (live_enabled) {
	return mouse_check_button(argument[0]);
} else return undefined;

#define __lnc__f280
if (live_enabled) {
	return mouse_check_button_pressed(argument[0]);
} else return undefined;

#define __lnc__f281
if (live_enabled) {
	return mouse_check_button_released(argument[0]);
} else return undefined;

#define __lnc__f282
if (live_enabled) {
	return mouse_wheel_up();
} else return undefined;

#define __lnc__f283
if (live_enabled) {
	return mouse_wheel_down();
} else return undefined;

#define __lnc__f284
if (live_enabled) {
	mouse_clear(argument[0]);
}

#define __lnc__f285
if (live_enabled) {
	draw_self();
}

#define __lnc__f286
if (live_enabled) {
	draw_sprite(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f287
if (live_enabled) {
	draw_sprite_pos(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);
}

#define __lnc__f288
if (live_enabled) {
	draw_sprite_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
}

#define __lnc__f289
if (live_enabled) {
	draw_sprite_stretched(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f290
if (live_enabled) {
	draw_sprite_stretched_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
}

#define __lnc__f291
if (live_enabled) {
	draw_sprite_tiled(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f292
if (live_enabled) {
	draw_sprite_tiled_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
}

#define __lnc__f293
if (live_enabled) {
	draw_sprite_part(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
}

#define __lnc__f294
if (live_enabled) {
	draw_sprite_part_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);
}

#define __lnc__f295
if (live_enabled) {
	draw_sprite_general(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15]);
}

#define __lnc__f296
if (live_enabled) {
	draw_clear(argument[0]);
}

#define __lnc__f297
if (live_enabled) {
	draw_clear_alpha(argument[0],argument[1]);
}

#define __lnc__f298
if (live_enabled) {
	draw_point(argument[0],argument[1]);
}

#define __lnc__f299
if (live_enabled) {
	draw_line(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f300
if (live_enabled) {
	draw_line_width(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f301
if (live_enabled) {
	draw_rectangle(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f302
if (live_enabled) {
	draw_roundrect(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f303
if (live_enabled) {
	draw_roundrect_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f304
if (live_enabled) {
	draw_triangle(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f305
if (live_enabled) {
	draw_circle(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f306
if (live_enabled) {
	draw_ellipse(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f307
if (live_enabled) {
	draw_set_circle_precision(argument[0]);
}

#define __lnc__f308
if (live_enabled) {
	draw_arrow(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f309
if (live_enabled) {
	draw_button(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f310
if (live_enabled) {
	draw_path(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f311
if (live_enabled) {
	draw_healthbar(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);
}

#define __lnc__f312
if (live_enabled) {
	return draw_getpixel(argument[0],argument[1]);
} else return undefined;

#define __lnc__f313
if (live_enabled) {
	return draw_getpixel_ext(argument[0],argument[1]);
} else return undefined;

#define __lnc__f314
if (live_enabled) {
	draw_set_colour(argument[0]);
}

#define __lnc__f315
if (live_enabled) {
	draw_set_color(argument[0]);
}

#define __lnc__f316
if (live_enabled) {
	draw_set_alpha(argument[0]);
}

#define __lnc__f317
if (live_enabled) {
	return draw_get_colour();
} else return undefined;

#define __lnc__f318
if (live_enabled) {
	return draw_get_color();
} else return undefined;

#define __lnc__f319
if (live_enabled) {
	return draw_get_alpha();
} else return undefined;

#define __lnc__f320
if (live_enabled) {
	return merge_colour(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f321
if (live_enabled) {
	return make_colour_rgb(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f322
if (live_enabled) {
	return make_colour_hsv(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f323
if (live_enabled) {
	return colour_get_red(argument[0]);
} else return undefined;

#define __lnc__f324
if (live_enabled) {
	return colour_get_green(argument[0]);
} else return undefined;

#define __lnc__f325
if (live_enabled) {
	return colour_get_blue(argument[0]);
} else return undefined;

#define __lnc__f326
if (live_enabled) {
	return colour_get_hue(argument[0]);
} else return undefined;

#define __lnc__f327
if (live_enabled) {
	return colour_get_saturation(argument[0]);
} else return undefined;

#define __lnc__f328
if (live_enabled) {
	return colour_get_value(argument[0]);
} else return undefined;

#define __lnc__f329
if (live_enabled) {
	return merge_color(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f330
if (live_enabled) {
	return make_color_rgb(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f331
if (live_enabled) {
	return make_color_hsv(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f332
if (live_enabled) {
	return color_get_red(argument[0]);
} else return undefined;

#define __lnc__f333
if (live_enabled) {
	return color_get_green(argument[0]);
} else return undefined;

#define __lnc__f334
if (live_enabled) {
	return color_get_blue(argument[0]);
} else return undefined;

#define __lnc__f335
if (live_enabled) {
	return color_get_hue(argument[0]);
} else return undefined;

#define __lnc__f336
if (live_enabled) {
	return color_get_saturation(argument[0]);
} else return undefined;

#define __lnc__f337
if (live_enabled) {
	return color_get_value(argument[0]);
} else return undefined;

#define __lnc__f338
if (live_enabled) {
	screen_save(argument[0]);
}

#define __lnc__f339
if (live_enabled) {
	screen_save_part(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f340
if (live_enabled) {
	if(argument_count<2){
		gml_thread_error("gif_open needs at least 2 arguments, got "+string(argument_count));
		return 0;
	} else switch(argument_count){
		case 2:gif_open(argument[0],argument[1]);break;
		case 3:gif_open(argument[0],argument[1],argument[2]);break;
		case 4:gif_open(argument[0],argument[1],argument[2],argument[3]);break;
		case 5:gif_open(argument[0],argument[1],argument[2],argument[3],argument[4]);break;
		case 6:gif_open(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);break;
		case 7:gif_open(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);break;
		case 8:gif_open(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);break;
		case 9:gif_open(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);break;
		case 10:gif_open(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);break;
		case 11:gif_open(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);break;
		case 12:gif_open(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);break;
		case 13:gif_open(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);break;
		case 14:gif_open(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);break;
		case 15:gif_open(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);break;
		case 16:gif_open(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15]);break;
		case 17:gif_open(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16]);break;
		default:gml_thread_error("gif_open takes at most 18 arguments, got "+string(argument_count));
	}
}

#define __lnc__f341
if (live_enabled) {
	if(argument_count<3){
		gml_thread_error("gif_add_surface needs at least 3 arguments, got "+string(argument_count));
		return 0;
	} else switch(argument_count){
		case 3:gif_add_surface(argument[0],argument[1],argument[2]);break;
		case 4:gif_add_surface(argument[0],argument[1],argument[2],argument[3]);break;
		case 5:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4]);break;
		case 6:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);break;
		case 7:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);break;
		case 8:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);break;
		case 9:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);break;
		case 10:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);break;
		case 11:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);break;
		case 12:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);break;
		case 13:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);break;
		case 14:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);break;
		case 15:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);break;
		case 16:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15]);break;
		case 17:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16]);break;
		case 18:gif_add_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16],argument[17]);break;
		default:gml_thread_error("gif_add_surface takes at most 19 arguments, got "+string(argument_count));
	}
}

#define __lnc__f342
if (live_enabled) {
	gif_save(argument[0],argument[1]);
}

#define __lnc__f343
if (live_enabled) {
	gif_save_buffer(argument[0]);
}

#define __lnc__f344
if (live_enabled) {
	draw_set_font(argument[0]);
}

#define __lnc__f345
if (live_enabled) {
	return draw_get_font();
} else return undefined;

#define __lnc__f346
if (live_enabled) {
	draw_set_halign(argument[0]);
}

#define __lnc__f347
if (live_enabled) {
	return draw_get_halign();
} else return undefined;

#define __lnc__f348
if (live_enabled) {
	draw_set_valign(argument[0]);
}

#define __lnc__f349
if (live_enabled) {
	return draw_get_valign();
} else return undefined;

#define __lnc__f350
if (live_enabled) {
	draw_text(argument[0],argument[1],argument[2]);
}

#define __lnc__f351
if (live_enabled) {
	draw_text_ext(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f352
if (live_enabled) {
	return string_width(argument[0]);
} else return undefined;

#define __lnc__f353
if (live_enabled) {
	return string_height(argument[0]);
} else return undefined;

#define __lnc__f354
if (live_enabled) {
	return string_width_ext(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f355
if (live_enabled) {
	return string_height_ext(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f356
if (live_enabled) {
	draw_text_transformed(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f357
if (live_enabled) {
	draw_text_ext_transformed(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
}

#define __lnc__f358
if (live_enabled) {
	draw_text_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
}

#define __lnc__f359
if (live_enabled) {
	draw_text_ext_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);
}

#define __lnc__f360
if (live_enabled) {
	draw_text_transformed_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);
}

#define __lnc__f361
if (live_enabled) {
	draw_text_ext_transformed_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);
}

#define __lnc__f362
if (live_enabled) {
	draw_text_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
}

#define __lnc__f363
if (live_enabled) {
	draw_text_ext_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);
}

#define __lnc__f364
if (live_enabled) {
	draw_text_transformed_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);
}

#define __lnc__f365
if (live_enabled) {
	draw_text_ext_transformed_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);
}

#define __lnc__f366
if (live_enabled) {
	draw_point_colour(argument[0],argument[1],argument[2]);
}

#define __lnc__f367
if (live_enabled) {
	draw_line_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f368
if (live_enabled) {
	draw_line_width_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f369
if (live_enabled) {
	draw_rectangle_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
}

#define __lnc__f370
if (live_enabled) {
	draw_roundrect_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f371
if (live_enabled) {
	draw_roundrect_colour_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
}

#define __lnc__f372
if (live_enabled) {
	draw_triangle_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);
}

#define __lnc__f373
if (live_enabled) {
	draw_circle_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f374
if (live_enabled) {
	draw_ellipse_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f375
if (live_enabled) {
	draw_point_color(argument[0],argument[1],argument[2]);
}

#define __lnc__f376
if (live_enabled) {
	draw_line_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f377
if (live_enabled) {
	draw_line_width_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f378
if (live_enabled) {
	draw_rectangle_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
}

#define __lnc__f379
if (live_enabled) {
	draw_roundrect_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f380
if (live_enabled) {
	draw_roundrect_color_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
}

#define __lnc__f381
if (live_enabled) {
	draw_triangle_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);
}

#define __lnc__f382
if (live_enabled) {
	draw_circle_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f383
if (live_enabled) {
	draw_ellipse_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f384
if (live_enabled) {
	draw_primitive_begin(argument[0]);
}

#define __lnc__f385
if (live_enabled) {
	draw_vertex(argument[0],argument[1]);
}

#define __lnc__f386
if (live_enabled) {
	draw_vertex_colour(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f387
if (live_enabled) {
	draw_vertex_color(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f388
if (live_enabled) {
	draw_primitive_end();
}

#define __lnc__f389
if (live_enabled) {
	return sprite_get_uvs(argument[0],argument[1]);
} else return undefined;

#define __lnc__f390
if (live_enabled) {
	return font_get_uvs(argument[0]);
} else return undefined;

#define __lnc__f391
if (live_enabled) {
	return sprite_get_texture(argument[0],argument[1]);
} else return undefined;

#define __lnc__f392
if (live_enabled) {
	return font_get_texture(argument[0]);
} else return undefined;

#define __lnc__f393
if (live_enabled) {
	return texture_get_width(argument[0]);
} else return undefined;

#define __lnc__f394
if (live_enabled) {
	return texture_get_height(argument[0]);
} else return undefined;

#define __lnc__f395
if (live_enabled) {
	return texture_get_uvs(argument[0]);
} else return undefined;

#define __lnc__f396
if (live_enabled) {
	draw_primitive_begin_texture(argument[0],argument[1]);
}

#define __lnc__f397
if (live_enabled) {
	draw_vertex_texture(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f398
if (live_enabled) {
	draw_vertex_texture_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f399
if (live_enabled) {
	draw_vertex_texture_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f400
if (live_enabled) {
	texture_global_scale(argument[0]);
}

#define __lnc__f401
if (live_enabled) {
	return surface_create(argument[0],argument[1]);
} else return undefined;

#define __lnc__f402
if (live_enabled) {
	return surface_create_ext(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f403
if (live_enabled) {
	surface_resize(argument[0],argument[1],argument[2]);
}

#define __lnc__f404
if (live_enabled) {
	surface_free(argument[0]);
}

#define __lnc__f405
if (live_enabled) {
	return surface_exists(argument[0]);
} else return undefined;

#define __lnc__f406
if (live_enabled) {
	return surface_get_width(argument[0]);
} else return undefined;

#define __lnc__f407
if (live_enabled) {
	return surface_get_height(argument[0]);
} else return undefined;

#define __lnc__f408
if (live_enabled) {
	return surface_get_texture(argument[0]);
} else return undefined;

#define __lnc__f409
if (live_enabled) {
	surface_set_target(argument[0]);
}

#define __lnc__f410
if (live_enabled) {
	surface_set_target_ext(argument[0],argument[1]);
}

#define __lnc__f411
if (live_enabled) {
	return surface_get_target();
} else return undefined;

#define __lnc__f412
if (live_enabled) {
	return surface_get_target_ext(argument[0]);
} else return undefined;

#define __lnc__f413
if (live_enabled) {
	surface_reset_target();
}

#define __lnc__f414
if (live_enabled) {
	surface_depth_disable(argument[0]);
}

#define __lnc__f415
if (live_enabled) {
	return surface_get_depth_disable();
} else return undefined;

#define __lnc__f416
if (live_enabled) {
	draw_surface(argument[0],argument[1],argument[2]);
}

#define __lnc__f417
if (live_enabled) {
	draw_surface_stretched(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f418
if (live_enabled) {
	draw_surface_tiled(argument[0],argument[1],argument[2]);
}

#define __lnc__f419
if (live_enabled) {
	draw_surface_part(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f420
if (live_enabled) {
	draw_surface_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
}

#define __lnc__f421
if (live_enabled) {
	draw_surface_stretched_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f422
if (live_enabled) {
	draw_surface_tiled_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f423
if (live_enabled) {
	draw_surface_part_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);
}

#define __lnc__f424
if (live_enabled) {
	draw_surface_general(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);
}

#define __lnc__f425
if (live_enabled) {
	return surface_getpixel(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f426
if (live_enabled) {
	return surface_getpixel_ext(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f427
if (live_enabled) {
	surface_save(argument[0],argument[1]);
}

#define __lnc__f428
if (live_enabled) {
	surface_save_part(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f429
if (live_enabled) {
	surface_copy(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f430
if (live_enabled) {
	surface_copy_part(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
}

#define __lnc__f431
if (live_enabled) {
	application_surface_draw_enable(argument[0]);
}

#define __lnc__f432
if (live_enabled) {
	return application_get_position();
} else return undefined;

#define __lnc__f433
if (live_enabled) {
	application_surface_enable(argument[0]);
}

#define __lnc__f434
if (live_enabled) {
	return application_surface_is_enabled();
} else return undefined;

#define __lnc__f435
if (live_enabled) {
	return display_get_width();
} else return undefined;

#define __lnc__f436
if (live_enabled) {
	return display_get_height();
} else return undefined;

#define __lnc__f437
if (live_enabled) {
	return display_get_orientation();
} else return undefined;

#define __lnc__f438
if (live_enabled) {
	return display_get_gui_width();
} else return undefined;

#define __lnc__f439
if (live_enabled) {
	return display_get_gui_height();
} else return undefined;

#define __lnc__f440
if (live_enabled) {
	return display_reset(argument[0],argument[1]);
} else return undefined;

#define __lnc__f441
if (live_enabled) {
	return display_mouse_get_x();
} else return undefined;

#define __lnc__f442
if (live_enabled) {
	return display_mouse_get_y();
} else return undefined;

#define __lnc__f443
if (live_enabled) {
	display_mouse_set(argument[0],argument[1]);
}

#define __lnc__f444
if (live_enabled) {
	display_set_ui_visibility(argument[0]);
}

#define __lnc__f445
if (live_enabled) {
	window_set_fullscreen(argument[0]);
}

#define __lnc__f446
if (live_enabled) {
	return window_get_fullscreen();
} else return undefined;

#define __lnc__f447
if (live_enabled) {
	window_set_caption(argument[0]);
}

#define __lnc__f448
if (live_enabled) {
	window_set_min_width(argument[0]);
}

#define __lnc__f449
if (live_enabled) {
	window_set_max_width(argument[0]);
}

#define __lnc__f450
if (live_enabled) {
	window_set_min_height(argument[0]);
}

#define __lnc__f451
if (live_enabled) {
	window_set_max_height(argument[0]);
}

#define __lnc__f452
if (live_enabled) {
	return window_get_visible_rects(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f453
if (live_enabled) {
	return window_get_caption();
} else return undefined;

#define __lnc__f454
if (live_enabled) {
	window_set_cursor(argument[0]);
}

#define __lnc__f455
if (live_enabled) {
	return window_get_cursor();
} else return undefined;

#define __lnc__f456
if (live_enabled) {
	window_set_colour(argument[0]);
}

#define __lnc__f457
if (live_enabled) {
	return window_get_colour();
} else return undefined;

#define __lnc__f458
if (live_enabled) {
	window_set_color(argument[0]);
}

#define __lnc__f459
if (live_enabled) {
	return window_get_color();
} else return undefined;

#define __lnc__f460
if (live_enabled) {
	window_set_position(argument[0],argument[1]);
}

#define __lnc__f461
if (live_enabled) {
	window_set_size(argument[0],argument[1]);
}

#define __lnc__f462
if (live_enabled) {
	window_set_rectangle(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f463
if (live_enabled) {
	window_center();
}

#define __lnc__f464
if (live_enabled) {
	return window_get_x();
} else return undefined;

#define __lnc__f465
if (live_enabled) {
	return window_get_y();
} else return undefined;

#define __lnc__f466
if (live_enabled) {
	return window_get_width();
} else return undefined;

#define __lnc__f467
if (live_enabled) {
	return window_get_height();
} else return undefined;

#define __lnc__f468
if (live_enabled) {
	return window_mouse_get_x();
} else return undefined;

#define __lnc__f469
if (live_enabled) {
	return window_mouse_get_y();
} else return undefined;

#define __lnc__f470
if (live_enabled) {
	window_mouse_set(argument[0],argument[1]);
}

#define __lnc__f471
if (live_enabled) {
	return window_view_mouse_get_x(argument[0]);
} else return undefined;

#define __lnc__f472
if (live_enabled) {
	return window_view_mouse_get_y(argument[0]);
} else return undefined;

#define __lnc__f473
if (live_enabled) {
	return window_views_mouse_get_x();
} else return undefined;

#define __lnc__f474
if (live_enabled) {
	return window_views_mouse_get_y();
} else return undefined;

#define __lnc__f475
if (live_enabled) {
	audio_listener_position(argument[0],argument[1],argument[2]);
}

#define __lnc__f476
if (live_enabled) {
	audio_listener_velocity(argument[0],argument[1],argument[2]);
}

#define __lnc__f477
if (live_enabled) {
	audio_listener_orientation(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f478
if (live_enabled) {
	audio_emitter_position(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f479
if (live_enabled) {
	return audio_emitter_create();
} else return undefined;

#define __lnc__f480
if (live_enabled) {
	audio_emitter_free(argument[0]);
}

#define __lnc__f481
if (live_enabled) {
	return audio_emitter_exists(argument[0]);
} else return undefined;

#define __lnc__f482
if (live_enabled) {
	audio_emitter_pitch(argument[0],argument[1]);
}

#define __lnc__f483
if (live_enabled) {
	audio_emitter_velocity(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f484
if (live_enabled) {
	audio_emitter_falloff(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f485
if (live_enabled) {
	audio_emitter_gain(argument[0],argument[1]);
}

#define __lnc__f486
if (live_enabled) {
	return audio_play_sound(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f487
if (live_enabled) {
	return audio_play_sound_on(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f488
if (live_enabled) {
	return audio_play_sound_at(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
} else return undefined;

#define __lnc__f489
if (live_enabled) {
	audio_stop_sound(argument[0]);
}

#define __lnc__f490
if (live_enabled) {
	audio_resume_sound(argument[0]);
}

#define __lnc__f491
if (live_enabled) {
	audio_pause_sound(argument[0]);
}

#define __lnc__f492
if (live_enabled) {
	audio_channel_num(argument[0]);
}

#define __lnc__f493
if (live_enabled) {
	return audio_sound_length(argument[0]);
} else return undefined;

#define __lnc__f494
if (live_enabled) {
	return audio_get_type(argument[0]);
} else return undefined;

#define __lnc__f495
if (live_enabled) {
	audio_falloff_set_model(argument[0]);
}

#define __lnc__f496
if (live_enabled) {
	audio_master_gain(argument[0]);
}

#define __lnc__f497
if (live_enabled) {
	audio_sound_gain(argument[0],argument[1],argument[2]);
}

#define __lnc__f498
if (live_enabled) {
	audio_sound_pitch(argument[0],argument[1]);
}

#define __lnc__f499
if (live_enabled) {
	audio_stop_all();
}

#define __lnc__f500
if (live_enabled) {
	audio_resume_all();
}

#define __lnc__f501
if (live_enabled) {
	audio_pause_all();
}

#define __lnc__f502
if (live_enabled) {
	return audio_is_playing(argument[0]);
} else return undefined;

#define __lnc__f503
if (live_enabled) {
	return audio_is_paused(argument[0]);
} else return undefined;

#define __lnc__f504
if (live_enabled) {
	return audio_exists(argument[0]);
} else return undefined;

#define __lnc__f505
if (live_enabled) {
	return audio_system_is_available();
} else return undefined;

#define __lnc__f506
if (live_enabled) {
	return audio_sound_is_playable(argument[0]);
} else return undefined;

#define __lnc__f507
if (live_enabled) {
	return audio_emitter_get_gain(argument[0]);
} else return undefined;

#define __lnc__f508
if (live_enabled) {
	return audio_emitter_get_pitch(argument[0]);
} else return undefined;

#define __lnc__f509
if (live_enabled) {
	return audio_emitter_get_x(argument[0]);
} else return undefined;

#define __lnc__f510
if (live_enabled) {
	return audio_emitter_get_y(argument[0]);
} else return undefined;

#define __lnc__f511
if (live_enabled) {
	return audio_emitter_get_z(argument[0]);
} else return undefined;

#define __lnc__f512
if (live_enabled) {
	return audio_emitter_get_vx(argument[0]);
} else return undefined;

#define __lnc__f513
if (live_enabled) {
	return audio_emitter_get_vy(argument[0]);
} else return undefined;

#define __lnc__f514
if (live_enabled) {
	return audio_emitter_get_vz(argument[0]);
} else return undefined;

#define __lnc__f515
if (live_enabled) {
	audio_listener_set_position(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f516
if (live_enabled) {
	audio_listener_set_velocity(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f517
if (live_enabled) {
	audio_listener_set_orientation(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f518
if (live_enabled) {
	return audio_listener_get_data(argument[0]);
} else return undefined;

#define __lnc__f519
if (live_enabled) {
	audio_set_master_gain(argument[0],argument[1]);
}

#define __lnc__f520
if (live_enabled) {
	return audio_get_master_gain(argument[0]);
} else return undefined;

#define __lnc__f521
if (live_enabled) {
	return audio_sound_get_gain(argument[0]);
} else return undefined;

#define __lnc__f522
if (live_enabled) {
	return audio_sound_get_pitch(argument[0]);
} else return undefined;

#define __lnc__f523
if (live_enabled) {
	return audio_get_name(argument[0]);
} else return undefined;

#define __lnc__f524
if (live_enabled) {
	audio_sound_set_track_position(argument[0],argument[1]);
}

#define __lnc__f525
if (live_enabled) {
	return audio_sound_get_track_position(argument[0]);
} else return undefined;

#define __lnc__f526
if (live_enabled) {
	return audio_create_stream(argument[0]);
} else return undefined;

#define __lnc__f527
if (live_enabled) {
	audio_destroy_stream(argument[0]);
}

#define __lnc__f528
if (live_enabled) {
	return audio_create_sync_group(argument[0]);
} else return undefined;

#define __lnc__f529
if (live_enabled) {
	audio_destroy_sync_group(argument[0]);
}

#define __lnc__f530
if (live_enabled) {
	return audio_play_in_sync_group(argument[0],argument[1]);
} else return undefined;

#define __lnc__f531
if (live_enabled) {
	audio_start_sync_group(argument[0]);
}

#define __lnc__f532
if (live_enabled) {
	audio_stop_sync_group(argument[0]);
}

#define __lnc__f533
if (live_enabled) {
	audio_pause_sync_group(argument[0]);
}

#define __lnc__f534
if (live_enabled) {
	audio_resume_sync_group(argument[0]);
}

#define __lnc__f535
if (live_enabled) {
	return audio_sync_group_get_track_pos(argument[0]);
} else return undefined;

#define __lnc__f536
if (live_enabled) {
	audio_sync_group_debug(argument[0]);
}

#define __lnc__f537
if (live_enabled) {
	return audio_sync_group_is_playing(argument[0]);
} else return undefined;

#define __lnc__f538
if (live_enabled) {
	audio_debug(argument[0]);
}

#define __lnc__f539
if (live_enabled) {
	return audio_group_load(argument[0]);
} else return undefined;

#define __lnc__f540
if (live_enabled) {
	audio_group_unload(argument[0]);
}

#define __lnc__f541
if (live_enabled) {
	return audio_group_is_loaded(argument[0]);
} else return undefined;

#define __lnc__f542
if (live_enabled) {
	return audio_group_load_progress(argument[0]);
} else return undefined;

#define __lnc__f543
if (live_enabled) {
	return audio_group_name(argument[0]);
} else return undefined;

#define __lnc__f544
if (live_enabled) {
	audio_group_stop_all(argument[0]);
}

#define __lnc__f545
if (live_enabled) {
	audio_group_set_gain(argument[0],argument[1],argument[2]);
}

#define __lnc__f546
if (live_enabled) {
	return audio_create_buffer_sound(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f547
if (live_enabled) {
	audio_free_buffer_sound(argument[0]);
}

#define __lnc__f548
if (live_enabled) {
	return audio_create_play_queue(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f549
if (live_enabled) {
	audio_free_play_queue(argument[0]);
}

#define __lnc__f550
if (live_enabled) {
	audio_queue_sound(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f551
if (live_enabled) {
	return audio_get_recorder_count();
} else return undefined;

#define __lnc__f552
if (live_enabled) {
	return audio_get_recorder_info(argument[0]);
} else return undefined;

#define __lnc__f553
if (live_enabled) {
	return audio_start_recording(argument[0]);
} else return undefined;

#define __lnc__f554
if (live_enabled) {
	audio_stop_recording(argument[0]);
}

#define __lnc__f555
if (live_enabled) {
	return audio_sound_get_listener_mask(argument[0]);
} else return undefined;

#define __lnc__f556
if (live_enabled) {
	return audio_emitter_get_listener_mask(argument[0]);
} else return undefined;

#define __lnc__f557
if (live_enabled) {
	return audio_get_listener_mask();
} else return undefined;

#define __lnc__f558
if (live_enabled) {
	audio_sound_set_listener_mask(argument[0],argument[1]);
}

#define __lnc__f559
if (live_enabled) {
	audio_emitter_set_listener_mask(argument[0],argument[1]);
}

#define __lnc__f560
if (live_enabled) {
	audio_set_listener_mask(argument[0]);
}

#define __lnc__f561
if (live_enabled) {
	return audio_get_listener_count();
} else return undefined;

#define __lnc__f562
if (live_enabled) {
	return audio_get_listener_info(argument[0]);
} else return undefined;

#define __lnc__f563
if (live_enabled) {
	show_message(argument[0]);
}

#define __lnc__f564
if (live_enabled) {
	show_message_async(argument[0]);
}

#define __lnc__f565
if (live_enabled) {
	return clickable_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f566
if (live_enabled) {
	return clickable_add_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
} else return undefined;

#define __lnc__f567
if (live_enabled) {
	clickable_change(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f568
if (live_enabled) {
	clickable_change_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f569
if (live_enabled) {
	clickable_delete(argument[0]);
}

#define __lnc__f570
if (live_enabled) {
	return clickable_exists(argument[0]);
} else return undefined;

#define __lnc__f571
if (live_enabled) {
	clickable_set_style(argument[0],argument[1]);
}

#define __lnc__f572
if (live_enabled) {
	return show_question(argument[0]);
} else return undefined;

#define __lnc__f573
if (live_enabled) {
	return show_question_async(argument[0]);
} else return undefined;

#define __lnc__f574
if (live_enabled) {
	return get_integer(argument[0],argument[1]);
} else return undefined;

#define __lnc__f575
if (live_enabled) {
	return get_string(argument[0],argument[1]);
} else return undefined;

#define __lnc__f576
if (live_enabled) {
	return get_integer_async(argument[0],argument[1]);
} else return undefined;

#define __lnc__f577
if (live_enabled) {
	return get_string_async(argument[0],argument[1]);
} else return undefined;

#define __lnc__f578
if (live_enabled) {
	return get_login_async(argument[0],argument[1]);
} else return undefined;

#define __lnc__f579
if (live_enabled) {
	return get_open_filename(argument[0],argument[1]);
} else return undefined;

#define __lnc__f580
if (live_enabled) {
	return get_save_filename(argument[0],argument[1]);
} else return undefined;

#define __lnc__f581
if (live_enabled) {
	return get_open_filename_ext(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f582
if (live_enabled) {
	return get_save_filename_ext(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f583
if (live_enabled) {
	show_error(argument[0],argument[1]);
}

#define __lnc__f584
if (live_enabled) {
	highscore_clear();
}

#define __lnc__f585
if (live_enabled) {
	highscore_add(argument[0],argument[1]);
}

#define __lnc__f586
if (live_enabled) {
	return highscore_value(argument[0]);
} else return undefined;

#define __lnc__f587
if (live_enabled) {
	return highscore_name(argument[0]);
} else return undefined;

#define __lnc__f588
if (live_enabled) {
	draw_highscore(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f589
if (live_enabled) {
	return sprite_exists(argument[0]);
} else return undefined;

#define __lnc__f590
if (live_enabled) {
	return sprite_get_name(argument[0]);
} else return undefined;

#define __lnc__f591
if (live_enabled) {
	return sprite_get_number(argument[0]);
} else return undefined;

#define __lnc__f592
if (live_enabled) {
	return sprite_get_width(argument[0]);
} else return undefined;

#define __lnc__f593
if (live_enabled) {
	return sprite_get_height(argument[0]);
} else return undefined;

#define __lnc__f594
if (live_enabled) {
	return sprite_get_xoffset(argument[0]);
} else return undefined;

#define __lnc__f595
if (live_enabled) {
	return sprite_get_yoffset(argument[0]);
} else return undefined;

#define __lnc__f596
if (live_enabled) {
	return sprite_get_bbox_mode(argument[0]);
} else return undefined;

#define __lnc__f597
if (live_enabled) {
	return sprite_get_bbox_left(argument[0]);
} else return undefined;

#define __lnc__f598
if (live_enabled) {
	return sprite_get_bbox_right(argument[0]);
} else return undefined;

#define __lnc__f599
if (live_enabled) {
	return sprite_get_bbox_top(argument[0]);
} else return undefined;

#define __lnc__f600
if (live_enabled) {
	return sprite_get_bbox_bottom(argument[0]);
} else return undefined;

#define __lnc__f601
if (live_enabled) {
	sprite_set_bbox_mode(argument[0],argument[1]);
}

#define __lnc__f602
if (live_enabled) {
	sprite_set_bbox(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f603
if (live_enabled) {
	sprite_save(argument[0],argument[1],argument[2]);
}

#define __lnc__f604
if (live_enabled) {
	sprite_save_strip(argument[0],argument[1]);
}

#define __lnc__f605
if (live_enabled) {
	sprite_set_cache_size(argument[0],argument[1]);
}

#define __lnc__f606
if (live_enabled) {
	sprite_set_cache_size_ext(argument[0],argument[1],argument[2]);
}

#define __lnc__f607
if (live_enabled) {
	return sprite_get_tpe(argument[0],argument[1]);
} else return undefined;

#define __lnc__f608
if (live_enabled) {
	sprite_prefetch(argument[0]);
}

#define __lnc__f609
if (live_enabled) {
	sprite_prefetch_multi(argument[0]);
}

#define __lnc__f610
if (live_enabled) {
	sprite_flush(argument[0]);
}

#define __lnc__f611
if (live_enabled) {
	sprite_flush_multi(argument[0]);
}

#define __lnc__f612
if (live_enabled) {
	sprite_set_speed(argument[0],argument[1],argument[2]);
}

#define __lnc__f613
if (live_enabled) {
	return sprite_get_speed_type(argument[0]);
} else return undefined;

#define __lnc__f614
if (live_enabled) {
	return sprite_get_speed(argument[0]);
} else return undefined;

#define __lnc__f615
if (live_enabled) {
	return texture_is_ready(argument[0]);
} else return undefined;

#define __lnc__f616
if (live_enabled) {
	texture_prefetch(argument[0]);
}

#define __lnc__f617
if (live_enabled) {
	texture_flush(argument[0]);
}

#define __lnc__f618
if (live_enabled) {
	return texturegroup_get_textures(argument[0]);
} else return undefined;

#define __lnc__f619
if (live_enabled) {
	return texturegroup_get_sprites(argument[0]);
} else return undefined;

#define __lnc__f620
if (live_enabled) {
	return texturegroup_get_fonts(argument[0]);
} else return undefined;

#define __lnc__f621
if (live_enabled) {
	return texturegroup_get_tilesets(argument[0]);
} else return undefined;

#define __lnc__f622
if (live_enabled) {
	texture_debug_messages(argument[0]);
}

#define __lnc__f623
if (live_enabled) {
	return font_exists(argument[0]);
} else return undefined;

#define __lnc__f624
if (live_enabled) {
	return font_get_name(argument[0]);
} else return undefined;

#define __lnc__f625
if (live_enabled) {
	return font_get_fontname(argument[0]);
} else return undefined;

#define __lnc__f626
if (live_enabled) {
	return font_get_bold(argument[0]);
} else return undefined;

#define __lnc__f627
if (live_enabled) {
	return font_get_italic(argument[0]);
} else return undefined;

#define __lnc__f628
if (live_enabled) {
	return font_get_first(argument[0]);
} else return undefined;

#define __lnc__f629
if (live_enabled) {
	return font_get_last(argument[0]);
} else return undefined;

#define __lnc__f630
if (live_enabled) {
	return font_get_size(argument[0]);
} else return undefined;

#define __lnc__f631
if (live_enabled) {
	font_set_cache_size(argument[0],argument[1]);
}

#define __lnc__f632
if (live_enabled) {
	return path_exists(argument[0]);
} else return undefined;

#define __lnc__f633
if (live_enabled) {
	return path_get_name(argument[0]);
} else return undefined;

#define __lnc__f634
if (live_enabled) {
	return path_get_length(argument[0]);
} else return undefined;

#define __lnc__f635
if (live_enabled) {
	return path_get_time(argument[0],argument[1]);
} else return undefined;

#define __lnc__f636
if (live_enabled) {
	return path_get_kind(argument[0]);
} else return undefined;

#define __lnc__f637
if (live_enabled) {
	return path_get_closed(argument[0]);
} else return undefined;

#define __lnc__f638
if (live_enabled) {
	return path_get_precision(argument[0]);
} else return undefined;

#define __lnc__f639
if (live_enabled) {
	return path_get_number(argument[0]);
} else return undefined;

#define __lnc__f640
if (live_enabled) {
	return path_get_point_x(argument[0],argument[1]);
} else return undefined;

#define __lnc__f641
if (live_enabled) {
	return path_get_point_y(argument[0],argument[1]);
} else return undefined;

#define __lnc__f642
if (live_enabled) {
	return path_get_point_speed(argument[0],argument[1]);
} else return undefined;

#define __lnc__f643
if (live_enabled) {
	return path_get_x(argument[0],argument[1]);
} else return undefined;

#define __lnc__f644
if (live_enabled) {
	return path_get_y(argument[0],argument[1]);
} else return undefined;

#define __lnc__f645
if (live_enabled) {
	return path_get_speed(argument[0],argument[1]);
} else return undefined;

#define __lnc__f646
if (live_enabled) {
	return script_exists(argument[0]);
} else return undefined;

#define __lnc__f647
if (live_enabled) {
	return script_get_name(argument[0]);
} else return undefined;

#define __lnc__f648
if (live_enabled) {
	return timeline_add();
} else return undefined;

#define __lnc__f649
if (live_enabled) {
	timeline_delete(argument[0]);
}

#define __lnc__f650
if (live_enabled) {
	timeline_clear(argument[0]);
}

#define __lnc__f651
if (live_enabled) {
	return timeline_exists(argument[0]);
} else return undefined;

#define __lnc__f652
if (live_enabled) {
	return timeline_get_name(argument[0]);
} else return undefined;

#define __lnc__f653
if (live_enabled) {
	timeline_moment_clear(argument[0],argument[1]);
}

#define __lnc__f654
if (live_enabled) {
	timeline_moment_add_script(argument[0],argument[1],argument[2]);
}

#define __lnc__f655
if (live_enabled) {
	return timeline_size(argument[0]);
} else return undefined;

#define __lnc__f656
if (live_enabled) {
	return timeline_max_moment(argument[0]);
} else return undefined;

#define __lnc__f657
if (live_enabled) {
	return object_exists(argument[0]);
} else return undefined;

#define __lnc__f658
if (live_enabled) {
	return object_get_name(argument[0]);
} else return undefined;

#define __lnc__f659
if (live_enabled) {
	return object_get_sprite(argument[0]);
} else return undefined;

#define __lnc__f660
if (live_enabled) {
	return object_get_solid(argument[0]);
} else return undefined;

#define __lnc__f661
if (live_enabled) {
	return object_get_visible(argument[0]);
} else return undefined;

#define __lnc__f662
if (live_enabled) {
	return object_get_persistent(argument[0]);
} else return undefined;

#define __lnc__f663
if (live_enabled) {
	return object_get_mask(argument[0]);
} else return undefined;

#define __lnc__f664
if (live_enabled) {
	return object_get_parent(argument[0]);
} else return undefined;

#define __lnc__f665
if (live_enabled) {
	return object_get_physics(argument[0]);
} else return undefined;

#define __lnc__f666
if (live_enabled) {
	return object_is_ancestor(argument[0],argument[1]);
} else return undefined;

#define __lnc__f667
if (live_enabled) {
	return room_exists(argument[0]);
} else return undefined;

#define __lnc__f668
if (live_enabled) {
	return room_get_name(argument[0]);
} else return undefined;

#define __lnc__f669
if (live_enabled) {
	sprite_set_offset(argument[0],argument[1],argument[2]);
}

#define __lnc__f670
if (live_enabled) {
	return sprite_duplicate(argument[0]);
} else return undefined;

#define __lnc__f671
if (live_enabled) {
	sprite_assign(argument[0],argument[1]);
}

#define __lnc__f672
if (live_enabled) {
	sprite_merge(argument[0],argument[1]);
}

#define __lnc__f673
if (live_enabled) {
	return sprite_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f674
if (live_enabled) {
	sprite_replace(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f675
if (live_enabled) {
	return sprite_create_from_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
} else return undefined;

#define __lnc__f676
if (live_enabled) {
	return sprite_add_from_surface(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
} else return undefined;

#define __lnc__f677
if (live_enabled) {
	sprite_delete(argument[0]);
}

#define __lnc__f678
if (live_enabled) {
	sprite_set_alpha_from_sprite(argument[0],argument[1]);
}

#define __lnc__f679
if (live_enabled) {
	sprite_collision_mask(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
}

#define __lnc__f680
if (live_enabled) {
	font_add_enable_aa(argument[0]);
}

#define __lnc__f681
if (live_enabled) {
	return font_add_get_enable_aa();
} else return undefined;

#define __lnc__f682
if (live_enabled) {
	return font_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f683
if (live_enabled) {
	return font_add_sprite(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f684
if (live_enabled) {
	return font_add_sprite_ext(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f685
if (live_enabled) {
	font_replace_sprite(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f686
if (live_enabled) {
	font_replace_sprite_ext(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f687
if (live_enabled) {
	font_delete(argument[0]);
}

#define __lnc__f688
if (live_enabled) {
	path_set_kind(argument[0],argument[1]);
}

#define __lnc__f689
if (live_enabled) {
	path_set_closed(argument[0],argument[1]);
}

#define __lnc__f690
if (live_enabled) {
	path_set_precision(argument[0],argument[1]);
}

#define __lnc__f691
if (live_enabled) {
	return path_add();
} else return undefined;

#define __lnc__f692
if (live_enabled) {
	path_assign(argument[0],argument[1]);
}

#define __lnc__f693
if (live_enabled) {
	return path_duplicate(argument[0]);
} else return undefined;

#define __lnc__f694
if (live_enabled) {
	path_append(argument[0],argument[1]);
}

#define __lnc__f695
if (live_enabled) {
	path_delete(argument[0]);
}

#define __lnc__f696
if (live_enabled) {
	path_add_point(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f697
if (live_enabled) {
	path_insert_point(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f698
if (live_enabled) {
	path_change_point(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f699
if (live_enabled) {
	path_delete_point(argument[0],argument[1]);
}

#define __lnc__f700
if (live_enabled) {
	path_clear_points(argument[0]);
}

#define __lnc__f701
if (live_enabled) {
	path_reverse(argument[0]);
}

#define __lnc__f702
if (live_enabled) {
	path_mirror(argument[0]);
}

#define __lnc__f703
if (live_enabled) {
	path_flip(argument[0]);
}

#define __lnc__f704
if (live_enabled) {
	path_rotate(argument[0],argument[1]);
}

#define __lnc__f705
if (live_enabled) {
	path_rescale(argument[0],argument[1],argument[2]);
}

#define __lnc__f706
if (live_enabled) {
	path_shift(argument[0],argument[1],argument[2]);
}

#define __lnc__f707
if (live_enabled) {
	object_set_sprite(argument[0],argument[1]);
}

#define __lnc__f708
if (live_enabled) {
	object_set_solid(argument[0],argument[1]);
}

#define __lnc__f709
if (live_enabled) {
	object_set_visible(argument[0],argument[1]);
}

#define __lnc__f710
if (live_enabled) {
	object_set_persistent(argument[0],argument[1]);
}

#define __lnc__f711
if (live_enabled) {
	object_set_mask(argument[0],argument[1]);
}

#define __lnc__f712
if (live_enabled) {
	room_set_width(argument[0],argument[1]);
}

#define __lnc__f713
if (live_enabled) {
	room_set_height(argument[0],argument[1]);
}

#define __lnc__f714
if (live_enabled) {
	room_set_persistent(argument[0],argument[1]);
}

#define __lnc__f715
if (live_enabled) {
	room_set_viewport(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f716
if (live_enabled) {
	return room_get_viewport(argument[0],argument[1]);
} else return undefined;

#define __lnc__f717
if (live_enabled) {
	room_set_view_enabled(argument[0],argument[1]);
}

#define __lnc__f718
if (live_enabled) {
	return room_add();
} else return undefined;

#define __lnc__f719
if (live_enabled) {
	return room_duplicate(argument[0]);
} else return undefined;

#define __lnc__f720
if (live_enabled) {
	room_assign(argument[0],argument[1]);
}

#define __lnc__f721
if (live_enabled) {
	return room_instance_add(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f722
if (live_enabled) {
	room_instance_clear(argument[0]);
}

#define __lnc__f723
if (live_enabled) {
	return room_get_camera(argument[0],argument[1]);
} else return undefined;

#define __lnc__f724
if (live_enabled) {
	room_set_camera(argument[0],argument[1],argument[2]);
}

#define __lnc__f725
if (live_enabled) {
	return asset_get_index(argument[0]);
} else return undefined;

#define __lnc__f726
if (live_enabled) {
	return asset_get_type(argument[0]);
} else return undefined;

#define __lnc__f727
if (live_enabled) {
	return file_text_open_from_string(argument[0]);
} else return undefined;

#define __lnc__f728
if (live_enabled) {
	return file_text_open_read(argument[0]);
} else return undefined;

#define __lnc__f729
if (live_enabled) {
	return file_text_open_write(argument[0]);
} else return undefined;

#define __lnc__f730
if (live_enabled) {
	return file_text_open_append(argument[0]);
} else return undefined;

#define __lnc__f731
if (live_enabled) {
	file_text_close(argument[0]);
}

#define __lnc__f732
if (live_enabled) {
	file_text_write_string(argument[0],argument[1]);
}

#define __lnc__f733
if (live_enabled) {
	file_text_write_real(argument[0],argument[1]);
}

#define __lnc__f734
if (live_enabled) {
	file_text_writeln(argument[0]);
}

#define __lnc__f735
if (live_enabled) {
	return file_text_read_string(argument[0]);
} else return undefined;

#define __lnc__f736
if (live_enabled) {
	return file_text_read_real(argument[0]);
} else return undefined;

#define __lnc__f737
if (live_enabled) {
	return file_text_readln(argument[0]);
} else return undefined;

#define __lnc__f738
if (live_enabled) {
	return file_text_eof(argument[0]);
} else return undefined;

#define __lnc__f739
if (live_enabled) {
	return file_text_eoln(argument[0]);
} else return undefined;

#define __lnc__f740
if (live_enabled) {
	return file_exists(argument[0]);
} else return undefined;

#define __lnc__f741
if (live_enabled) {
	file_delete(argument[0]);
}

#define __lnc__f742
if (live_enabled) {
	file_rename(argument[0],argument[1]);
}

#define __lnc__f743
if (live_enabled) {
	file_copy(argument[0],argument[1]);
}

#define __lnc__f744
if (live_enabled) {
	return directory_exists(argument[0]);
} else return undefined;

#define __lnc__f745
if (live_enabled) {
	return directory_create(argument[0]);
} else return undefined;

#define __lnc__f746
if (live_enabled) {
	directory_destroy(argument[0]);
}

#define __lnc__f747
if (live_enabled) {
	return file_find_first(argument[0],argument[1]);
} else return undefined;

#define __lnc__f748
if (live_enabled) {
	return file_find_next();
} else return undefined;

#define __lnc__f749
if (live_enabled) {
	return file_find_close();
} else return undefined;

#define __lnc__f750
if (live_enabled) {
	return file_attributes(argument[0],argument[1]);
} else return undefined;

#define __lnc__f751
if (live_enabled) {
	return filename_name(argument[0]);
} else return undefined;

#define __lnc__f752
if (live_enabled) {
	return filename_path(argument[0]);
} else return undefined;

#define __lnc__f753
if (live_enabled) {
	return filename_dir(argument[0]);
} else return undefined;

#define __lnc__f754
if (live_enabled) {
	return filename_drive(argument[0]);
} else return undefined;

#define __lnc__f755
if (live_enabled) {
	return filename_ext(argument[0]);
} else return undefined;

#define __lnc__f756
if (live_enabled) {
	return filename_change_ext(argument[0],argument[1]);
} else return undefined;

#define __lnc__f757
if (live_enabled) {
	return file_bin_open(argument[0],argument[1]);
} else return undefined;

#define __lnc__f758
if (live_enabled) {
	file_bin_rewrite(argument[0]);
}

#define __lnc__f759
if (live_enabled) {
	file_bin_close(argument[0]);
}

#define __lnc__f760
if (live_enabled) {
	return file_bin_position(argument[0]);
} else return undefined;

#define __lnc__f761
if (live_enabled) {
	return file_bin_size(argument[0]);
} else return undefined;

#define __lnc__f762
if (live_enabled) {
	file_bin_seek(argument[0],argument[1]);
}

#define __lnc__f763
if (live_enabled) {
	file_bin_write_byte(argument[0],argument[1]);
}

#define __lnc__f764
if (live_enabled) {
	return file_bin_read_byte(argument[0]);
} else return undefined;

#define __lnc__f765
if (live_enabled) {
	return parameter_count();
} else return undefined;

#define __lnc__f766
if (live_enabled) {
	return parameter_string(argument[0]);
} else return undefined;

#define __lnc__f767
if (live_enabled) {
	return environment_get_variable(argument[0]);
} else return undefined;

#define __lnc__f768
if (live_enabled) {
	ini_open_from_string(argument[0]);
}

#define __lnc__f769
if (live_enabled) {
	ini_open(argument[0]);
}

#define __lnc__f770
if (live_enabled) {
	return ini_close();
} else return undefined;

#define __lnc__f771
if (live_enabled) {
	return ini_read_string(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f772
if (live_enabled) {
	return ini_read_real(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f773
if (live_enabled) {
	ini_write_string(argument[0],argument[1],argument[2]);
}

#define __lnc__f774
if (live_enabled) {
	ini_write_real(argument[0],argument[1],argument[2]);
}

#define __lnc__f775
if (live_enabled) {
	return ini_key_exists(argument[0],argument[1]);
} else return undefined;

#define __lnc__f776
if (live_enabled) {
	return ini_section_exists(argument[0]);
} else return undefined;

#define __lnc__f777
if (live_enabled) {
	ini_key_delete(argument[0],argument[1]);
}

#define __lnc__f778
if (live_enabled) {
	ini_section_delete(argument[0]);
}

#define __lnc__f779
if (live_enabled) {
	ds_set_precision(argument[0]);
}

#define __lnc__f780
if (live_enabled) {
	return ds_exists(argument[0],argument[1]);
} else return undefined;

#define __lnc__f781
if (live_enabled) {
	return ds_stack_create();
} else return undefined;

#define __lnc__f782
if (live_enabled) {
	ds_stack_destroy(argument[0]);
}

#define __lnc__f783
if (live_enabled) {
	ds_stack_clear(argument[0]);
}

#define __lnc__f784
if (live_enabled) {
	ds_stack_copy(argument[0],argument[1]);
}

#define __lnc__f785
if (live_enabled) {
	return ds_stack_size(argument[0]);
} else return undefined;

#define __lnc__f786
if (live_enabled) {
	ds_stack_empty(argument[0]);
}

#define __lnc__f787
if (live_enabled) {
	if(argument_count<2){
		gml_thread_error("ds_stack_push needs at least 2 arguments, got "+string(argument_count));
		return 0;
	} else switch(argument_count){
		case 2:ds_stack_push(argument[0],argument[1]);break;
		case 3:ds_stack_push(argument[0],argument[1],argument[2]);break;
		case 4:ds_stack_push(argument[0],argument[1],argument[2],argument[3]);break;
		case 5:ds_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4]);break;
		case 6:ds_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);break;
		case 7:ds_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);break;
		case 8:ds_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);break;
		case 9:ds_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);break;
		case 10:ds_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);break;
		case 11:ds_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);break;
		case 12:ds_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);break;
		case 13:ds_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);break;
		case 14:ds_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);break;
		case 15:ds_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);break;
		case 16:ds_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15]);break;
		case 17:ds_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16]);break;
		default:gml_thread_error("ds_stack_push takes at most 18 arguments, got "+string(argument_count));
	}
}

#define __lnc__f788
if (live_enabled) {
	ds_stack_pop(argument[0]);
}

#define __lnc__f789
if (live_enabled) {
	return ds_stack_top(argument[0]);
} else return undefined;

#define __lnc__f790
if (live_enabled) {
	return ds_stack_write(argument[0]);
} else return undefined;

#define __lnc__f791
if (live_enabled) {
	if(argument_count<2){
		return gml_thread_error("ds_stack_read needs at least 2 arguments, got "+string(argument_count));
	} else switch(argument_count){
		case 2:return ds_stack_read(argument[0],argument[1]);
		case 3:return ds_stack_read(argument[0],argument[1],argument[2]);
		default:return gml_thread_error("ds_stack_read takes at most 3 arguments, got "+string(argument_count));
	}
} else return undefined;

#define __lnc__f792
if (live_enabled) {
	return ds_queue_create();
} else return undefined;

#define __lnc__f793
if (live_enabled) {
	ds_queue_destroy(argument[0]);
}

#define __lnc__f794
if (live_enabled) {
	ds_queue_clear(argument[0]);
}

#define __lnc__f795
if (live_enabled) {
	ds_queue_copy(argument[0],argument[1]);
}

#define __lnc__f796
if (live_enabled) {
	return ds_queue_size(argument[0]);
} else return undefined;

#define __lnc__f797
if (live_enabled) {
	return ds_queue_empty(argument[0]);
} else return undefined;

#define __lnc__f798
if (live_enabled) {
	if(argument_count<2){
		gml_thread_error("ds_queue_enqueue needs at least 2 arguments, got "+string(argument_count));
		return 0;
	} else switch(argument_count){
		case 2:ds_queue_enqueue(argument[0],argument[1]);break;
		case 3:ds_queue_enqueue(argument[0],argument[1],argument[2]);break;
		case 4:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3]);break;
		case 5:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3],argument[4]);break;
		case 6:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);break;
		case 7:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);break;
		case 8:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);break;
		case 9:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);break;
		case 10:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);break;
		case 11:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);break;
		case 12:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);break;
		case 13:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);break;
		case 14:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);break;
		case 15:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);break;
		case 16:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15]);break;
		case 17:ds_queue_enqueue(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16]);break;
		default:gml_thread_error("ds_queue_enqueue takes at most 18 arguments, got "+string(argument_count));
	}
}

#define __lnc__f799
if (live_enabled) {
	return ds_queue_dequeue(argument[0]);
} else return undefined;

#define __lnc__f800
if (live_enabled) {
	return ds_queue_head(argument[0]);
} else return undefined;

#define __lnc__f801
if (live_enabled) {
	return ds_queue_tail(argument[0]);
} else return undefined;

#define __lnc__f802
if (live_enabled) {
	return ds_queue_write(argument[0]);
} else return undefined;

#define __lnc__f803
if (live_enabled) {
	if(argument_count<2){
		return gml_thread_error("ds_queue_read needs at least 2 arguments, got "+string(argument_count));
	} else switch(argument_count){
		case 2:return ds_queue_read(argument[0],argument[1]);
		case 3:return ds_queue_read(argument[0],argument[1],argument[2]);
		default:return gml_thread_error("ds_queue_read takes at most 3 arguments, got "+string(argument_count));
	}
} else return undefined;

#define __lnc__f804
if (live_enabled) {
	return ds_list_create();
} else return undefined;

#define __lnc__f805
if (live_enabled) {
	ds_list_destroy(argument[0]);
}

#define __lnc__f806
if (live_enabled) {
	ds_list_clear(argument[0]);
}

#define __lnc__f807
if (live_enabled) {
	ds_list_copy(argument[0],argument[1]);
}

#define __lnc__f808
if (live_enabled) {
	return ds_list_size(argument[0]);
} else return undefined;

#define __lnc__f809
if (live_enabled) {
	return ds_list_empty(argument[0]);
} else return undefined;

#define __lnc__f810
if (live_enabled) {
	if(argument_count<1){
		gml_thread_error("ds_list_add needs at least 1 arguments, got "+string(argument_count));
		return 0;
	} else switch(argument_count){
		case 1:ds_list_add(argument[0]);break;
		case 2:ds_list_add(argument[0],argument[1]);break;
		case 3:ds_list_add(argument[0],argument[1],argument[2]);break;
		case 4:ds_list_add(argument[0],argument[1],argument[2],argument[3]);break;
		case 5:ds_list_add(argument[0],argument[1],argument[2],argument[3],argument[4]);break;
		case 6:ds_list_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);break;
		case 7:ds_list_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);break;
		case 8:ds_list_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);break;
		case 9:ds_list_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);break;
		case 10:ds_list_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);break;
		case 11:ds_list_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);break;
		case 12:ds_list_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);break;
		case 13:ds_list_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);break;
		case 14:ds_list_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);break;
		case 15:ds_list_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);break;
		case 16:ds_list_add(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15]);break;
		default:gml_thread_error("ds_list_add takes at most 17 arguments, got "+string(argument_count));
	}
}

#define __lnc__f811
if (live_enabled) {
	ds_list_insert(argument[0],argument[1],argument[2]);
}

#define __lnc__f812
if (live_enabled) {
	ds_list_replace(argument[0],argument[1],argument[2]);
}

#define __lnc__f813
if (live_enabled) {
	ds_list_delete(argument[0],argument[1]);
}

#define __lnc__f814
if (live_enabled) {
	return ds_list_find_index(argument[0],argument[1]);
} else return undefined;

#define __lnc__f815
if (live_enabled) {
	return ds_list_find_value(argument[0],argument[1]);
} else return undefined;

#define __lnc__f816
if (live_enabled) {
	ds_list_mark_as_list(argument[0],argument[1]);
}

#define __lnc__f817
if (live_enabled) {
	ds_list_mark_as_map(argument[0],argument[1]);
}

#define __lnc__f818
if (live_enabled) {
	ds_list_sort(argument[0],argument[1]);
}

#define __lnc__f819
if (live_enabled) {
	ds_list_shuffle(argument[0]);
}

#define __lnc__f820
if (live_enabled) {
	return ds_list_write(argument[0]);
} else return undefined;

#define __lnc__f821
if (live_enabled) {
	if(argument_count<2){
		return gml_thread_error("ds_list_read needs at least 2 arguments, got "+string(argument_count));
	} else switch(argument_count){
		case 2:return ds_list_read(argument[0],argument[1]);
		case 3:return ds_list_read(argument[0],argument[1],argument[2]);
		default:return gml_thread_error("ds_list_read takes at most 3 arguments, got "+string(argument_count));
	}
} else return undefined;

#define __lnc__f822
if (live_enabled) {
	ds_list_set(argument[0],argument[1],argument[2]);
}

#define __lnc__f823
if (live_enabled) {
	return ds_map_create();
} else return undefined;

#define __lnc__f824
if (live_enabled) {
	ds_map_destroy(argument[0]);
}

#define __lnc__f825
if (live_enabled) {
	ds_map_clear(argument[0]);
}

#define __lnc__f826
if (live_enabled) {
	ds_map_copy(argument[0],argument[1]);
}

#define __lnc__f827
if (live_enabled) {
	return ds_map_size(argument[0]);
} else return undefined;

#define __lnc__f828
if (live_enabled) {
	return ds_map_empty(argument[0]);
} else return undefined;

#define __lnc__f829
if (live_enabled) {
	ds_map_add(argument[0],argument[1],argument[2]);
}

#define __lnc__f830
if (live_enabled) {
	ds_map_add_list(argument[0],argument[1],argument[2]);
}

#define __lnc__f831
if (live_enabled) {
	ds_map_add_map(argument[0],argument[1],argument[2]);
}

#define __lnc__f832
if (live_enabled) {
	ds_map_replace(argument[0],argument[1],argument[2]);
}

#define __lnc__f833
if (live_enabled) {
	ds_map_replace_map(argument[0],argument[1],argument[2]);
}

#define __lnc__f834
if (live_enabled) {
	ds_map_replace_list(argument[0],argument[1],argument[2]);
}

#define __lnc__f835
if (live_enabled) {
	ds_map_delete(argument[0],argument[1]);
}

#define __lnc__f836
if (live_enabled) {
	return ds_map_exists(argument[0],argument[1]);
} else return undefined;

#define __lnc__f837
if (live_enabled) {
	return ds_map_find_value(argument[0],argument[1]);
} else return undefined;

#define __lnc__f838
if (live_enabled) {
	return ds_map_find_previous(argument[0],argument[1]);
} else return undefined;

#define __lnc__f839
if (live_enabled) {
	return ds_map_find_next(argument[0],argument[1]);
} else return undefined;

#define __lnc__f840
if (live_enabled) {
	return ds_map_find_first(argument[0]);
} else return undefined;

#define __lnc__f841
if (live_enabled) {
	return ds_map_find_last(argument[0]);
} else return undefined;

#define __lnc__f842
if (live_enabled) {
	return ds_map_write(argument[0]);
} else return undefined;

#define __lnc__f843
if (live_enabled) {
	if(argument_count<2){
		return gml_thread_error("ds_map_read needs at least 2 arguments, got "+string(argument_count));
	} else switch(argument_count){
		case 2:return ds_map_read(argument[0],argument[1]);
		case 3:return ds_map_read(argument[0],argument[1],argument[2]);
		default:return gml_thread_error("ds_map_read takes at most 3 arguments, got "+string(argument_count));
	}
} else return undefined;

#define __lnc__f844
if (live_enabled) {
	ds_map_secure_save(argument[0],argument[1]);
}

#define __lnc__f845
if (live_enabled) {
	return ds_map_secure_load(argument[0]);
} else return undefined;

#define __lnc__f846
if (live_enabled) {
	return ds_map_secure_load_buffer(argument[0]);
} else return undefined;

#define __lnc__f847
if (live_enabled) {
	ds_map_secure_save_buffer(argument[0],argument[1]);
}

#define __lnc__f848
if (live_enabled) {
	ds_map_set(argument[0],argument[1],argument[2]);
}

#define __lnc__f849
if (live_enabled) {
	return ds_priority_create();
} else return undefined;

#define __lnc__f850
if (live_enabled) {
	ds_priority_destroy(argument[0]);
}

#define __lnc__f851
if (live_enabled) {
	ds_priority_clear(argument[0]);
}

#define __lnc__f852
if (live_enabled) {
	ds_priority_copy(argument[0],argument[1]);
}

#define __lnc__f853
if (live_enabled) {
	return ds_priority_size(argument[0]);
} else return undefined;

#define __lnc__f854
if (live_enabled) {
	return ds_priority_empty(argument[0]);
} else return undefined;

#define __lnc__f855
if (live_enabled) {
	ds_priority_add(argument[0],argument[1],argument[2]);
}

#define __lnc__f856
if (live_enabled) {
	ds_priority_change_priority(argument[0],argument[1],argument[2]);
}

#define __lnc__f857
if (live_enabled) {
	return ds_priority_find_priority(argument[0],argument[1]);
} else return undefined;

#define __lnc__f858
if (live_enabled) {
	ds_priority_delete_value(argument[0],argument[1]);
}

#define __lnc__f859
if (live_enabled) {
	return ds_priority_delete_min(argument[0]);
} else return undefined;

#define __lnc__f860
if (live_enabled) {
	return ds_priority_find_min(argument[0]);
} else return undefined;

#define __lnc__f861
if (live_enabled) {
	return ds_priority_delete_max(argument[0]);
} else return undefined;

#define __lnc__f862
if (live_enabled) {
	return ds_priority_find_max(argument[0]);
} else return undefined;

#define __lnc__f863
if (live_enabled) {
	return ds_priority_write(argument[0]);
} else return undefined;

#define __lnc__f864
if (live_enabled) {
	if(argument_count<2){
		return gml_thread_error("ds_priority_read needs at least 2 arguments, got "+string(argument_count));
	} else switch(argument_count){
		case 2:return ds_priority_read(argument[0],argument[1]);
		case 3:return ds_priority_read(argument[0],argument[1],argument[2]);
		default:return gml_thread_error("ds_priority_read takes at most 3 arguments, got "+string(argument_count));
	}
} else return undefined;

#define __lnc__f865
if (live_enabled) {
	return ds_grid_create(argument[0],argument[1]);
} else return undefined;

#define __lnc__f866
if (live_enabled) {
	ds_grid_destroy(argument[0]);
}

#define __lnc__f867
if (live_enabled) {
	ds_grid_copy(argument[0],argument[1]);
}

#define __lnc__f868
if (live_enabled) {
	ds_grid_resize(argument[0],argument[1],argument[2]);
}

#define __lnc__f869
if (live_enabled) {
	return ds_grid_width(argument[0]);
} else return undefined;

#define __lnc__f870
if (live_enabled) {
	return ds_grid_height(argument[0]);
} else return undefined;

#define __lnc__f871
if (live_enabled) {
	ds_grid_clear(argument[0],argument[1]);
}

#define __lnc__f872
if (live_enabled) {
	ds_grid_set(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f873
if (live_enabled) {
	ds_grid_add(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f874
if (live_enabled) {
	ds_grid_multiply(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f875
if (live_enabled) {
	ds_grid_set_region(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f876
if (live_enabled) {
	ds_grid_add_region(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f877
if (live_enabled) {
	ds_grid_multiply_region(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f878
if (live_enabled) {
	ds_grid_set_disk(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f879
if (live_enabled) {
	ds_grid_add_disk(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f880
if (live_enabled) {
	ds_grid_multiply_disk(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f881
if (live_enabled) {
	ds_grid_set_grid_region(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
}

#define __lnc__f882
if (live_enabled) {
	ds_grid_add_grid_region(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
}

#define __lnc__f883
if (live_enabled) {
	ds_grid_multiply_grid_region(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
}

#define __lnc__f884
if (live_enabled) {
	return ds_grid_get(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f885
if (live_enabled) {
	return ds_grid_get_sum(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f886
if (live_enabled) {
	return ds_grid_get_max(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f887
if (live_enabled) {
	return ds_grid_get_min(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f888
if (live_enabled) {
	return ds_grid_get_mean(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f889
if (live_enabled) {
	return ds_grid_get_disk_sum(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f890
if (live_enabled) {
	return ds_grid_get_disk_min(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f891
if (live_enabled) {
	return ds_grid_get_disk_max(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f892
if (live_enabled) {
	return ds_grid_get_disk_mean(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f893
if (live_enabled) {
	return ds_grid_value_exists(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f894
if (live_enabled) {
	return ds_grid_value_x(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f895
if (live_enabled) {
	return ds_grid_value_y(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f896
if (live_enabled) {
	return ds_grid_value_disk_exists(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f897
if (live_enabled) {
	return ds_grid_value_disk_x(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f898
if (live_enabled) {
	return ds_grid_value_disk_y(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f899
if (live_enabled) {
	ds_grid_shuffle(argument[0]);
}

#define __lnc__f900
if (live_enabled) {
	return ds_grid_write(argument[0]);
} else return undefined;

#define __lnc__f901
if (live_enabled) {
	if(argument_count<2){
		return gml_thread_error("ds_grid_read needs at least 2 arguments, got "+string(argument_count));
	} else switch(argument_count){
		case 2:return ds_grid_read(argument[0],argument[1]);
		case 3:return ds_grid_read(argument[0],argument[1],argument[2]);
		default:return gml_thread_error("ds_grid_read takes at most 3 arguments, got "+string(argument_count));
	}
} else return undefined;

#define __lnc__f902
if (live_enabled) {
	ds_grid_sort(argument[0],argument[1],argument[2]);
}

#define __lnc__f903
if (live_enabled) {
	return effect_create_below(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f904
if (live_enabled) {
	return effect_create_above(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f905
if (live_enabled) {
	effect_clear();
}

#define __lnc__f906
if (live_enabled) {
	return part_type_create();
} else return undefined;

#define __lnc__f907
if (live_enabled) {
	part_type_destroy(argument[0]);
}

#define __lnc__f908
if (live_enabled) {
	return part_type_exists(argument[0]);
} else return undefined;

#define __lnc__f909
if (live_enabled) {
	part_type_clear(argument[0]);
}

#define __lnc__f910
if (live_enabled) {
	part_type_shape(argument[0],argument[1]);
}

#define __lnc__f911
if (live_enabled) {
	part_type_sprite(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f912
if (live_enabled) {
	return part_type_size(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f913
if (live_enabled) {
	part_type_scale(argument[0],argument[1],argument[2]);
}

#define __lnc__f914
if (live_enabled) {
	part_type_orientation(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f915
if (live_enabled) {
	part_type_life(argument[0],argument[1],argument[2]);
}

#define __lnc__f916
if (live_enabled) {
	part_type_step(argument[0],argument[1],argument[2]);
}

#define __lnc__f917
if (live_enabled) {
	part_type_death(argument[0],argument[1],argument[2]);
}

#define __lnc__f918
if (live_enabled) {
	part_type_speed(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f919
if (live_enabled) {
	part_type_direction(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f920
if (live_enabled) {
	part_type_gravity(argument[0],argument[1],argument[2]);
}

#define __lnc__f921
if (live_enabled) {
	part_type_colour1(argument[0],argument[1]);
}

#define __lnc__f922
if (live_enabled) {
	part_type_colour2(argument[0],argument[1],argument[2]);
}

#define __lnc__f923
if (live_enabled) {
	part_type_colour3(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f924
if (live_enabled) {
	part_type_colour_mix(argument[0],argument[1],argument[2]);
}

#define __lnc__f925
if (live_enabled) {
	part_type_colour_rgb(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f926
if (live_enabled) {
	part_type_colour_hsv(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f927
if (live_enabled) {
	part_type_color1(argument[0],argument[1]);
}

#define __lnc__f928
if (live_enabled) {
	part_type_color2(argument[0],argument[1],argument[2]);
}

#define __lnc__f929
if (live_enabled) {
	part_type_color3(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f930
if (live_enabled) {
	part_type_color_mix(argument[0],argument[1],argument[2]);
}

#define __lnc__f931
if (live_enabled) {
	part_type_color_rgb(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f932
if (live_enabled) {
	part_type_color_hsv(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f933
if (live_enabled) {
	part_type_alpha1(argument[0],argument[1]);
}

#define __lnc__f934
if (live_enabled) {
	part_type_alpha2(argument[0],argument[1],argument[2]);
}

#define __lnc__f935
if (live_enabled) {
	part_type_alpha3(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f936
if (live_enabled) {
	part_type_blend(argument[0],argument[1]);
}

#define __lnc__f937
if (live_enabled) {
	return part_system_create();
} else return undefined;

#define __lnc__f938
if (live_enabled) {
	return part_system_create_layer(argument[0],argument[1]);
} else return undefined;

#define __lnc__f939
if (live_enabled) {
	part_system_destroy(argument[0]);
}

#define __lnc__f940
if (live_enabled) {
	return part_system_exists(argument[0]);
} else return undefined;

#define __lnc__f941
if (live_enabled) {
	part_system_clear(argument[0]);
}

#define __lnc__f942
if (live_enabled) {
	part_system_draw_order(argument[0],argument[1]);
}

#define __lnc__f943
if (live_enabled) {
	part_system_depth(argument[0],argument[1]);
}

#define __lnc__f944
if (live_enabled) {
	part_system_position(argument[0],argument[1],argument[2]);
}

#define __lnc__f945
if (live_enabled) {
	part_system_automatic_update(argument[0],argument[1]);
}

#define __lnc__f946
if (live_enabled) {
	part_system_automatic_draw(argument[0],argument[1]);
}

#define __lnc__f947
if (live_enabled) {
	part_system_update(argument[0]);
}

#define __lnc__f948
if (live_enabled) {
	part_system_drawit(argument[0]);
}

#define __lnc__f949
if (live_enabled) {
	return part_system_get_layer(argument[0]);
} else return undefined;

#define __lnc__f950
if (live_enabled) {
	part_system_layer(argument[0],argument[1]);
}

#define __lnc__f951
if (live_enabled) {
	return part_particles_create(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f952
if (live_enabled) {
	return part_particles_create_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f953
if (live_enabled) {
	return part_particles_create_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f954
if (live_enabled) {
	part_particles_clear(argument[0]);
}

#define __lnc__f955
if (live_enabled) {
	part_particles_count(argument[0]);
}

#define __lnc__f956
if (live_enabled) {
	return part_emitter_create(argument[0]);
} else return undefined;

#define __lnc__f957
if (live_enabled) {
	part_emitter_destroy(argument[0],argument[1]);
}

#define __lnc__f958
if (live_enabled) {
	part_emitter_destroy_all(argument[0]);
}

#define __lnc__f959
if (live_enabled) {
	return part_emitter_exists(argument[0],argument[1]);
} else return undefined;

#define __lnc__f960
if (live_enabled) {
	part_emitter_clear(argument[0],argument[1]);
}

#define __lnc__f961
if (live_enabled) {
	part_emitter_region(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
}

#define __lnc__f962
if (live_enabled) {
	part_emitter_burst(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f963
if (live_enabled) {
	part_emitter_stream(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f964
if (live_enabled) {
	return window_handle();
} else return undefined;

#define __lnc__f965
if (live_enabled) {
	return window_device();
} else return undefined;

#define __lnc__f966
if (live_enabled) {
	return matrix_get(argument[0]);
} else return undefined;

#define __lnc__f967
if (live_enabled) {
	matrix_set(argument[0],argument[1]);
}

#define __lnc__f968
if (live_enabled) {
	return matrix_build_identity();
} else return undefined;

#define __lnc__f969
if (live_enabled) {
	return matrix_build(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
} else return undefined;

#define __lnc__f970
if (live_enabled) {
	return matrix_build_lookat(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
} else return undefined;

#define __lnc__f971
if (live_enabled) {
	return matrix_build_projection_ortho(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f972
if (live_enabled) {
	return matrix_build_projection_perspective(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f973
if (live_enabled) {
	return matrix_build_projection_perspective_fov(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f974
if (live_enabled) {
	return matrix_multiply(argument[0],argument[1]);
} else return undefined;

#define __lnc__f975
if (live_enabled) {
	return matrix_transform_vertex(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f976
if (live_enabled) {
	switch(argument_count){
		case 0:matrix_stack_push();break;
		case 1:matrix_stack_push(argument[0]);break;
		case 2:matrix_stack_push(argument[0],argument[1]);break;
		case 3:matrix_stack_push(argument[0],argument[1],argument[2]);break;
		case 4:matrix_stack_push(argument[0],argument[1],argument[2],argument[3]);break;
		case 5:matrix_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4]);break;
		case 6:matrix_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);break;
		case 7:matrix_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);break;
		case 8:matrix_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);break;
		case 9:matrix_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);break;
		case 10:matrix_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);break;
		case 11:matrix_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);break;
		case 12:matrix_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);break;
		case 13:matrix_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);break;
		case 14:matrix_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);break;
		case 15:matrix_stack_push(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);break;
		default:gml_thread_error("matrix_stack_push takes at most 16 arguments, got "+string(argument_count));
	}
}

#define __lnc__f977
if (live_enabled) {
	return matrix_stack_pop();
} else return undefined;

#define __lnc__f978
if (live_enabled) {
	matrix_stack_set(argument[0]);
}

#define __lnc__f979
if (live_enabled) {
	matrix_stack_clear();
}

#define __lnc__f980
if (live_enabled) {
	return matrix_stack_top();
} else return undefined;

#define __lnc__f981
if (live_enabled) {
	return matrix_stack_is_empty();
} else return undefined;

#define __lnc__f982
if (live_enabled) {
	browser_input_capture(argument[0]);
}

#define __lnc__f983
if (live_enabled) {
	return os_get_config();
} else return undefined;

#define __lnc__f984
if (live_enabled) {
	return os_get_info();
} else return undefined;

#define __lnc__f985
if (live_enabled) {
	return os_get_language();
} else return undefined;

#define __lnc__f986
if (live_enabled) {
	return os_get_region();
} else return undefined;

#define __lnc__f987
if (live_enabled) {
	os_check_permission(argument[0]);
}

#define __lnc__f988
if (live_enabled) {
	os_request_permission(argument[0]);
}

#define __lnc__f989
if (live_enabled) {
	os_lock_orientation(argument[0]);
}

#define __lnc__f990
if (live_enabled) {
	return display_get_dpi_x();
} else return undefined;

#define __lnc__f991
if (live_enabled) {
	return display_get_dpi_y();
} else return undefined;

#define __lnc__f992
if (live_enabled) {
	display_set_gui_size(argument[0],argument[1]);
}

#define __lnc__f993
if (live_enabled) {
	if(argument_count<4){
		gml_thread_error("display_set_gui_maximise needs at least 4 arguments, got "+string(argument_count));
		return 0;
	} else switch(argument_count){
		case 4:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3]);break;
		case 5:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4]);break;
		case 6:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);break;
		case 7:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);break;
		case 8:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);break;
		case 9:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);break;
		case 10:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);break;
		case 11:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);break;
		case 12:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);break;
		case 13:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);break;
		case 14:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);break;
		case 15:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);break;
		case 16:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15]);break;
		case 17:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16]);break;
		case 18:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16],argument[17]);break;
		case 19:display_set_gui_maximise(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16],argument[17],argument[18]);break;
		default:gml_thread_error("display_set_gui_maximise takes at most 20 arguments, got "+string(argument_count));
	}
}

#define __lnc__f994
if (live_enabled) {
	if(argument_count<4){
		gml_thread_error("display_set_gui_maximize needs at least 4 arguments, got "+string(argument_count));
		return 0;
	} else switch(argument_count){
		case 4:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3]);break;
		case 5:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4]);break;
		case 6:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);break;
		case 7:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);break;
		case 8:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);break;
		case 9:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);break;
		case 10:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);break;
		case 11:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);break;
		case 12:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);break;
		case 13:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);break;
		case 14:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);break;
		case 15:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);break;
		case 16:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15]);break;
		case 17:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16]);break;
		case 18:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16],argument[17]);break;
		case 19:display_set_gui_maximize(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16],argument[17],argument[18]);break;
		default:gml_thread_error("display_set_gui_maximize takes at most 20 arguments, got "+string(argument_count));
	}
}

#define __lnc__f995
if (live_enabled) {
	device_mouse_dbclick_enable(argument[0]);
}

#define __lnc__f996
if (live_enabled) {
	display_set_timing_method(argument[0]);
}

#define __lnc__f997
if (live_enabled) {
	return display_get_timing_method();
} else return undefined;

#define __lnc__f998
if (live_enabled) {
	display_set_sleep_margin(argument[0]);
}

#define __lnc__f999
if (live_enabled) {
	return display_get_sleep_margin();
} else return undefined;

#define __lnc__f1000
if (live_enabled) {
	virtual_key_add(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f1001
if (live_enabled) {
	virtual_key_hide(argument[0]);
}

#define __lnc__f1002
if (live_enabled) {
	virtual_key_delete(argument[0]);
}

#define __lnc__f1003
if (live_enabled) {
	virtual_key_show(argument[0]);
}

#define __lnc__f1004
if (live_enabled) {
	draw_enable_drawevent(argument[0]);
}

#define __lnc__f1005
if (live_enabled) {
	draw_texture_flush();
}

#define __lnc__f1006
if (live_enabled) {
	draw_flush();
}

#define __lnc__f1007
if (live_enabled) {
	gpu_set_blendenable(argument[0]);
}

#define __lnc__f1008
if (live_enabled) {
	gpu_set_ztestenable(argument[0]);
}

#define __lnc__f1009
if (live_enabled) {
	gpu_set_zfunc(argument[0]);
}

#define __lnc__f1010
if (live_enabled) {
	gpu_set_zwriteenable(argument[0]);
}

#define __lnc__f1011
if (live_enabled) {
	if(argument_count<1){
		gml_thread_error("gpu_set_fog needs at least 1 arguments, got "+string(argument_count));
		return 0;
	} else switch(argument_count){
		case 1:gpu_set_fog(argument[0]);break;
		case 2:gpu_set_fog(argument[0],argument[1]);break;
		case 3:gpu_set_fog(argument[0],argument[1],argument[2]);break;
		case 4:gpu_set_fog(argument[0],argument[1],argument[2],argument[3]);break;
		default:gml_thread_error("gpu_set_fog takes at most 4 arguments, got "+string(argument_count));
	}
}

#define __lnc__f1012
if (live_enabled) {
	gpu_set_cullmode(argument[0]);
}

#define __lnc__f1013
if (live_enabled) {
	gpu_set_blendmode(argument[0]);
}

#define __lnc__f1014
if (live_enabled) {
	gpu_set_blendmode_ext(argument[0],argument[1]);
}

#define __lnc__f1015
if (live_enabled) {
	gpu_set_blendmode_ext_sepalpha(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1016
if (live_enabled) {
	gpu_set_colorwriteenable(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1017
if (live_enabled) {
	gpu_set_colourwriteenable(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1018
if (live_enabled) {
	gpu_set_alphatestenable(argument[0]);
}

#define __lnc__f1019
if (live_enabled) {
	gpu_set_alphatestref(argument[0]);
}

#define __lnc__f1020
if (live_enabled) {
	gpu_set_alphatestfunc(argument[0]);
}

#define __lnc__f1021
if (live_enabled) {
	gpu_set_texfilter(argument[0]);
}

#define __lnc__f1022
if (live_enabled) {
	gpu_set_texfilter_ext(argument[0],argument[1]);
}

#define __lnc__f1023
if (live_enabled) {
	gpu_set_texrepeat(argument[0]);
}

#define __lnc__f1024
if (live_enabled) {
	gpu_set_texrepeat_ext(argument[0],argument[1]);
}

#define __lnc__f1025
if (live_enabled) {
	gpu_set_tex_filter(argument[0]);
}

#define __lnc__f1026
if (live_enabled) {
	gpu_set_tex_filter_ext(argument[0],argument[1]);
}

#define __lnc__f1027
if (live_enabled) {
	gpu_set_tex_repeat(argument[0]);
}

#define __lnc__f1028
if (live_enabled) {
	gpu_set_tex_repeat_ext(argument[0],argument[1]);
}

#define __lnc__f1029
if (live_enabled) {
	gpu_set_tex_mip_filter(argument[0]);
}

#define __lnc__f1030
if (live_enabled) {
	gpu_set_tex_mip_filter_ext(argument[0],argument[1]);
}

#define __lnc__f1031
if (live_enabled) {
	gpu_set_tex_mip_bias(argument[0]);
}

#define __lnc__f1032
if (live_enabled) {
	gpu_set_tex_mip_bias_ext(argument[0],argument[1]);
}

#define __lnc__f1033
if (live_enabled) {
	gpu_set_tex_min_mip(argument[0]);
}

#define __lnc__f1034
if (live_enabled) {
	gpu_set_tex_min_mip_ext(argument[0],argument[1]);
}

#define __lnc__f1035
if (live_enabled) {
	gpu_set_tex_max_mip(argument[0]);
}

#define __lnc__f1036
if (live_enabled) {
	gpu_set_tex_max_mip_ext(argument[0],argument[1]);
}

#define __lnc__f1037
if (live_enabled) {
	gpu_set_tex_max_aniso(argument[0]);
}

#define __lnc__f1038
if (live_enabled) {
	gpu_set_tex_max_aniso_ext(argument[0],argument[1]);
}

#define __lnc__f1039
if (live_enabled) {
	gpu_set_tex_mip_enable(argument[0]);
}

#define __lnc__f1040
if (live_enabled) {
	gpu_set_tex_mip_enable_ext(argument[0],argument[1]);
}

#define __lnc__f1041
if (live_enabled) {
	return gpu_get_blendenable();
} else return undefined;

#define __lnc__f1042
if (live_enabled) {
	return gpu_get_ztestenable();
} else return undefined;

#define __lnc__f1043
if (live_enabled) {
	return gpu_get_zfunc();
} else return undefined;

#define __lnc__f1044
if (live_enabled) {
	return gpu_get_zwriteenable();
} else return undefined;

#define __lnc__f1045
if (live_enabled) {
	return gpu_get_fog();
} else return undefined;

#define __lnc__f1046
if (live_enabled) {
	return gpu_get_cullmode();
} else return undefined;

#define __lnc__f1047
if (live_enabled) {
	return gpu_get_blendmode();
} else return undefined;

#define __lnc__f1048
if (live_enabled) {
	return gpu_get_blendmode_ext();
} else return undefined;

#define __lnc__f1049
if (live_enabled) {
	return gpu_get_blendmode_ext_sepalpha();
} else return undefined;

#define __lnc__f1050
if (live_enabled) {
	return gpu_get_blendmode_src();
} else return undefined;

#define __lnc__f1051
if (live_enabled) {
	return gpu_get_blendmode_dest();
} else return undefined;

#define __lnc__f1052
if (live_enabled) {
	return gpu_get_blendmode_srcalpha();
} else return undefined;

#define __lnc__f1053
if (live_enabled) {
	return gpu_get_blendmode_destalpha();
} else return undefined;

#define __lnc__f1054
if (live_enabled) {
	return gpu_get_colorwriteenable();
} else return undefined;

#define __lnc__f1055
if (live_enabled) {
	return gpu_get_colourwriteenable();
} else return undefined;

#define __lnc__f1056
if (live_enabled) {
	return gpu_get_alphatestenable();
} else return undefined;

#define __lnc__f1057
if (live_enabled) {
	return gpu_get_alphatestref();
} else return undefined;

#define __lnc__f1058
if (live_enabled) {
	return gpu_get_alphatestfunc();
} else return undefined;

#define __lnc__f1059
if (live_enabled) {
	return gpu_get_texfilter();
} else return undefined;

#define __lnc__f1060
if (live_enabled) {
	return gpu_get_texfilter_ext(argument[0]);
} else return undefined;

#define __lnc__f1061
if (live_enabled) {
	return gpu_get_texrepeat();
} else return undefined;

#define __lnc__f1062
if (live_enabled) {
	return gpu_get_texrepeat_ext(argument[0]);
} else return undefined;

#define __lnc__f1063
if (live_enabled) {
	return gpu_get_tex_filter();
} else return undefined;

#define __lnc__f1064
if (live_enabled) {
	return gpu_get_tex_filter_ext(argument[0]);
} else return undefined;

#define __lnc__f1065
if (live_enabled) {
	return gpu_get_tex_repeat();
} else return undefined;

#define __lnc__f1066
if (live_enabled) {
	return gpu_get_tex_repeat_ext(argument[0]);
} else return undefined;

#define __lnc__f1067
if (live_enabled) {
	return gpu_get_tex_mip_filter();
} else return undefined;

#define __lnc__f1068
if (live_enabled) {
	return gpu_get_tex_mip_filter_ext(argument[0]);
} else return undefined;

#define __lnc__f1069
if (live_enabled) {
	return gpu_get_tex_mip_bias();
} else return undefined;

#define __lnc__f1070
if (live_enabled) {
	return gpu_get_tex_mip_bias_ext(argument[0]);
} else return undefined;

#define __lnc__f1071
if (live_enabled) {
	return gpu_get_tex_min_mip();
} else return undefined;

#define __lnc__f1072
if (live_enabled) {
	return gpu_get_tex_min_mip_ext(argument[0]);
} else return undefined;

#define __lnc__f1073
if (live_enabled) {
	return gpu_get_tex_max_mip();
} else return undefined;

#define __lnc__f1074
if (live_enabled) {
	return gpu_get_tex_max_mip_ext(argument[0]);
} else return undefined;

#define __lnc__f1075
if (live_enabled) {
	return gpu_get_tex_max_aniso();
} else return undefined;

#define __lnc__f1076
if (live_enabled) {
	return gpu_get_tex_max_aniso_ext(argument[0]);
} else return undefined;

#define __lnc__f1077
if (live_enabled) {
	return gpu_get_tex_mip_enable();
} else return undefined;

#define __lnc__f1078
if (live_enabled) {
	return gpu_get_tex_mip_enable_ext(argument[0]);
} else return undefined;

#define __lnc__f1079
if (live_enabled) {
	gpu_push_state();
}

#define __lnc__f1080
if (live_enabled) {
	gpu_pop_state();
}

#define __lnc__f1081
if (live_enabled) {
	return gpu_get_state();
} else return undefined;

#define __lnc__f1082
if (live_enabled) {
	gpu_set_state(argument[0]);
}

#define __lnc__f1083
if (live_enabled) {
	draw_light_define_ambient(argument[0]);
}

#define __lnc__f1084
if (live_enabled) {
	draw_light_define_direction(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f1085
if (live_enabled) {
	draw_light_define_point(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
}

#define __lnc__f1086
if (live_enabled) {
	draw_light_enable(argument[0],argument[1]);
}

#define __lnc__f1087
if (live_enabled) {
	draw_set_lighting(argument[0]);
}

#define __lnc__f1088
if (live_enabled) {
	return draw_light_get_ambient();
} else return undefined;

#define __lnc__f1089
if (live_enabled) {
	return draw_light_get(argument[0]);
} else return undefined;

#define __lnc__f1090
if (live_enabled) {
	return draw_get_lighting();
} else return undefined;

#define __lnc__f1091
if (live_enabled) {
	shop_leave_rating(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1092
if (live_enabled) {
	return url_get_domain();
} else return undefined;

#define __lnc__f1093
if (live_enabled) {
	url_open(argument[0]);
}

#define __lnc__f1094
if (live_enabled) {
	url_open_ext(argument[0],argument[1]);
}

#define __lnc__f1095
if (live_enabled) {
	url_open_full(argument[0],argument[1],argument[2]);
}

#define __lnc__f1096
if (live_enabled) {
	return get_timer();
} else return undefined;

#define __lnc__f1097
if (live_enabled) {
	return device_get_tilt_x();
} else return undefined;

#define __lnc__f1098
if (live_enabled) {
	return device_get_tilt_y();
} else return undefined;

#define __lnc__f1099
if (live_enabled) {
	return device_get_tilt_z();
} else return undefined;

#define __lnc__f1100
if (live_enabled) {
	return device_is_keypad_open();
} else return undefined;

#define __lnc__f1101
if (live_enabled) {
	return device_mouse_check_button(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1102
if (live_enabled) {
	return device_mouse_check_button_pressed(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1103
if (live_enabled) {
	return device_mouse_check_button_released(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1104
if (live_enabled) {
	return device_mouse_x(argument[0]);
} else return undefined;

#define __lnc__f1105
if (live_enabled) {
	return device_mouse_y(argument[0]);
} else return undefined;

#define __lnc__f1106
if (live_enabled) {
	return device_mouse_raw_x(argument[0]);
} else return undefined;

#define __lnc__f1107
if (live_enabled) {
	return device_mouse_raw_y(argument[0]);
} else return undefined;

#define __lnc__f1108
if (live_enabled) {
	return device_mouse_x_to_gui(argument[0]);
} else return undefined;

#define __lnc__f1109
if (live_enabled) {
	return device_mouse_y_to_gui(argument[0]);
} else return undefined;

#define __lnc__f1110
if (live_enabled) {
	return gamepad_is_supported();
} else return undefined;

#define __lnc__f1111
if (live_enabled) {
	return gamepad_get_device_count();
} else return undefined;

#define __lnc__f1112
if (live_enabled) {
	return gamepad_is_connected(argument[0]);
} else return undefined;

#define __lnc__f1113
if (live_enabled) {
	return gamepad_get_description(argument[0]);
} else return undefined;

#define __lnc__f1114
if (live_enabled) {
	return gamepad_get_button_threshold(argument[0]);
} else return undefined;

#define __lnc__f1115
if (live_enabled) {
	gamepad_set_button_threshold(argument[0],argument[1]);
}

#define __lnc__f1116
if (live_enabled) {
	return gamepad_get_axis_deadzone(argument[0]);
} else return undefined;

#define __lnc__f1117
if (live_enabled) {
	gamepad_set_axis_deadzone(argument[0],argument[1]);
}

#define __lnc__f1118
if (live_enabled) {
	return gamepad_button_count(argument[0]);
} else return undefined;

#define __lnc__f1119
if (live_enabled) {
	return gamepad_button_check(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1120
if (live_enabled) {
	return gamepad_button_check_pressed(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1121
if (live_enabled) {
	return gamepad_button_check_released(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1122
if (live_enabled) {
	return gamepad_button_value(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1123
if (live_enabled) {
	return gamepad_axis_count(argument[0]);
} else return undefined;

#define __lnc__f1124
if (live_enabled) {
	return gamepad_axis_value(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1125
if (live_enabled) {
	gamepad_set_vibration(argument[0],argument[1],argument[2]);
}

#define __lnc__f1126
if (live_enabled) {
	gamepad_set_colour(argument[0],argument[1]);
}

#define __lnc__f1127
if (live_enabled) {
	gamepad_set_color(argument[0],argument[1]);
}

#define __lnc__f1128
if (live_enabled) {
	gamepad_hat_count(argument[0]);
}

#define __lnc__f1129
if (live_enabled) {
	gamepad_hat_value(argument[0],argument[1]);
}

#define __lnc__f1130
if (live_enabled) {
	gamepad_remove_mapping(argument[0]);
}

#define __lnc__f1131
if (live_enabled) {
	gamepad_test_mapping(argument[0],argument[1]);
}

#define __lnc__f1132
if (live_enabled) {
	return gamepad_get_mapping(argument[0]);
} else return undefined;

#define __lnc__f1133
if (live_enabled) {
	return gamepad_get_guid(argument[0]);
} else return undefined;

#define __lnc__f1134
if (live_enabled) {
	gamepad_set_option(argument[0],argument[1],argument[2]);
}

#define __lnc__f1135
if (live_enabled) {
	return gamepad_get_option(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1136
if (live_enabled) {
	return os_is_paused();
} else return undefined;

#define __lnc__f1137
if (live_enabled) {
	return window_has_focus();
} else return undefined;

#define __lnc__f1138
if (live_enabled) {
	return code_is_compiled();
} else return undefined;

#define __lnc__f1139
if (live_enabled) {
	return http_get(argument[0]);
} else return undefined;

#define __lnc__f1140
if (live_enabled) {
	return http_get_file(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1141
if (live_enabled) {
	return http_post_string(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1142
if (live_enabled) {
	return http_request(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f1143
if (live_enabled) {
	return http_get_request_crossorigin();
} else return undefined;

#define __lnc__f1144
if (live_enabled) {
	http_set_request_crossorigin(argument[0]);
}

#define __lnc__f1145
if (live_enabled) {
	return json_encode(argument[0]);
} else return undefined;

#define __lnc__f1146
if (live_enabled) {
	return json_decode(argument[0]);
} else return undefined;

#define __lnc__f1147
if (live_enabled) {
	zip_unzip(argument[0],argument[1]);
}

#define __lnc__f1148
if (live_enabled) {
	return load_csv(argument[0]);
} else return undefined;

#define __lnc__f1149
if (live_enabled) {
	return base64_encode(argument[0]);
} else return undefined;

#define __lnc__f1150
if (live_enabled) {
	return base64_decode(argument[0]);
} else return undefined;

#define __lnc__f1151
if (live_enabled) {
	return md5_string_unicode(argument[0]);
} else return undefined;

#define __lnc__f1152
if (live_enabled) {
	return md5_string_utf8(argument[0]);
} else return undefined;

#define __lnc__f1153
if (live_enabled) {
	return md5_file(argument[0]);
} else return undefined;

#define __lnc__f1154
if (live_enabled) {
	return os_is_network_connected();
} else return undefined;

#define __lnc__f1155
if (live_enabled) {
	return sha1_string_unicode(argument[0]);
} else return undefined;

#define __lnc__f1156
if (live_enabled) {
	return sha1_string_utf8(argument[0]);
} else return undefined;

#define __lnc__f1157
if (live_enabled) {
	return sha1_file(argument[0]);
} else return undefined;

#define __lnc__f1158
if (live_enabled) {
	os_powersave_enable(argument[0]);
}

#define __lnc__f1159
if (live_enabled) {
	uwp_livetile_tile_clear();
}

#define __lnc__f1160
if (live_enabled) {
	uwp_livetile_badge_notification(argument[0]);
}

#define __lnc__f1161
if (live_enabled) {
	uwp_livetile_badge_clear();
}

#define __lnc__f1162
if (live_enabled) {
	uwp_livetile_queue_enable(argument[0]);
}

#define __lnc__f1163
if (live_enabled) {
	uwp_secondarytile_pin(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
}

#define __lnc__f1164
if (live_enabled) {
	uwp_secondarytile_badge_notification(argument[0],argument[1]);
}

#define __lnc__f1165
if (live_enabled) {
	uwp_secondarytile_delete(argument[0]);
}

#define __lnc__f1166
if (live_enabled) {
	uwp_secondarytile_badge_clear(argument[0]);
}

#define __lnc__f1167
if (live_enabled) {
	uwp_secondarytile_tile_clear(argument[0]);
}

#define __lnc__f1168
if (live_enabled) {
	uwp_livetile_notification_begin(argument[0]);
}

#define __lnc__f1169
if (live_enabled) {
	uwp_livetile_notification_secondary_begin(argument[0],argument[1]);
}

#define __lnc__f1170
if (live_enabled) {
	uwp_livetile_notification_expiry(argument[0]);
}

#define __lnc__f1171
if (live_enabled) {
	uwp_livetile_notification_tag(argument[0]);
}

#define __lnc__f1172
if (live_enabled) {
	uwp_livetile_notification_text_add(argument[0]);
}

#define __lnc__f1173
if (live_enabled) {
	uwp_livetile_notification_image_add(argument[0]);
}

#define __lnc__f1174
if (live_enabled) {
	uwp_livetile_notification_end();
}

#define __lnc__f1175
if (live_enabled) {
	uwp_livetile_notification_template_add(argument[0]);
}

#define __lnc__f1176
if (live_enabled) {
	uwp_appbar_enable(argument[0]);
}

#define __lnc__f1177
if (live_enabled) {
	uwp_appbar_add_element(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
}

#define __lnc__f1178
if (live_enabled) {
	uwp_appbar_remove_element(argument[0]);
}

#define __lnc__f1179
if (live_enabled) {
	uwp_device_touchscreen_available();
}

#define __lnc__f1180
if (live_enabled) {
	return physics_world_create(argument[0]);
} else return undefined;

#define __lnc__f1181
if (live_enabled) {
	physics_world_gravity(argument[0],argument[1]);
}

#define __lnc__f1182
if (live_enabled) {
	physics_world_update_speed(argument[0]);
}

#define __lnc__f1183
if (live_enabled) {
	physics_world_update_iterations(argument[0]);
}

#define __lnc__f1184
if (live_enabled) {
	physics_world_draw_debug(argument[0]);
}

#define __lnc__f1185
if (live_enabled) {
	physics_pause_enable(argument[0]);
}

#define __lnc__f1186
if (live_enabled) {
	return physics_fixture_create();
} else return undefined;

#define __lnc__f1187
if (live_enabled) {
	physics_fixture_set_kinematic(argument[0]);
}

#define __lnc__f1188
if (live_enabled) {
	physics_fixture_set_density(argument[0],argument[1]);
}

#define __lnc__f1189
if (live_enabled) {
	physics_fixture_set_awake(argument[0],argument[1]);
}

#define __lnc__f1190
if (live_enabled) {
	physics_fixture_set_restitution(argument[0],argument[1]);
}

#define __lnc__f1191
if (live_enabled) {
	physics_fixture_set_friction(argument[0],argument[1]);
}

#define __lnc__f1192
if (live_enabled) {
	physics_fixture_set_collision_group(argument[0],argument[1]);
}

#define __lnc__f1193
if (live_enabled) {
	physics_fixture_set_sensor(argument[0],argument[1]);
}

#define __lnc__f1194
if (live_enabled) {
	physics_fixture_set_linear_damping(argument[0],argument[1]);
}

#define __lnc__f1195
if (live_enabled) {
	physics_fixture_set_angular_damping(argument[0],argument[1]);
}

#define __lnc__f1196
if (live_enabled) {
	physics_fixture_set_circle_shape(argument[0],argument[1]);
}

#define __lnc__f1197
if (live_enabled) {
	physics_fixture_set_box_shape(argument[0],argument[1],argument[2]);
}

#define __lnc__f1198
if (live_enabled) {
	physics_fixture_set_edge_shape(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f1199
if (live_enabled) {
	physics_fixture_set_polygon_shape(argument[0]);
}

#define __lnc__f1200
if (live_enabled) {
	physics_fixture_set_chain_shape(argument[0],argument[1]);
}

#define __lnc__f1201
if (live_enabled) {
	physics_fixture_add_point(argument[0],argument[1],argument[2]);
}

#define __lnc__f1202
if (live_enabled) {
	physics_fixture_bind(argument[0],argument[1]);
}

#define __lnc__f1203
if (live_enabled) {
	physics_fixture_bind_ext(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1204
if (live_enabled) {
	physics_fixture_delete(argument[0]);
}

#define __lnc__f1205
if (live_enabled) {
	physics_apply_force(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1206
if (live_enabled) {
	physics_apply_impulse(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1207
if (live_enabled) {
	physics_apply_angular_impulse(argument[0]);
}

#define __lnc__f1208
if (live_enabled) {
	physics_apply_local_force(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1209
if (live_enabled) {
	physics_apply_local_impulse(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1210
if (live_enabled) {
	physics_apply_torque(argument[0]);
}

#define __lnc__f1211
if (live_enabled) {
	physics_mass_properties(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1212
if (live_enabled) {
	physics_draw_debug();
}

#define __lnc__f1213
if (live_enabled) {
	physics_test_overlap(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1214
if (live_enabled) {
	physics_remove_fixture(argument[0],argument[1]);
}

#define __lnc__f1215
if (live_enabled) {
	physics_set_friction(argument[0],argument[1]);
}

#define __lnc__f1216
if (live_enabled) {
	physics_set_density(argument[0],argument[1]);
}

#define __lnc__f1217
if (live_enabled) {
	physics_set_restitution(argument[0],argument[1]);
}

#define __lnc__f1218
if (live_enabled) {
	return physics_get_friction(argument[0]);
} else return undefined;

#define __lnc__f1219
if (live_enabled) {
	return physics_get_density(argument[0]);
} else return undefined;

#define __lnc__f1220
if (live_enabled) {
	return physics_get_restitution(argument[0]);
} else return undefined;

#define __lnc__f1221
if (live_enabled) {
	return physics_joint_distance_create(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
} else return undefined;

#define __lnc__f1222
if (live_enabled) {
	return physics_joint_rope_create(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
} else return undefined;

#define __lnc__f1223
if (live_enabled) {
	return physics_joint_revolute_create(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);
} else return undefined;

#define __lnc__f1224
if (live_enabled) {
	return physics_joint_prismatic_create(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);
} else return undefined;

#define __lnc__f1225
if (live_enabled) {
	return physics_joint_pulley_create(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);
} else return undefined;

#define __lnc__f1226
if (live_enabled) {
	return physics_joint_wheel_create(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);
} else return undefined;

#define __lnc__f1227
if (live_enabled) {
	return physics_joint_weld_create(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
} else return undefined;

#define __lnc__f1228
if (live_enabled) {
	return physics_joint_friction_create(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
} else return undefined;

#define __lnc__f1229
if (live_enabled) {
	return physics_joint_gear_create(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f1230
if (live_enabled) {
	physics_joint_enable_motor(argument[0],argument[1]);
}

#define __lnc__f1231
if (live_enabled) {
	return physics_joint_get_value(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1232
if (live_enabled) {
	physics_joint_set_value(argument[0],argument[1],argument[2]);
}

#define __lnc__f1233
if (live_enabled) {
	physics_joint_delete(argument[0]);
}

#define __lnc__f1234
if (live_enabled) {
	return physics_particle_create(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
} else return undefined;

#define __lnc__f1235
if (live_enabled) {
	physics_particle_delete(argument[0]);
}

#define __lnc__f1236
if (live_enabled) {
	physics_particle_delete_region_circle(argument[0],argument[1],argument[2]);
}

#define __lnc__f1237
if (live_enabled) {
	physics_particle_delete_region_box(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1238
if (live_enabled) {
	physics_particle_delete_region_poly(argument[0]);
}

#define __lnc__f1239
if (live_enabled) {
	physics_particle_set_flags(argument[0],argument[1]);
}

#define __lnc__f1240
if (live_enabled) {
	physics_particle_set_category_flags(argument[0],argument[1]);
}

#define __lnc__f1241
if (live_enabled) {
	physics_particle_draw(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1242
if (live_enabled) {
	physics_particle_draw_ext(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
}

#define __lnc__f1243
if (live_enabled) {
	physics_particle_count();
}

#define __lnc__f1244
if (live_enabled) {
	return physics_particle_get_data(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1245
if (live_enabled) {
	return physics_particle_get_data_particle(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1246
if (live_enabled) {
	physics_particle_group_begin(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);
}

#define __lnc__f1247
if (live_enabled) {
	physics_particle_group_circle(argument[0]);
}

#define __lnc__f1248
if (live_enabled) {
	physics_particle_group_box(argument[0],argument[1]);
}

#define __lnc__f1249
if (live_enabled) {
	physics_particle_group_polygon();
}

#define __lnc__f1250
if (live_enabled) {
	physics_particle_group_add_point(argument[0],argument[1]);
}

#define __lnc__f1251
if (live_enabled) {
	physics_particle_group_end();
}

#define __lnc__f1252
if (live_enabled) {
	physics_particle_group_join(argument[0],argument[1]);
}

#define __lnc__f1253
if (live_enabled) {
	physics_particle_group_delete(argument[0]);
}

#define __lnc__f1254
if (live_enabled) {
	physics_particle_group_count(argument[0]);
}

#define __lnc__f1255
if (live_enabled) {
	return physics_particle_group_get_data(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1256
if (live_enabled) {
	return physics_particle_group_get_mass(argument[0]);
} else return undefined;

#define __lnc__f1257
if (live_enabled) {
	return physics_particle_group_get_inertia(argument[0]);
} else return undefined;

#define __lnc__f1258
if (live_enabled) {
	return physics_particle_group_get_centre_x(argument[0]);
} else return undefined;

#define __lnc__f1259
if (live_enabled) {
	return physics_particle_group_get_centre_y(argument[0]);
} else return undefined;

#define __lnc__f1260
if (live_enabled) {
	return physics_particle_group_get_vel_x(argument[0]);
} else return undefined;

#define __lnc__f1261
if (live_enabled) {
	return physics_particle_group_get_vel_y(argument[0]);
} else return undefined;

#define __lnc__f1262
if (live_enabled) {
	return physics_particle_group_get_ang_vel(argument[0]);
} else return undefined;

#define __lnc__f1263
if (live_enabled) {
	return physics_particle_group_get_x(argument[0]);
} else return undefined;

#define __lnc__f1264
if (live_enabled) {
	return physics_particle_group_get_y(argument[0]);
} else return undefined;

#define __lnc__f1265
if (live_enabled) {
	return physics_particle_group_get_angle(argument[0]);
} else return undefined;

#define __lnc__f1266
if (live_enabled) {
	physics_particle_set_group_flags(argument[0],argument[1]);
}

#define __lnc__f1267
if (live_enabled) {
	return physics_particle_get_group_flags(argument[0]);
} else return undefined;

#define __lnc__f1268
if (live_enabled) {
	return physics_particle_get_max_count();
} else return undefined;

#define __lnc__f1269
if (live_enabled) {
	return physics_particle_get_radius();
} else return undefined;

#define __lnc__f1270
if (live_enabled) {
	return physics_particle_get_density();
} else return undefined;

#define __lnc__f1271
if (live_enabled) {
	return physics_particle_get_damping();
} else return undefined;

#define __lnc__f1272
if (live_enabled) {
	return physics_particle_get_gravity_scale();
} else return undefined;

#define __lnc__f1273
if (live_enabled) {
	physics_particle_set_max_count(argument[0]);
}

#define __lnc__f1274
if (live_enabled) {
	physics_particle_set_radius(argument[0]);
}

#define __lnc__f1275
if (live_enabled) {
	physics_particle_set_density(argument[0]);
}

#define __lnc__f1276
if (live_enabled) {
	physics_particle_set_damping(argument[0]);
}

#define __lnc__f1277
if (live_enabled) {
	physics_particle_set_gravity_scale(argument[0]);
}

#define __lnc__f1278
if (live_enabled) {
	return network_create_socket(argument[0]);
} else return undefined;

#define __lnc__f1279
if (live_enabled) {
	return network_create_socket_ext(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1280
if (live_enabled) {
	return network_create_server(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1281
if (live_enabled) {
	return network_create_server_raw(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1282
if (live_enabled) {
	return network_connect(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1283
if (live_enabled) {
	return network_connect_raw(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1284
if (live_enabled) {
	return network_send_packet(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1285
if (live_enabled) {
	return network_send_raw(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1286
if (live_enabled) {
	return network_send_broadcast(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f1287
if (live_enabled) {
	return network_send_udp(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f1288
if (live_enabled) {
	return network_send_udp_raw(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f1289
if (live_enabled) {
	network_set_timeout(argument[0],argument[1],argument[2]);
}

#define __lnc__f1290
if (live_enabled) {
	network_set_config(argument[0],argument[1]);
}

#define __lnc__f1291
if (live_enabled) {
	return network_resolve(argument[0]);
} else return undefined;

#define __lnc__f1292
if (live_enabled) {
	network_destroy(argument[0]);
}

#define __lnc__f1293
if (live_enabled) {
	return buffer_create(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1294
if (live_enabled) {
	buffer_write(argument[0],argument[1],argument[2]);
}

#define __lnc__f1295
if (live_enabled) {
	return buffer_read(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1296
if (live_enabled) {
	buffer_seek(argument[0],argument[1],argument[2]);
}

#define __lnc__f1297
if (live_enabled) {
	return buffer_get_surface(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f1298
if (live_enabled) {
	buffer_set_surface(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f1299
if (live_enabled) {
	buffer_delete(argument[0]);
}

#define __lnc__f1300
if (live_enabled) {
	return buffer_exists(argument[0]);
} else return undefined;

#define __lnc__f1301
if (live_enabled) {
	return buffer_get_type(argument[0]);
} else return undefined;

#define __lnc__f1302
if (live_enabled) {
	return buffer_get_alignment(argument[0]);
} else return undefined;

#define __lnc__f1303
if (live_enabled) {
	buffer_poke(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1304
if (live_enabled) {
	buffer_peek(argument[0],argument[1],argument[2]);
}

#define __lnc__f1305
if (live_enabled) {
	buffer_save(argument[0],argument[1]);
}

#define __lnc__f1306
if (live_enabled) {
	buffer_save_ext(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1307
if (live_enabled) {
	return buffer_load(argument[0]);
} else return undefined;

#define __lnc__f1308
if (live_enabled) {
	return buffer_load_ext(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1309
if (live_enabled) {
	return buffer_load_partial(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f1310
if (live_enabled) {
	buffer_copy(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f1311
if (live_enabled) {
	buffer_fill(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f1312
if (live_enabled) {
	return buffer_get_size(argument[0]);
} else return undefined;

#define __lnc__f1313
if (live_enabled) {
	return buffer_tell(argument[0]);
} else return undefined;

#define __lnc__f1314
if (live_enabled) {
	buffer_resize(argument[0],argument[1]);
}

#define __lnc__f1315
if (live_enabled) {
	return buffer_md5(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1316
if (live_enabled) {
	return buffer_sha1(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1317
if (live_enabled) {
	return buffer_base64_encode(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1318
if (live_enabled) {
	return buffer_base64_decode(argument[0]);
} else return undefined;

#define __lnc__f1319
if (live_enabled) {
	buffer_base64_decode_ext(argument[0],argument[1],argument[2]);
}

#define __lnc__f1320
if (live_enabled) {
	return buffer_sizeof(argument[0]);
} else return undefined;

#define __lnc__f1321
if (live_enabled) {
	return buffer_get_address(argument[0]);
} else return undefined;

#define __lnc__f1322
if (live_enabled) {
	return buffer_create_from_vertex_buffer(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1323
if (live_enabled) {
	return buffer_create_from_vertex_buffer_ext(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f1324
if (live_enabled) {
	buffer_copy_from_vertex_buffer(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f1325
if (live_enabled) {
	buffer_async_group_begin(argument[0]);
}

#define __lnc__f1326
if (live_enabled) {
	buffer_async_group_option(argument[0],argument[1]);
}

#define __lnc__f1327
if (live_enabled) {
	buffer_async_group_end();
}

#define __lnc__f1328
if (live_enabled) {
	return buffer_load_async(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f1329
if (live_enabled) {
	buffer_save_async(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1330
if (live_enabled) {
	buffer_compress(argument[0],argument[1],argument[2]);
}

#define __lnc__f1331
if (live_enabled) {
	buffer_decompress(argument[0]);
}

#define __lnc__f1332
if (live_enabled) {
	gml_release_mode(argument[0]);
}

#define __lnc__f1333
if (live_enabled) {
	steam_activate_overlay(argument[0]);
}

#define __lnc__f1334
if (live_enabled) {
	return steam_is_overlay_enabled();
} else return undefined;

#define __lnc__f1335
if (live_enabled) {
	return steam_is_overlay_activated();
} else return undefined;

#define __lnc__f1336
if (live_enabled) {
	return steam_get_persona_name();
} else return undefined;

#define __lnc__f1337
if (live_enabled) {
	return steam_initialised();
} else return undefined;

#define __lnc__f1338
if (live_enabled) {
	return steam_is_cloud_enabled_for_app();
} else return undefined;

#define __lnc__f1339
if (live_enabled) {
	return steam_is_cloud_enabled_for_account();
} else return undefined;

#define __lnc__f1340
if (live_enabled) {
	return steam_file_persisted(argument[0]);
} else return undefined;

#define __lnc__f1341
if (live_enabled) {
	return steam_get_quota_total();
} else return undefined;

#define __lnc__f1342
if (live_enabled) {
	return steam_get_quota_free();
} else return undefined;

#define __lnc__f1343
if (live_enabled) {
	return steam_file_write(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1344
if (live_enabled) {
	return steam_file_write_file(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1345
if (live_enabled) {
	return steam_file_read(argument[0]);
} else return undefined;

#define __lnc__f1346
if (live_enabled) {
	steam_file_delete(argument[0]);
}

#define __lnc__f1347
if (live_enabled) {
	return steam_file_exists(argument[0]);
} else return undefined;

#define __lnc__f1348
if (live_enabled) {
	return steam_file_size(argument[0]);
} else return undefined;

#define __lnc__f1349
if (live_enabled) {
	steam_file_share(argument[0]);
}

#define __lnc__f1350
if (live_enabled) {
	return steam_is_screenshot_requested();
} else return undefined;

#define __lnc__f1351
if (live_enabled) {
	steam_send_screenshot(argument[0],argument[1],argument[2]);
}

#define __lnc__f1352
if (live_enabled) {
	return steam_is_user_logged_on();
} else return undefined;

#define __lnc__f1353
if (live_enabled) {
	return steam_get_user_steam_id();
} else return undefined;

#define __lnc__f1354
if (live_enabled) {
	return steam_user_owns_dlc(argument[0]);
} else return undefined;

#define __lnc__f1355
if (live_enabled) {
	return steam_user_installed_dlc(argument[0]);
} else return undefined;

#define __lnc__f1356
if (live_enabled) {
	steam_set_achievement(argument[0]);
}

#define __lnc__f1357
if (live_enabled) {
	return steam_get_achievement(argument[0]);
} else return undefined;

#define __lnc__f1358
if (live_enabled) {
	steam_clear_achievement(argument[0]);
}

#define __lnc__f1359
if (live_enabled) {
	steam_set_stat_int(argument[0],argument[1]);
}

#define __lnc__f1360
if (live_enabled) {
	steam_set_stat_float(argument[0],argument[1]);
}

#define __lnc__f1361
if (live_enabled) {
	steam_set_stat_avg_rate(argument[0],argument[1],argument[2]);
}

#define __lnc__f1362
if (live_enabled) {
	return steam_get_stat_int(argument[0]);
} else return undefined;

#define __lnc__f1363
if (live_enabled) {
	return steam_get_stat_float(argument[0]);
} else return undefined;

#define __lnc__f1364
if (live_enabled) {
	return steam_get_stat_avg_rate(argument[0]);
} else return undefined;

#define __lnc__f1365
if (live_enabled) {
	steam_reset_all_stats();
}

#define __lnc__f1366
if (live_enabled) {
	steam_reset_all_stats_achievements();
}

#define __lnc__f1367
if (live_enabled) {
	return steam_stats_ready();
} else return undefined;

#define __lnc__f1368
if (live_enabled) {
	return steam_create_leaderboard(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1369
if (live_enabled) {
	return steam_upload_score(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1370
if (live_enabled) {
	return steam_upload_score_ext(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1371
if (live_enabled) {
	return steam_download_scores_around_user(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1372
if (live_enabled) {
	return steam_download_scores(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1373
if (live_enabled) {
	return steam_download_friends_scores(argument[0]);
} else return undefined;

#define __lnc__f1374
if (live_enabled) {
	return steam_upload_score_buffer(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1375
if (live_enabled) {
	return steam_upload_score_buffer_ext(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f1376
if (live_enabled) {
	return steam_current_game_language();
} else return undefined;

#define __lnc__f1377
if (live_enabled) {
	return steam_available_languages();
} else return undefined;

#define __lnc__f1378
if (live_enabled) {
	steam_activate_overlay_browser(argument[0]);
}

#define __lnc__f1379
if (live_enabled) {
	steam_activate_overlay_user(argument[0],argument[1]);
}

#define __lnc__f1380
if (live_enabled) {
	steam_activate_overlay_store(argument[0]);
}

#define __lnc__f1381
if (live_enabled) {
	return steam_get_user_persona_name(argument[0]);
} else return undefined;

#define __lnc__f1382
if (live_enabled) {
	return steam_get_app_id();
} else return undefined;

#define __lnc__f1383
if (live_enabled) {
	return steam_get_user_account_id();
} else return undefined;

#define __lnc__f1384
if (live_enabled) {
	return steam_ugc_download(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1385
if (live_enabled) {
	return steam_ugc_create_item(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1386
if (live_enabled) {
	steam_ugc_start_item_update(argument[0],argument[1]);
}

#define __lnc__f1387
if (live_enabled) {
	steam_ugc_set_item_title(argument[0],argument[1]);
}

#define __lnc__f1388
if (live_enabled) {
	steam_ugc_set_item_description(argument[0],argument[1]);
}

#define __lnc__f1389
if (live_enabled) {
	steam_ugc_set_item_visibility(argument[0],argument[1]);
}

#define __lnc__f1390
if (live_enabled) {
	steam_ugc_set_item_tags(argument[0],argument[1]);
}

#define __lnc__f1391
if (live_enabled) {
	steam_ugc_set_item_content(argument[0],argument[1]);
}

#define __lnc__f1392
if (live_enabled) {
	steam_ugc_set_item_preview(argument[0],argument[1]);
}

#define __lnc__f1393
if (live_enabled) {
	return steam_ugc_submit_item_update(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1394
if (live_enabled) {
	return steam_ugc_get_item_update_progress(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1395
if (live_enabled) {
	return steam_ugc_subscribe_item(argument[0]);
} else return undefined;

#define __lnc__f1396
if (live_enabled) {
	return steam_ugc_unsubscribe_item(argument[0]);
} else return undefined;

#define __lnc__f1397
if (live_enabled) {
	return steam_ugc_num_subscribed_items();
} else return undefined;

#define __lnc__f1398
if (live_enabled) {
	return steam_ugc_get_subscribed_items(argument[0]);
} else return undefined;

#define __lnc__f1399
if (live_enabled) {
	return steam_ugc_get_item_install_info(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1400
if (live_enabled) {
	return steam_ugc_get_item_update_info(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1401
if (live_enabled) {
	return steam_ugc_request_item_details(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1402
if (live_enabled) {
	return steam_ugc_create_query_user(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f1403
if (live_enabled) {
	return steam_ugc_create_query_user_ex(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
} else return undefined;

#define __lnc__f1404
if (live_enabled) {
	return steam_ugc_create_query_all(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1405
if (live_enabled) {
	return steam_ugc_create_query_all_ex(argument[0],argument[1],argument[2],argument[3],argument[4]);
} else return undefined;

#define __lnc__f1406
if (live_enabled) {
	return steam_ugc_query_set_cloud_filename_filter(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1407
if (live_enabled) {
	steam_ugc_query_set_match_any_tag(argument[0],argument[1]);
}

#define __lnc__f1408
if (live_enabled) {
	steam_ugc_query_set_search_text(argument[0],argument[1]);
}

#define __lnc__f1409
if (live_enabled) {
	steam_ugc_query_set_ranked_by_trend_days(argument[0],argument[1]);
}

#define __lnc__f1410
if (live_enabled) {
	steam_ugc_query_add_required_tag(argument[0],argument[1]);
}

#define __lnc__f1411
if (live_enabled) {
	steam_ugc_query_add_excluded_tag(argument[0],argument[1]);
}

#define __lnc__f1412
if (live_enabled) {
	steam_ugc_query_set_return_long_description(argument[0],argument[1]);
}

#define __lnc__f1413
if (live_enabled) {
	steam_ugc_query_set_return_total_only(argument[0],argument[1]);
}

#define __lnc__f1414
if (live_enabled) {
	steam_ugc_query_set_allow_cached_response(argument[0],argument[1]);
}

#define __lnc__f1415
if (live_enabled) {
	steam_ugc_send_query(argument[0]);
}

#define __lnc__f1416
if (live_enabled) {
	shader_set(argument[0]);
}

#define __lnc__f1417
if (live_enabled) {
	return shader_get_name(argument[0]);
} else return undefined;

#define __lnc__f1418
if (live_enabled) {
	shader_reset();
}

#define __lnc__f1419
if (live_enabled) {
	return shader_current();
} else return undefined;

#define __lnc__f1420
if (live_enabled) {
	return shader_is_compiled(argument[0]);
} else return undefined;

#define __lnc__f1421
if (live_enabled) {
	return shader_get_sampler_index(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1422
if (live_enabled) {
	return shader_get_uniform(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1423
if (live_enabled) {
	if(argument_count<2){
		gml_thread_error("shader_set_uniform_i needs at least 2 arguments, got "+string(argument_count));
		return 0;
	} else switch(argument_count){
		case 2:shader_set_uniform_i(argument[0],argument[1]);break;
		case 3:shader_set_uniform_i(argument[0],argument[1],argument[2]);break;
		case 4:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3]);break;
		case 5:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3],argument[4]);break;
		case 6:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);break;
		case 7:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);break;
		case 8:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);break;
		case 9:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);break;
		case 10:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);break;
		case 11:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);break;
		case 12:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);break;
		case 13:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);break;
		case 14:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);break;
		case 15:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);break;
		case 16:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15]);break;
		case 17:shader_set_uniform_i(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16]);break;
		default:gml_thread_error("shader_set_uniform_i takes at most 18 arguments, got "+string(argument_count));
	}
}

#define __lnc__f1424
if (live_enabled) {
	shader_set_uniform_i_array(argument[0],argument[1]);
}

#define __lnc__f1425
if (live_enabled) {
	if(argument_count<2){
		gml_thread_error("shader_set_uniform_f needs at least 2 arguments, got "+string(argument_count));
		return 0;
	} else switch(argument_count){
		case 2:shader_set_uniform_f(argument[0],argument[1]);break;
		case 3:shader_set_uniform_f(argument[0],argument[1],argument[2]);break;
		case 4:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3]);break;
		case 5:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3],argument[4]);break;
		case 6:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);break;
		case 7:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);break;
		case 8:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);break;
		case 9:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);break;
		case 10:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);break;
		case 11:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);break;
		case 12:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);break;
		case 13:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);break;
		case 14:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);break;
		case 15:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);break;
		case 16:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15]);break;
		case 17:shader_set_uniform_f(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16]);break;
		default:gml_thread_error("shader_set_uniform_f takes at most 18 arguments, got "+string(argument_count));
	}
}

#define __lnc__f1426
if (live_enabled) {
	shader_set_uniform_f_array(argument[0],argument[1]);
}

#define __lnc__f1427
if (live_enabled) {
	shader_set_uniform_matrix(argument[0]);
}

#define __lnc__f1428
if (live_enabled) {
	shader_set_uniform_matrix_array(argument[0],argument[1]);
}

#define __lnc__f1429
if (live_enabled) {
	shader_enable_corner_id(argument[0]);
}

#define __lnc__f1430
if (live_enabled) {
	texture_set_stage(argument[0],argument[1]);
}

#define __lnc__f1431
if (live_enabled) {
	return texture_get_texel_width(argument[0]);
} else return undefined;

#define __lnc__f1432
if (live_enabled) {
	return texture_get_texel_height(argument[0]);
} else return undefined;

#define __lnc__f1433
if (live_enabled) {
	return shaders_are_supported();
} else return undefined;

#define __lnc__f1434
if (live_enabled) {
	vertex_format_begin();
}

#define __lnc__f1435
if (live_enabled) {
	return vertex_format_end();
} else return undefined;

#define __lnc__f1436
if (live_enabled) {
	vertex_format_delete(argument[0]);
}

#define __lnc__f1437
if (live_enabled) {
	vertex_format_add_position();
}

#define __lnc__f1438
if (live_enabled) {
	vertex_format_add_position_3d();
}

#define __lnc__f1439
if (live_enabled) {
	vertex_format_add_colour();
}

#define __lnc__f1440
if (live_enabled) {
	vertex_format_add_color();
}

#define __lnc__f1441
if (live_enabled) {
	vertex_format_add_normal();
}

#define __lnc__f1442
if (live_enabled) {
	vertex_format_add_texcoord();
}

#define __lnc__f1443
if (live_enabled) {
	vertex_format_add_custom(argument[0],argument[1]);
}

#define __lnc__f1444
if (live_enabled) {
	return vertex_create_buffer();
} else return undefined;

#define __lnc__f1445
if (live_enabled) {
	return vertex_create_buffer_ext(argument[0]);
} else return undefined;

#define __lnc__f1446
if (live_enabled) {
	vertex_delete_buffer(argument[0]);
}

#define __lnc__f1447
if (live_enabled) {
	vertex_begin(argument[0],argument[1]);
}

#define __lnc__f1448
if (live_enabled) {
	vertex_end(argument[0]);
}

#define __lnc__f1449
if (live_enabled) {
	vertex_position(argument[0],argument[1],argument[2]);
}

#define __lnc__f1450
if (live_enabled) {
	vertex_position_3d(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1451
if (live_enabled) {
	vertex_colour(argument[0],argument[1],argument[2]);
}

#define __lnc__f1452
if (live_enabled) {
	vertex_color(argument[0],argument[1],argument[2]);
}

#define __lnc__f1453
if (live_enabled) {
	vertex_argb(argument[0],argument[1]);
}

#define __lnc__f1454
if (live_enabled) {
	vertex_texcoord(argument[0],argument[1],argument[2]);
}

#define __lnc__f1455
if (live_enabled) {
	vertex_normal(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1456
if (live_enabled) {
	vertex_float1(argument[0],argument[1]);
}

#define __lnc__f1457
if (live_enabled) {
	vertex_float2(argument[0],argument[1],argument[2]);
}

#define __lnc__f1458
if (live_enabled) {
	vertex_float3(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1459
if (live_enabled) {
	vertex_float4(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f1460
if (live_enabled) {
	vertex_ubyte4(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f1461
if (live_enabled) {
	vertex_submit(argument[0],argument[1],argument[2]);
}

#define __lnc__f1462
if (live_enabled) {
	vertex_freeze(argument[0]);
}

#define __lnc__f1463
if (live_enabled) {
	return vertex_get_number(argument[0]);
} else return undefined;

#define __lnc__f1464
if (live_enabled) {
	return vertex_get_buffer_size(argument[0]);
} else return undefined;

#define __lnc__f1465
if (live_enabled) {
	return vertex_create_buffer_from_buffer(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1466
if (live_enabled) {
	return vertex_create_buffer_from_buffer_ext(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f1467
if (live_enabled) {
	skeleton_animation_set(argument[0]);
}

#define __lnc__f1468
if (live_enabled) {
	return skeleton_animation_get();
} else return undefined;

#define __lnc__f1469
if (live_enabled) {
	skeleton_animation_mix(argument[0],argument[1],argument[2]);
}

#define __lnc__f1470
if (live_enabled) {
	skeleton_animation_set_ext(argument[0],argument[1]);
}

#define __lnc__f1471
if (live_enabled) {
	return skeleton_animation_get_ext(argument[0]);
} else return undefined;

#define __lnc__f1472
if (live_enabled) {
	return skeleton_animation_get_duration(argument[0]);
} else return undefined;

#define __lnc__f1473
if (live_enabled) {
	return skeleton_animation_get_frames(argument[0]);
} else return undefined;

#define __lnc__f1474
if (live_enabled) {
	skeleton_animation_clear(argument[0]);
}

#define __lnc__f1475
if (live_enabled) {
	skeleton_skin_set(argument[0]);
}

#define __lnc__f1476
if (live_enabled) {
	return skeleton_skin_get();
} else return undefined;

#define __lnc__f1477
if (live_enabled) {
	skeleton_attachment_set(argument[0],argument[1]);
}

#define __lnc__f1478
if (live_enabled) {
	return skeleton_attachment_get(argument[0]);
} else return undefined;

#define __lnc__f1479
if (live_enabled) {
	return skeleton_attachment_create(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
} else return undefined;

#define __lnc__f1480
if (live_enabled) {
	return skeleton_attachment_create_colour(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);
} else return undefined;

#define __lnc__f1481
if (live_enabled) {
	return skeleton_attachment_create_color(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);
} else return undefined;

#define __lnc__f1482
if (live_enabled) {
	skeleton_collision_draw_set(argument[0]);
}

#define __lnc__f1483
if (live_enabled) {
	return skeleton_bone_data_get(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1484
if (live_enabled) {
	skeleton_bone_data_set(argument[0],argument[1]);
}

#define __lnc__f1485
if (live_enabled) {
	return skeleton_bone_state_get(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1486
if (live_enabled) {
	skeleton_bone_state_set(argument[0],argument[1]);
}

#define __lnc__f1487
if (live_enabled) {
	skeleton_slot_colour_set(argument[0],argument[1],argument[2]);
}

#define __lnc__f1488
if (live_enabled) {
	skeleton_slot_color_set(argument[0],argument[1],argument[2]);
}

#define __lnc__f1489
if (live_enabled) {
	return skeleton_slot_colour_get(argument[0]);
} else return undefined;

#define __lnc__f1490
if (live_enabled) {
	return skeleton_slot_color_get(argument[0]);
} else return undefined;

#define __lnc__f1491
if (live_enabled) {
	return skeleton_slot_alpha_get(argument[0]);
} else return undefined;

#define __lnc__f1492
if (live_enabled) {
	return skeleton_find_slot(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1493
if (live_enabled) {
	return skeleton_get_minmax();
} else return undefined;

#define __lnc__f1494
if (live_enabled) {
	return skeleton_get_num_bounds();
} else return undefined;

#define __lnc__f1495
if (live_enabled) {
	return skeleton_get_bounds(argument[0]);
} else return undefined;

#define __lnc__f1496
if (live_enabled) {
	return skeleton_animation_get_frame(argument[0]);
} else return undefined;

#define __lnc__f1497
if (live_enabled) {
	skeleton_animation_set_frame(argument[0],argument[1]);
}

#define __lnc__f1498
if (live_enabled) {
	draw_skeleton(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);
}

#define __lnc__f1499
if (live_enabled) {
	draw_skeleton_time(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);
}

#define __lnc__f1500
if (live_enabled) {
	draw_skeleton_instance(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);
}

#define __lnc__f1501
if (live_enabled) {
	draw_skeleton_collision(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
}

#define __lnc__f1502
if (live_enabled) {
	draw_enable_skeleton_blendmodes(argument[0]);
}

#define __lnc__f1503
if (live_enabled) {
	return draw_get_enable_skeleton_blendmodes();
} else return undefined;

#define __lnc__f1504
if (live_enabled) {
	skeleton_animation_list(argument[0],argument[1]);
}

#define __lnc__f1505
if (live_enabled) {
	skeleton_skin_list(argument[0],argument[1]);
}

#define __lnc__f1506
if (live_enabled) {
	skeleton_bone_list(argument[0],argument[1]);
}

#define __lnc__f1507
if (live_enabled) {
	skeleton_slot_list(argument[0],argument[1]);
}

#define __lnc__f1508
if (live_enabled) {
	skeleton_slot_data(argument[0],argument[1]);
}

#define __lnc__f1509
if (live_enabled) {
	skeleton_slot_data_instance(argument[0]);
}

#define __lnc__f1510
if (live_enabled) {
	return layer_get_id(argument[0]);
} else return undefined;

#define __lnc__f1511
if (live_enabled) {
	return layer_get_id_at_depth(argument[0]);
} else return undefined;

#define __lnc__f1512
if (live_enabled) {
	return layer_get_depth(argument[0]);
} else return undefined;

#define __lnc__f1513
if (live_enabled) {
	if(argument_count<1){
		return gml_thread_error("layer_create needs at least 1 arguments, got "+string(argument_count));
	} else switch(argument_count){
		case 1:return layer_create(argument[0]);
		case 2:return layer_create(argument[0],argument[1]);
		default:return gml_thread_error("layer_create takes at most 2 arguments, got "+string(argument_count));
	}
} else return undefined;

#define __lnc__f1514
if (live_enabled) {
	layer_destroy(argument[0]);
}

#define __lnc__f1515
if (live_enabled) {
	layer_destroy_instances(argument[0]);
}

#define __lnc__f1516
if (live_enabled) {
	layer_add_instance(argument[0],argument[1]);
}

#define __lnc__f1517
if (live_enabled) {
	layer_has_instance(argument[0],argument[1]);
}

#define __lnc__f1518
if (live_enabled) {
	layer_set_visible(argument[0],argument[1]);
}

#define __lnc__f1519
if (live_enabled) {
	return layer_get_visible(argument[0]);
} else return undefined;

#define __lnc__f1520
if (live_enabled) {
	return layer_exists(argument[0]);
} else return undefined;

#define __lnc__f1521
if (live_enabled) {
	layer_x(argument[0],argument[1]);
}

#define __lnc__f1522
if (live_enabled) {
	layer_y(argument[0],argument[1]);
}

#define __lnc__f1523
if (live_enabled) {
	return layer_get_x(argument[0]);
} else return undefined;

#define __lnc__f1524
if (live_enabled) {
	return layer_get_y(argument[0]);
} else return undefined;

#define __lnc__f1525
if (live_enabled) {
	layer_hspeed(argument[0],argument[1]);
}

#define __lnc__f1526
if (live_enabled) {
	layer_vspeed(argument[0],argument[1]);
}

#define __lnc__f1527
if (live_enabled) {
	return layer_get_hspeed(argument[0]);
} else return undefined;

#define __lnc__f1528
if (live_enabled) {
	return layer_get_vspeed(argument[0]);
} else return undefined;

#define __lnc__f1529
if (live_enabled) {
	layer_script_begin(argument[0],argument[1]);
}

#define __lnc__f1530
if (live_enabled) {
	layer_script_end(argument[0],argument[1]);
}

#define __lnc__f1531
if (live_enabled) {
	layer_shader(argument[0],argument[1]);
}

#define __lnc__f1532
if (live_enabled) {
	return layer_get_script_begin(argument[0]);
} else return undefined;

#define __lnc__f1533
if (live_enabled) {
	return layer_get_script_end(argument[0]);
} else return undefined;

#define __lnc__f1534
if (live_enabled) {
	return layer_get_shader(argument[0]);
} else return undefined;

#define __lnc__f1535
if (live_enabled) {
	layer_set_target_room(argument[0]);
}

#define __lnc__f1536
if (live_enabled) {
	return layer_get_target_room();
} else return undefined;

#define __lnc__f1537
if (live_enabled) {
	layer_reset_target_room();
}

#define __lnc__f1538
if (live_enabled) {
	return layer_get_all();
} else return undefined;

#define __lnc__f1539
if (live_enabled) {
	return layer_get_all_elements(argument[0]);
} else return undefined;

#define __lnc__f1540
if (live_enabled) {
	return layer_get_name(argument[0]);
} else return undefined;

#define __lnc__f1541
if (live_enabled) {
	layer_depth(argument[0],argument[1]);
}

#define __lnc__f1542
if (live_enabled) {
	return layer_get_element_layer(argument[0]);
} else return undefined;

#define __lnc__f1543
if (live_enabled) {
	return layer_get_element_type(argument[0]);
} else return undefined;

#define __lnc__f1544
if (live_enabled) {
	layer_element_move(argument[0],argument[1]);
}

#define __lnc__f1545
if (live_enabled) {
	layer_force_draw_depth(argument[0],argument[1]);
}

#define __lnc__f1546
if (live_enabled) {
	return layer_is_draw_depth_forced();
} else return undefined;

#define __lnc__f1547
if (live_enabled) {
	return layer_get_forced_depth();
} else return undefined;

#define __lnc__f1548
if (live_enabled) {
	return layer_background_get_id(argument[0]);
} else return undefined;

#define __lnc__f1549
if (live_enabled) {
	return layer_background_exists(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1550
if (live_enabled) {
	return layer_background_create(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1551
if (live_enabled) {
	layer_background_destroy(argument[0]);
}

#define __lnc__f1552
if (live_enabled) {
	layer_background_visible(argument[0],argument[1]);
}

#define __lnc__f1553
if (live_enabled) {
	layer_background_change(argument[0],argument[1]);
}

#define __lnc__f1554
if (live_enabled) {
	layer_background_sprite(argument[0],argument[1]);
}

#define __lnc__f1555
if (live_enabled) {
	layer_background_htiled(argument[0],argument[1]);
}

#define __lnc__f1556
if (live_enabled) {
	layer_background_vtiled(argument[0],argument[1]);
}

#define __lnc__f1557
if (live_enabled) {
	layer_background_stretch(argument[0],argument[1]);
}

#define __lnc__f1558
if (live_enabled) {
	layer_background_yscale(argument[0],argument[1]);
}

#define __lnc__f1559
if (live_enabled) {
	layer_background_xscale(argument[0],argument[1]);
}

#define __lnc__f1560
if (live_enabled) {
	layer_background_blend(argument[0],argument[1]);
}

#define __lnc__f1561
if (live_enabled) {
	layer_background_alpha(argument[0],argument[1]);
}

#define __lnc__f1562
if (live_enabled) {
	layer_background_index(argument[0],argument[1]);
}

#define __lnc__f1563
if (live_enabled) {
	layer_background_speed(argument[0],argument[1]);
}

#define __lnc__f1564
if (live_enabled) {
	return layer_background_get_visible(argument[0]);
} else return undefined;

#define __lnc__f1565
if (live_enabled) {
	return layer_background_get_sprite(argument[0]);
} else return undefined;

#define __lnc__f1566
if (live_enabled) {
	return layer_background_get_htiled(argument[0]);
} else return undefined;

#define __lnc__f1567
if (live_enabled) {
	return layer_background_get_vtiled(argument[0]);
} else return undefined;

#define __lnc__f1568
if (live_enabled) {
	return layer_background_get_stretch(argument[0]);
} else return undefined;

#define __lnc__f1569
if (live_enabled) {
	return layer_background_get_yscale(argument[0]);
} else return undefined;

#define __lnc__f1570
if (live_enabled) {
	return layer_background_get_xscale(argument[0]);
} else return undefined;

#define __lnc__f1571
if (live_enabled) {
	return layer_background_get_blend(argument[0]);
} else return undefined;

#define __lnc__f1572
if (live_enabled) {
	return layer_background_get_alpha(argument[0]);
} else return undefined;

#define __lnc__f1573
if (live_enabled) {
	return layer_background_get_index(argument[0]);
} else return undefined;

#define __lnc__f1574
if (live_enabled) {
	return layer_background_get_speed(argument[0]);
} else return undefined;

#define __lnc__f1575
if (live_enabled) {
	return layer_sprite_get_id(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1576
if (live_enabled) {
	return layer_sprite_exists(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1577
if (live_enabled) {
	return layer_sprite_create(argument[0],argument[1],argument[2],argument[3]);
} else return undefined;

#define __lnc__f1578
if (live_enabled) {
	layer_sprite_destroy(argument[0]);
}

#define __lnc__f1579
if (live_enabled) {
	layer_sprite_change(argument[0],argument[1]);
}

#define __lnc__f1580
if (live_enabled) {
	layer_sprite_index(argument[0],argument[1]);
}

#define __lnc__f1581
if (live_enabled) {
	layer_sprite_speed(argument[0],argument[1]);
}

#define __lnc__f1582
if (live_enabled) {
	layer_sprite_xscale(argument[0],argument[1]);
}

#define __lnc__f1583
if (live_enabled) {
	layer_sprite_yscale(argument[0],argument[1]);
}

#define __lnc__f1584
if (live_enabled) {
	layer_sprite_angle(argument[0],argument[1]);
}

#define __lnc__f1585
if (live_enabled) {
	layer_sprite_blend(argument[0],argument[1]);
}

#define __lnc__f1586
if (live_enabled) {
	layer_sprite_alpha(argument[0],argument[1]);
}

#define __lnc__f1587
if (live_enabled) {
	layer_sprite_x(argument[0],argument[1]);
}

#define __lnc__f1588
if (live_enabled) {
	layer_sprite_y(argument[0],argument[1]);
}

#define __lnc__f1589
if (live_enabled) {
	return layer_sprite_get_sprite(argument[0]);
} else return undefined;

#define __lnc__f1590
if (live_enabled) {
	return layer_sprite_get_index(argument[0]);
} else return undefined;

#define __lnc__f1591
if (live_enabled) {
	return layer_sprite_get_speed(argument[0]);
} else return undefined;

#define __lnc__f1592
if (live_enabled) {
	return layer_sprite_get_xscale(argument[0]);
} else return undefined;

#define __lnc__f1593
if (live_enabled) {
	return layer_sprite_get_yscale(argument[0]);
} else return undefined;

#define __lnc__f1594
if (live_enabled) {
	return layer_sprite_get_angle(argument[0]);
} else return undefined;

#define __lnc__f1595
if (live_enabled) {
	return layer_sprite_get_blend(argument[0]);
} else return undefined;

#define __lnc__f1596
if (live_enabled) {
	return layer_sprite_get_alpha(argument[0]);
} else return undefined;

#define __lnc__f1597
if (live_enabled) {
	return layer_sprite_get_x(argument[0]);
} else return undefined;

#define __lnc__f1598
if (live_enabled) {
	return layer_sprite_get_y(argument[0]);
} else return undefined;

#define __lnc__f1599
if (live_enabled) {
	return layer_tilemap_get_id(argument[0]);
} else return undefined;

#define __lnc__f1600
if (live_enabled) {
	return layer_tilemap_exists(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1601
if (live_enabled) {
	return layer_tilemap_create(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
} else return undefined;

#define __lnc__f1602
if (live_enabled) {
	layer_tilemap_destroy(argument[0]);
}

#define __lnc__f1603
if (live_enabled) {
	tilemap_tileset(argument[0],argument[1]);
}

#define __lnc__f1604
if (live_enabled) {
	tilemap_x(argument[0],argument[1]);
}

#define __lnc__f1605
if (live_enabled) {
	tilemap_y(argument[0],argument[1]);
}

#define __lnc__f1606
if (live_enabled) {
	tilemap_set(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1607
if (live_enabled) {
	tilemap_set_at_pixel(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1608
if (live_enabled) {
	return tileset_get_texture(argument[0]);
} else return undefined;

#define __lnc__f1609
if (live_enabled) {
	return tileset_get_uvs(argument[0]);
} else return undefined;

#define __lnc__f1610
if (live_enabled) {
	return tileset_get_name(argument[0]);
} else return undefined;

#define __lnc__f1611
if (live_enabled) {
	return tilemap_get_tileset(argument[0]);
} else return undefined;

#define __lnc__f1612
if (live_enabled) {
	return tilemap_get_tile_width(argument[0]);
} else return undefined;

#define __lnc__f1613
if (live_enabled) {
	return tilemap_get_tile_height(argument[0]);
} else return undefined;

#define __lnc__f1614
if (live_enabled) {
	return tilemap_get_width(argument[0]);
} else return undefined;

#define __lnc__f1615
if (live_enabled) {
	return tilemap_get_height(argument[0]);
} else return undefined;

#define __lnc__f1616
if (live_enabled) {
	tilemap_set_width(argument[0],argument[1]);
}

#define __lnc__f1617
if (live_enabled) {
	tilemap_set_height(argument[0],argument[1]);
}

#define __lnc__f1618
if (live_enabled) {
	return tilemap_get_x(argument[0]);
} else return undefined;

#define __lnc__f1619
if (live_enabled) {
	return tilemap_get_y(argument[0]);
} else return undefined;

#define __lnc__f1620
if (live_enabled) {
	return tilemap_get(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1621
if (live_enabled) {
	return tilemap_get_at_pixel(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1622
if (live_enabled) {
	return tilemap_get_cell_x_at_pixel(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1623
if (live_enabled) {
	return tilemap_get_cell_y_at_pixel(argument[0],argument[1],argument[2]);
} else return undefined;

#define __lnc__f1624
if (live_enabled) {
	tilemap_clear(argument[0],argument[1]);
}

#define __lnc__f1625
if (live_enabled) {
	draw_tilemap(argument[0],argument[1],argument[2]);
}

#define __lnc__f1626
if (live_enabled) {
	draw_tile(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f1627
if (live_enabled) {
	tilemap_set_global_mask(argument[0]);
}

#define __lnc__f1628
if (live_enabled) {
	return tilemap_get_global_mask();
} else return undefined;

#define __lnc__f1629
if (live_enabled) {
	tilemap_set_mask(argument[0],argument[1]);
}

#define __lnc__f1630
if (live_enabled) {
	return tilemap_get_mask(argument[0]);
} else return undefined;

#define __lnc__f1631
if (live_enabled) {
	return tilemap_get_frame(argument[0]);
} else return undefined;

#define __lnc__f1632
if (live_enabled) {
	tile_set_empty(argument[0]);
}

#define __lnc__f1633
if (live_enabled) {
	tile_set_index(argument[0],argument[1]);
}

#define __lnc__f1634
if (live_enabled) {
	tile_set_flip(argument[0],argument[1]);
}

#define __lnc__f1635
if (live_enabled) {
	tile_set_mirror(argument[0],argument[1]);
}

#define __lnc__f1636
if (live_enabled) {
	tile_set_rotate(argument[0],argument[1]);
}

#define __lnc__f1637
if (live_enabled) {
	return tile_get_empty(argument[0]);
} else return undefined;

#define __lnc__f1638
if (live_enabled) {
	return tile_get_index(argument[0]);
} else return undefined;

#define __lnc__f1639
if (live_enabled) {
	return tile_get_flip(argument[0]);
} else return undefined;

#define __lnc__f1640
if (live_enabled) {
	return tile_get_mirror(argument[0]);
} else return undefined;

#define __lnc__f1641
if (live_enabled) {
	return tile_get_rotate(argument[0]);
} else return undefined;

#define __lnc__f1642
if (live_enabled) {
	if(argument_count<2){
		return gml_thread_error("layer_tile_exists needs at least 2 arguments, got "+string(argument_count));
	} else switch(argument_count){
		case 2:return layer_tile_exists(argument[0],argument[1]);
		case 3:return layer_tile_exists(argument[0],argument[1],argument[2]);
		case 4:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3]);
		case 5:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3],argument[4]);
		case 6:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
		case 7:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6]);
		case 8:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
		case 9:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);
		case 10:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);
		case 11:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]);
		case 12:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]);
		case 13:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]);
		case 14:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]);
		case 15:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14]);
		case 16:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15]);
		case 17:return layer_tile_exists(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13],argument[14],argument[15],argument[16]);
		default:return gml_thread_error("layer_tile_exists takes at most 18 arguments, got "+string(argument_count));
	}
} else return undefined;

#define __lnc__f1643
if (live_enabled) {
	return layer_tile_create(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]);
} else return undefined;

#define __lnc__f1644
if (live_enabled) {
	layer_tile_destroy(argument[0]);
}

#define __lnc__f1645
if (live_enabled) {
	layer_tile_change(argument[0],argument[1]);
}

#define __lnc__f1646
if (live_enabled) {
	layer_tile_xscale(argument[0],argument[1]);
}

#define __lnc__f1647
if (live_enabled) {
	layer_tile_yscale(argument[0],argument[1]);
}

#define __lnc__f1648
if (live_enabled) {
	layer_tile_blend(argument[0],argument[1]);
}

#define __lnc__f1649
if (live_enabled) {
	layer_tile_alpha(argument[0],argument[1]);
}

#define __lnc__f1650
if (live_enabled) {
	layer_tile_x(argument[0],argument[1]);
}

#define __lnc__f1651
if (live_enabled) {
	layer_tile_y(argument[0],argument[1]);
}

#define __lnc__f1652
if (live_enabled) {
	layer_tile_region(argument[0],argument[1],argument[2],argument[3],argument[4]);
}

#define __lnc__f1653
if (live_enabled) {
	layer_tile_visible(argument[0],argument[1]);
}

#define __lnc__f1654
if (live_enabled) {
	return layer_tile_get_sprite(argument[0]);
} else return undefined;

#define __lnc__f1655
if (live_enabled) {
	return layer_tile_get_xscale(argument[0]);
} else return undefined;

#define __lnc__f1656
if (live_enabled) {
	return layer_tile_get_yscale(argument[0]);
} else return undefined;

#define __lnc__f1657
if (live_enabled) {
	return layer_tile_get_blend(argument[0]);
} else return undefined;

#define __lnc__f1658
if (live_enabled) {
	return layer_tile_get_alpha(argument[0]);
} else return undefined;

#define __lnc__f1659
if (live_enabled) {
	return layer_tile_get_x(argument[0]);
} else return undefined;

#define __lnc__f1660
if (live_enabled) {
	return layer_tile_get_y(argument[0]);
} else return undefined;

#define __lnc__f1661
if (live_enabled) {
	return layer_tile_get_region(argument[0]);
} else return undefined;

#define __lnc__f1662
if (live_enabled) {
	return layer_tile_get_visible(argument[0]);
} else return undefined;

#define __lnc__f1663
if (live_enabled) {
	return layer_instance_get_instance(argument[0]);
} else return undefined;

#define __lnc__f1664
if (live_enabled) {
	instance_activate_layer(argument[0]);
}

#define __lnc__f1665
if (live_enabled) {
	instance_deactivate_layer(argument[0]);
}

#define __lnc__f1666
if (live_enabled) {
	return camera_create();
} else return undefined;

#define __lnc__f1667
if (live_enabled) {
	return camera_create_view(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]);
} else return undefined;

#define __lnc__f1668
if (live_enabled) {
	camera_destroy(argument[0]);
}

#define __lnc__f1669
if (live_enabled) {
	camera_apply(argument[0]);
}

#define __lnc__f1670
if (live_enabled) {
	return camera_get_active();
} else return undefined;

#define __lnc__f1671
if (live_enabled) {
	return camera_get_default();
} else return undefined;

#define __lnc__f1672
if (live_enabled) {
	camera_set_default(argument[0]);
}

#define __lnc__f1673
if (live_enabled) {
	camera_set_view_mat(argument[0],argument[1]);
}

#define __lnc__f1674
if (live_enabled) {
	camera_set_proj_mat(argument[0],argument[1]);
}

#define __lnc__f1675
if (live_enabled) {
	camera_set_update_script(argument[0],argument[1]);
}

#define __lnc__f1676
if (live_enabled) {
	camera_set_begin_script(argument[0],argument[1]);
}

#define __lnc__f1677
if (live_enabled) {
	camera_set_end_script(argument[0],argument[1]);
}

#define __lnc__f1678
if (live_enabled) {
	camera_set_view_pos(argument[0],argument[1],argument[2]);
}

#define __lnc__f1679
if (live_enabled) {
	camera_set_view_size(argument[0],argument[1],argument[2]);
}

#define __lnc__f1680
if (live_enabled) {
	camera_set_view_speed(argument[0],argument[1],argument[2]);
}

#define __lnc__f1681
if (live_enabled) {
	camera_set_view_border(argument[0],argument[1],argument[2]);
}

#define __lnc__f1682
if (live_enabled) {
	camera_set_view_angle(argument[0],argument[1]);
}

#define __lnc__f1683
if (live_enabled) {
	camera_set_view_target(argument[0],argument[1]);
}

#define __lnc__f1684
if (live_enabled) {
	return camera_get_view_mat(argument[0]);
} else return undefined;

#define __lnc__f1685
if (live_enabled) {
	return camera_get_proj_mat(argument[0]);
} else return undefined;

#define __lnc__f1686
if (live_enabled) {
	return camera_get_update_script(argument[0]);
} else return undefined;

#define __lnc__f1687
if (live_enabled) {
	return camera_get_begin_script(argument[0]);
} else return undefined;

#define __lnc__f1688
if (live_enabled) {
	return camera_get_end_script(argument[0]);
} else return undefined;

#define __lnc__f1689
if (live_enabled) {
	return camera_get_view_x(argument[0]);
} else return undefined;

#define __lnc__f1690
if (live_enabled) {
	return camera_get_view_y(argument[0]);
} else return undefined;

#define __lnc__f1691
if (live_enabled) {
	return camera_get_view_width(argument[0]);
} else return undefined;

#define __lnc__f1692
if (live_enabled) {
	return camera_get_view_height(argument[0]);
} else return undefined;

#define __lnc__f1693
if (live_enabled) {
	return camera_get_view_speed_x(argument[0]);
} else return undefined;

#define __lnc__f1694
if (live_enabled) {
	return camera_get_view_speed_y(argument[0]);
} else return undefined;

#define __lnc__f1695
if (live_enabled) {
	return camera_get_view_border_x(argument[0]);
} else return undefined;

#define __lnc__f1696
if (live_enabled) {
	return camera_get_view_border_y(argument[0]);
} else return undefined;

#define __lnc__f1697
if (live_enabled) {
	return camera_get_view_angle(argument[0]);
} else return undefined;

#define __lnc__f1698
if (live_enabled) {
	return camera_get_view_target(argument[0]);
} else return undefined;

#define __lnc__f1699
if (live_enabled) {
	return view_get_camera(argument[0]);
} else return undefined;

#define __lnc__f1700
if (live_enabled) {
	return view_get_visible(argument[0]);
} else return undefined;

#define __lnc__f1701
if (live_enabled) {
	return view_get_xport(argument[0]);
} else return undefined;

#define __lnc__f1702
if (live_enabled) {
	return view_get_yport(argument[0]);
} else return undefined;

#define __lnc__f1703
if (live_enabled) {
	return view_get_wport(argument[0]);
} else return undefined;

#define __lnc__f1704
if (live_enabled) {
	return view_get_hport(argument[0]);
} else return undefined;

#define __lnc__f1705
if (live_enabled) {
	return view_get_surface_id(argument[0]);
} else return undefined;

#define __lnc__f1706
if (live_enabled) {
	view_set_camera(argument[0],argument[1]);
}

#define __lnc__f1707
if (live_enabled) {
	view_set_visible(argument[0],argument[1]);
}

#define __lnc__f1708
if (live_enabled) {
	view_set_xport(argument[0],argument[1]);
}

#define __lnc__f1709
if (live_enabled) {
	view_set_yport(argument[0],argument[1]);
}

#define __lnc__f1710
if (live_enabled) {
	view_set_wport(argument[0],argument[1]);
}

#define __lnc__f1711
if (live_enabled) {
	view_set_hport(argument[0],argument[1]);
}

#define __lnc__f1712
if (live_enabled) {
	view_set_surface_id(argument[0],argument[1]);
}

#define __lnc__f1713
if (live_enabled) {
	gesture_drag_time(argument[0]);
}

#define __lnc__f1714
if (live_enabled) {
	gesture_drag_distance(argument[0]);
}

#define __lnc__f1715
if (live_enabled) {
	gesture_flick_speed(argument[0]);
}

#define __lnc__f1716
if (live_enabled) {
	gesture_double_tap_time(argument[0]);
}

#define __lnc__f1717
if (live_enabled) {
	gesture_double_tap_distance(argument[0]);
}

#define __lnc__f1718
if (live_enabled) {
	gesture_pinch_distance(argument[0]);
}

#define __lnc__f1719
if (live_enabled) {
	gesture_pinch_angle_towards(argument[0]);
}

#define __lnc__f1720
if (live_enabled) {
	gesture_pinch_angle_away(argument[0]);
}

#define __lnc__f1721
if (live_enabled) {
	gesture_rotate_time(argument[0]);
}

#define __lnc__f1722
if (live_enabled) {
	gesture_rotate_angle(argument[0]);
}

#define __lnc__f1723
if (live_enabled) {
	gesture_tap_count(argument[0]);
}

#define __lnc__f1724
if (live_enabled) {
	return gesture_get_drag_time();
} else return undefined;

#define __lnc__f1725
if (live_enabled) {
	return gesture_get_drag_distance();
} else return undefined;

#define __lnc__f1726
if (live_enabled) {
	return gesture_get_flick_speed();
} else return undefined;

#define __lnc__f1727
if (live_enabled) {
	return gesture_get_double_tap_time();
} else return undefined;

#define __lnc__f1728
if (live_enabled) {
	return gesture_get_double_tap_distance();
} else return undefined;

#define __lnc__f1729
if (live_enabled) {
	return gesture_get_pinch_distance();
} else return undefined;

#define __lnc__f1730
if (live_enabled) {
	return gesture_get_pinch_angle_towards();
} else return undefined;

#define __lnc__f1731
if (live_enabled) {
	return gesture_get_pinch_angle_away();
} else return undefined;

#define __lnc__f1732
if (live_enabled) {
	return gesture_get_rotate_time();
} else return undefined;

#define __lnc__f1733
if (live_enabled) {
	return gesture_get_rotate_angle();
} else return undefined;

#define __lnc__f1734
if (live_enabled) {
	return gesture_get_tap_count();
} else return undefined;

#define __lnc__f1735
if (live_enabled) {
	keyboard_virtual_show(argument[0],argument[1],argument[2],argument[3]);
}

#define __lnc__f1736
if (live_enabled) {
	keyboard_virtual_hide();
}

#define __lnc__f1737
if (live_enabled) {
	keyboard_virtual_status();
}

#define __lnc__f1738
if (live_enabled) {
	keyboard_virtual_height();
}

#define __lnc__f1739
if (live_enabled) {
	return extension_get_string(argument[0],argument[1]);
} else return undefined;

#define __lnc__f1740
if (live_enabled) {
	variable_instance_names_count(argument[0]);
}

#define __lnc__f1741
if (live_enabled) {
	if(argument[0]){
		room_speed = argument[1];
		return undefined;
	} else return room_speed;
} else return undefined;

#define __lnc__f1742
if (live_enabled) {
	return fps;
} else return undefined;

#define __lnc__f1743
if (live_enabled) {
	return fps_real;
} else return undefined;

#define __lnc__f1744
if (live_enabled) {
	return current_time;
} else return undefined;

#define __lnc__f1745
if (live_enabled) {
	return current_year;
} else return undefined;

#define __lnc__f1746
if (live_enabled) {
	return current_month;
} else return undefined;

#define __lnc__f1747
if (live_enabled) {
	return current_day;
} else return undefined;

#define __lnc__f1748
if (live_enabled) {
	return current_weekday;
} else return undefined;

#define __lnc__f1749
if (live_enabled) {
	return current_hour;
} else return undefined;

#define __lnc__f1750
if (live_enabled) {
	return current_minute;
} else return undefined;

#define __lnc__f1751
if (live_enabled) {
	return current_second;
} else return undefined;

#define __lnc__f1752
if (live_enabled) {
	return room;
} else return undefined;

#define __lnc__f1753
if (live_enabled) {
	return room_first;
} else return undefined;

#define __lnc__f1754
if (live_enabled) {
	return room_last;
} else return undefined;

#define __lnc__f1755
if (live_enabled) {
	return room_width;
} else return undefined;

#define __lnc__f1756
if (live_enabled) {
	return room_height;
} else return undefined;

#define __lnc__f1757
if (live_enabled) {
	if(argument[0]){
		room_persistent = argument[1];
		return undefined;
	} else return room_persistent;
} else return undefined;

#define __lnc__f1758
if (live_enabled) {
	if(argument[0]){
		score = argument[1];
		return undefined;
	} else return score;
} else return undefined;

#define __lnc__f1759
if (live_enabled) {
	if(argument[0]){
		lives = argument[1];
		return undefined;
	} else return lives;
} else return undefined;

#define __lnc__f1760
if (live_enabled) {
	if(argument[0]){
		health = argument[1];
		return undefined;
	} else return health;
} else return undefined;

#define __lnc__f1761
if (live_enabled) {
	return event_type;
} else return undefined;

#define __lnc__f1762
if (live_enabled) {
	return event_number;
} else return undefined;

#define __lnc__f1763
if (live_enabled) {
	return event_object;
} else return undefined;

#define __lnc__f1764
if (live_enabled) {
	return event_action;
} else return undefined;

#define __lnc__f1765
if (live_enabled) {
	return application_surface;
} else return undefined;

#define __lnc__f1766
if (live_enabled) {
	return debug_mode;
} else return undefined;

#define __lnc__f1767
if (live_enabled) {
	if(argument[0]){
		font_texture_page_size = argument[1];
		return undefined;
	} else return font_texture_page_size;
} else return undefined;

#define __lnc__f1768
if (live_enabled) {
	if(argument[0]){
		keyboard_key = argument[1];
		return undefined;
	} else return keyboard_key;
} else return undefined;

#define __lnc__f1769
if (live_enabled) {
	if(argument[0]){
		keyboard_lastkey = argument[1];
		return undefined;
	} else return keyboard_lastkey;
} else return undefined;

#define __lnc__f1770
if (live_enabled) {
	if(argument[0]){
		keyboard_lastchar = argument[1];
		return undefined;
	} else return keyboard_lastchar;
} else return undefined;

#define __lnc__f1771
if (live_enabled) {
	if(argument[0]){
		keyboard_string = argument[1];
		return undefined;
	} else return keyboard_string;
} else return undefined;

#define __lnc__f1772
if (live_enabled) {
	return mouse_x;
} else return undefined;

#define __lnc__f1773
if (live_enabled) {
	return mouse_y;
} else return undefined;

#define __lnc__f1774
if (live_enabled) {
	if(argument[0]){
		mouse_button = argument[1];
		return undefined;
	} else return mouse_button;
} else return undefined;

#define __lnc__f1775
if (live_enabled) {
	if(argument[0]){
		mouse_lastbutton = argument[1];
		return undefined;
	} else return mouse_lastbutton;
} else return undefined;

#define __lnc__f1776
if (live_enabled) {
	if(argument[0]){
		cursor_sprite = argument[1];
		return undefined;
	} else return cursor_sprite;
} else return undefined;

#define __lnc__f1777
if (live_enabled) {
	if(argument[0]){
		background_colour = argument[1];
		return undefined;
	} else return background_colour;
} else return undefined;

#define __lnc__f1778
if (live_enabled) {
	if(argument[0]){
		background_showcolour = argument[1];
		return undefined;
	} else return background_showcolour;
} else return undefined;

#define __lnc__f1779
if (live_enabled) {
	if(argument[0]){
		background_color = argument[1];
		return undefined;
	} else return background_color;
} else return undefined;

#define __lnc__f1780
if (live_enabled) {
	if(argument[0]){
		background_showcolor = argument[1];
		return undefined;
	} else return background_showcolor;
} else return undefined;

#define __lnc__f1781
if (live_enabled) {
	if(argument[0]){
		view_enabled = argument[1];
		return undefined;
	} else return view_enabled;
} else return undefined;

#define __lnc__f1782
if (live_enabled) {
	return view_current;
} else return undefined;

#define __lnc__f1783
if (live_enabled) {
	if(argument[2]<0||argument[2]>7)return gml_thread_error(("Index ("+__lnc__std_Std_string(argument[2])+") is out of range [0..7]"));
	if(argument[0]){
		view_visible[argument[2]] = argument[1];
		return undefined;
	} else return view_visible[argument[2]];
} else return undefined;

#define __lnc__f1784
if (live_enabled) {
	if(argument[2]<0||argument[2]>7)return gml_thread_error(("Index ("+__lnc__std_Std_string(argument[2])+") is out of range [0..7]"));
	if(argument[0]){
		view_xport[argument[2]] = argument[1];
		return undefined;
	} else return view_xport[argument[2]];
} else return undefined;

#define __lnc__f1785
if (live_enabled) {
	if(argument[2]<0||argument[2]>7)return gml_thread_error(("Index ("+__lnc__std_Std_string(argument[2])+") is out of range [0..7]"));
	if(argument[0]){
		view_yport[argument[2]] = argument[1];
		return undefined;
	} else return view_yport[argument[2]];
} else return undefined;

#define __lnc__f1786
if (live_enabled) {
	if(argument[2]<0||argument[2]>7)return gml_thread_error(("Index ("+__lnc__std_Std_string(argument[2])+") is out of range [0..7]"));
	if(argument[0]){
		view_wport[argument[2]] = argument[1];
		return undefined;
	} else return view_wport[argument[2]];
} else return undefined;

#define __lnc__f1787
if (live_enabled) {
	if(argument[2]<0||argument[2]>7)return gml_thread_error(("Index ("+__lnc__std_Std_string(argument[2])+") is out of range [0..7]"));
	if(argument[0]){
		view_hport[argument[2]] = argument[1];
		return undefined;
	} else return view_hport[argument[2]];
} else return undefined;

#define __lnc__f1788
if (live_enabled) {
	if(argument[2]<0||argument[2]>7)return gml_thread_error(("Index ("+__lnc__std_Std_string(argument[2])+") is out of range [0..7]"));
	if(argument[0]){
		view_surface_id[argument[2]] = argument[1];
		return undefined;
	} else return view_surface_id[argument[2]];
} else return undefined;

#define __lnc__f1789
if (live_enabled) {
	if(argument[2]<0||argument[2]>7)return gml_thread_error(("Index ("+__lnc__std_Std_string(argument[2])+") is out of range [0..7]"));
	if(argument[0]){
		view_camera[argument[2]] = argument[1];
		return undefined;
	} else return view_camera[argument[2]];
} else return undefined;

#define __lnc__f1790
if (live_enabled) {
	return game_id;
} else return undefined;

#define __lnc__f1791
if (live_enabled) {
	return game_display_name;
} else return undefined;

#define __lnc__f1792
if (live_enabled) {
	return game_project_name;
} else return undefined;

#define __lnc__f1793
if (live_enabled) {
	return game_save_id;
} else return undefined;

#define __lnc__f1794
if (live_enabled) {
	return working_directory;
} else return undefined;

#define __lnc__f1795
if (live_enabled) {
	return temp_directory;
} else return undefined;

#define __lnc__f1796
if (live_enabled) {
	return program_directory;
} else return undefined;

#define __lnc__f1797
if (live_enabled) {
	return browser_width;
} else return undefined;

#define __lnc__f1798
if (live_enabled) {
	return browser_height;
} else return undefined;

#define __lnc__f1799
if (live_enabled) {
	return os_type;
} else return undefined;

#define __lnc__f1800
if (live_enabled) {
	return os_device;
} else return undefined;

#define __lnc__f1801
if (live_enabled) {
	return os_browser;
} else return undefined;

#define __lnc__f1802
if (live_enabled) {
	return os_version;
} else return undefined;

#define __lnc__f1803
if (live_enabled) {
	return display_aa;
} else return undefined;

#define __lnc__f1804
if (live_enabled) {
	return async_load;
} else return undefined;

#define __lnc__f1805
if (live_enabled) {
	return delta_time;
} else return undefined;

#define __lnc__f1806
if (live_enabled) {
	return webgl_enabled;
} else return undefined;

#define __lnc__f1807
if (live_enabled) {
	return event_data;
} else return undefined;

#define __lnc_const_decl_f0
if (live_enabled) {
	gml_const_add("undefined",undefined);
	gml_const_add("pointer_invalid",pointer_invalid);
	gml_const_add("pointer_null",pointer_null);
	gml_const_add("path_action_stop",path_action_stop);
	gml_const_add("path_action_restart",path_action_restart);
	gml_const_add("path_action_continue",path_action_continue);
	gml_const_add("path_action_reverse",path_action_reverse);
	gml_const_add("pi",pi);
	gml_const_add("NaN",NaN);
	gml_const_add("infinity",infinity);
	gml_const_add("GM_build_date",GM_build_date);
	gml_const_add("GM_version",GM_version);
	gml_const_add("GM_runtime_version",GM_runtime_version);
	gml_const_add("timezone_local",timezone_local);
	gml_const_add("timezone_utc",timezone_utc);
	gml_const_add("gamespeed_fps",gamespeed_fps);
	gml_const_add("gamespeed_microseconds",gamespeed_microseconds);
	gml_const_add("ev_create",ev_create);
	gml_const_add("ev_destroy",ev_destroy);
	gml_const_add("ev_step",ev_step);
	gml_const_add("ev_alarm",ev_alarm);
	gml_const_add("ev_keyboard",ev_keyboard);
	gml_const_add("ev_mouse",ev_mouse);
	gml_const_add("ev_collision",ev_collision);
	gml_const_add("ev_other",ev_other);
	gml_const_add("ev_draw",ev_draw);
	gml_const_add("ev_draw_begin",ev_draw_begin);
	gml_const_add("ev_draw_end",ev_draw_end);
	gml_const_add("ev_draw_pre",ev_draw_pre);
	gml_const_add("ev_draw_post",ev_draw_post);
	gml_const_add("ev_keypress",ev_keypress);
	gml_const_add("ev_keyrelease",ev_keyrelease);
}

#define __lnc_const_decl_f1
if (live_enabled) {
	gml_const_add("ev_trigger",ev_trigger);
	gml_const_add("ev_left_button",ev_left_button);
	gml_const_add("ev_right_button",ev_right_button);
	gml_const_add("ev_middle_button",ev_middle_button);
	gml_const_add("ev_no_button",ev_no_button);
	gml_const_add("ev_left_press",ev_left_press);
	gml_const_add("ev_right_press",ev_right_press);
	gml_const_add("ev_middle_press",ev_middle_press);
	gml_const_add("ev_left_release",ev_left_release);
	gml_const_add("ev_right_release",ev_right_release);
	gml_const_add("ev_middle_release",ev_middle_release);
	gml_const_add("ev_mouse_enter",ev_mouse_enter);
	gml_const_add("ev_mouse_leave",ev_mouse_leave);
	gml_const_add("ev_mouse_wheel_up",ev_mouse_wheel_up);
	gml_const_add("ev_mouse_wheel_down",ev_mouse_wheel_down);
	gml_const_add("ev_global_left_button",ev_global_left_button);
	gml_const_add("ev_global_right_button",ev_global_right_button);
	gml_const_add("ev_global_middle_button",ev_global_middle_button);
	gml_const_add("ev_global_left_press",ev_global_left_press);
	gml_const_add("ev_global_right_press",ev_global_right_press);
	gml_const_add("ev_global_middle_press",ev_global_middle_press);
	gml_const_add("ev_global_left_release",ev_global_left_release);
	gml_const_add("ev_global_right_release",ev_global_right_release);
	gml_const_add("ev_global_middle_release",ev_global_middle_release);
	gml_const_add("ev_joystick1_left",ev_joystick1_left);
	gml_const_add("ev_joystick1_right",ev_joystick1_right);
	gml_const_add("ev_joystick1_up",ev_joystick1_up);
	gml_const_add("ev_joystick1_down",ev_joystick1_down);
	gml_const_add("ev_joystick1_button1",ev_joystick1_button1);
	gml_const_add("ev_joystick1_button2",ev_joystick1_button2);
	gml_const_add("ev_joystick1_button3",ev_joystick1_button3);
	gml_const_add("ev_joystick1_button4",ev_joystick1_button4);
}

#define __lnc_const_decl_f2
if (live_enabled) {
	gml_const_add("ev_joystick1_button5",ev_joystick1_button5);
	gml_const_add("ev_joystick1_button6",ev_joystick1_button6);
	gml_const_add("ev_joystick1_button7",ev_joystick1_button7);
	gml_const_add("ev_joystick1_button8",ev_joystick1_button8);
	gml_const_add("ev_joystick2_left",ev_joystick2_left);
	gml_const_add("ev_joystick2_right",ev_joystick2_right);
	gml_const_add("ev_joystick2_up",ev_joystick2_up);
	gml_const_add("ev_joystick2_down",ev_joystick2_down);
	gml_const_add("ev_joystick2_button1",ev_joystick2_button1);
	gml_const_add("ev_joystick2_button2",ev_joystick2_button2);
	gml_const_add("ev_joystick2_button3",ev_joystick2_button3);
	gml_const_add("ev_joystick2_button4",ev_joystick2_button4);
	gml_const_add("ev_joystick2_button5",ev_joystick2_button5);
	gml_const_add("ev_joystick2_button6",ev_joystick2_button6);
	gml_const_add("ev_joystick2_button7",ev_joystick2_button7);
	gml_const_add("ev_joystick2_button8",ev_joystick2_button8);
	gml_const_add("ev_outside",ev_outside);
	gml_const_add("ev_boundary",ev_boundary);
	gml_const_add("ev_game_start",ev_game_start);
	gml_const_add("ev_game_end",ev_game_end);
	gml_const_add("ev_room_start",ev_room_start);
	gml_const_add("ev_room_end",ev_room_end);
	gml_const_add("ev_no_more_lives",ev_no_more_lives);
	gml_const_add("ev_animation_end",ev_animation_end);
	gml_const_add("ev_end_of_path",ev_end_of_path);
	gml_const_add("ev_no_more_health",ev_no_more_health);
	gml_const_add("ev_user0",ev_user0);
	gml_const_add("ev_user1",ev_user1);
	gml_const_add("ev_user2",ev_user2);
	gml_const_add("ev_user3",ev_user3);
	gml_const_add("ev_user4",ev_user4);
	gml_const_add("ev_user5",ev_user5);
}

#define __lnc_const_decl_f3
if (live_enabled) {
	gml_const_add("ev_user6",ev_user6);
	gml_const_add("ev_user7",ev_user7);
	gml_const_add("ev_user8",ev_user8);
	gml_const_add("ev_user9",ev_user9);
	gml_const_add("ev_user10",ev_user10);
	gml_const_add("ev_user11",ev_user11);
	gml_const_add("ev_user12",ev_user12);
	gml_const_add("ev_user13",ev_user13);
	gml_const_add("ev_user14",ev_user14);
	gml_const_add("ev_user15",ev_user15);
	gml_const_add("ev_step_normal",ev_step_normal);
	gml_const_add("ev_step_begin",ev_step_begin);
	gml_const_add("ev_step_end",ev_step_end);
	gml_const_add("ev_gui",ev_gui);
	gml_const_add("ev_gui_begin",ev_gui_begin);
	gml_const_add("ev_gui_end",ev_gui_end);
	gml_const_add("ev_cleanup",ev_cleanup);
	gml_const_add("ev_gesture",ev_gesture);
	gml_const_add("ev_gesture_tap",ev_gesture_tap);
	gml_const_add("ev_gesture_double_tap",ev_gesture_double_tap);
	gml_const_add("ev_gesture_drag_start",ev_gesture_drag_start);
	gml_const_add("ev_gesture_dragging",ev_gesture_dragging);
	gml_const_add("ev_gesture_drag_end",ev_gesture_drag_end);
	gml_const_add("ev_gesture_flick",ev_gesture_flick);
	gml_const_add("ev_gesture_pinch_start",ev_gesture_pinch_start);
	gml_const_add("ev_gesture_pinch_in",ev_gesture_pinch_in);
	gml_const_add("ev_gesture_pinch_out",ev_gesture_pinch_out);
	gml_const_add("ev_gesture_pinch_end",ev_gesture_pinch_end);
	gml_const_add("ev_gesture_rotate_start",ev_gesture_rotate_start);
	gml_const_add("ev_gesture_rotating",ev_gesture_rotating);
	gml_const_add("ev_gesture_rotate_end",ev_gesture_rotate_end);
	gml_const_add("ev_global_gesture_tap",ev_global_gesture_tap);
}

#define __lnc_const_decl_f4
if (live_enabled) {
	gml_const_add("ev_global_gesture_double_tap",ev_global_gesture_double_tap);
	gml_const_add("ev_global_gesture_drag_start",ev_global_gesture_drag_start);
	gml_const_add("ev_global_gesture_dragging",ev_global_gesture_dragging);
	gml_const_add("ev_global_gesture_drag_end",ev_global_gesture_drag_end);
	gml_const_add("ev_global_gesture_flick",ev_global_gesture_flick);
	gml_const_add("ev_global_gesture_pinch_start",ev_global_gesture_pinch_start);
	gml_const_add("ev_global_gesture_pinch_in",ev_global_gesture_pinch_in);
	gml_const_add("ev_global_gesture_pinch_out",ev_global_gesture_pinch_out);
	gml_const_add("ev_global_gesture_pinch_end",ev_global_gesture_pinch_end);
	gml_const_add("ev_global_gesture_rotate_start",ev_global_gesture_rotate_start);
	gml_const_add("ev_global_gesture_rotating",ev_global_gesture_rotating);
	gml_const_add("ev_global_gesture_rotate_end",ev_global_gesture_rotate_end);
	gml_const_add("vk_nokey",vk_nokey);
	gml_const_add("vk_anykey",vk_anykey);
	gml_const_add("vk_enter",vk_enter);
	gml_const_add("vk_return",vk_return);
	gml_const_add("vk_shift",vk_shift);
	gml_const_add("vk_control",vk_control);
	gml_const_add("vk_alt",vk_alt);
	gml_const_add("vk_escape",vk_escape);
	gml_const_add("vk_space",vk_space);
	gml_const_add("vk_backspace",vk_backspace);
	gml_const_add("vk_tab",vk_tab);
	gml_const_add("vk_pause",vk_pause);
	gml_const_add("vk_printscreen",vk_printscreen);
	gml_const_add("vk_left",vk_left);
	gml_const_add("vk_right",vk_right);
	gml_const_add("vk_up",vk_up);
	gml_const_add("vk_down",vk_down);
	gml_const_add("vk_home",vk_home);
	gml_const_add("vk_end",vk_end);
	gml_const_add("vk_delete",vk_delete);
}

#define __lnc_const_decl_f5
if (live_enabled) {
	gml_const_add("vk_insert",vk_insert);
	gml_const_add("vk_pageup",vk_pageup);
	gml_const_add("vk_pagedown",vk_pagedown);
	gml_const_add("vk_f1",vk_f1);
	gml_const_add("vk_f2",vk_f2);
	gml_const_add("vk_f3",vk_f3);
	gml_const_add("vk_f4",vk_f4);
	gml_const_add("vk_f5",vk_f5);
	gml_const_add("vk_f6",vk_f6);
	gml_const_add("vk_f7",vk_f7);
	gml_const_add("vk_f8",vk_f8);
	gml_const_add("vk_f9",vk_f9);
	gml_const_add("vk_f10",vk_f10);
	gml_const_add("vk_f11",vk_f11);
	gml_const_add("vk_f12",vk_f12);
	gml_const_add("vk_numpad0",vk_numpad0);
	gml_const_add("vk_numpad1",vk_numpad1);
	gml_const_add("vk_numpad2",vk_numpad2);
	gml_const_add("vk_numpad3",vk_numpad3);
	gml_const_add("vk_numpad4",vk_numpad4);
	gml_const_add("vk_numpad5",vk_numpad5);
	gml_const_add("vk_numpad6",vk_numpad6);
	gml_const_add("vk_numpad7",vk_numpad7);
	gml_const_add("vk_numpad8",vk_numpad8);
	gml_const_add("vk_numpad9",vk_numpad9);
	gml_const_add("vk_divide",vk_divide);
	gml_const_add("vk_multiply",vk_multiply);
	gml_const_add("vk_subtract",vk_subtract);
	gml_const_add("vk_add",vk_add);
	gml_const_add("vk_decimal",vk_decimal);
	gml_const_add("vk_lshift",vk_lshift);
	gml_const_add("vk_lcontrol",vk_lcontrol);
}

#define __lnc_const_decl_f6
if (live_enabled) {
	gml_const_add("vk_lalt",vk_lalt);
	gml_const_add("vk_rshift",vk_rshift);
	gml_const_add("vk_rcontrol",vk_rcontrol);
	gml_const_add("vk_ralt",vk_ralt);
	gml_const_add("mb_any",mb_any);
	gml_const_add("mb_none",mb_none);
	gml_const_add("mb_left",mb_left);
	gml_const_add("mb_right",mb_right);
	gml_const_add("mb_middle",mb_middle);
	gml_const_add("bboxmode_automatic",bboxmode_automatic);
	gml_const_add("bboxmode_fullimage",bboxmode_fullimage);
	gml_const_add("bboxmode_manual",bboxmode_manual);
	gml_const_add("bboxkind_precise",bboxkind_precise);
	gml_const_add("bboxkind_rectangular",bboxkind_rectangular);
	gml_const_add("bboxkind_ellipse",bboxkind_ellipse);
	gml_const_add("bboxkind_diamond",bboxkind_diamond);
	gml_const_add("c_aqua",c_aqua);
	gml_const_add("c_black",c_black);
	gml_const_add("c_blue",c_blue);
	gml_const_add("c_dkgray",c_dkgray);
	gml_const_add("c_fuchsia",c_fuchsia);
	gml_const_add("c_gray",c_gray);
	gml_const_add("c_green",c_green);
	gml_const_add("c_lime",c_lime);
	gml_const_add("c_ltgray",c_ltgray);
	gml_const_add("c_maroon",c_maroon);
	gml_const_add("c_navy",c_navy);
	gml_const_add("c_olive",c_olive);
	gml_const_add("c_purple",c_purple);
	gml_const_add("c_red",c_red);
	gml_const_add("c_silver",c_silver);
	gml_const_add("c_teal",c_teal);
}

#define __lnc_const_decl_f7
if (live_enabled) {
	gml_const_add("c_white",c_white);
	gml_const_add("c_yellow",c_yellow);
	gml_const_add("c_orange",c_orange);
	gml_const_add("fa_left",fa_left);
	gml_const_add("fa_center",fa_center);
	gml_const_add("fa_right",fa_right);
	gml_const_add("fa_top",fa_top);
	gml_const_add("fa_middle",fa_middle);
	gml_const_add("fa_bottom",fa_bottom);
	gml_const_add("pr_pointlist",pr_pointlist);
	gml_const_add("pr_linelist",pr_linelist);
	gml_const_add("pr_linestrip",pr_linestrip);
	gml_const_add("pr_trianglelist",pr_trianglelist);
	gml_const_add("pr_trianglestrip",pr_trianglestrip);
	gml_const_add("pr_trianglefan",pr_trianglefan);
	gml_const_add("bm_normal",bm_normal);
	gml_const_add("bm_add",bm_add);
	gml_const_add("bm_max",bm_max);
	gml_const_add("bm_subtract",bm_subtract);
	gml_const_add("bm_zero",bm_zero);
	gml_const_add("bm_one",bm_one);
	gml_const_add("bm_src_colour",bm_src_colour);
	gml_const_add("bm_inv_src_colour",bm_inv_src_colour);
	gml_const_add("bm_src_color",bm_src_color);
	gml_const_add("bm_inv_src_color",bm_inv_src_color);
	gml_const_add("bm_src_alpha",bm_src_alpha);
	gml_const_add("bm_inv_src_alpha",bm_inv_src_alpha);
	gml_const_add("bm_dest_alpha",bm_dest_alpha);
	gml_const_add("bm_inv_dest_alpha",bm_inv_dest_alpha);
	gml_const_add("bm_dest_colour",bm_dest_colour);
	gml_const_add("bm_inv_dest_colour",bm_inv_dest_colour);
	gml_const_add("bm_dest_color",bm_dest_color);
}

#define __lnc_const_decl_f8
if (live_enabled) {
	gml_const_add("bm_inv_dest_color",bm_inv_dest_color);
	gml_const_add("bm_src_alpha_sat",bm_src_alpha_sat);
	gml_const_add("tf_point",tf_point);
	gml_const_add("tf_linear",tf_linear);
	gml_const_add("tf_anisotropic",tf_anisotropic);
	gml_const_add("mip_off",mip_off);
	gml_const_add("mip_on",mip_on);
	gml_const_add("mip_markedonly",mip_markedonly);
	gml_const_add("audio_falloff_none",audio_falloff_none);
	gml_const_add("audio_falloff_inverse_distance",audio_falloff_inverse_distance);
	gml_const_add("audio_falloff_inverse_distance_clamped",audio_falloff_inverse_distance_clamped);
	gml_const_add("audio_falloff_linear_distance",audio_falloff_linear_distance);
	gml_const_add("audio_falloff_linear_distance_clamped",audio_falloff_linear_distance_clamped);
	gml_const_add("audio_falloff_exponent_distance",audio_falloff_exponent_distance);
	gml_const_add("audio_falloff_exponent_distance_clamped",audio_falloff_exponent_distance_clamped);
	gml_const_add("audio_mono",audio_mono);
	gml_const_add("audio_stereo",audio_stereo);
	gml_const_add("audio_3d",audio_3d);
	gml_const_add("cr_default",cr_default);
	gml_const_add("cr_none",cr_none);
	gml_const_add("cr_arrow",cr_arrow);
	gml_const_add("cr_cross",cr_cross);
	gml_const_add("cr_beam",cr_beam);
	gml_const_add("cr_size_nesw",cr_size_nesw);
	gml_const_add("cr_size_ns",cr_size_ns);
	gml_const_add("cr_size_nwse",cr_size_nwse);
	gml_const_add("cr_size_we",cr_size_we);
	gml_const_add("cr_uparrow",cr_uparrow);
	gml_const_add("cr_hourglass",cr_hourglass);
	gml_const_add("cr_drag",cr_drag);
	gml_const_add("cr_appstart",cr_appstart);
	gml_const_add("cr_handpoint",cr_handpoint);
}

#define __lnc_const_decl_f9
if (live_enabled) {
	gml_const_add("cr_size_all",cr_size_all);
	gml_const_add("spritespeed_framespersecond",spritespeed_framespersecond);
	gml_const_add("spritespeed_framespergameframe",spritespeed_framespergameframe);
	gml_const_add("asset_object",asset_object);
	gml_const_add("asset_unknown",asset_unknown);
	gml_const_add("asset_sprite",asset_sprite);
	gml_const_add("asset_sound",asset_sound);
	gml_const_add("asset_room",asset_room);
	gml_const_add("asset_path",asset_path);
	gml_const_add("asset_script",asset_script);
	gml_const_add("asset_font",asset_font);
	gml_const_add("asset_timeline",asset_timeline);
	gml_const_add("asset_tiles",asset_tiles);
	gml_const_add("asset_shader",asset_shader);
	gml_const_add("fa_readonly",fa_readonly);
	gml_const_add("fa_hidden",fa_hidden);
	gml_const_add("fa_sysfile",fa_sysfile);
	gml_const_add("fa_volumeid",fa_volumeid);
	gml_const_add("fa_directory",fa_directory);
	gml_const_add("fa_archive",fa_archive);
	gml_const_add("ds_type_map",ds_type_map);
	gml_const_add("ds_type_list",ds_type_list);
	gml_const_add("ds_type_stack",ds_type_stack);
	gml_const_add("ds_type_queue",ds_type_queue);
	gml_const_add("ds_type_grid",ds_type_grid);
	gml_const_add("ds_type_priority",ds_type_priority);
	gml_const_add("ef_explosion",ef_explosion);
	gml_const_add("ef_ring",ef_ring);
	gml_const_add("ef_ellipse",ef_ellipse);
	gml_const_add("ef_firework",ef_firework);
	gml_const_add("ef_smoke",ef_smoke);
	gml_const_add("ef_smokeup",ef_smokeup);
}

#define __lnc_const_decl_f10
if (live_enabled) {
	gml_const_add("ef_star",ef_star);
	gml_const_add("ef_spark",ef_spark);
	gml_const_add("ef_flare",ef_flare);
	gml_const_add("ef_cloud",ef_cloud);
	gml_const_add("ef_rain",ef_rain);
	gml_const_add("ef_snow",ef_snow);
	gml_const_add("pt_shape_pixel",pt_shape_pixel);
	gml_const_add("pt_shape_disk",pt_shape_disk);
	gml_const_add("pt_shape_square",pt_shape_square);
	gml_const_add("pt_shape_line",pt_shape_line);
	gml_const_add("pt_shape_star",pt_shape_star);
	gml_const_add("pt_shape_circle",pt_shape_circle);
	gml_const_add("pt_shape_ring",pt_shape_ring);
	gml_const_add("pt_shape_sphere",pt_shape_sphere);
	gml_const_add("pt_shape_flare",pt_shape_flare);
	gml_const_add("pt_shape_spark",pt_shape_spark);
	gml_const_add("pt_shape_explosion",pt_shape_explosion);
	gml_const_add("pt_shape_cloud",pt_shape_cloud);
	gml_const_add("pt_shape_smoke",pt_shape_smoke);
	gml_const_add("pt_shape_snow",pt_shape_snow);
	gml_const_add("ps_distr_linear",ps_distr_linear);
	gml_const_add("ps_distr_gaussian",ps_distr_gaussian);
	gml_const_add("ps_distr_invgaussian",ps_distr_invgaussian);
	gml_const_add("ps_shape_rectangle",ps_shape_rectangle);
	gml_const_add("ps_shape_ellipse",ps_shape_ellipse);
	gml_const_add("ps_shape_diamond",ps_shape_diamond);
	gml_const_add("ps_shape_line",ps_shape_line);
	gml_const_add("matrix_view",matrix_view);
	gml_const_add("matrix_projection",matrix_projection);
	gml_const_add("matrix_world",matrix_world);
	gml_const_add("os_windows",os_windows);
	gml_const_add("os_macosx",os_macosx);
}

#define __lnc_const_decl_f11
if (live_enabled) {
	gml_const_add("os_ios",os_ios);
	gml_const_add("os_android",os_android);
	gml_const_add("os_linux",os_linux);
	gml_const_add("os_unknown",os_unknown);
	gml_const_add("os_winphone",os_winphone);
	gml_const_add("os_win8native",os_win8native);
	gml_const_add("os_psvita",os_psvita);
	gml_const_add("os_ps4",os_ps4);
	gml_const_add("os_xboxone",os_xboxone);
	gml_const_add("os_ps3",os_ps3);
	gml_const_add("os_uwp",os_uwp);
	gml_const_add("os_tvos",os_tvos);
	gml_const_add("os_switch",os_switch);
	gml_const_add("browser_not_a_browser",browser_not_a_browser);
	gml_const_add("browser_unknown",browser_unknown);
	gml_const_add("browser_ie",browser_ie);
	gml_const_add("browser_firefox",browser_firefox);
	gml_const_add("browser_chrome",browser_chrome);
	gml_const_add("browser_safari",browser_safari);
	gml_const_add("browser_safari_mobile",browser_safari_mobile);
	gml_const_add("browser_opera",browser_opera);
	gml_const_add("browser_tizen",browser_tizen);
	gml_const_add("browser_edge",browser_edge);
	gml_const_add("browser_windows_store",browser_windows_store);
	gml_const_add("browser_ie_mobile",browser_ie_mobile);
	gml_const_add("device_ios_unknown",device_ios_unknown);
	gml_const_add("device_ios_iphone",device_ios_iphone);
	gml_const_add("device_ios_iphone_retina",device_ios_iphone_retina);
	gml_const_add("device_ios_ipad",device_ios_ipad);
	gml_const_add("device_ios_ipad_retina",device_ios_ipad_retina);
	gml_const_add("device_ios_iphone5",device_ios_iphone5);
	gml_const_add("device_ios_iphone6",device_ios_iphone6);
}

#define __lnc_const_decl_f12
if (live_enabled) {
	gml_const_add("device_ios_iphone6plus",device_ios_iphone6plus);
	gml_const_add("device_emulator",device_emulator);
	gml_const_add("device_tablet",device_tablet);
	gml_const_add("display_landscape",display_landscape);
	gml_const_add("display_landscape_flipped",display_landscape_flipped);
	gml_const_add("display_portrait",display_portrait);
	gml_const_add("display_portrait_flipped",display_portrait_flipped);
	gml_const_add("tm_sleep",tm_sleep);
	gml_const_add("tm_countvsyncs",tm_countvsyncs);
	gml_const_add("of_challenge_win",of_challenge_win);
	gml_const_add("of_challenge_lose",of_challenge_lose);
	gml_const_add("of_challenge_tie",of_challenge_tie);
	gml_const_add("cmpfunc_never",cmpfunc_never);
	gml_const_add("cmpfunc_less",cmpfunc_less);
	gml_const_add("cmpfunc_equal",cmpfunc_equal);
	gml_const_add("cmpfunc_lessequal",cmpfunc_lessequal);
	gml_const_add("cmpfunc_greater",cmpfunc_greater);
	gml_const_add("cmpfunc_notequal",cmpfunc_notequal);
	gml_const_add("cmpfunc_greaterequal",cmpfunc_greaterequal);
	gml_const_add("cmpfunc_always",cmpfunc_always);
	gml_const_add("cull_noculling",cull_noculling);
	gml_const_add("cull_clockwise",cull_clockwise);
	gml_const_add("cull_counterclockwise",cull_counterclockwise);
	gml_const_add("lighttype_dir",lighttype_dir);
	gml_const_add("lighttype_point",lighttype_point);
	gml_const_add("phy_joint_anchor_1_x",phy_joint_anchor_1_x);
	gml_const_add("phy_joint_anchor_1_y",phy_joint_anchor_1_y);
	gml_const_add("phy_joint_anchor_2_x",phy_joint_anchor_2_x);
	gml_const_add("phy_joint_anchor_2_y",phy_joint_anchor_2_y);
	gml_const_add("phy_joint_reaction_force_x",phy_joint_reaction_force_x);
	gml_const_add("phy_joint_reaction_force_y",phy_joint_reaction_force_y);
	gml_const_add("phy_joint_reaction_torque",phy_joint_reaction_torque);
}

#define __lnc_const_decl_f13
if (live_enabled) {
	gml_const_add("phy_joint_motor_speed",phy_joint_motor_speed);
	gml_const_add("phy_joint_angle",phy_joint_angle);
	gml_const_add("phy_joint_motor_torque",phy_joint_motor_torque);
	gml_const_add("phy_joint_max_motor_torque",phy_joint_max_motor_torque);
	gml_const_add("phy_joint_translation",phy_joint_translation);
	gml_const_add("phy_joint_speed",phy_joint_speed);
	gml_const_add("phy_joint_motor_force",phy_joint_motor_force);
	gml_const_add("phy_joint_max_motor_force",phy_joint_max_motor_force);
	gml_const_add("phy_joint_length_1",phy_joint_length_1);
	gml_const_add("phy_joint_length_2",phy_joint_length_2);
	gml_const_add("phy_joint_damping_ratio",phy_joint_damping_ratio);
	gml_const_add("phy_joint_frequency",phy_joint_frequency);
	gml_const_add("phy_joint_lower_angle_limit",phy_joint_lower_angle_limit);
	gml_const_add("phy_joint_upper_angle_limit",phy_joint_upper_angle_limit);
	gml_const_add("phy_joint_angle_limits",phy_joint_angle_limits);
	gml_const_add("phy_joint_max_length",phy_joint_max_length);
	gml_const_add("phy_joint_max_torque",phy_joint_max_torque);
	gml_const_add("phy_joint_max_force",phy_joint_max_force);
	gml_const_add("phy_debug_render_aabb",phy_debug_render_aabb);
	gml_const_add("phy_debug_render_collision_pairs",phy_debug_render_collision_pairs);
	gml_const_add("phy_debug_render_coms",phy_debug_render_coms);
	gml_const_add("phy_debug_render_core_shapes",phy_debug_render_core_shapes);
	gml_const_add("phy_debug_render_joints",phy_debug_render_joints);
	gml_const_add("phy_debug_render_obb",phy_debug_render_obb);
	gml_const_add("phy_debug_render_shapes",phy_debug_render_shapes);
	gml_const_add("phy_particle_flag_water",phy_particle_flag_water);
	gml_const_add("phy_particle_flag_zombie",phy_particle_flag_zombie);
	gml_const_add("phy_particle_flag_wall",phy_particle_flag_wall);
	gml_const_add("phy_particle_flag_spring",phy_particle_flag_spring);
	gml_const_add("phy_particle_flag_elastic",phy_particle_flag_elastic);
	gml_const_add("phy_particle_flag_viscous",phy_particle_flag_viscous);
	gml_const_add("phy_particle_flag_powder",phy_particle_flag_powder);
}

#define __lnc_const_decl_f14
if (live_enabled) {
	gml_const_add("phy_particle_flag_tensile",phy_particle_flag_tensile);
	gml_const_add("phy_particle_flag_colourmixing",phy_particle_flag_colourmixing);
	gml_const_add("phy_particle_group_flag_solid",phy_particle_group_flag_solid);
	gml_const_add("phy_particle_group_flag_rigid",phy_particle_group_flag_rigid);
	gml_const_add("phy_particle_data_flag_typeflags",phy_particle_data_flag_typeflags);
	gml_const_add("phy_particle_data_flag_position",phy_particle_data_flag_position);
	gml_const_add("phy_particle_data_flag_velocity",phy_particle_data_flag_velocity);
	gml_const_add("phy_particle_data_flag_colour",phy_particle_data_flag_colour);
	gml_const_add("phy_particle_data_flag_category",phy_particle_data_flag_category);
	gml_const_add("network_socket_tcp",network_socket_tcp);
	gml_const_add("network_socket_udp",network_socket_udp);
	gml_const_add("network_socket_ws",network_socket_ws);
	gml_const_add("network_socket_bluetooth",network_socket_bluetooth);
	gml_const_add("network_type_connect",network_type_connect);
	gml_const_add("network_type_disconnect",network_type_disconnect);
	gml_const_add("network_type_data",network_type_data);
	gml_const_add("network_type_non_blocking_connect",network_type_non_blocking_connect);
	gml_const_add("network_config_connect_timeout",network_config_connect_timeout);
	gml_const_add("network_config_use_non_blocking_socket",network_config_use_non_blocking_socket);
	gml_const_add("network_config_enable_reliable_udp",network_config_enable_reliable_udp);
	gml_const_add("network_config_disable_reliable_udp",network_config_disable_reliable_udp);
	gml_const_add("buffer_fixed",buffer_fixed);
	gml_const_add("buffer_grow",buffer_grow);
	gml_const_add("buffer_wrap",buffer_wrap);
	gml_const_add("buffer_fast",buffer_fast);
	gml_const_add("buffer_vbuffer",buffer_vbuffer);
	gml_const_add("buffer_u8",buffer_u8);
	gml_const_add("buffer_s8",buffer_s8);
	gml_const_add("buffer_u16",buffer_u16);
	gml_const_add("buffer_s16",buffer_s16);
	gml_const_add("buffer_u32",buffer_u32);
	gml_const_add("buffer_s32",buffer_s32);
}

#define __lnc_const_decl_f15
if (live_enabled) {
	gml_const_add("buffer_u64",buffer_u64);
	gml_const_add("buffer_f16",buffer_f16);
	gml_const_add("buffer_f32",buffer_f32);
	gml_const_add("buffer_f64",buffer_f64);
	gml_const_add("buffer_bool",buffer_bool);
	gml_const_add("buffer_text",buffer_text);
	gml_const_add("buffer_string",buffer_string);
	gml_const_add("buffer_surface_copy",buffer_surface_copy);
	gml_const_add("buffer_seek_start",buffer_seek_start);
	gml_const_add("buffer_seek_relative",buffer_seek_relative);
	gml_const_add("buffer_seek_end",buffer_seek_end);
	gml_const_add("gp_face1",gp_face1);
	gml_const_add("gp_face2",gp_face2);
	gml_const_add("gp_face3",gp_face3);
	gml_const_add("gp_face4",gp_face4);
	gml_const_add("gp_shoulderl",gp_shoulderl);
	gml_const_add("gp_shoulderr",gp_shoulderr);
	gml_const_add("gp_shoulderlb",gp_shoulderlb);
	gml_const_add("gp_shoulderrb",gp_shoulderrb);
	gml_const_add("gp_select",gp_select);
	gml_const_add("gp_start",gp_start);
	gml_const_add("gp_stickl",gp_stickl);
	gml_const_add("gp_stickr",gp_stickr);
	gml_const_add("gp_padu",gp_padu);
	gml_const_add("gp_padd",gp_padd);
	gml_const_add("gp_padl",gp_padl);
	gml_const_add("gp_padr",gp_padr);
	gml_const_add("gp_axislh",gp_axislh);
	gml_const_add("gp_axislv",gp_axislv);
	gml_const_add("gp_axisrh",gp_axisrh);
	gml_const_add("gp_axisrv",gp_axisrv);
	gml_const_add("ov_friends",ov_friends);
}

#define __lnc_const_decl_f16
if (live_enabled) {
	gml_const_add("ov_community",ov_community);
	gml_const_add("ov_players",ov_players);
	gml_const_add("ov_settings",ov_settings);
	gml_const_add("ov_gamegroup",ov_gamegroup);
	gml_const_add("ov_achievements",ov_achievements);
	gml_const_add("lb_sort_none",lb_sort_none);
	gml_const_add("lb_sort_ascending",lb_sort_ascending);
	gml_const_add("lb_sort_descending",lb_sort_descending);
	gml_const_add("lb_disp_none",lb_disp_none);
	gml_const_add("lb_disp_numeric",lb_disp_numeric);
	gml_const_add("lb_disp_time_sec",lb_disp_time_sec);
	gml_const_add("lb_disp_time_ms",lb_disp_time_ms);
	gml_const_add("ugc_result_success",ugc_result_success);
	gml_const_add("ugc_filetype_community",ugc_filetype_community);
	gml_const_add("ugc_filetype_microtrans",ugc_filetype_microtrans);
	gml_const_add("ugc_visibility_public",ugc_visibility_public);
	gml_const_add("ugc_visibility_friends_only",ugc_visibility_friends_only);
	gml_const_add("ugc_visibility_private",ugc_visibility_private);
	gml_const_add("ugc_query_RankedByVote",ugc_query_RankedByVote);
	gml_const_add("ugc_query_RankedByPublicationDate",ugc_query_RankedByPublicationDate);
	gml_const_add("ugc_query_AcceptedForGameRankedByAcceptanceDate",ugc_query_AcceptedForGameRankedByAcceptanceDate);
	gml_const_add("ugc_query_RankedByTrend",ugc_query_RankedByTrend);
	gml_const_add("ugc_query_FavoritedByFriendsRankedByPublicationDate",ugc_query_FavoritedByFriendsRankedByPublicationDate);
	gml_const_add("ugc_query_CreatedByFriendsRankedByPublicationDate",ugc_query_CreatedByFriendsRankedByPublicationDate);
	gml_const_add("ugc_query_RankedByNumTimesReported",ugc_query_RankedByNumTimesReported);
	gml_const_add("ugc_query_CreatedByFollowedUsersRankedByPublicationDate",ugc_query_CreatedByFollowedUsersRankedByPublicationDate);
	gml_const_add("ugc_query_NotYetRated",ugc_query_NotYetRated);
	gml_const_add("ugc_query_RankedByTotalVotesAsc",ugc_query_RankedByTotalVotesAsc);
	gml_const_add("ugc_query_RankedByVotesUp",ugc_query_RankedByVotesUp);
	gml_const_add("ugc_query_RankedByTextSearch",ugc_query_RankedByTextSearch);
	gml_const_add("ugc_sortorder_CreationOrderDesc",ugc_sortorder_CreationOrderDesc);
	gml_const_add("ugc_sortorder_CreationOrderAsc",ugc_sortorder_CreationOrderAsc);
}

#define __lnc_const_decl_f17
if (live_enabled) {
	gml_const_add("ugc_sortorder_TitleAsc",ugc_sortorder_TitleAsc);
	gml_const_add("ugc_sortorder_LastUpdatedDesc",ugc_sortorder_LastUpdatedDesc);
	gml_const_add("ugc_sortorder_SubscriptionDateDesc",ugc_sortorder_SubscriptionDateDesc);
	gml_const_add("ugc_sortorder_VoteScoreDesc",ugc_sortorder_VoteScoreDesc);
	gml_const_add("ugc_sortorder_ForModeration",ugc_sortorder_ForModeration);
	gml_const_add("ugc_list_Published",ugc_list_Published);
	gml_const_add("ugc_list_VotedOn",ugc_list_VotedOn);
	gml_const_add("ugc_list_VotedUp",ugc_list_VotedUp);
	gml_const_add("ugc_list_VotedDown",ugc_list_VotedDown);
	gml_const_add("ugc_list_WillVoteLater",ugc_list_WillVoteLater);
	gml_const_add("ugc_list_Favorited",ugc_list_Favorited);
	gml_const_add("ugc_list_Subscribed",ugc_list_Subscribed);
	gml_const_add("ugc_list_UsedOrPlayed",ugc_list_UsedOrPlayed);
	gml_const_add("ugc_list_Followed",ugc_list_Followed);
	gml_const_add("ugc_match_Items",ugc_match_Items);
	gml_const_add("ugc_match_Items_Mtx",ugc_match_Items_Mtx);
	gml_const_add("ugc_match_Items_ReadyToUse",ugc_match_Items_ReadyToUse);
	gml_const_add("ugc_match_Collections",ugc_match_Collections);
	gml_const_add("ugc_match_Artwork",ugc_match_Artwork);
	gml_const_add("ugc_match_Videos",ugc_match_Videos);
	gml_const_add("ugc_match_Screenshots",ugc_match_Screenshots);
	gml_const_add("ugc_match_AllGuides",ugc_match_AllGuides);
	gml_const_add("ugc_match_WebGuides",ugc_match_WebGuides);
	gml_const_add("ugc_match_IntegratedGuides",ugc_match_IntegratedGuides);
	gml_const_add("ugc_match_UsableInGame",ugc_match_UsableInGame);
	gml_const_add("ugc_match_ControllerBindings",ugc_match_ControllerBindings);
	gml_const_add("vertex_usage_position",vertex_usage_position);
	gml_const_add("vertex_usage_colour",vertex_usage_colour);
	gml_const_add("vertex_usage_normal",vertex_usage_normal);
	gml_const_add("vertex_usage_texcoord",vertex_usage_texcoord);
	gml_const_add("vertex_usage_blendweight",vertex_usage_blendweight);
	gml_const_add("vertex_usage_blendindices",vertex_usage_blendindices);
}

#define __lnc_const_decl_f18
if (live_enabled) {
	gml_const_add("vertex_usage_psize",vertex_usage_psize);
	gml_const_add("vertex_usage_tangent",vertex_usage_tangent);
	gml_const_add("vertex_usage_binormal",vertex_usage_binormal);
	gml_const_add("vertex_usage_fog",vertex_usage_fog);
	gml_const_add("vertex_usage_depth",vertex_usage_depth);
	gml_const_add("vertex_usage_sample",vertex_usage_sample);
	gml_const_add("vertex_type_float1",vertex_type_float1);
	gml_const_add("vertex_type_float2",vertex_type_float2);
	gml_const_add("vertex_type_float3",vertex_type_float3);
	gml_const_add("vertex_type_float4",vertex_type_float4);
	gml_const_add("vertex_type_colour",vertex_type_colour);
	gml_const_add("vertex_type_ubyte4",vertex_type_ubyte4);
	gml_const_add("layerelementtype_undefined",layerelementtype_undefined);
	gml_const_add("layerelementtype_background",layerelementtype_background);
	gml_const_add("layerelementtype_instance",layerelementtype_instance);
	gml_const_add("layerelementtype_oldtilemap",layerelementtype_oldtilemap);
	gml_const_add("layerelementtype_sprite",layerelementtype_sprite);
	gml_const_add("layerelementtype_tilemap",layerelementtype_tilemap);
	gml_const_add("layerelementtype_particlesystem",layerelementtype_particlesystem);
	gml_const_add("layerelementtype_tile",layerelementtype_tile);
	gml_const_add("tile_rotate",tile_rotate);
	gml_const_add("tile_flip",tile_flip);
	gml_const_add("tile_mirror",tile_mirror);
	gml_const_add("tile_index_mask",tile_index_mask);
	gml_const_add("kbv_type_default",kbv_type_default);
	gml_const_add("kbv_type_ascii",kbv_type_ascii);
	gml_const_add("kbv_type_url",kbv_type_url);
	gml_const_add("kbv_type_email",kbv_type_email);
	gml_const_add("kbv_type_numbers",kbv_type_numbers);
	gml_const_add("kbv_type_phone",kbv_type_phone);
	gml_const_add("kbv_type_phone_name",kbv_type_phone_name);
	gml_const_add("kbv_returnkey_default",kbv_returnkey_default);
}

#define __lnc_const_decl_f19
if (live_enabled) {
	gml_const_add("kbv_returnkey_go",kbv_returnkey_go);
	gml_const_add("kbv_returnkey_google",kbv_returnkey_google);
	gml_const_add("kbv_returnkey_join",kbv_returnkey_join);
	gml_const_add("kbv_returnkey_next",kbv_returnkey_next);
	gml_const_add("kbv_returnkey_route",kbv_returnkey_route);
	gml_const_add("kbv_returnkey_search",kbv_returnkey_search);
	gml_const_add("kbv_returnkey_send",kbv_returnkey_send);
	gml_const_add("kbv_returnkey_yahoo",kbv_returnkey_yahoo);
	gml_const_add("kbv_returnkey_done",kbv_returnkey_done);
	gml_const_add("kbv_returnkey_continue",kbv_returnkey_continue);
	gml_const_add("kbv_returnkey_emergency",kbv_returnkey_emergency);
	gml_const_add("kbv_autocapitalize_none",kbv_autocapitalize_none);
	gml_const_add("kbv_autocapitalize_words",kbv_autocapitalize_words);
	gml_const_add("kbv_autocapitalize_sentences",kbv_autocapitalize_sentences);
	gml_const_add("kbv_autocapitalize_characters",kbv_autocapitalize_characters);
	gml_const_add("os_permission_denied_dont_request",os_permission_denied_dont_request);
	gml_const_add("os_permission_denied",os_permission_denied);
	gml_const_add("os_permission_granted",os_permission_granted);
}

#define __lnc_const_decl
if (live_enabled) {
	__lnc_const_decl_f0();
	__lnc_const_decl_f1();
	__lnc_const_decl_f2();
	__lnc_const_decl_f3();
	__lnc_const_decl_f4();
	__lnc_const_decl_f5();
	__lnc_const_decl_f6();
	__lnc_const_decl_f7();
	__lnc_const_decl_f8();
	__lnc_const_decl_f9();
	__lnc_const_decl_f10();
	__lnc_const_decl_f11();
	__lnc_const_decl_f12();
	__lnc_const_decl_f13();
	__lnc_const_decl_f14();
	__lnc_const_decl_f15();
	__lnc_const_decl_f16();
	__lnc_const_decl_f17();
	__lnc_const_decl_f18();
	__lnc_const_decl_f19();
}
