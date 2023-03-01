// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.
// Feather disable all

if(live_enabled)
function gml_seek_set_op_resolve_set_op_rfn(l_q,l_st){
	var l__g=l_q;
	switch(l__g.__enumIndex__){
		case 64:
			if(gml_node_tools_equals(gml_seek_set_op_resolve_set_op_xw,l__g.h_x)){
				gml_seek_set_op_resolve_set_op_safe=true;
				return true;
			}
			break;
		case 65:
			if(gml_node_tools_equals(gml_seek_set_op_resolve_set_op_xw,l__g.h_x)){
				gml_seek_set_op_resolve_set_op_safe=true;
				return true;
			}
			break;
		case 67:
			if(gml_node_tools_equals(gml_seek_set_op_resolve_set_op_xw,l__g.h_x)){
				gml_seek_set_op_resolve_set_op_safe=true;
				return true;
			}
			break;
		case 68:
			if(gml_node_tools_equals(gml_seek_set_op_resolve_set_op_xw,l__g.h_x)){
				gml_seek_set_op_resolve_set_op_safe=true;
				return true;
			}
			break;
		case 36:
			var l_x2=l__g.h_a;
			var l_v2=l__g.h_b;
			if(gml_node_tools_equals(gml_seek_set_op_resolve_set_op_xw,l_x2)){
				var l__g1=l_v2;
				gml_seek_set_op_resolve_set_op_safe=(l__g1.__enumIndex__==5);
				return true;
			}
			break;
	}
	return gml_node_tools_seek_all(l_q,l_st,gml_seek_set_op_resolve_set_op_rfn);
}

if(live_enabled)
function gml_seek_set_op_proc(l_q,l_st){
	var l__g=l_q;
	if(l__g.__enumIndex__==36){
		var l_d=l__g.h_d;
		var l_o=l__g.h_o;
		var l_x=l__g.h_a;
		var l_v=l__g.h_b;
		var l__g=gml_node_tools_unpack(l_x);
		switch(l__g.__enumIndex__){
			case 42:
				var l_s=l__g.h_id;
				if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_local_aop(l_d,l_s,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_local_set(l_d,l_s,l_v));
				break;
			case 45:
				var l_s=l__g.h_id;
				if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_global_aop(l_d,l_s,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_global_set(l_d,l_s,l_v));
				break;
			case 19:break;
			case 20:break;
			case 48:
				var l_x1=l__g.h_x;
				var l_s=l__g.h_fd;
				if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_field_aop(l_d,l_x1,l_s,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_field_set(l_d,l_x1,l_s,l_v));
				break;
			case 60:
				var l_x1=l__g.h_x;
				var l_i=l__g.h_i;
				if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_alarm_aop(l_d,l_x1,l_i,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_alarm_set_hx(l_d,l_x1,l_i,l_v));
				break;
			case 63:
				var l_xd=l__g.h_d;
				var l_xw=l__g.h_x;
				var l__g1=l_x;
				switch(l__g1.__enumIndex__){
					case 63:
						var l_xi=l__g1.h_id;
						if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_index_aop(l_xd,l_xw,l_xi,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_index_set(l_xd,l_xw,l_xi,l_v));
						break;
					case 66:
						var l_i1=l__g1.h_i1;
						var l_i2=l__g1.h_i2;
						if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_index2d_aop(l_xd,l_xw,l_i1,l_i2,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_index2d_set(l_xd,l_xw,l_i1,l_i2,l_v));
						break;
				}
				gml_seek_set_op_resolve_set_op_safe=false;
				gml_seek_set_op_resolve_set_op_xw=l_xw;
				gml_node_tools_seek_all_out(l_q,l_st,gml_seek_set_op_resolve_set_op_rfn,0);
				var l_expr=l_xw;
				while(l_expr!=undefined){
					var l__g1=l_expr;
					switch(l__g1.__enumIndex__){
						case 42:
							gml_std_haxe_enum_tools_setTo(l_expr,gml_node_ensure_array_for_local(l__g1.h_d,l__g1.h_id));
							l_expr=undefined;
							break;
						case 45:
							gml_std_haxe_enum_tools_setTo(l_expr,gml_node_ensure_array_for_global(l__g1.h_d,l__g1.h_id));
							l_expr=undefined;
							break;
						case 48:
							gml_std_haxe_enum_tools_setTo(l_expr,gml_node_ensure_array_for_field(l__g1.h_d,l__g1.h_x,l__g1.h_fd));
							l_expr=undefined;
							break;
						case 63:
							var l_x2=l__g1.h_x;
							gml_std_haxe_enum_tools_setTo(l_expr,gml_node_ensure_array_for_index(l__g1.h_d,l_x2,l__g1.h_id));
							l_expr=l_x2;
							break;
						case 66:
							var l_x3=l__g1.h_x;
							gml_std_haxe_enum_tools_setTo(l_expr,gml_node_ensure_array_for_index2d(l__g1.h_d,l_x3,l__g1.h_i1,l__g1.h_i2));
							l_expr=l_x3;
							break;
						default:l_expr=undefined;
					}
				}
				break;
			case 66:
				var l_xd=l__g.h_d;
				var l_xw=l__g.h_x;
				var l__g1=l_x;
				switch(l__g1.__enumIndex__){
					case 63:
						var l_xi=l__g1.h_id;
						if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_index_aop(l_xd,l_xw,l_xi,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_index_set(l_xd,l_xw,l_xi,l_v));
						break;
					case 66:
						var l_i1=l__g1.h_i1;
						var l_i2=l__g1.h_i2;
						if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_index2d_aop(l_xd,l_xw,l_i1,l_i2,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_index2d_set(l_xd,l_xw,l_i1,l_i2,l_v));
						break;
				}
				gml_seek_set_op_resolve_set_op_safe=false;
				gml_seek_set_op_resolve_set_op_xw=l_xw;
				gml_node_tools_seek_all_out(l_q,l_st,gml_seek_set_op_resolve_set_op_rfn,0);
				var l_expr=l_xw;
				while(l_expr!=undefined){
					var l__g1=l_expr;
					switch(l__g1.__enumIndex__){
						case 42:
							gml_std_haxe_enum_tools_setTo(l_expr,gml_node_ensure_array_for_local(l__g1.h_d,l__g1.h_id));
							l_expr=undefined;
							break;
						case 45:
							gml_std_haxe_enum_tools_setTo(l_expr,gml_node_ensure_array_for_global(l__g1.h_d,l__g1.h_id));
							l_expr=undefined;
							break;
						case 48:
							gml_std_haxe_enum_tools_setTo(l_expr,gml_node_ensure_array_for_field(l__g1.h_d,l__g1.h_x,l__g1.h_fd));
							l_expr=undefined;
							break;
						case 63:
							var l_x2=l__g1.h_x;
							gml_std_haxe_enum_tools_setTo(l_expr,gml_node_ensure_array_for_index(l__g1.h_d,l_x2,l__g1.h_id));
							l_expr=l_x2;
							break;
						case 66:
							var l_x3=l__g1.h_x;
							gml_std_haxe_enum_tools_setTo(l_expr,gml_node_ensure_array_for_index2d(l__g1.h_d,l_x3,l__g1.h_i1,l__g1.h_i2));
							l_expr=l_x3;
							break;
						default:l_expr=undefined;
					}
				}
				break;
			case 51:
				var l_av=l__g.h_v;
				var l_f=l_av.h_flags;
				if((l_f&1)==0){
					if((l_f&2)!=0){
						var l_k=gml_node_number(l_d,0,undefined);
						if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_env1d_aop(l_d,l_av,l_k,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_env1d_set(l_d,l_av,l_k,l_v));
					} else if(l_o!=-1){
						gml_std_haxe_enum_tools_setTo(l_q,gml_node_env_aop(l_d,l_av,l_o,l_v));
					} else gml_std_haxe_enum_tools_setTo(l_q,gml_node_env_set(l_d,l_av,l_v));
				} else return gml_program_seek_inst.h_error("`"+l_av.h_name+"` is read-only",l__g.h_d);
				break;
			case 54:
				var l_av=l__g.h_av;
				if((l_av.h_flags&1)==0){
					if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_env_fd_aop(l_d,l__g.h_x,l_av,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_env_fd_set(l_d,l__g.h_x,l_av,l_v));
				} else return gml_program_seek_inst.h_error("`"+l_av.h_name+"` is read-only",l__g.h_d);
				break;
			case 57:
				var l_av=l__g.h_v;
				if((l_av.h_flags&1)==0){
					if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_env1d_aop(l_d,l_av,l__g.h_k,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_env1d_set(l_d,l_av,l__g.h_k,l_v));
				} else return gml_program_seek_inst.h_error("`"+l_av.h_name+"` is read-only",l__g.h_d);
				break;
			case 75:
				var l_x1=l__g.h_lx;
				var l_k=l__g.h_id;
				if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_ds_list_aop(l_d,l_x1,l_k,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_ds_list_set_hx(l_d,l_x1,l_k,l_v));
				break;
			case 78:
				var l_x1=l__g.h_lx;
				var l_k=l__g.h_id;
				if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_ds_map_aop(l_d,l_x1,l_k,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_ds_map_set_hx(l_d,l_x1,l_k,l_v));
				break;
			case 81:
				var l_x1=l__g.h_lx;
				var l_i=l__g.h_i1;
				var l_k=l__g.h_i2;
				if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_ds_grid_aop(l_d,l_x1,l_i,l_k,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_ds_grid_set_hx(l_d,l_x1,l_i,l_k,l_v));
				break;
			case 69:
				var l_x1=l__g.h_x;
				var l_k=l__g.h_id;
				if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_raw_id_aop(l_d,l_x1,l_k,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_raw_id_set(l_d,l_x1,l_k,l_v));
				break;
			case 72:
				var l_x1=l__g.h_x;
				var l_i=l__g.h_i1;
				var l_k=l__g.h_i2;
				if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_raw_id2d_aop(l_d,l_x1,l_i,l_k,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_raw_id2d_set(l_d,l_x1,l_i,l_k,l_v));
				break;
			case 84:
				var l_x1=l__g.h_x;
				var l_k=l__g.h_id;
				if(l_o!=-1)gml_std_haxe_enum_tools_setTo(l_q,gml_node_key_id_aop(l_d,l_x1,l_k,l_o,l_v)); else gml_std_haxe_enum_tools_setTo(l_q,gml_node_key_id_set(l_d,l_x1,l_k,l_v));
				break;
			default:return gml_program_seek_inst.h_error("Expression is not settable",gml_std_haxe_enum_tools_getParameter(l_x,0));
		}
	}
	return gml_node_tools_seek(l_q,l_st,gml_program_seek_func);
}
