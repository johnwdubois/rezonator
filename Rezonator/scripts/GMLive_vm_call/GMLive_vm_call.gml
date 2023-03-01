// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.
// Feather disable all

if(live_enabled)
function vm_group_call_check_func_args(l_th,l_act,l_argChecks,l_restCheck,l_array1,l_arrOffset,l_argc){
	var l_argChecks_len=array_length(l_argChecks);
	var l_i=0;
	for(var l__g1=l_argc;l_i<l__g1;l_i++){
		var l_err,l_ac;
		if(l_i<l_argChecks_len){
			l_ac=l_argChecks[l_i];
			l_err=l_ac(l_array1[l_arrOffset+l_i]);
		} else l_err=l_restCheck(l_array1[l_arrOffset+l_i]);
		if(l_err!="")return l_th.h_proc_error(l_err,l_act);
	}
	return true;
}

if(live_enabled)
function vm_group_call_call_value(l_th,l_act,l_v1,l_argArray,l_argOffset,l_n){
	if(is_method(l_v1)){
		if(vm_v2_gml_thread_group_call_gml23_call_self_other_soft(l_th,l_act,l_v1,l_argArray,l_argOffset,l_n)){
			l_th.h_result=vm_group_call_call_func_result;
			return vm_group_call_call_func_status;
		} else return 1;
	}
	if(gml_std_gml_NativeTypeHelper_isNumber(l_v1)){
		if(script_exists(l_v1)){
			if(vm_v2_gml_thread_group_call_gml23_call_self_other_soft(l_th,l_act,l_v1,l_argArray,l_argOffset,l_n)){
				l_th.h_result=vm_group_call_call_func_result;
				return vm_group_call_call_func_status;
			} else return 1;
		} else return l_th.h_proc_error2("Trying to call invalid script index "+gml_value_print(l_v1),l_act);
	} else return l_th.h_proc_error2("Script index must be a number, got "+gml_value_dump(l_v1),l_act);
}

if(live_enabled)
function vm_group_call_on_call_script(l_th,l_act,l_scope,l_st){
	var l_scr=l_act.h_script;
	var l_n=l_act.h_argc;
	var l_arr=[];
	var l_k=l_st[0]-l_n;
	array_copy(l_arr,0,l_st,l_k+1,l_n);
	array_copy(l_st,l_k+1,gml_stack_fill_value_arr,0,l_n);
	l_st[@0]=l_k;
	var l_args1=l_arr;
	gml_value_list_pad_to_size_with_null(l_args1,l_scr.h_arguments);
	var l_inst=l_scope[6];
	l_th.h_scope=gml_thread_scope_create(l_scr.h_actions,0,l_args1,array_create(l_scr.h_locals),l_inst[l_inst[0]],l_inst[l_inst[0]-1],l_scope,l_scope[9]);
	return 3;
}

if(live_enabled)
function vm_group_call_on_call_script_id(l_th,l_act,l_scope,l_stack){
	var l_n=l_act.h_argc;
	var l_v1=l_stack[l_stack[0]-l_n];
	var l_argOffset=l_stack[0]-l_n+1;
	l_stack[@0]=(l_stack[0]-(l_n+1));
	return vm_group_call_call_value(l_th,l_act,l_v1,l_stack,l_argOffset,l_n);
	return 0;
}

if(live_enabled)
function vm_group_call_on_call_field(l_th,l_act,l_scope,l_stack){
	var l_s=l_act.h_field;
	var l_n=l_act.h_argc;
	var l_ctx=l_stack[l_stack[0]-l_n];
	var l_argOffset=l_stack[0]-l_n+1;
	var l_val=undefined;
	var l_notFound=true;
	if(gml_std_gml_NativeTypeHelper_isNumber(l_ctx)&&l_ctx>=100000){
		l_val=variable_instance_get(l_ctx,l_s);
		if(l_val!=undefined||variable_instance_exists(l_ctx,l_s)){
			l_notFound=false;
		} else if(variable_instance_exists(l_ctx,"id")){
			return l_th.h_proc_error2("`"+gml_std_Std_stringify(l_ctx)+"` ("+object_get_name(l_ctx.object_index)+") does not have a variable `"+l_s+"`",l_act);
		}
	} else with (l_ctx) {
		l_val=variable_instance_get(self,l_s);
		if(l_val!=undefined||variable_instance_exists(self,l_s)){
			l_notFound=false;
			break;
		} else return l_th.h_proc_error2("`"+gml_std_Std_stringify(self)+"` ("+object_get_name(self.object_index)+") does not have a variable `"+l_s+"`",l_act);
	}
	if(is_method(l_val)){
		if(method_get_self(l_val)==undefined)l_val=method(l_ctx,l_val);
		var l_this1=l_scope[6];
		var l_me=l_this1[l_this1[0]];
		with (l_me) {
			var l_tmp;
			try{
				var l_r=vm_group_call_call_value(l_th,l_act,l_val,l_stack,l_argOffset,l_n);
				gml_stack_discard_multi(l_stack,l_n+1);
				l_tmp=l_r;
			}catch(l__g){
				var l_x=gml_std_haxe_Exception_caught(l__g).h_native;
				gml_stack_discard_multi(l_stack,l_n+1);
				l_tmp=l_th.h_proc_error2(l_x,l_act);
			}
			return l_tmp;
		}
	}
	var l_tmp;
	try{
		var l_r=vm_group_call_call_value(l_th,l_act,l_val,l_stack,l_argOffset,l_n);
		gml_stack_discard_multi(l_stack,l_n+1);
		l_tmp=l_r;
	}catch(l__g){
		var l_x=gml_std_haxe_Exception_caught(l__g).h_native;
		gml_stack_discard_multi(l_stack,l_n+1);
		l_tmp=l_th.h_proc_error2(l_x,l_act);
	}
	return l_tmp;
	return 0;
}

if(live_enabled)
function vm_group_call_on_construct(l_th,l_act,l_scope,l_stack){
	var l__argc=l_act.h_argc;
	var l_args1=gml_stack_pop_multi(l_stack,l__argc+1);
	var l_v1=l_args1[0];
	if(gml_std_gml_NativeTypeHelper_isNumber(l_v1)){
		if(!script_exists((l_v1|0)))return l_th.h_proc_error2(gml_value_print(l_v1)+" is not a valid script index.",l_act);
	} else if(!is_method(l_v1)){
		return l_th.h_proc_error2(gml_value_print(l_v1)+" ("+gml_value_get_type(l_v1)+") is not a callable type.",l_act);
	}
	if(vm_v2_gml_thread_group_call_gml23_call_construct(l_th,l_act,l_v1,l_args1,1,l__argc)){
		l_th.h_result=vm_group_call_call_func_result;
		return vm_group_call_call_func_status;
	} else return 1;
	return 0;
}

if(live_enabled)
function vm_group_call_on_call_script_with_array(l_th,l_act,l_scope,l_stack){
	var l_v1,l_arr;
	var l_z=l_stack[0]-1;
	l_stack[@0]=(l_z-1);
	l_v1=l_stack[l_z];
	l_arr=l_stack[l_z+1];
	l_stack[@l_z]=0;
	l_stack[@l_z+1]=0;
	if(is_array(l_arr))return vm_group_call_call_value(l_th,l_act,l_v1,l_arr,0,array_length(l_arr)); else return l_th.h_proc_error2("Expected an array with arguments, got "+gml_value_dump(l_arr),l_act);
	return 0;
}

if(live_enabled)
function vm_group_call_on_call_func(l_th,l_act,l_scope,l_stack){
	var l__func=l_act.h_func;
	var l__argc=l_act.h_argc;
	var l__argChecks=l_act.h_args;
	var l__restCheck=l_act.h_rest;
	var l__inst=l_act.h_inst;
	var l__out=l_act.h_out;
	var l_k=l_stack[0]-l__argc;
	l_stack[@0]=l_k;
	l_k++;
	if(vm_group_call_check_func_args(l_th,l_act,l__argChecks,l__restCheck,l_stack,l_k,l__argc)&&vm_v2_gml_thread_group_call_gml23_funcs[l__inst+7](l_th,l_act,l__func,l_stack,l_k,l__argc)){
		if(l__out){
			var l_i=l_stack[0]+1;
			if(l_i>=array_length(l_stack))l_stack[@array_length(l_stack)*2]=0;
			l_stack[@l_i]=vm_group_call_call_func_result;
			l_stack[@0]=l_i;
		}
		return vm_group_call_call_func_status;
	} else return 1;
	return 0;
}
