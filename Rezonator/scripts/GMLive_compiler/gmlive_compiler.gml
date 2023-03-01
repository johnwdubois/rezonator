// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.
// Feather disable all

// converts AST to "instructions"!
if(live_enabled)
function gml_compile_error(l_text,l_pos){
	gml_compile_error_text=l_pos.h_to_string()+" "+l_text;
	gml_compile_error_pos=l_pos;
	return true;
}

if(live_enabled)
function gml_compile_const_val_of(l_q){
	var l__g=l_q;
	var l_tmp;
	switch(l__g.__enumIndex__){
		case 0:l_tmp=undefined;break;
		case 1:l_tmp=l__g.h_value;break;
		case 2:l_tmp=l__g.h_value;break;
		case 3:l_tmp=l__g.h_value;break;
		case 18:l_tmp=gml_const_val.h_obj[$ l__g.h_id];break;
		default:return false;
	}
	gml_compile_const_val_of_val=l_tmp;
	return true;
}

if(live_enabled)
function gml_compile_set_handlers(l_fn,l_defNames){
	var l__g=0;
	while(l__g<array_length(l_defNames)){
		var l_defName=l_defNames[l__g];
		l__g++;
		var l_i=gml_compile_def_indexes.h_obj[$ l_defName];
		if(l_i==undefined)show_error("Couldn't find "+l_defName,true);
		if(gml_compile_handlers[l_i]!=undefined)trace("GmlCompile.hx:71:","Handler re-definition for "+l_defName);
		gml_compile_handlers[@l_i]=l_fn;
	}
}

if(live_enabled)
function gml_compile_init(){
	gml_compile_def_indexes=new haxe_ds_string_map();
	var l_names=gml_std_Type_getEnumConstructs(mt_gml_node);
	var l__g_current=0;
	var l__g_array=l_names;
	while(l__g_current<array_length(l__g_array)){
		var l_name=l__g_array[l__g_current];
		var l_i=l__g_current++;
		if(gml_std_StringTools_endsWith(l_name,"_hx"))l_name=gml_std_string_substring(l_name,0,string_length(l_name)-3);
		gml_compile_def_indexes.h_obj[$ l_name]=l_i;
	}
	gml_compile_handlers=array_create(array_length(l_names),undefined);
	compile_groups_gml_compile_group_literal_init();
	compile_groups_gml_compile_group_ds_init();
	compile_groups_gml_compile_group_array_init();
	return undefined;
}

if(live_enabled)
function gml_compile_node_lf(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]=self.val;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf1(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]=self.val;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf2(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]/=self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf3(l_th,l_v,l_scope,l_st){
	var l_this1=l_scope[4];
	l_this1[@self.ind]=(l_scope[4][self.ind] div self.num);
	return 0;
}

if(live_enabled)
function gml_compile_node_lf4(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]-=self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf5(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]=(l_scope[4][self.ind]<<self.num);
	return 0;
}

if(live_enabled)
function gml_compile_node_lf6(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]=(l_scope[4][self.ind]>>self.num);
	return 0;
}

if(live_enabled)
function gml_compile_node_lf7(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]|=self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf8(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]&=self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf9(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]^=self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf10(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]=l_scope[4][self.ind]==self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf11(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]=l_scope[4][self.ind]!=self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf12(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]=l_scope[4][self.ind]<=self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf13(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]=l_scope[4][self.ind]>self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf14(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]=l_scope[4][self.ind]>=self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf15(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]=l_scope[4][self.ind]<self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf16(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]+=self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf17(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]/=self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node_lf18(l_th,l_v,l_scope,l_st){
	l_scope[4][@self.ind]*=self.num;
	return 0;
}

if(live_enabled)
function gml_compile_node(l_q,l_actions,l_out){
	var l_h=gml_compile_handlers[l_q.__enumIndex__];
	if(l_h!=undefined){
		var l_z=l_h(l_q,l_actions,l_out);
		if(l_z!=undefined)return l_z;
	}
	var l_x,l_x2,l_w,l_i,l_k,l_z,l_n,l_p0,l_p1,l_p2,l_p3,l_pc,l_pb,l_s,l_v,l_d,l_o,l_fn,l_fn2;
	var l__g=l_q;
	switch(l__g.__enumIndex__){
		case 7:ds_list_add(l_actions,gml_action_ensure_array_for_local(l__g.h_d,gml_compile_curr_script.h_local_map.h_obj[$ l__g.h_name]));break;
		case 8:ds_list_add(l_actions,gml_action_ensure_array_for_global(l__g.h_d,l__g.h_name));break;
		case 9:
			if(gml_compile_node(l__g.h_obj,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_ensure_array_for_field(l__g.h_d,l__g.h_fd));
			break;
		case 10:
			if(compile_gml_compile_args_proc(l_actions,[l__g.h_arr,l__g.h_ind]))return true;
			ds_list_add(l_actions,gml_action_ensure_array_for_index(l__g.h_d));
			break;
		case 11:
			if(compile_gml_compile_args_proc(l_actions,[l__g.h_arr,l__g.h_ind1,l__g.h_ind2]))return true;
			ds_list_add(l_actions,gml_action_ensure_array_for_index2d(l__g.h_d));
			break;
		case 41:
			var l__field=l__g.h_fd;
			var l__g1=l__field;
			if(l__g1.__enumIndex__==2){
				if(gml_compile_node(l__g.h_val,l_actions,true))return true;
				ds_list_add(l_actions,gml_action_in_const(l__g.h_d,l__g1.h_value,l__g.h_not));
			} else {
				if(compile_gml_compile_args_proc(l_actions,[l__field,l__g.h_val]))return true;
				ds_list_add(l_actions,gml_action_in(l__g.h_d,l__g.h_not));
			}
			break;
		case 87:
			var l_d1=l__g.h_d;
			l_x=l__g.h_value;
			l_s=l__g.h_name;
			if(l_x!=undefined){
				l_i=gml_compile_curr_script.h_local_map.h_obj[$ l_s];
				if(gml_compile_const_val_of(l_x)){
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local = const",{ind:l_i,name:l_s,val:gml_compile_const_val_of_val},gml_compile_node_lf));
					return false;
				}
				if(gml_compile_node(l_x,l_actions,true))return true;
				ds_list_add(l_actions,gml_action_local_set(l_d1,l_i,l_s));
			}
			break;
		case 42:
			l_s=l__g.h_id;
			ds_list_add(l_actions,gml_action_local_hx(l__g.h_d,gml_compile_curr_script.h_local_map.h_obj[$ l_s],l_s));
			break;
		case 43:
			var l_d1=l__g.h_d;
			l_x=l__g.h_val;
			l_s=l__g.h_id;
			l_i=gml_compile_curr_script.h_local_map.h_obj[$ l_s];
			if(gml_compile_const_val_of(l_x)){
				ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local = const",{ind:l_i,name:l_s,val:gml_compile_const_val_of_val},gml_compile_node_lf1));
				return false;
			}
			if(gml_compile_node(l_x,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_local_set(l_d1,l_i,l_s));
			break;
		case 44:
			var l_d1=l__g.h_d;
			var l_o=l__g.h_op;
			l_s=l__g.h_id;
			l_x=l__g.h_val;
			l_i=gml_compile_curr_script.h_local_map.h_obj[$ l_s];
			if(gml_compile_const_val_of(l_x))switch(l_o){
				case 2:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local %= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf2));
					return false;
				case 3:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local div= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf3));
					return false;
				case 17:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local -= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf4));
					return false;
				case 32:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local <<= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf5));
					return false;
				case 33:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local >>= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf6));
					return false;
				case 48:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local |= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf7));
					return false;
				case 49:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local &= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf8));
					return false;
				case 50:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local ^= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf9));
					return false;
				case 64:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local eq= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf10));
					return false;
				case 65:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local ne= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf11));
					return false;
				case 67:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local le= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf12));
					return false;
				case 68:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local gt= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf13));
					return false;
				case 69:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local ge= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf14));
					return false;
				case 66:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local lt= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf15));
					return false;
				case 16:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local += number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf16));
					return false;
				case 1:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local /= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf17));
					return false;
				case 0:
					ds_list_add(l_actions,vm_v2_gml_action_closure_bind(l_d1,"local *= number",{
						ind:l_i,
						name:l_s,
						num:gml_compile_const_val_of_val,
						op:l_o
					},gml_compile_node_lf18));
					return false;
			}
			if(gml_compile_node(l_x,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_local_aop(l_d1,l_o,gml_compile_curr_script.h_local_map.h_obj[$ l_s],l_s));
			break;
		case 45:ds_list_add(l_actions,gml_action_global_hx(l__g.h_d,l__g.h_id));break;
		case 46:
			if(gml_compile_node(l__g.h_val,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_global_set(l__g.h_d,l__g.h_id));
			break;
		case 47:
			if(gml_compile_node(l__g.h_val,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_global_aop(l__g.h_d,l__g.h_op,l__g.h_id));
			break;
		case 48:
			var l_x1=l__g.h_x;
			var l_s1=l__g.h_fd;
			var l_fastGetter=api_api_fast_field_getters.h_obj[$ l_s1];
			var l__g1=l_x1;
			switch(l__g1.__enumIndex__){
				case 13:if(l_fastGetter!=undefined)ds_list_add(l_actions,gml_action_fast_self_field(l__g.h_d,l_fastGetter)); else ds_list_add(l_actions,gml_action_self_field(l__g.h_d,l_s1));break;
				case 42:
					var l_i1=gml_compile_curr_script.h_local_map.h_obj[$ l__g1.h_id];
					if(l_fastGetter!=undefined)ds_list_add(l_actions,gml_action_fast_local_field(l__g.h_d,l_i1,l_fastGetter)); else ds_list_add(l_actions,gml_action_local_field(l__g.h_d,l_i1,l_s1));
					break;
				default:
					if(gml_compile_node(l_x1,l_actions,true))return true;
					if(l_fastGetter!=undefined)ds_list_add(l_actions,gml_action_call_func1o(l__g.h_d,l_fastGetter)); else ds_list_add(l_actions,gml_action_field(l__g.h_d,l_s1));
			}
			break;
		case 49:
			var l_x1=l__g.h_x;
			var l_s1=l__g.h_fd;
			var l_fastSetter=api_api_fast_field_setters.h_obj[$ l_s1];
			var l__g1=l_x1;
			switch(l__g1.__enumIndex__){
				case 13:
					if(gml_compile_node(l__g.h_val,l_actions,true))return true;
					if(l_fastSetter!=undefined)ds_list_add(l_actions,gml_action_fast_self_field_set(l__g.h_d,l_fastSetter)); else ds_list_add(l_actions,gml_action_self_field_set(l__g.h_d,l_s1));
					break;
				case 42:
					var l_i1=gml_compile_curr_script.h_local_map.h_obj[$ l__g1.h_id];
					if(gml_compile_node(l__g.h_val,l_actions,true))return true;
					if(l_fastSetter!=undefined)ds_list_add(l_actions,gml_action_fast_local_field_set(l__g.h_d,l_i1,l_fastSetter)); else ds_list_add(l_actions,gml_action_local_field_set(l__g.h_d,l_i1,l_s1));
					break;
				default:
					if(compile_gml_compile_args_proc(l_actions,[l_x1,l__g.h_val]))return true;
					if(l_fastSetter!=undefined)ds_list_add(l_actions,gml_action_call_func2(l__g.h_d,l_fastSetter)); else ds_list_add(l_actions,gml_action_field_set(l__g.h_d,l_s1));
			}
			break;
		case 50:
			var l_x1=l__g.h_x;
			var l_s1=l__g.h_fd;
			var l_fastGetter=api_api_fast_field_getters.h_obj[$ l_s1];
			var l_fastSetter=api_api_fast_field_setters.h_obj[$ l_s1];
			var l__g1=l_x1;
			switch(l__g1.__enumIndex__){
				case 13:
					if(gml_compile_node(l__g.h_val,l_actions,true))return true;
					if(l_fastGetter!=undefined&&l_fastSetter!=undefined)ds_list_add(l_actions,gml_action_fast_self_field_aop(l__g.h_d,l__g.h_op,l_fastGetter,l_fastSetter)); else ds_list_add(l_actions,gml_action_self_field_aop(l__g.h_d,l__g.h_op,l_s1));
					break;
				case 42:
					var l_i1=gml_compile_curr_script.h_local_map.h_obj[$ l__g1.h_id];
					if(gml_compile_node(l__g.h_val,l_actions,true))return true;
					if(l_fastGetter!=undefined&&l_fastSetter!=undefined)ds_list_add(l_actions,gml_action_fast_local_field_aop(l__g.h_d,l_i1,l__g.h_op,l_fastGetter,l_fastSetter)); else ds_list_add(l_actions,gml_action_local_field_aop(l__g.h_d,l_i1,l__g.h_op,l_s1));
					break;
				default:
					if(compile_gml_compile_args_proc(l_actions,[l_x1,l__g.h_val]))return true;
					if(l_fastGetter!=undefined&&l_fastSetter!=undefined)ds_list_add(l_actions,gml_action_fast_field_aop(l__g.h_d,l__g.h_op,l_fastGetter,l_fastSetter)); else ds_list_add(l_actions,gml_action_field_aop(l__g.h_d,l__g.h_op,l_s1));
			}
			break;
		case 60:
			if(compile_gml_compile_args_proc(l_actions,[l__g.h_x,l__g.h_i]))return true;
			ds_list_add(l_actions,gml_action_alarm(l__g.h_d));
			break;
		case 61:
			if(compile_gml_compile_args_proc(l_actions,[l__g.h_x,l__g.h_i,l__g.h_v]))return true;
			ds_list_add(l_actions,gml_action_alarm_set_hx(l__g.h_d));
			break;
		case 62:
			if(compile_gml_compile_args_proc(l_actions,[l__g.h_x,l__g.h_i,l__g.h_v]))return true;
			ds_list_add(l_actions,gml_action_alarm_aop(l__g.h_d,l__g.h_op));
			break;
		case 51:ds_list_add(l_actions,gml_action_env(l__g.h_d,l__g.h_v.h_func));break;
		case 52:
			var l_av=l__g.h_v;
			if(gml_compile_node(l__g.h_val,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_env_set(l__g.h_d,l_av.h_func,l_av.h_type_check));
			break;
		case 53:
			if(gml_compile_node(l__g.h_val,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_env_aop(l__g.h_d,l__g.h_op,l__g.h_v.h_func));
			break;
		case 57:
			if(gml_compile_node(l__g.h_k,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_env1d(l__g.h_d,l__g.h_v.h_func));
			break;
		case 58:
			var l_av=l__g.h_v;
			if(compile_gml_compile_args_proc(l_actions,[l__g.h_k,l__g.h_val]))return true;
			ds_list_add(l_actions,gml_action_env1d_set(l__g.h_d,l_av.h_func,l_av.h_type_check));
			break;
		case 59:
			if(compile_gml_compile_args_proc(l_actions,[l__g.h_k,l__g.h_val]))return true;
			ds_list_add(l_actions,gml_action_env1d_aop(l__g.h_d,l__g.h_op,l__g.h_v.h_func));
			break;
		case 19:ds_list_add(l_actions,gml_action_arg_const(l__g.h_d,l__g.h_id));break;
		case 20:
			if(gml_compile_node(l__g.h_id,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_arg_index(l__g.h_d));
			break;
		case 21:ds_list_add(l_actions,gml_action_arg_count(l__g.h_d));break;
		case 36:
			l_d=l__g.h_d;
			l_o=l__g.h_o;
			l_x=l__g.h_a;
			l_x2=l__g.h_b;
			var l__g1=l_x;
			switch(l__g1.__enumIndex__){
				case 19:
					l_i=l__g1.h_id;
					if(gml_compile_node(l_x2,l_actions,true))return true;
					if(l_o!=-1)ds_list_add(l_actions,gml_action_arg_const_aop(l_d,l_o,l_i)); else ds_list_add(l_actions,gml_action_arg_const_set(l_d,l_i));
					break;
				case 20:
					if(gml_compile_node(l__g1.h_id,l_actions,true))return true;
					if(gml_compile_node(l_x2,l_actions,true))return true;
					if(l_o!=-1)ds_list_add(l_actions,gml_action_arg_index_aop(l_d,l_o)); else ds_list_add(l_actions,gml_action_arg_index_set(l_d));
					break;
				default:return gml_compile_error("Cannot set "+gml_std_Type_enumConstructor(l_x),l_d);
			}
			break;
		case 35:compile_gml_compile_bin_op_proc(l_actions,l__g.h_d,l__g.h_o,l__g.h_a,l__g.h_b);break;
		case 34:
			if(gml_compile_node(l__g.h_x,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_un_op(l__g.h_d,l__g.h_o));
			break;
		case 32:compile_gml_compile_adjfix_proc(l__g.h_d,l__g.h_x,true,l__g.h_inc,l_actions,l_out);break;
		case 33:compile_gml_compile_adjfix_proc(l__g.h_d,l__g.h_x,false,l__g.h_inc,l_actions,l_out);break;
		case 23:
			l_d=l__g.h_d;
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(gml_compile_node(l_w[l_i],l_actions,true))return true;
			}
			ds_list_add(l_actions,gml_action_call_script(l_d,gml_compile_curr_program.h_script_map.h_obj[$ l__g.h_name],l_n));
			if(l_out)ds_list_add(l_actions,gml_action_result(l_d));
			break;
		case 25:
			l_d=l__g.h_d;
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			if(gml_compile_node(l__g.h_index,l_actions,true))return true;
			for(l_i=0;l_i<l_n;l_i++){
				if(gml_compile_node(l_w[l_i],l_actions,true))return true;
			}
			ds_list_add(l_actions,gml_action_call_script_id(l_d,l_n));
			if(l_out)ds_list_add(l_actions,gml_action_result(l_d));
			break;
		case 27:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_inst,l_actions,true))return true;
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				gml_compile_node(l_w[l_i],l_actions,true);
			}
			ds_list_add(l_actions,gml_action_call_field(l_d,l__g.h_prop,l_n));
			if(l_out)ds_list_add(l_actions,gml_action_result(l_d));
			break;
		case 29:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_x,l_actions,true))return true;
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				gml_compile_node(l_w[l_i],l_actions,true);
			}
			ds_list_add(l_actions,gml_action_call_field(l_d,l__g.h_s,l_n));
			if(l_out)ds_list_add(l_actions,gml_action_result(l_d));
			break;
		case 30:
			l_d=l__g.h_d;
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			if(gml_compile_node(l__g.h_ctr,l_actions,true))return true;
			for(l_i=0;l_i<l_n;l_i++){
				if(gml_compile_node(l_w[l_i],l_actions,true))return true;
			}
			ds_list_add(l_actions,gml_action_construct(l_d,l_n));
			if(l_out)ds_list_add(l_actions,gml_action_result(l_d));
			break;
		case 26:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_index,l_actions,true))return true;
			if(gml_compile_node(l__g.h_array,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_call_script_with_array(l_d));
			if(l_out)ds_list_add(l_actions,gml_action_result(l_d));
			break;
		case 24:
			l_d=l__g.h_d;
			return gml_compile_error("dot-calls are currently not supported.",l_d);
		case 28:compile_gml_compile_call_func_proc(l_actions,l__g.h_d,l__g.h_fn,l__g.h_args,l_out);break;
		case 31:ds_list_add(l_actions,gml_action_func_literal(l__g.h_d,l__g.h_name));break;
		case 88:
			l_w=l__g.h_nodes;
			l_n=array_length(l_w);
			if(l_n>0){
				l_n--;
				for(l_i=0;l_i<l_n;l_i++){
					if(gml_compile_node(l_w[l_i],l_actions,false))return true;
				}
				if(gml_compile_node(l_w[l_i],l_actions,l_out))return true;
			}
			break;
		case 89:
			l_d=l__g.h_d;
			l_x=l__g.h_not;
			if(gml_compile_node(l__g.h_cond,l_actions,true))return true;
			l_i=ds_list_size(l_actions);
			ds_list_add(l_actions,gml_action_jump_unless(l_d,0));
			if(gml_compile_node(l__g.h_then,l_actions,false))return true;
			if(l_x!=undefined){
				l_n=ds_list_size(l_actions);
				ds_list_add(l_actions,gml_action_jump(l_d,0));
				ds_list_set(l_actions,l_i,gml_action_jump_unless(l_d,ds_list_size(l_actions)));
				if(gml_compile_node(l_x,l_actions,false))return true;
				ds_list_set(l_actions,l_n,gml_action_jump(l_d,ds_list_size(l_actions)));
			} else ds_list_set(l_actions,l_i,gml_action_jump_unless(l_d,ds_list_size(l_actions)));
			break;
		case 90:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_cond,l_actions,true))return true;
			l_i=ds_list_size(l_actions);
			ds_list_add(l_actions,gml_action_jump_unless(l_d,0));
			if(gml_compile_node(l__g.h_then,l_actions,l_out))return true;
			l_n=ds_list_size(l_actions);
			ds_list_add(l_actions,gml_action_jump(l_d,0));
			ds_list_set(l_actions,l_i,gml_action_jump_unless(l_d,ds_list_size(l_actions)));
			if(gml_compile_node(l__g.h_not,l_actions,l_out))return true;
			ds_list_set(l_actions,l_n,gml_action_jump(l_d,ds_list_size(l_actions)));
			break;
		case 38:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_a,l_actions,true))return true;
			l_i=ds_list_size(l_actions);
			ds_list_add(l_actions,gml_action_jump_placeholder(l_d));
			if(gml_compile_node(l__g.h_b,l_actions,true))return true;
			ds_list_set(l_actions,l_i,gml_action_null_co(l_d,ds_list_size(l_actions)));
			if(!l_out)ds_list_add(l_actions,gml_action_discard(l_d));
			break;
		case 97:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_times,l_actions,true))return true;
			l_n=ds_list_size(l_actions);
			ds_list_add(l_actions,gml_action_repeat_pre(l_d,0));
			l_p0=ds_list_size(l_actions);
			l_pc=gml_compile_curr_continue;
			l_pb=gml_compile_curr_break;
			gml_compile_curr_continue=l_p0;
			gml_compile_curr_break=l_p0;
			if(gml_compile_node(l__g.h_node,l_actions,false))return true;
			gml_compile_curr_continue=l_pc;
			gml_compile_curr_break=l_pb;
			l_p1=ds_list_size(l_actions);
			ds_list_add(l_actions,gml_action_repeat_jump(l_d,l_p0));
			l_p2=ds_list_size(l_actions);
			ds_list_add(l_actions,gml_action_discard(l_d));
			for(l_k=l_p0;l_k<l_p2;l_k++){
				var l__g1=ds_list_find_value(l_actions,l_k);
				switch(l__g1.__enumIndex__){
					case 105:if(l__g1.h_lp==l_p0)ds_list_set(l_actions,l_k,gml_action_jump(l__g1.h_d,l_p1));break;
					case 104:if(l__g1.h_lp==l_p0)ds_list_set(l_actions,l_k,gml_action_jump(l__g1.h_d,l_p2));break;
				}
			}
			ds_list_set(l_actions,l_n,gml_action_repeat_pre(l_d,ds_list_size(l_actions)));
			break;
		case 94:
			l_d=l__g.h_d;
			l_p0=ds_list_size(l_actions);
			if(gml_compile_node(l__g.h_cond,l_actions,true))return true;
			l_p1=ds_list_size(l_actions);
			ds_list_add(l_actions,gml_action_jump_unless(l_d,0));
			l_pc=gml_compile_curr_continue;
			l_pb=gml_compile_curr_break;
			gml_compile_curr_continue=l_p0;
			gml_compile_curr_break=l_p0;
			if(gml_compile_node(l__g.h_node,l_actions,false))return true;
			gml_compile_curr_continue=l_pc;
			gml_compile_curr_break=l_pb;
			ds_list_add(l_actions,gml_action_jump(l_d,l_p0));
			l_p2=ds_list_size(l_actions);
			ds_list_set(l_actions,l_p1,gml_action_jump_unless(l_d,l_p2));
			for(l_k=l_p1;l_k<l_p2;l_k++){
				var l__g1=ds_list_find_value(l_actions,l_k);
				switch(l__g1.__enumIndex__){
					case 105:if(l__g1.h_lp==l_p0)ds_list_set(l_actions,l_k,gml_action_jump(l__g1.h_d,l_p0));break;
					case 104:if(l__g1.h_lp==l_p0)ds_list_set(l_actions,l_k,gml_action_jump(l__g1.h_d,l_p2));break;
				}
			}
			break;
		case 95:
			l_d=l__g.h_d;
			l_p0=ds_list_size(l_actions);
			l_pc=gml_compile_curr_continue;
			l_pb=gml_compile_curr_break;
			gml_compile_curr_continue=l_p0;
			gml_compile_curr_break=l_p0;
			if(gml_compile_node(l__g.h_node,l_actions,false))return true;
			gml_compile_curr_continue=l_pc;
			gml_compile_curr_break=l_pb;
			l_p1=ds_list_size(l_actions);
			if(gml_compile_node(l__g.h_cond,l_actions,true))return true;
			var l__g1=l_q;
			if((l__g1.__enumIndex__==95))ds_list_add(l_actions,gml_action_jump_unless(l_d,l_p0)); else ds_list_add(l_actions,gml_action_jump_if(l_d,l_p0));
			l_p2=ds_list_size(l_actions);
			for(l_k=l_p0;l_k<l_p1;l_k++){
				var l__g1=ds_list_find_value(l_actions,l_k);
				switch(l__g1.__enumIndex__){
					case 105:if(l__g1.h_lp==l_p0)ds_list_set(l_actions,l_k,gml_action_jump(l__g1.h_d,l_p1));break;
					case 104:if(l__g1.h_lp==l_p0)ds_list_set(l_actions,l_k,gml_action_jump(l__g1.h_d,l_p2));break;
				}
			}
			break;
		case 96:
			l_d=l__g.h_d;
			l_p0=ds_list_size(l_actions);
			l_pc=gml_compile_curr_continue;
			l_pb=gml_compile_curr_break;
			gml_compile_curr_continue=l_p0;
			gml_compile_curr_break=l_p0;
			if(gml_compile_node(l__g.h_node,l_actions,false))return true;
			gml_compile_curr_continue=l_pc;
			gml_compile_curr_break=l_pb;
			l_p1=ds_list_size(l_actions);
			if(gml_compile_node(l__g.h_cond,l_actions,true))return true;
			var l__g1=l_q;
			if((l__g1.__enumIndex__==95))ds_list_add(l_actions,gml_action_jump_unless(l_d,l_p0)); else ds_list_add(l_actions,gml_action_jump_if(l_d,l_p0));
			l_p2=ds_list_size(l_actions);
			for(l_k=l_p0;l_k<l_p1;l_k++){
				var l__g1=ds_list_find_value(l_actions,l_k);
				switch(l__g1.__enumIndex__){
					case 105:if(l__g1.h_lp==l_p0)ds_list_set(l_actions,l_k,gml_action_jump(l__g1.h_d,l_p1));break;
					case 104:if(l__g1.h_lp==l_p0)ds_list_set(l_actions,l_k,gml_action_jump(l__g1.h_d,l_p2));break;
				}
			}
			break;
		case 98:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_pre,l_actions,false))return true;
			l_p0=ds_list_size(l_actions);
			if(gml_compile_node(l__g.h_cond,l_actions,true))return true;
			l_p1=ds_list_size(l_actions);
			ds_list_add(l_actions,gml_action_jump_unless(l_d,0));
			l_pc=gml_compile_curr_continue;
			l_pb=gml_compile_curr_break;
			gml_compile_curr_continue=l_p0;
			gml_compile_curr_break=l_p0;
			if(gml_compile_node(l__g.h_loop,l_actions,false))return true;
			gml_compile_curr_continue=l_pc;
			gml_compile_curr_break=l_pb;
			l_p2=ds_list_size(l_actions);
			if(gml_compile_node(l__g.h_post,l_actions,false))return true;
			ds_list_add(l_actions,gml_action_jump(l_d,l_p0));
			l_p3=ds_list_size(l_actions);
			ds_list_set(l_actions,l_p1,gml_action_jump_unless(l_d,l_p3));
			for(l_k=l_p1;l_k<l_p2;l_k++){
				var l__g1=ds_list_find_value(l_actions,l_k);
				switch(l__g1.__enumIndex__){
					case 105:if(l__g1.h_lp==l_p0)ds_list_set(l_actions,l_k,gml_action_jump(l__g1.h_d,l_p2));break;
					case 104:if(l__g1.h_lp==l_p0)ds_list_set(l_actions,l_k,gml_action_jump(l__g1.h_d,l_p3));break;
				}
			}
			break;
		case 91:
			var l__cc=l__g.h_list;
			l_d=l__g.h_d;
			var l_jt=ds_map_create();
			if(gml_compile_node(l__g.h_expr,l_actions,true))return true;
			l_p0=ds_list_size(l_actions);
			l_n=array_length(l__cc);
			for(l_i=0;l_i<l_n;l_i++){
				var l__cv=l__cc[l_i].values;
				l_z=array_length(l__cv);
				for(l_k=0;l_k<l_z;l_k++){
					if(gml_node_tools_to_case_value(l__cv[l_k])==undefined)break;
				}
				if(l_k<l_z)break;
			}
			if(l_i<l_n){
				var l_caseLabels=[];
				l_pb=gml_compile_curr_break;
				gml_compile_curr_break=l_p0;
				for(l_i=0;l_i<l_n;l_i++){
					var l__cv=l__cc[l_i].values;
					l_z=array_length(l__cv);
					var l_cl1=[];
					for(l_k=0;l_k<l_z;l_k++){
						if(gml_compile_node(l__cv[l_k],l_actions,true))return true;
						l_cl1[@l_k]=ds_list_size(l_actions);
						ds_list_add(l_actions,gml_action_switch_case(l_d,0));
					}
					l_caseLabels[@l_i]=l_cl1;
				}
				ds_list_add(l_actions,gml_action_discard(l_d));
				var l_defCasePos=ds_list_size(l_actions);
				ds_list_add(l_actions,gml_action_jump(l_d,0));
				for(l_i=0;l_i<l_n;l_i++){
					var l_cl1=l_caseLabels[l_i];
					l_z=array_length(l_cl1);
					for(l_k=0;l_k<l_z;l_k++){
						ds_list_set(l_actions,l_cl1[l_k],gml_action_switch_case(l_d,ds_list_size(l_actions)));
					}
					if(gml_compile_node(l__cc[l_i].expr,l_actions,false))return true;
				}
				ds_list_set(l_actions,l_defCasePos,gml_action_jump(l_d,ds_list_size(l_actions)));
				l_x=l__g.h_def;
				if(l_x!=undefined){
					if(gml_compile_node(l_x,l_actions,false))return true;
				}
				gml_compile_curr_break=l_pb;
			} else {
				ds_list_add(l_actions,gml_action_switch_hx(l_d,l_jt,0));
				l_pb=gml_compile_curr_break;
				gml_compile_curr_break=l_p0;
				l_n=array_length(l__cc);
				for(l_i=0;l_i<l_n;l_i++){
					var l__cv=l__cc[l_i].values;
					l_z=array_length(l__cv);
					for(l_k=0;l_k<l_z;l_k++){
						ds_map_set(l_jt,gml_node_tools_to_case_value(l__cv[l_k]),ds_list_size(l_actions));
					}
					if(gml_compile_node(l__cc[l_i].expr,l_actions,false))return true;
				}
				l_p1=ds_list_size(l_actions);
				l_x=l__g.h_def;
				if(l_x!=undefined){
					if(gml_compile_node(l_x,l_actions,false))return true;
				}
				gml_compile_curr_break=l_pb;
				ds_list_set(l_actions,l_p0,gml_action_switch_hx(l_d,l_jt,l_p1));
			}
			l_p2=ds_list_size(l_actions);
			for(l_k=l_p0;l_k<l_p2;l_k++){
				var l__g1=ds_list_find_value(l_actions,l_k);
				if(l__g1.__enumIndex__==104){
					var l_d1=l__g1.h_d;
					if(l__g1.h_lp==l_p0)ds_list_set(l_actions,l_k,gml_action_jump(l_d1,l_p2));
				}
			}
			break;
		case 99:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_ctx,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_with_pre(l_d));
			l_p0=ds_list_size(l_actions);
			ds_list_add(l_actions,gml_action_with_next(l_d,0));
			l_pc=gml_compile_curr_continue;
			l_pb=gml_compile_curr_break;
			gml_compile_curr_continue=l_p0;
			gml_compile_curr_break=l_p0;
			if(gml_compile_node(l__g.h_node,l_actions,false))return true;
			gml_compile_curr_continue=l_pc;
			gml_compile_curr_break=l_pb;
			ds_list_add(l_actions,gml_action_jump(l_d,l_p0));
			l_p1=ds_list_size(l_actions);
			ds_list_add(l_actions,gml_action_with_post(l_d));
			ds_list_set(l_actions,l_p0,gml_action_with_next(l_d,l_p1));
			for(l_k=l_p0;l_k<l_p1;l_k++){
				var l__g1=ds_list_find_value(l_actions,l_k);
				switch(l__g1.__enumIndex__){
					case 105:if(l__g1.h_lp==l_p0)ds_list_set(l_actions,l_k,gml_action_jump(l__g1.h_d,l_p0));break;
					case 104:if(l__g1.h_lp==l_p0)ds_list_set(l_actions,l_k,gml_action_jump(l__g1.h_d,l_p1));break;
				}
			}
			break;
		case 106:
			l_d=l__g.h_d;
			l_p0=ds_list_size(l_actions);
			ds_list_add(l_actions,gml_action_try_hx(l_d,0));
			if(gml_compile_node(l__g.h_node,l_actions,false))return true;
			l_p1=ds_list_size(l_actions);
			ds_list_add(l_actions,gml_action_finally_hx(l_d,0));
			ds_list_set(l_actions,l_p0,gml_action_try_hx(l_d,ds_list_size(l_actions)));
			ds_list_add(l_actions,gml_action_catch_hx(l_d,gml_compile_curr_script.h_local_map.h_obj[$ l__g.h_cap]));
			if(gml_compile_node(l__g.h_cat,l_actions,false))return true;
			ds_list_set(l_actions,l_p1,gml_action_finally_hx(l_d,ds_list_size(l_actions)));
			break;
		case 107:
			if(gml_compile_node(l__g.h_x,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_throw_hx(l__g.h_d));
			break;
		case 103:
			l_d=l__g.h_d;
			l_i=gml_compile_curr_break;
			if(l_i>=0)ds_list_add(l_actions,gml_action_break_hx(l_d,l_i)); else return gml_compile_error("Cannot `break` here",l_d);
			break;
		case 104:
			l_d=l__g.h_d;
			l_i=gml_compile_curr_continue;
			if(l_i>=0)ds_list_add(l_actions,gml_action_continue_hx(l_d,l_i)); else return gml_compile_error("Cannot `continue` here",l_d);
			break;
		case 101:
			if(gml_compile_node(l__g.h_v,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_return_hx(l__g.h_d));
			break;
		case 102:
			l_d=l__g.h_d;
			ds_list_add(l_actions,gml_action_return_const(l_d,l_d.h_src.h_version.h_default_ret_value));
			break;
		case 92:
			if(gml_compile_node(l__g.h_time,l_actions,true))return true;
			ds_list_add(l_actions,gml_action_wait(l__g.h_d));
			break;
		case 37:if(compile_gml_compile_delete_proc(l_actions,l__g.h_d,l__g.h_x))return true;break;
		case 93:ds_list_add(l_actions,gml_action_fork(l__g.h_d,l_out));break;
		default:return gml_compile_error("Cannot compile "+gml_std_Type_enumConstructor(l_q),gml_std_haxe_enum_tools_getParameter(l_q,0));
	}
	return false;
}

if(live_enabled)
function gml_compile_add_exit(l_actions){
	gml_compile_node(gml_node_exit_hx(gml_compile_curr_script.h_pos),l_actions,false);
}

if(live_enabled)
function gml_compile_script(l_q){
	var l_actions=ds_list_create();
	l_q.h_actions=l_actions;
	gml_compile_curr_script=l_q;
	gml_compile_curr_break=-1;
	gml_compile_curr_continue=-1;
	var l_trouble;
	l_trouble=gml_compile_node(l_q.h_node,l_actions,false);
	if(!l_trouble)gml_compile_add_exit(l_actions);
	if(!l_trouble){
		var l_i=0;
		for(var l__g1=ds_list_size(l_actions);l_i<l__g1;l_i++){
			var l_a=ds_list_find_value(l_actions,l_i);
			if(l_a.__enumIndex__==123)l_a.__func__=l_a.h_fn; else l_a.__func__=vm_v2_gml_thread_v2_handlers[l_a.__enumIndex__];
		}
	}
	gml_compile_curr_script=undefined;
	return l_trouble;
}

if(live_enabled)
function gml_compile_program(l_p){
	gml_compile_curr_program=l_p;
	var l_arr=l_p.h_script_array;
	var l_i;
	var l_num=array_length(l_arr);
	for(l_i=0;l_i<l_num;l_i++){
		if(gml_compile_script(l_arr[l_i]))break;
	}
	gml_compile_curr_program=undefined;
	return l_i<l_num;
}
