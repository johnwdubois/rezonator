// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.
// Feather disable all

// Helpers for AST nodes
if(live_enabled)
function gml_node_tools_unpack(l_q){
	while(l_q!=undefined){
		var l__g=l_q;
		if(l__g.__enumIndex__==88){
			var l__g2=l__g.h_nodes;
			if(array_length(l__g2)==1)l_q=l__g2[0]; else return l_q;
		} else return l_q;
	}
	return l_q;
}

if(live_enabled)
function gml_node_tools_is_statement(l_q){
	switch(l_q.__enumIndex__){
		case 22:return true;
		case 36:return true;
		case 87:return true;
		case 32:return true;
		case 33:return true;
		case 88:return true;
		case 89:return true;
		case 91:return true;
		case 98:return true;
		case 94:return true;
		case 97:return true;
		case 96:return true;
		case 95:return true;
		case 99:return true;
		case 103:return true;
		case 104:return true;
		case 102:return true;
		case 101:return true;
		case 92:return true;
		case 105:return true;
		case 106:return true;
		case 107:return true;
		default:return false;
	}
}

if(live_enabled)
function gml_node_tools_is_in_block(l_q,l_p){
	if(l_p==undefined||l_q==undefined)return false;
	var l__g=l_p;
	switch(l__g.__enumIndex__){
		case 88:return true;
		case 89:if(l_q!=l__g.h_then)return l_q==l__g.h_not; else return true;
		case 94:return l_q==l__g.h_node;
		case 96:return l_q==l__g.h_node;
		case 95:return l_q==l__g.h_node;
		case 97:return l_q==l__g.h_node;
		case 98:return (l_q==l__g.h_pre||l_q==l__g.h_post)||l_q==l__g.h_loop;
		case 91:
			var l__cases=l__g.h_list;
			if(l_q==l__g.h_def)return true;
			var l_i=0;
			for(var l__g2=array_length(l__cases);l_i<l__g2;l_i++){
				if(l__cases[l_i].expr==l_q)return true;
			}
			return false;
		default:return false;
	}
}

if(live_enabled)
function gml_node_tools_to_case_value(l_q){
	var l__g=l_q;
	switch(l__g.__enumIndex__){
		case 1:
			var l_f=l__g.h_value;
			if(is_real(l_f)&&sign(frac(l_f))!=0)return undefined;
			if(int64(l_f)!=l_f)return undefined;
			return l_f;
		case 2:return l__g.h_value;
		case 4:return l__g.h_ctr.h_value;
		default:return undefined;
	}
}

if(live_enabled)
function gml_node_tools_equals_list(l_a,l_b){
	var l_n=array_length(l_a);
	if(array_length(l_b)!=l_n)return false;
	var l_i=0;
	while(l_i<l_n){
		if(gml_node_tools_equals(l_a[l_i],l_b[l_i]))l_i++; else return false;
	}
	return true;
}

if(live_enabled)
function gml_node_tools_equals(l_a,l_b){
	if(l_a.__enumIndex__!=l_b.__enumIndex__)return false;
	var l_i,l_n;
	var l__g=l_a;
	switch(l__g.__enumIndex__){
		case 0:return true;
		case 13:return true;
		case 14:return true;
		case 15:return true;
		case 21:return true;
		case 93:return true;
		case 102:return true;
		case 103:return true;
		case 104:return true;
		case 105:return true;
		case 1:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==1){
				var l_b_value=l__g1.h_value;
				var l_b_src=l__g1.h_src;
				return l__g.h_value==l_b_value&&l__g.h_src==l_b_src;
			} else return false;
		case 2:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==2)return l__g.h_value==l__g1.h_value; else return false;
		case 3:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==3)return l__g.h_value==l__g1.h_value; else return false;
		case 4:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==4){
				var l_b_e=l__g1.h_e;
				var l_b_ctr=l__g1.h_ctr;
				return l__g.h_e==l_b_e&&l__g.h_ctr==l_b_ctr;
			} else return false;
		case 5:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==5)return gml_node_tools_equals_list(l__g.h_values,l__g1.h_values); else return false;
		case 7:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==7)return l__g.h_name==l__g1.h_name; else return false;
		case 8:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==8)return l__g.h_name==l__g1.h_name; else return false;
		case 9:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==9){
				var l_b_obj=l__g1.h_obj;
				var l_b_fd=l__g1.h_fd;
				return gml_node_tools_equals(l__g.h_obj,l_b_obj)&&l__g.h_fd==l_b_fd;
			} else return false;
		case 10:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==10){
				var l_b_arr=l__g1.h_arr;
				var l_b_ind=l__g1.h_ind;
				return gml_node_tools_equals(l__g.h_arr,l_b_arr)&&gml_node_tools_equals(l__g.h_ind,l_b_ind);
			} else return false;
		case 11:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==11){
				var l_b_arr=l__g1.h_arr;
				var l_b_ind1=l__g1.h_ind1;
				var l_b_ind2=l__g1.h_ind2;
				return gml_node_tools_equals(l__g.h_arr,l_b_arr)&&gml_node_tools_equals(l__g.h_ind1,l_b_ind1)&&gml_node_tools_equals(l__g.h_ind2,l_b_ind2);
			} else return false;
		case 12:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==12)return l__g.h_id==l__g1.h_id; else return false;
		case 16:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==16)return l__g.h_ref==l__g1.h_ref; else return false;
		case 18:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==18)return l__g.h_id==l__g1.h_id; else return false;
		case 19:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==19)return l__g.h_id==l__g1.h_id; else return false;
		case 20:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==20)return gml_node_tools_equals(l__g.h_id,l__g1.h_id); else return false;
		case 22:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==22){
				var l_b_x=l__g1.h_x;
				var l_b_args=l__g1.h_args;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals_list(l__g.h_args,l_b_args);
			} else return false;
		case 23:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==23){
				var l_b_name=l__g1.h_name;
				var l_b_args=l__g1.h_args;
				return l__g.h_name==l_b_name&&gml_node_tools_equals_list(l__g.h_args,l_b_args);
			} else return false;
		case 24:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==24){
				var l_b_inst=l__g1.h_inst;
				var l_b_script=l__g1.h_script;
				var l_b_args=l__g1.h_args;
				return gml_node_tools_equals(l__g.h_inst,l_b_inst)&&l__g.h_script==l_b_script&&gml_node_tools_equals_list(l__g.h_args,l_b_args);
			} else return false;
		case 25:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==25){
				var l_b_index=l__g1.h_index;
				var l_b_args=l__g1.h_args;
				return gml_node_tools_equals(l__g.h_index,l_b_index)&&gml_node_tools_equals_list(l__g.h_args,l_b_args);
			} else return false;
		case 26:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==26){
				var l_b_index=l__g1.h_index;
				var l_b_array=l__g1.h_array;
				return gml_node_tools_equals(l__g.h_index,l_b_index)&&gml_node_tools_equals(l__g.h_array,l_b_array);
			} else return false;
		case 27:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==27){
				var l_b_inst=l__g1.h_inst;
				var l_b_prop=l__g1.h_prop;
				var l_b_args=l__g1.h_args;
				return gml_node_tools_equals(l__g.h_inst,l_b_inst)&&l__g.h_prop==l_b_prop&&gml_node_tools_equals_list(l__g.h_args,l_b_args);
			} else return false;
		case 28:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==28){
				var l_b_fn=l__g1.h_fn;
				var l_b_args=l__g1.h_args;
				return l__g.h_fn==l_b_fn&&gml_node_tools_equals_list(l__g.h_args,l_b_args);
			} else return false;
		case 29:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==29){
				var l_b_x=l__g1.h_x;
				var l_b_s=l__g1.h_s;
				var l_b_args=l__g1.h_args;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&l__g.h_s==l_b_s&&gml_node_tools_equals_list(l__g.h_args,l_b_args);
			} else return false;
		case 30:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==30){
				var l_b_ctr=l__g1.h_ctr;
				var l_b_args=l__g1.h_args;
				return gml_node_tools_equals(l__g.h_ctr,l_b_ctr)&&gml_node_tools_equals_list(l__g.h_args,l_b_args);
			} else return false;
		case 31:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==31)return l__g.h_name==l__g1.h_name; else return false;
		case 32:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==32){
				var l_b_x=l__g1.h_x;
				var l_b_inc=l__g1.h_inc;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&l__g.h_inc==l_b_inc;
			} else return false;
		case 33:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==33){
				var l_b_x=l__g1.h_x;
				var l_b_inc=l__g1.h_inc;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&l__g.h_inc==l_b_inc;
			} else return false;
		case 34:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==34){
				var l_b_x=l__g1.h_x;
				var l_b_o=l__g1.h_o;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&l__g.h_o==l_b_o;
			} else return false;
		case 35:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==35){
				var l_b_o=l__g1.h_o;
				var l_b_a=l__g1.h_a;
				var l_b_b=l__g1.h_b;
				return l__g.h_o==l_b_o&&gml_node_tools_equals(l__g.h_a,l_b_a)&&gml_node_tools_equals(l__g.h_b,l_b_b);
			} else return false;
		case 36:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==36){
				var l_b_o=l__g1.h_o;
				var l_b_a=l__g1.h_a;
				var l_b_b=l__g1.h_b;
				return l__g.h_o==l_b_o&&gml_node_tools_equals(l__g.h_a,l_b_a)&&gml_node_tools_equals(l__g.h_b,l_b_b);
			} else return false;
		case 37:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==37)return gml_node_tools_equals(l__g.h_x,l__g1.h_x); else return false;
		case 38:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==38){
				var l_b_a=l__g1.h_a;
				var l_b_b=l__g1.h_b;
				return gml_node_tools_equals(l__g.h_a,l_b_a)&&gml_node_tools_equals(l__g.h_b,l_b_b);
			} else return false;
		case 39:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==39)return gml_node_tools_equals(l__g.h_v,l__g1.h_v); else return false;
		case 40:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==40)return gml_node_tools_equals(l__g.h_v,l__g1.h_v); else return false;
		case 41:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==41){
				var l_b_fd=l__g1.h_fd;
				var l_b_val=l__g1.h_val;
				var l_b_not=l__g1.h_not;
				return gml_node_tools_equals(l__g.h_fd,l_b_fd)&&gml_node_tools_equals(l__g.h_val,l_b_val)&&l__g.h_not==l_b_not;
			} else return false;
		case 42:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==42)return l__g.h_id==l__g1.h_id; else return false;
		case 43:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==43){
				var l_b_id=l__g1.h_id;
				var l_b_val=l__g1.h_val;
				return l__g.h_id==l_b_id&&gml_node_tools_equals(l__g.h_val,l_b_val);
			} else return false;
		case 44:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==44){
				var l_b_id=l__g1.h_id;
				var l_b_op=l__g1.h_op;
				var l_b_val=l__g1.h_val;
				return l__g.h_id==l_b_id&&l__g.h_op==l_b_op&&gml_node_tools_equals(l__g.h_val,l_b_val);
			} else return false;
		case 45:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==45)return l__g.h_id==l__g1.h_id; else return false;
		case 46:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==46){
				var l_b_id=l__g1.h_id;
				var l_b_val=l__g1.h_val;
				return l__g.h_id==l_b_id&&gml_node_tools_equals(l__g.h_val,l_b_val);
			} else return false;
		case 47:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==47){
				var l_b_id=l__g1.h_id;
				var l_b_op=l__g1.h_op;
				var l_b_val=l__g1.h_val;
				return l__g.h_id==l_b_id&&l__g.h_op==l_b_op&&gml_node_tools_equals(l__g.h_val,l_b_val);
			} else return false;
		case 48:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==48){
				var l_b_x=l__g1.h_x;
				var l_b_fd=l__g1.h_fd;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&l__g.h_fd==l_b_fd;
			} else return false;
		case 49:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==49){
				var l_b_x=l__g1.h_x;
				var l_b_fd=l__g1.h_fd;
				var l_b_val=l__g1.h_val;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&l__g.h_fd==l_b_fd&&gml_node_tools_equals(l__g.h_val,l_b_val);
			} else return false;
		case 50:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==50){
				var l_b_x=l__g1.h_x;
				var l_b_fd=l__g1.h_fd;
				var l_b_op=l__g1.h_op;
				var l_b_val=l__g1.h_val;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&l__g.h_fd==l_b_fd&&l__g.h_op==l_b_op&&gml_node_tools_equals(l__g.h_val,l_b_val);
			} else return false;
		case 51:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==51)return l__g.h_v==l__g1.h_v; else return false;
		case 52:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==52){
				var l_b_v=l__g1.h_v;
				var l_b_val=l__g1.h_val;
				return l__g.h_v==l_b_v&&gml_node_tools_equals(l__g.h_val,l_b_val);
			} else return false;
		case 53:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==53){
				var l_b_v=l__g1.h_v;
				var l_b_op=l__g1.h_op;
				var l_b_val=l__g1.h_val;
				return l__g.h_v==l_b_v&&l__g.h_op==l_b_op&&gml_node_tools_equals(l__g.h_val,l_b_val);
			} else return false;
		case 54:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==54){
				var l_b_x=l__g1.h_x;
				var l_b_av=l__g1.h_av;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&l__g.h_av==l_b_av;
			} else return false;
		case 55:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==55){
				var l_b_x=l__g1.h_x;
				var l_b_av=l__g1.h_av;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&l__g.h_av==l_b_av&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 56:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==56){
				var l_b_x=l__g1.h_x;
				var l_b_av=l__g1.h_av;
				var l_b_op=l__g1.h_op;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&l__g.h_av==l_b_av&&l__g.h_op==l_b_op&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 57:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==57){
				var l_b_v=l__g1.h_v;
				var l_b_k=l__g1.h_k;
				return l__g.h_v==l_b_v&&gml_node_tools_equals(l__g.h_k,l_b_k);
			} else return false;
		case 58:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==58){
				var l_b_v=l__g1.h_v;
				var l_b_k=l__g1.h_k;
				var l_b_val=l__g1.h_val;
				return l__g.h_v==l_b_v&&gml_node_tools_equals(l__g.h_k,l_b_k)&&gml_node_tools_equals(l__g.h_val,l_b_val);
			} else return false;
		case 59:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==59){
				var l_b_v=l__g1.h_v;
				var l_b_k=l__g1.h_k;
				var l_b_op=l__g1.h_op;
				var l_b_val=l__g1.h_val;
				return l__g.h_v==l_b_v&&gml_node_tools_equals(l__g.h_k,l_b_k)&&l__g.h_op==l_b_op&&gml_node_tools_equals(l__g.h_val,l_b_val);
			} else return false;
		case 60:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==60){
				var l_b_x=l__g1.h_x;
				var l_b_i=l__g1.h_i;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_i,l_b_i);
			} else return false;
		case 61:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==61){
				var l_b_x=l__g1.h_x;
				var l_b_i=l__g1.h_i;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_i,l_b_i)&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 62:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==62){
				var l_b_x=l__g1.h_x;
				var l_b_i=l__g1.h_i;
				var l_b_op=l__g1.h_op;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_i,l_b_i)&&l__g.h_op==l_b_op&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 63:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==63){
				var l_b_x=l__g1.h_x;
				var l_b_id=l__g1.h_id;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_id,l_b_id);
			} else return false;
		case 64:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==64){
				var l_b_x=l__g1.h_x;
				var l_b_id=l__g1.h_id;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_id,l_b_id)&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 65:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==65){
				var l_b_x=l__g1.h_x;
				var l_b_id=l__g1.h_id;
				var l_b_o=l__g1.h_o;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_id,l_b_id)&&l__g.h_o==l_b_o&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 66:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==66){
				var l_b_x=l__g1.h_x;
				var l_b_i1=l__g1.h_i1;
				var l_b_i2=l__g1.h_i2;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_i1,l_b_i1)&&gml_node_tools_equals(l__g.h_i2,l_b_i2);
			} else return false;
		case 67:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==67){
				var l_b_x=l__g1.h_x;
				var l_b_i1=l__g1.h_i1;
				var l_b_i2=l__g1.h_i2;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_i1,l_b_i1)&&gml_node_tools_equals(l__g.h_i2,l_b_i2)&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 68:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==68){
				var l_b_x=l__g1.h_x;
				var l_b_i1=l__g1.h_i1;
				var l_b_i2=l__g1.h_i2;
				var l_b_o=l__g1.h_o;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_i1,l_b_i1)&&gml_node_tools_equals(l__g.h_i2,l_b_i2)&&l__g.h_o==l_b_o&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 69:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==69){
				var l_b_x=l__g1.h_x;
				var l_b_id=l__g1.h_id;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_id,l_b_id);
			} else return false;
		case 70:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==70){
				var l_b_x=l__g1.h_x;
				var l_b_id=l__g1.h_id;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_id,l_b_id)&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 71:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==71){
				var l_b_x=l__g1.h_x;
				var l_b_id=l__g1.h_id;
				var l_b_o=l__g1.h_o;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_id,l_b_id)&&l__g.h_o==l_b_o&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 72:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==72){
				var l_b_x=l__g1.h_x;
				var l_b_i1=l__g1.h_i1;
				var l_b_i2=l__g1.h_i2;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_i1,l_b_i1)&&gml_node_tools_equals(l__g.h_i2,l_b_i2);
			} else return false;
		case 73:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==73){
				var l_b_x=l__g1.h_x;
				var l_b_i1=l__g1.h_i1;
				var l_b_i2=l__g1.h_i2;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_i1,l_b_i1)&&gml_node_tools_equals(l__g.h_i2,l_b_i2)&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 74:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==74){
				var l_b_x=l__g1.h_x;
				var l_b_i1=l__g1.h_i1;
				var l_b_i2=l__g1.h_i2;
				var l_b_o=l__g1.h_o;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_i1,l_b_i1)&&gml_node_tools_equals(l__g.h_i2,l_b_i2)&&l__g.h_o==l_b_o&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 75:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==75){
				var l_b_lx=l__g1.h_lx;
				var l_b_id=l__g1.h_id;
				return gml_node_tools_equals(l__g.h_lx,l_b_lx)&&gml_node_tools_equals(l__g.h_id,l_b_id);
			} else return false;
		case 76:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==76){
				var l_b_lx=l__g1.h_lx;
				var l_b_id=l__g1.h_id;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_lx,l_b_lx)&&gml_node_tools_equals(l__g.h_id,l_b_id)&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 77:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==77){
				var l_b_lx=l__g1.h_lx;
				var l_b_id=l__g1.h_id;
				var l_b_o=l__g1.h_o;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_lx,l_b_lx)&&gml_node_tools_equals(l__g.h_id,l_b_id)&&l__g.h_o==l_b_o&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 78:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==78){
				var l_b_lx=l__g1.h_lx;
				var l_b_id=l__g1.h_id;
				return gml_node_tools_equals(l__g.h_lx,l_b_lx)&&gml_node_tools_equals(l__g.h_id,l_b_id);
			} else return false;
		case 79:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==79){
				var l_b_lx=l__g1.h_lx;
				var l_b_id=l__g1.h_id;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_lx,l_b_lx)&&gml_node_tools_equals(l__g.h_id,l_b_id)&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 80:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==80){
				var l_b_lx=l__g1.h_lx;
				var l_b_id=l__g1.h_id;
				var l_b_o=l__g1.h_o;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_lx,l_b_lx)&&gml_node_tools_equals(l__g.h_id,l_b_id)&&l__g.h_o==l_b_o&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 81:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==81){
				var l_b_lx=l__g1.h_lx;
				var l_b_i1=l__g1.h_i1;
				var l_b_i2=l__g1.h_i2;
				return gml_node_tools_equals(l__g.h_lx,l_b_lx)&&gml_node_tools_equals(l__g.h_i1,l_b_i1)&&gml_node_tools_equals(l__g.h_i2,l_b_i2);
			} else return false;
		case 82:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==82){
				var l_b_lx=l__g1.h_lx;
				var l_b_i1=l__g1.h_i1;
				var l_b_i2=l__g1.h_i2;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_lx,l_b_lx)&&gml_node_tools_equals(l__g.h_i1,l_b_i1)&&gml_node_tools_equals(l__g.h_i2,l_b_i2)&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 83:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==83){
				var l_b_lx=l__g1.h_lx;
				var l_b_i1=l__g1.h_i1;
				var l_b_i2=l__g1.h_i2;
				var l_b_o=l__g1.h_o;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_lx,l_b_lx)&&gml_node_tools_equals(l__g.h_i1,l_b_i1)&&gml_node_tools_equals(l__g.h_i2,l_b_i2)&&l__g.h_o==l_b_o&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 84:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==84){
				var l_b_x=l__g1.h_x;
				var l_b_id=l__g1.h_id;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_id,l_b_id);
			} else return false;
		case 85:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==85){
				var l_b_x=l__g1.h_x;
				var l_b_id=l__g1.h_id;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_id,l_b_id)&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 86:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==86){
				var l_b_x=l__g1.h_x;
				var l_b_id=l__g1.h_id;
				var l_b_o=l__g1.h_o;
				var l_b_v=l__g1.h_v;
				return gml_node_tools_equals(l__g.h_x,l_b_x)&&gml_node_tools_equals(l__g.h_id,l_b_id)&&l__g.h_o==l_b_o&&gml_node_tools_equals(l__g.h_v,l_b_v);
			} else return false;
		case 87:
			var l_a_value=l__g.h_value;
			var l__g1=l_b;
			if(l__g1.__enumIndex__==87){
				var l_b_name=l__g1.h_name;
				var l_b_value=l__g1.h_value;
				if(l__g.h_name==l_b_name){
					if(l_a_value!=undefined)return l_b_value!=undefined&&gml_node_tools_equals(l_a_value,l_b_value); else return l_b_value==undefined;
				} else return false;
			} else return false;
		case 88:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==88)return gml_node_tools_equals_list(l__g.h_nodes,l__g1.h_nodes); else return false;
		case 89:
			var l_a_not=l__g.h_not;
			var l__g1=l_b;
			if(l__g1.__enumIndex__==89){
				var l_b_cond=l__g1.h_cond;
				var l_b_then=l__g1.h_then;
				var l_b_not=l__g1.h_not;
				if(gml_node_tools_equals(l__g.h_cond,l_b_cond)&&gml_node_tools_equals(l__g.h_then,l_b_then)){
					if(l_a_not!=undefined)return l_b_not!=undefined&&gml_node_tools_equals(l_a_not,l_b_not); else return l_b_not==undefined;
				} else return false;
			} else return false;
		case 90:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==90){
				var l_b_cond=l__g1.h_cond;
				var l_b_then=l__g1.h_then;
				var l_b_not=l__g1.h_not;
				return gml_node_tools_equals(l__g.h_cond,l_b_cond)&&gml_node_tools_equals(l__g.h_then,l_b_then)&&gml_node_tools_equals(l__g.h_not,l_b_not);
			} else return false;
		case 92:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==92)return gml_node_tools_equals(l__g.h_time,l__g1.h_time); else return false;
		case 94:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==94){
				var l_b_cond=l__g1.h_cond;
				var l_b_node=l__g1.h_node;
				return gml_node_tools_equals(l__g.h_cond,l_b_cond)&&gml_node_tools_equals(l__g.h_node,l_b_node);
			} else return false;
		case 95:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==95){
				var l_b_node=l__g1.h_node;
				var l_b_cond=l__g1.h_cond;
				return gml_node_tools_equals(l__g.h_node,l_b_node)&&gml_node_tools_equals(l__g.h_cond,l_b_cond);
			} else return false;
		case 96:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==96){
				var l_b_node=l__g1.h_node;
				var l_b_cond=l__g1.h_cond;
				return gml_node_tools_equals(l__g.h_node,l_b_node)&&gml_node_tools_equals(l__g.h_cond,l_b_cond);
			} else return false;
		case 97:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==97){
				var l_b_times=l__g1.h_times;
				var l_b_node=l__g1.h_node;
				return gml_node_tools_equals(l__g.h_times,l_b_times)&&gml_node_tools_equals(l__g.h_node,l_b_node);
			} else return false;
		case 98:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==98){
				var l_b_pre=l__g1.h_pre;
				var l_b_cond=l__g1.h_cond;
				var l_b_post=l__g1.h_post;
				var l_b_loop=l__g1.h_loop;
				return gml_node_tools_equals(l__g.h_pre,l_b_pre)&&gml_node_tools_equals(l__g.h_cond,l_b_cond)&&gml_node_tools_equals(l__g.h_post,l_b_post)&&gml_node_tools_equals(l__g.h_loop,l_b_loop);
			} else return false;
		case 99:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==99){
				var l_b_ctx=l__g1.h_ctx;
				var l_b_node=l__g1.h_node;
				return gml_node_tools_equals(l__g.h_ctx,l_b_ctx)&&gml_node_tools_equals(l__g.h_node,l_b_node);
			} else return false;
		case 100:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==100)return gml_node_tools_equals(l__g.h_node,l__g1.h_node); else return false;
		case 101:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==101)return gml_node_tools_equals(l__g.h_v,l__g1.h_v); else return false;
		case 106:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==106){
				var l_b_node=l__g1.h_node;
				var l_b_cap=l__g1.h_cap;
				var l_b_cat=l__g1.h_cat;
				return gml_node_tools_equals(l__g.h_node,l_b_node)&&l__g.h_cap==l_b_cap&&gml_node_tools_equals(l__g.h_cat,l_b_cat);
			} else return false;
		case 107:
			var l__g=l_b;
			if(l__g.__enumIndex__==107)return gml_node_tools_equals(l__g.h_x,l__g.h_x); else return false;
		case 17:
			var l__g1=l_b;
			if(l__g1.__enumIndex__==17){
				var l_s2=l__g1.h_name;
				var l_i2=l__g1.h_id;
				return l__g.h_name==l_s2&&l__g.h_id==l_i2;
			} else return false;
		case 6:
			var l_m1=l__g.h_values;
			var l__g1=l_b;
			if(l__g1.__enumIndex__==6){
				var l_k2=l__g1.h_keys;
				var l_m2=l__g1.h_values;
				l_n=array_length(l_m1);
				if(array_length(l_m2)==l_n){
					l_i=0;
					while(l_i<l_n){
						if(l__g.h_keys[l_i]==l_k2[l_i]&&gml_node_tools_equals(l_m1[l_i],l_m2[l_i]))l_i++; else break;
					}
					return l_i>=l_n;
				} else return false;
			} else return false;
		case 91:
			var l_m1=l__g.h_list;
			var l_o1=l__g.h_def;
			var l__g1=l_b;
			if(l__g1.__enumIndex__==91){
				var l_x2=l__g1.h_expr;
				var l_m2=l__g1.h_list;
				var l_o2=l__g1.h_def;
				if(gml_node_tools_equals(l__g.h_expr,l_x2)&&(l_o1!=undefined&&l_o2!=undefined&&gml_node_tools_equals(l_o1,l_o2)||l_o1==undefined&&l_o2==undefined)){
					l_n=array_length(l_m1);
					if(array_length(l_m2)!=l_n)return false;
					l_i=0;
					while(l_i<l_n){
						if(gml_node_tools_equals(l_m1[l_i].expr,l_m2[l_i].expr)&&gml_node_tools_equals_list(l_m1[l_i].values,l_m2[l_i].values))l_i++; else break;
					}
					return l_i>=l_n;
				} else return false;
			} else return false;
	}
}

if(live_enabled)
function gml_node_tools_clone_opt(l_q){
	if(l_q!=undefined)return gml_node_tools_clone(l_q); else return undefined;
}

if(live_enabled)
function gml_node_tools_clone(l_q){
	var l_xw,l_i,l_n,l_fi;
	var l_d=gml_std_haxe_enum_tools_getParameter(l_q,0);
	var l__g=l_q;
	switch(l__g.__enumIndex__){
		case 0:return gml_node_undefined_hx(l_d);
		case 1:return gml_node_number(l_d,l__g.h_value,l__g.h_src);
		case 2:return gml_node_cstring(l_d,l__g.h_value);
		case 3:return gml_node_other_const(l_d,l__g.h_value);
		case 4:return gml_node_enum_ctr(l_d,l__g.h_e,l__g.h_ctr);
		case 5:
			l_xw=gml_std_gml_internal_ArrayImpl_copy(l__g.h_values);
			l_fi=array_length(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_tools_clone(l_xw[l_fi]);
			}
			return gml_node_array_decl(l_d,l_xw);
		case 6:
			l_xw=gml_std_gml_internal_ArrayImpl_copy(l__g.h_values);
			l_fi=array_length(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_tools_clone(l_xw[l_fi]);
			}
			return gml_node_object_decl(l_d,gml_std_gml_internal_ArrayImpl_slice(l__g.h_keys,0),l_xw);
		case 7:return gml_node_ensure_array_for_local(l_d,l__g.h_name);
		case 8:return gml_node_ensure_array_for_global(l_d,l__g.h_name);
		case 9:return gml_node_ensure_array_for_field(l_d,gml_node_tools_clone(l__g.h_obj),l__g.h_fd);
		case 10:return gml_node_ensure_array_for_index(l_d,gml_node_tools_clone(l__g.h_arr),gml_node_tools_clone(l__g.h_ind));
		case 11:return gml_node_ensure_array_for_index2d(l_d,gml_node_tools_clone(l__g.h_arr),gml_node_tools_clone(l__g.h_ind1),gml_node_tools_clone(l__g.h_ind2));
		case 12:return gml_node_ident(l_d,l__g.h_id);
		case 13:return gml_node_self_hx(l_d);
		case 14:return gml_node_other_hx(l_d);
		case 15:return gml_node_global_ref(l_d);
		case 16:return gml_node_script(l_d,l__g.h_ref);
		case 18:return gml_node_const(l_d,l__g.h_id);
		case 19:return gml_node_arg_const(l_d,l__g.h_id);
		case 20:return gml_node_arg_index(l_d,gml_node_tools_clone(l__g.h_id));
		case 21:return gml_node_arg_count(l_d);
		case 22:
			l_xw=gml_std_gml_internal_ArrayImpl_copy(l__g.h_args);
			l_fi=array_length(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_tools_clone(l_xw[l_fi]);
			}
			return gml_node_call(l_d,gml_node_tools_clone(l__g.h_x),l_xw);
		case 23:
			l_xw=gml_std_gml_internal_ArrayImpl_copy(l__g.h_args);
			l_fi=array_length(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_tools_clone(l_xw[l_fi]);
			}
			return gml_node_call_script(l_d,l__g.h_name,l_xw);
		case 24:
			l_xw=gml_std_gml_internal_ArrayImpl_copy(l__g.h_args);
			l_fi=array_length(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_tools_clone(l_xw[l_fi]);
			}
			return gml_node_call_script_at(l_d,gml_node_tools_clone(l__g.h_inst),l__g.h_script,l_xw);
		case 25:
			l_xw=gml_std_gml_internal_ArrayImpl_copy(l__g.h_args);
			l_fi=array_length(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_tools_clone(l_xw[l_fi]);
			}
			return gml_node_call_script_id(l_d,gml_node_tools_clone(l__g.h_index),l_xw);
		case 26:return gml_node_call_script_with_array(l_d,gml_node_tools_clone(l__g.h_index),gml_node_tools_clone(l__g.h_array));
		case 27:
			l_xw=gml_std_gml_internal_ArrayImpl_copy(l__g.h_args);
			l_fi=array_length(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_tools_clone(l_xw[l_fi]);
			}
			return gml_node_call_field(l_d,gml_node_tools_clone(l__g.h_inst),l__g.h_prop,l_xw);
		case 28:
			l_xw=gml_std_gml_internal_ArrayImpl_copy(l__g.h_args);
			l_fi=array_length(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_tools_clone(l_xw[l_fi]);
			}
			return gml_node_call_func(l_d,l__g.h_fn,l_xw);
		case 29:
			l_xw=gml_std_gml_internal_ArrayImpl_copy(l__g.h_args);
			l_fi=array_length(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_tools_clone(l_xw[l_fi]);
			}
			return gml_node_call_func_at(l_d,gml_node_tools_clone(l__g.h_x),l__g.h_s,l_xw);
		case 30:
			l_xw=gml_std_gml_internal_ArrayImpl_copy(l__g.h_args);
			l_fi=array_length(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_tools_clone(l_xw[l_fi]);
			}
			return gml_node_construct(l_d,gml_node_tools_clone(l__g.h_ctr),l_xw);
		case 31:return gml_node_func_literal(l_d,l__g.h_name);
		case 32:return gml_node_prefix(l_d,gml_node_tools_clone(l__g.h_x),l__g.h_inc);
		case 33:return gml_node_postfix(l_d,gml_node_tools_clone(l__g.h_x),l__g.h_inc);
		case 34:return gml_node_un_op(l_d,gml_node_tools_clone(l__g.h_x),l__g.h_o);
		case 35:return gml_node_bin_op(l_d,l__g.h_o,gml_node_tools_clone(l__g.h_a),gml_node_tools_clone(l__g.h_b));
		case 36:return gml_node_set_op(l_d,l__g.h_o,gml_node_tools_clone(l__g.h_a),gml_node_tools_clone(l__g.h_b));
		case 37:return gml_node_delete_hx(l_d,gml_node_tools_clone(l__g.h_x));
		case 38:return gml_node_null_co(l_d,gml_node_tools_clone(l__g.h_a),gml_node_tools_clone(l__g.h_b));
		case 39:return gml_node_to_bool(l_d,gml_node_tools_clone(l__g.h_v));
		case 40:return gml_node_from_bool(l_d,gml_node_tools_clone(l__g.h_v));
		case 41:return gml_node_in(l_d,gml_node_tools_clone(l__g.h_fd),gml_node_tools_clone(l__g.h_val),l__g.h_not);
		case 42:return gml_node_local_hx(l_d,l__g.h_id);
		case 43:return gml_node_local_set(l_d,l__g.h_id,gml_node_tools_clone(l__g.h_val));
		case 44:return gml_node_local_aop(l_d,l__g.h_id,l__g.h_op,gml_node_tools_clone(l__g.h_val));
		case 45:return gml_node_global_hx(l_d,l__g.h_id);
		case 46:return gml_node_global_set(l_d,l__g.h_id,gml_node_tools_clone(l__g.h_val));
		case 47:return gml_node_global_aop(l_d,l__g.h_id,l__g.h_op,gml_node_tools_clone(l__g.h_val));
		case 48:return gml_node_field(l_d,gml_node_tools_clone(l__g.h_x),l__g.h_fd);
		case 49:return gml_node_field_set(l_d,gml_node_tools_clone(l__g.h_x),l__g.h_fd,gml_node_tools_clone(l__g.h_val));
		case 50:return gml_node_field_aop(l_d,gml_node_tools_clone(l__g.h_x),l__g.h_fd,l__g.h_op,gml_node_tools_clone(l__g.h_val));
		case 51:return gml_node_env(l_d,l__g.h_v);
		case 52:return gml_node_env_set(l_d,l__g.h_v,gml_node_tools_clone(l__g.h_val));
		case 53:return gml_node_env_aop(l_d,l__g.h_v,l__g.h_op,gml_node_tools_clone(l__g.h_val));
		case 54:return gml_node_env_fd(l_d,gml_node_tools_clone(l__g.h_x),l__g.h_av);
		case 55:return gml_node_env_fd_set(l_d,gml_node_tools_clone(l__g.h_x),l__g.h_av,gml_node_tools_clone(l__g.h_v));
		case 56:return gml_node_env_fd_aop(l_d,gml_node_tools_clone(l__g.h_x),l__g.h_av,l__g.h_op,gml_node_tools_clone(l__g.h_v));
		case 57:return gml_node_env1d(l_d,l__g.h_v,gml_node_tools_clone(l__g.h_k));
		case 58:return gml_node_env1d_set(l_d,l__g.h_v,gml_node_tools_clone(l__g.h_k),gml_node_tools_clone(l__g.h_val));
		case 59:return gml_node_env1d_aop(l_d,l__g.h_v,gml_node_tools_clone(l__g.h_k),l__g.h_op,gml_node_tools_clone(l__g.h_val));
		case 60:return gml_node_alarm(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_i));
		case 61:return gml_node_alarm_set_hx(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_i),gml_node_tools_clone(l__g.h_v));
		case 62:return gml_node_alarm_aop(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_i),l__g.h_op,gml_node_tools_clone(l__g.h_v));
		case 63:return gml_node_index(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_id));
		case 64:return gml_node_index_set(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_id),gml_node_tools_clone(l__g.h_v));
		case 65:return gml_node_index_aop(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_id),l__g.h_o,gml_node_tools_clone(l__g.h_v));
		case 66:return gml_node_index2d(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_i1),gml_node_tools_clone(l__g.h_i2));
		case 67:return gml_node_index2d_set(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_i1),gml_node_tools_clone(l__g.h_i2),gml_node_tools_clone(l__g.h_v));
		case 68:return gml_node_index2d_aop(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_i1),gml_node_tools_clone(l__g.h_i2),l__g.h_o,gml_node_tools_clone(l__g.h_v));
		case 69:return gml_node_raw_id(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_id));
		case 70:return gml_node_raw_id_set(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_id),gml_node_tools_clone(l__g.h_v));
		case 71:return gml_node_raw_id_aop(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_id),l__g.h_o,gml_node_tools_clone(l__g.h_v));
		case 72:return gml_node_raw_id2d(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_i1),gml_node_tools_clone(l__g.h_i2));
		case 73:return gml_node_raw_id2d_set(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_i1),gml_node_tools_clone(l__g.h_i2),gml_node_tools_clone(l__g.h_v));
		case 74:return gml_node_raw_id2d_aop(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_i1),gml_node_tools_clone(l__g.h_i2),l__g.h_o,gml_node_tools_clone(l__g.h_v));
		case 75:return gml_node_ds_list(l_d,gml_node_tools_clone(l__g.h_lx),gml_node_tools_clone(l__g.h_id));
		case 76:return gml_node_ds_list_set_hx(l_d,gml_node_tools_clone(l__g.h_lx),gml_node_tools_clone(l__g.h_id),gml_node_tools_clone(l__g.h_v));
		case 77:return gml_node_ds_list_aop(l_d,gml_node_tools_clone(l__g.h_lx),gml_node_tools_clone(l__g.h_id),l__g.h_o,gml_node_tools_clone(l__g.h_v));
		case 78:return gml_node_ds_map(l_d,gml_node_tools_clone(l__g.h_lx),gml_node_tools_clone(l__g.h_id));
		case 79:return gml_node_ds_map_set_hx(l_d,gml_node_tools_clone(l__g.h_lx),gml_node_tools_clone(l__g.h_id),gml_node_tools_clone(l__g.h_v));
		case 80:return gml_node_ds_map_aop(l_d,gml_node_tools_clone(l__g.h_lx),gml_node_tools_clone(l__g.h_id),l__g.h_o,gml_node_tools_clone(l__g.h_v));
		case 81:return gml_node_ds_grid(l_d,gml_node_tools_clone(l__g.h_lx),gml_node_tools_clone(l__g.h_i1),gml_node_tools_clone(l__g.h_i2));
		case 82:return gml_node_ds_grid_set_hx(l_d,gml_node_tools_clone(l__g.h_lx),gml_node_tools_clone(l__g.h_i1),gml_node_tools_clone(l__g.h_i2),gml_node_tools_clone(l__g.h_v));
		case 83:return gml_node_ds_grid_aop(l_d,gml_node_tools_clone(l__g.h_lx),gml_node_tools_clone(l__g.h_i1),gml_node_tools_clone(l__g.h_i2),l__g.h_o,gml_node_tools_clone(l__g.h_v));
		case 84:return gml_node_key_id(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_id));
		case 85:return gml_node_key_id_set(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_id),gml_node_tools_clone(l__g.h_v));
		case 86:return gml_node_key_id_aop(l_d,gml_node_tools_clone(l__g.h_x),gml_node_tools_clone(l__g.h_id),l__g.h_o,gml_node_tools_clone(l__g.h_v));
		case 87:return gml_node_var_decl(l_d,l__g.h_name,gml_node_tools_clone_opt(l__g.h_value));
		case 88:
			l_xw=gml_std_gml_internal_ArrayImpl_copy(l__g.h_nodes);
			l_fi=array_length(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_tools_clone(l_xw[l_fi]);
			}
			return gml_node_block(l_d,l_xw);
		case 89:return gml_node_if_then(l_d,gml_node_tools_clone(l__g.h_cond),gml_node_tools_clone(l__g.h_then),gml_node_tools_clone_opt(l__g.h_not));
		case 90:return gml_node_ternary(l_d,gml_node_tools_clone(l__g.h_cond),gml_node_tools_clone(l__g.h_then),gml_node_tools_clone(l__g.h_not));
		case 92:return gml_node_wait(l_d,gml_node_tools_clone(l__g.h_time));
		case 93:return gml_node_fork(l_d);
		case 94:return gml_node_while_hx(l_d,gml_node_tools_clone(l__g.h_cond),gml_node_tools_clone(l__g.h_node));
		case 95:return gml_node_do_until(l_d,gml_node_tools_clone(l__g.h_node),gml_node_tools_clone(l__g.h_cond));
		case 96:return gml_node_do_while(l_d,gml_node_tools_clone(l__g.h_node),gml_node_tools_clone(l__g.h_cond));
		case 97:return gml_node_repeat_hx(l_d,gml_node_tools_clone(l__g.h_times),gml_node_tools_clone(l__g.h_node));
		case 98:return gml_node_for_hx(l_d,gml_node_tools_clone(l__g.h_pre),gml_node_tools_clone(l__g.h_cond),gml_node_tools_clone(l__g.h_post),gml_node_tools_clone(l__g.h_loop));
		case 99:return gml_node_with_hx(l_d,gml_node_tools_clone(l__g.h_ctx),gml_node_tools_clone(l__g.h_node));
		case 100:return gml_node_once(l_d,gml_node_tools_clone(l__g.h_node));
		case 101:return gml_node_return_hx(l_d,gml_node_tools_clone(l__g.h_v));
		case 102:return gml_node_exit_hx(l_d);
		case 103:return gml_node_break_hx(l_d);
		case 104:return gml_node_continue_hx(l_d);
		case 105:return gml_node_debugger(l_d);
		case 106:return gml_node_try_catch(l_d,gml_node_tools_clone(l__g.h_node),l__g.h_cap,gml_node_tools_clone(l__g.h_cat));
		case 107:return gml_node_throw_hx(l_d,gml_node_tools_clone(l__g.h_x));
		case 17:return gml_node_native_script(l__g.h_d,l__g.h_name,l__g.h_id);
		case 91:
			var l_m=l__g.h_list;
			l_m=gml_std_gml_internal_ArrayImpl_copy(l_m);
			l_n=array_length(l_m);
			for(l_i=0;l_i<l_n;l_i++){
				var l_cc=l_m[l_i];
				l_xw=gml_std_gml_internal_ArrayImpl_copy(l_cc.values);
				l_fi=array_length(l_xw);
				while(--l_fi>=0){
					l_xw[@l_fi]=gml_node_tools_clone(l_xw[l_fi]);
				}
				l_cc={values:l_xw,expr:gml_node_tools_clone(l_cc.expr),pre:l_cc.pre}
				l_m[@l_i]=l_cc;
				l_xw=gml_std_gml_internal_ArrayImpl_copy(l_cc.pre);
				l_fi=array_length(l_xw);
				while(--l_fi>=0){
					l_xw[@l_fi]=gml_node_tools_clone(l_xw[l_fi]);
				}
				l_cc.pre=l_xw;
			}
			return gml_node_switch_hx(l__g.h_d,gml_node_tools_clone(l__g.h_expr),l_m,gml_node_tools_clone_opt(l__g.h_def));
	}
}

if(live_enabled)
function gml_node_tools_seek_all_out(l_q,l_st,l_c,l_si){
	var l_w,l_i;
	var l_par=ds_list_find_value(l_st,l_si);
	if(l_par==undefined)return false;
	var l__g=l_par;
	switch(l__g.__enumIndex__){
		case 88:
			l_w=l__g.h_nodes;
			l_i=array_length(l_w);
			while(--l_i>=0){
				if(l_w[l_i]==l_q)break;
			}
			while(--l_i>=0){
				if(l_c(l_w[l_i],undefined))return true;
			}
			break;
		case 89:
			var l_c1=l__g.h_cond;
			if(l_c1!=l_q&&l_c(l_c1,undefined))return true;
			break;
		case 94:
			var l_c1=l__g.h_cond;
			if(l_c1!=l_q&&l_c(l_c1,undefined))return true;
			break;
		case 96:
			var l_c1=l__g.h_node;
			if(l_c1!=l_q&&l_c(l_c1,undefined))return true;
			break;
		case 95:
			var l_c1=l__g.h_node;
			if(l_c1!=l_q&&l_c(l_c1,undefined))return true;
			break;
		case 97:
			var l_c1=l__g.h_times;
			if(l_c1!=l_q&&l_c(l_c1,undefined))return true;
			break;
		case 98:
			var l_c1=l__g.h_pre;
			if(l_c1!=l_q&&l_c(l_c1,undefined))return true;
			break;
		case 91:
			var l_c1=l__g.h_expr;
			if(l_c1!=l_q&&l_c(l_c1,undefined))return true;
			break;
		case 99:
			var l_c1=l__g.h_ctx;
			if(l_c1!=l_q&&l_c(l_c1,undefined))return true;
			break;
		default:show_error("Can't seekAllOut over "+ast_gml_node_tools_ni_get_pos_string(l_par)+" "+gml_std_Type_enumConstructor(l_par),true);
	}
	return gml_node_tools_seek_all_out(l_par,l_st,l_c,l_si+1);
}

if(live_enabled)
function gml_node_tools_seek_all(l_q,l_st,l_c){
	if(l_st!=undefined)ds_list_insert(l_st,0,l_q);
	var l_r,l_x,l_w,l_i,l_n;
	var l__g=l_q;
	switch(l__g.__enumIndex__){
		case 9:l_r=l_c(l__g.h_obj,undefined);break;
		case 20:l_r=l_c(l__g.h_id,undefined);break;
		case 32:l_r=l_c(l__g.h_x,undefined);break;
		case 33:l_r=l_c(l__g.h_x,undefined);break;
		case 37:l_r=l_c(l__g.h_x,undefined);break;
		case 39:l_r=l_c(l__g.h_v,undefined);break;
		case 40:l_r=l_c(l__g.h_v,undefined);break;
		case 43:l_r=l_c(l__g.h_val,undefined);break;
		case 44:l_r=l_c(l__g.h_val,undefined);break;
		case 46:l_r=l_c(l__g.h_val,undefined);break;
		case 47:l_r=l_c(l__g.h_val,undefined);break;
		case 52:l_r=l_c(l__g.h_val,undefined);break;
		case 53:l_r=l_c(l__g.h_val,undefined);break;
		case 92:l_r=l_c(l__g.h_time,undefined);break;
		case 100:l_r=l_c(l__g.h_node,undefined);break;
		case 101:l_r=l_c(l__g.h_v,undefined);break;
		case 107:l_r=l_c(l__g.h_x,undefined);break;
		case 0:l_r=false;break;
		case 1:l_r=false;break;
		case 2:l_r=false;break;
		case 3:l_r=false;break;
		case 4:l_r=false;break;
		case 7:l_r=false;break;
		case 8:l_r=false;break;
		case 12:l_r=false;break;
		case 13:l_r=false;break;
		case 14:l_r=false;break;
		case 15:l_r=false;break;
		case 16:l_r=false;break;
		case 17:l_r=false;break;
		case 18:l_r=false;break;
		case 19:l_r=false;break;
		case 21:l_r=false;break;
		case 31:l_r=false;break;
		case 42:l_r=false;break;
		case 45:l_r=false;break;
		case 51:l_r=false;break;
		case 93:l_r=false;break;
		case 102:l_r=false;break;
		case 103:l_r=false;break;
		case 104:l_r=false;break;
		case 105:l_r=false;break;
		case 35:
			switch(l__g.h_o){
				case 80:
					var l_a=l__g.h_a;
					var l_b=l__g.h_b;
					l_r=l_c(l_a,undefined)&&l_c(l_b,undefined);
					break;
				case 96:l_r=l_c(l__g.h_a,undefined);break;
				default:
					var l_l_a=l__g.h_a;
					var l_l_b=l__g.h_b;
					l_r=l_c(l_l_a,undefined)||l_c(l_l_b,undefined);
			}
			break;
		case 5:
			l_w=l__g.h_values;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(l_c(l_w[l_i],undefined))break;
			}
			l_r=l_i<l_n;
			break;
		case 6:
			l_w=l__g.h_values;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(l_c(l_w[l_i],undefined))break;
			}
			l_r=l_i<l_n;
			break;
		case 87:
			var l_v=l__g.h_value;
			l_r=l_v!=undefined&&l_c(l_v,undefined);
			break;
		case 38:l_r=l_c(l__g.h_a,undefined);break;
		case 34:l_r=l_c(l__g.h_x,undefined);break;
		case 88:
			l_w=l__g.h_nodes;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(l_c(l_w[l_i],undefined))break;
			}
			l_r=l_i<l_n;
			break;
		case 22:
			var l_x1=l__g.h_x;
			var l_m=l__g.h_args;
			if(l_c(l_x1,undefined)){
				l_r=true;
			} else {
				l_w=l_m;
				l_n=array_length(l_w);
				for(l_i=0;l_i<l_n;l_i++){
					if(l_c(l_w[l_i],undefined))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 25:
			var l_x1=l__g.h_index;
			var l_m=l__g.h_args;
			if(l_c(l_x1,undefined)){
				l_r=true;
			} else {
				l_w=l_m;
				l_n=array_length(l_w);
				for(l_i=0;l_i<l_n;l_i++){
					if(l_c(l_w[l_i],undefined))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 30:
			var l_x1=l__g.h_ctr;
			var l_m=l__g.h_args;
			if(l_c(l_x1,undefined)){
				l_r=true;
			} else {
				l_w=l_m;
				l_n=array_length(l_w);
				for(l_i=0;l_i<l_n;l_i++){
					if(l_c(l_w[l_i],undefined))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 24:
			var l_x1=l__g.h_inst;
			var l_m=l__g.h_args;
			if(l_c(l_x1,undefined)){
				l_r=true;
			} else {
				l_w=l_m;
				l_n=array_length(l_w);
				for(l_i=0;l_i<l_n;l_i++){
					if(l_c(l_w[l_i],undefined))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 27:
			var l_x1=l__g.h_inst;
			var l_m=l__g.h_args;
			if(l_c(l_x1,undefined)){
				l_r=true;
			} else {
				l_w=l_m;
				l_n=array_length(l_w);
				for(l_i=0;l_i<l_n;l_i++){
					if(l_c(l_w[l_i],undefined))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 29:
			var l_x1=l__g.h_x;
			var l_m=l__g.h_args;
			if(l_c(l_x1,undefined)){
				l_r=true;
			} else {
				l_w=l_m;
				l_n=array_length(l_w);
				for(l_i=0;l_i<l_n;l_i++){
					if(l_c(l_w[l_i],undefined))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 23:
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(l_c(l_w[l_i],undefined))break;
			}
			l_r=l_i<l_n;
			break;
		case 28:
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(l_c(l_w[l_i],undefined))break;
			}
			l_r=l_i<l_n;
			break;
		case 26:
			var l_x1=l__g.h_index;
			var l_y=l__g.h_array;
			l_r=l_c(l_x1,undefined)||l_c(l_y,undefined);
			break;
		case 89:
			var l_c1=l__g.h_cond;
			var l_a=l__g.h_then;
			var l_b=l__g.h_not;
			l_r=l_c(l_c1,undefined)||l_b!=undefined&&l_c(l_a,undefined)&&l_c(l_b,undefined);
			break;
		case 90:
			var l_c1=l__g.h_cond;
			var l_a=l__g.h_then;
			var l_b=l__g.h_not;
			l_r=l_c(l_c1,undefined)||l_c(l_a,undefined)&&l_c(l_b,undefined);
			break;
		case 98:
			var l_x=l__g.h_pre;
			var l_c1=l__g.h_cond;
			l_r=l_c(l_x,undefined)||l_c(l_c1,undefined);
			break;
		case 94:l_r=l_c(l__g.h_cond,undefined);break;
		case 99:l_r=l_c(l__g.h_ctx,undefined);break;
		case 96:l_r=l_c(l__g.h_node,undefined);break;
		case 95:l_r=l_c(l__g.h_node,undefined);break;
		case 97:l_r=l_c(l__g.h_times,undefined);break;
		case 91:
			var l__x=l__g.h_expr;
			var l__cc=l__g.h_list;
			var l__d=l__g.h_def;
			if(l_c(l__x,undefined)){
				l_r=true;
			} else {
				l_x=l__d;
				if(l_x!=undefined&&l_c(l_x,undefined)){
					l_n=array_length(l__cc);
					l_i=0;
					while(l_i<l_n){
						if(l_c(l_x,undefined))l_i++; else break;
					}
					l_r=l_i>=l_n;
				} else l_r=false;
			}
			break;
		case 106:
			var l_x=l__g.h_node;
			var l_e=l__g.h_cat;
			l_r=l_c(l_x,undefined)||l_c(l_e,undefined);
			break;
		case 36:
			var l_l_a=l__g.h_a;
			var l_l_b=l__g.h_b;
			l_r=l_c(l_l_a,undefined)||l_c(l_l_b,undefined);
			break;
		case 41:
			var l_l_fd=l__g.h_fd;
			var l_l_val=l__g.h_val;
			l_r=l_c(l_l_fd,undefined)||l_c(l_l_val,undefined);
			break;
		case 57:l_r=l_c(l__g.h_k,undefined);break;
		case 58:
			var l_l_k=l__g.h_k;
			var l_l_val=l__g.h_val;
			l_r=l_c(l_l_k,undefined)||l_c(l_l_val,undefined);
			break;
		case 59:
			var l_l_k=l__g.h_k;
			var l_l_val=l__g.h_val;
			l_r=l_c(l_l_k,undefined)||l_c(l_l_val,undefined);
			break;
		case 60:
			var l_l_x=l__g.h_x;
			var l_l_i=l__g.h_i;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_i,undefined);
			break;
		case 61:
			var l_l_x=l__g.h_x;
			var l_l_i=l__g.h_i;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_i,undefined)||l_c(l_l_v,undefined);
			break;
		case 62:
			var l_l_x=l__g.h_x;
			var l_l_i=l__g.h_i;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_i,undefined)||l_c(l_l_v,undefined);
			break;
		case 10:
			var l_l_arr=l__g.h_arr;
			var l_l_ind=l__g.h_ind;
			l_r=l_c(l_l_arr,undefined)||l_c(l_l_ind,undefined);
			break;
		case 11:
			var l_l_arr=l__g.h_arr;
			var l_l_ind1=l__g.h_ind1;
			var l_l_ind2=l__g.h_ind2;
			l_r=l_c(l_l_arr,undefined)||l_c(l_l_ind1,undefined)||l_c(l_l_ind2,undefined);
			break;
		case 63:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_id,undefined);
			break;
		case 64:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_id,undefined)||l_c(l_l_v,undefined);
			break;
		case 65:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_id,undefined)||l_c(l_l_v,undefined);
			break;
		case 66:
			var l_l_x=l__g.h_x;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_i1,undefined)||l_c(l_l_i2,undefined);
			break;
		case 67:
			var l_l_x=l__g.h_x;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_i1,undefined)||l_c(l_l_i2,undefined)||l_c(l_l_v,undefined);
			break;
		case 68:
			var l_l_x=l__g.h_x;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_i1,undefined)||l_c(l_l_i2,undefined)||l_c(l_l_v,undefined);
			break;
		case 69:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_id,undefined);
			break;
		case 70:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_id,undefined)||l_c(l_l_v,undefined);
			break;
		case 71:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_id,undefined)||l_c(l_l_v,undefined);
			break;
		case 72:
			var l_l_x=l__g.h_x;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_i1,undefined)||l_c(l_l_i2,undefined);
			break;
		case 73:
			var l_l_x=l__g.h_x;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_i1,undefined)||l_c(l_l_i2,undefined)||l_c(l_l_v,undefined);
			break;
		case 74:
			var l_l_x=l__g.h_x;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_i1,undefined)||l_c(l_l_i2,undefined)||l_c(l_l_v,undefined);
			break;
		case 48:l_r=l_c(l__g.h_x,undefined);break;
		case 49:
			var l_l_x=l__g.h_x;
			var l_l_val=l__g.h_val;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_val,undefined);
			break;
		case 50:
			var l_l_x=l__g.h_x;
			var l_l_val=l__g.h_val;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_val,undefined);
			break;
		case 54:l_r=l_c(l__g.h_x,undefined);break;
		case 55:
			var l_l_x=l__g.h_x;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_v,undefined);
			break;
		case 56:
			var l_l_x=l__g.h_x;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_v,undefined);
			break;
		case 75:
			var l_l_lx=l__g.h_lx;
			var l_l_id=l__g.h_id;
			l_r=l_c(l_l_lx,undefined)||l_c(l_l_id,undefined);
			break;
		case 76:
			var l_l_lx=l__g.h_lx;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_lx,undefined)||l_c(l_l_id,undefined)||l_c(l_l_v,undefined);
			break;
		case 77:
			var l_l_lx=l__g.h_lx;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_lx,undefined)||l_c(l_l_id,undefined)||l_c(l_l_v,undefined);
			break;
		case 78:
			var l_l_lx=l__g.h_lx;
			var l_l_id=l__g.h_id;
			l_r=l_c(l_l_lx,undefined)||l_c(l_l_id,undefined);
			break;
		case 79:
			var l_l_lx=l__g.h_lx;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_lx,undefined)||l_c(l_l_id,undefined)||l_c(l_l_v,undefined);
			break;
		case 80:
			var l_l_lx=l__g.h_lx;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_lx,undefined)||l_c(l_l_id,undefined)||l_c(l_l_v,undefined);
			break;
		case 81:
			var l_l_lx=l__g.h_lx;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			l_r=l_c(l_l_lx,undefined)||l_c(l_l_i1,undefined)||l_c(l_l_i2,undefined);
			break;
		case 82:
			var l_l_lx=l__g.h_lx;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_lx,undefined)||l_c(l_l_i1,undefined)||l_c(l_l_i2,undefined)||l_c(l_l_v,undefined);
			break;
		case 83:
			var l_l_lx=l__g.h_lx;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_lx,undefined)||l_c(l_l_i1,undefined)||l_c(l_l_i2,undefined)||l_c(l_l_v,undefined);
			break;
		case 84:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_id,undefined);
			break;
		case 85:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_id,undefined)||l_c(l_l_v,undefined);
			break;
		case 86:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,undefined)||l_c(l_l_id,undefined)||l_c(l_l_v,undefined);
			break;
	}
	if(l_st!=undefined)ds_list_delete(l_st,0);
	return false;
}

if(live_enabled)
function gml_node_tools_seek(l_q,l_st,l_c){
	if(l_st!=undefined)ds_list_insert(l_st,0,l_q);
	var l_r,l_w,l_i,l_n,l_k,l_l;
	var l__g=l_q;
	switch(l__g.__enumIndex__){
		case 0:l_r=false;break;
		case 1:l_r=false;break;
		case 2:l_r=false;break;
		case 3:l_r=false;break;
		case 4:l_r=false;break;
		case 5:
			l_w=l__g.h_values;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(l_c(l_w[l_i],l_st))break;
			}
			l_r=l_i<l_n;
			break;
		case 6:
			l_w=l__g.h_values;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(l_c(l_w[l_i],l_st))break;
			}
			l_r=l_i<l_n;
			break;
		case 7:l_r=false;break;
		case 8:l_r=false;break;
		case 9:l_r=l_c(l__g.h_obj,l_st);break;
		case 10:
			var l_l_arr=l__g.h_arr;
			var l_l_ind=l__g.h_ind;
			l_r=l_c(l_l_arr,l_st)||l_c(l_l_ind,l_st);
			break;
		case 11:
			var l_l_arr=l__g.h_arr;
			var l_l_ind1=l__g.h_ind1;
			var l_l_ind2=l__g.h_ind2;
			l_r=l_c(l_l_arr,l_st)||l_c(l_l_ind1,l_st)||l_c(l_l_ind2,l_st);
			break;
		case 12:l_r=false;break;
		case 13:l_r=false;break;
		case 14:l_r=false;break;
		case 15:l_r=false;break;
		case 16:l_r=false;break;
		case 18:l_r=false;break;
		case 19:l_r=false;break;
		case 20:l_r=l_c(l__g.h_id,l_st);break;
		case 21:l_r=false;break;
		case 22:
			var l_l_x=l__g.h_x;
			var l_l_args=l__g.h_args;
			if(l_c(l_l_x,l_st)){
				l_r=true;
			} else {
				l_w=l_l_args;
				l_n=array_length(l_w);
				for(l_i=0;l_i<l_n;l_i++){
					if(l_c(l_w[l_i],l_st))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 23:
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(l_c(l_w[l_i],l_st))break;
			}
			l_r=l_i<l_n;
			break;
		case 24:
			var l_l_inst=l__g.h_inst;
			var l_l_args=l__g.h_args;
			if(l_c(l_l_inst,l_st)){
				l_r=true;
			} else {
				l_w=l_l_args;
				l_n=array_length(l_w);
				for(l_i=0;l_i<l_n;l_i++){
					if(l_c(l_w[l_i],l_st))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 25:
			var l_l_index=l__g.h_index;
			var l_l_args=l__g.h_args;
			if(l_c(l_l_index,l_st)){
				l_r=true;
			} else {
				l_w=l_l_args;
				l_n=array_length(l_w);
				for(l_i=0;l_i<l_n;l_i++){
					if(l_c(l_w[l_i],l_st))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 26:
			var l_l_index=l__g.h_index;
			var l_l_array=l__g.h_array;
			l_r=l_c(l_l_index,l_st)||l_c(l_l_array,l_st);
			break;
		case 27:
			var l_l_inst=l__g.h_inst;
			var l_l_args=l__g.h_args;
			if(l_c(l_l_inst,l_st)){
				l_r=true;
			} else {
				l_w=l_l_args;
				l_n=array_length(l_w);
				for(l_i=0;l_i<l_n;l_i++){
					if(l_c(l_w[l_i],l_st))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 28:
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(l_c(l_w[l_i],l_st))break;
			}
			l_r=l_i<l_n;
			break;
		case 29:
			var l_l_x=l__g.h_x;
			var l_l_args=l__g.h_args;
			if(l_c(l_l_x,l_st)){
				l_r=true;
			} else {
				l_w=l_l_args;
				l_n=array_length(l_w);
				for(l_i=0;l_i<l_n;l_i++){
					if(l_c(l_w[l_i],l_st))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 30:
			var l_l_ctr=l__g.h_ctr;
			var l_l_args=l__g.h_args;
			if(l_c(l_l_ctr,l_st)){
				l_r=true;
			} else {
				l_w=l_l_args;
				l_n=array_length(l_w);
				for(l_i=0;l_i<l_n;l_i++){
					if(l_c(l_w[l_i],l_st))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 31:l_r=false;break;
		case 32:l_r=l_c(l__g.h_x,l_st);break;
		case 33:l_r=l_c(l__g.h_x,l_st);break;
		case 34:l_r=l_c(l__g.h_x,l_st);break;
		case 35:
			var l_l_a=l__g.h_a;
			var l_l_b=l__g.h_b;
			l_r=l_c(l_l_a,l_st)||l_c(l_l_b,l_st);
			break;
		case 36:
			var l_l_a=l__g.h_a;
			var l_l_b=l__g.h_b;
			l_r=l_c(l_l_a,l_st)||l_c(l_l_b,l_st);
			break;
		case 37:l_r=l_c(l__g.h_x,l_st);break;
		case 38:
			var l_l_a=l__g.h_a;
			var l_l_b=l__g.h_b;
			l_r=l_c(l_l_a,l_st)||l_c(l_l_b,l_st);
			break;
		case 39:l_r=l_c(l__g.h_v,l_st);break;
		case 40:l_r=l_c(l__g.h_v,l_st);break;
		case 41:
			var l_l_fd=l__g.h_fd;
			var l_l_val=l__g.h_val;
			l_r=l_c(l_l_fd,l_st)||l_c(l_l_val,l_st);
			break;
		case 42:l_r=false;break;
		case 43:l_r=l_c(l__g.h_val,l_st);break;
		case 44:l_r=l_c(l__g.h_val,l_st);break;
		case 45:l_r=false;break;
		case 46:l_r=l_c(l__g.h_val,l_st);break;
		case 47:l_r=l_c(l__g.h_val,l_st);break;
		case 48:l_r=l_c(l__g.h_x,l_st);break;
		case 49:
			var l_l_x=l__g.h_x;
			var l_l_val=l__g.h_val;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_val,l_st);
			break;
		case 50:
			var l_l_x=l__g.h_x;
			var l_l_val=l__g.h_val;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_val,l_st);
			break;
		case 51:l_r=false;break;
		case 52:l_r=l_c(l__g.h_val,l_st);break;
		case 53:l_r=l_c(l__g.h_val,l_st);break;
		case 54:l_r=l_c(l__g.h_x,l_st);break;
		case 55:
			var l_l_x=l__g.h_x;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_v,l_st);
			break;
		case 56:
			var l_l_x=l__g.h_x;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_v,l_st);
			break;
		case 57:l_r=l_c(l__g.h_k,l_st);break;
		case 58:
			var l_l_k=l__g.h_k;
			var l_l_val=l__g.h_val;
			l_r=l_c(l_l_k,l_st)||l_c(l_l_val,l_st);
			break;
		case 59:
			var l_l_k=l__g.h_k;
			var l_l_val=l__g.h_val;
			l_r=l_c(l_l_k,l_st)||l_c(l_l_val,l_st);
			break;
		case 60:
			var l_l_x=l__g.h_x;
			var l_l_i=l__g.h_i;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_i,l_st);
			break;
		case 61:
			var l_l_x=l__g.h_x;
			var l_l_i=l__g.h_i;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_i,l_st)||l_c(l_l_v,l_st);
			break;
		case 62:
			var l_l_x=l__g.h_x;
			var l_l_i=l__g.h_i;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_i,l_st)||l_c(l_l_v,l_st);
			break;
		case 63:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_id,l_st);
			break;
		case 64:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_id,l_st)||l_c(l_l_v,l_st);
			break;
		case 65:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_id,l_st)||l_c(l_l_v,l_st);
			break;
		case 66:
			var l_l_x=l__g.h_x;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_i1,l_st)||l_c(l_l_i2,l_st);
			break;
		case 67:
			var l_l_x=l__g.h_x;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_i1,l_st)||l_c(l_l_i2,l_st)||l_c(l_l_v,l_st);
			break;
		case 68:
			var l_l_x=l__g.h_x;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_i1,l_st)||l_c(l_l_i2,l_st)||l_c(l_l_v,l_st);
			break;
		case 69:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_id,l_st);
			break;
		case 70:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_id,l_st)||l_c(l_l_v,l_st);
			break;
		case 71:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_id,l_st)||l_c(l_l_v,l_st);
			break;
		case 72:
			var l_l_x=l__g.h_x;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_i1,l_st)||l_c(l_l_i2,l_st);
			break;
		case 73:
			var l_l_x=l__g.h_x;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_i1,l_st)||l_c(l_l_i2,l_st)||l_c(l_l_v,l_st);
			break;
		case 74:
			var l_l_x=l__g.h_x;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_i1,l_st)||l_c(l_l_i2,l_st)||l_c(l_l_v,l_st);
			break;
		case 75:
			var l_l_lx=l__g.h_lx;
			var l_l_id=l__g.h_id;
			l_r=l_c(l_l_lx,l_st)||l_c(l_l_id,l_st);
			break;
		case 76:
			var l_l_lx=l__g.h_lx;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_lx,l_st)||l_c(l_l_id,l_st)||l_c(l_l_v,l_st);
			break;
		case 77:
			var l_l_lx=l__g.h_lx;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_lx,l_st)||l_c(l_l_id,l_st)||l_c(l_l_v,l_st);
			break;
		case 78:
			var l_l_lx=l__g.h_lx;
			var l_l_id=l__g.h_id;
			l_r=l_c(l_l_lx,l_st)||l_c(l_l_id,l_st);
			break;
		case 79:
			var l_l_lx=l__g.h_lx;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_lx,l_st)||l_c(l_l_id,l_st)||l_c(l_l_v,l_st);
			break;
		case 80:
			var l_l_lx=l__g.h_lx;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_lx,l_st)||l_c(l_l_id,l_st)||l_c(l_l_v,l_st);
			break;
		case 81:
			var l_l_lx=l__g.h_lx;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			l_r=l_c(l_l_lx,l_st)||l_c(l_l_i1,l_st)||l_c(l_l_i2,l_st);
			break;
		case 82:
			var l_l_lx=l__g.h_lx;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_lx,l_st)||l_c(l_l_i1,l_st)||l_c(l_l_i2,l_st)||l_c(l_l_v,l_st);
			break;
		case 83:
			var l_l_lx=l__g.h_lx;
			var l_l_i1=l__g.h_i1;
			var l_l_i2=l__g.h_i2;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_lx,l_st)||l_c(l_l_i1,l_st)||l_c(l_l_i2,l_st)||l_c(l_l_v,l_st);
			break;
		case 84:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_id,l_st);
			break;
		case 85:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_id,l_st)||l_c(l_l_v,l_st);
			break;
		case 86:
			var l_l_x=l__g.h_x;
			var l_l_id=l__g.h_id;
			var l_l_v=l__g.h_v;
			l_r=l_c(l_l_x,l_st)||l_c(l_l_id,l_st)||l_c(l_l_v,l_st);
			break;
		case 87:
			var l_l_value=l__g.h_value;
			l_r=l_l_value!=undefined&&l_c(l_l_value,l_st);
			break;
		case 88:
			l_w=l__g.h_nodes;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(l_c(l_w[l_i],l_st))break;
			}
			l_r=l_i<l_n;
			break;
		case 89:
			var l_l_cond=l__g.h_cond;
			var l_l_then=l__g.h_then;
			var l_l_not=l__g.h_not;
			l_r=l_c(l_l_cond,l_st)||l_c(l_l_then,l_st)||l_l_not!=undefined&&l_c(l_l_not,l_st);
			break;
		case 90:
			var l_l_cond=l__g.h_cond;
			var l_l_then=l__g.h_then;
			var l_l_not=l__g.h_not;
			l_r=l_c(l_l_cond,l_st)||l_c(l_l_then,l_st)||l_c(l_l_not,l_st);
			break;
		case 92:l_r=l_c(l__g.h_time,l_st);break;
		case 93:l_r=false;break;
		case 94:
			var l_l_cond=l__g.h_cond;
			var l_l_node=l__g.h_node;
			l_r=l_c(l_l_cond,l_st)||l_c(l_l_node,l_st);
			break;
		case 95:
			var l_l_node=l__g.h_node;
			var l_l_cond=l__g.h_cond;
			l_r=l_c(l_l_node,l_st)||l_c(l_l_cond,l_st);
			break;
		case 96:
			var l_l_node=l__g.h_node;
			var l_l_cond=l__g.h_cond;
			l_r=l_c(l_l_node,l_st)||l_c(l_l_cond,l_st);
			break;
		case 97:
			var l_l_times=l__g.h_times;
			var l_l_node=l__g.h_node;
			l_r=l_c(l_l_times,l_st)||l_c(l_l_node,l_st);
			break;
		case 98:
			var l_l_pre=l__g.h_pre;
			var l_l_cond=l__g.h_cond;
			var l_l_post=l__g.h_post;
			var l_l_loop=l__g.h_loop;
			l_r=l_c(l_l_pre,l_st)||l_c(l_l_cond,l_st)||l_c(l_l_post,l_st)||l_c(l_l_loop,l_st);
			break;
		case 99:
			var l_l_ctx=l__g.h_ctx;
			var l_l_node=l__g.h_node;
			l_r=l_c(l_l_ctx,l_st)||l_c(l_l_node,l_st);
			break;
		case 100:l_r=l_c(l__g.h_node,l_st);break;
		case 101:l_r=l_c(l__g.h_v,l_st);break;
		case 102:l_r=false;break;
		case 103:l_r=false;break;
		case 104:l_r=false;break;
		case 105:l_r=false;break;
		case 106:
			var l_l_node=l__g.h_node;
			var l_l_cat=l__g.h_cat;
			l_r=l_c(l_l_node,l_st)||l_c(l_l_cat,l_st);
			break;
		case 107:l_r=l_c(l__g.h_x,l_st);break;
		case 17:l_r=false;break;
		case 91:
			var l_x=l__g.h_expr;
			var l_m=l__g.h_list;
			var l_o=l__g.h_def;
			if(l_c(l_x,l_st)){
				l_r=true;
			} else {
				l_n=array_length(l_m);
				for(l_i=0;l_i<l_n;l_i++){
					l_w=l_m[l_i].values;
					l_l=array_length(l_w);
					for(l_k=0;l_k<l_l;l_k++){
						if(l_c(l_w[l_k],l_st))break;
					}
					if(l_k<l_l||l_c(l_m[l_i].expr,l_st))break;
				}
				if(l_i<l_n)l_r=true; else l_r=l_o!=undefined&&l_c(l_o,l_st);
			}
			break;
	}
	if(l_st!=undefined)ds_list_delete(l_st,0);
	return l_r;
}
