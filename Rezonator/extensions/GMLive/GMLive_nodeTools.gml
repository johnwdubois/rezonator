#define gml_node_unpack
var l_q = argument[0];
if (live_enabled) {
	while(l_q!=undefined){
		var l__g=l_q;
		if(l__g[0]==89){
			var l__g2=l__g[2];
			if(array_length_1d(l__g2)==1)l_q=l__g2[0]; else return l_q;
		} else return l_q;
	}
	return l_q;
} else return undefined;

#define gml_node_is_simple
if (live_enabled) {
	var l_i,l_n,l_w;
	var l__g = argument[0];
	switch(l__g[0]){
		case 1:return true;
		case 2:return true;
		case 0:return true;
		case 32:return true;
		case 35:return true;
		case 4:
			l_w=l__g[2];
			l_n=array_length_1d(l_w);
			l_i=0;
			while(l_i<l_n){
				if(gml_node_is_simple(l_w[l_i]))++l_i; else break;
			}
			return l_i>=l_n;
		case 5:
			l_w=l__g[3];
			l_n=array_length_1d(l_w);
			l_i=0;
			while(l_i<l_n){
				if(gml_node_is_simple(l_w[l_i]))++l_i; else break;
			}
			return l_i>=l_n;
		case 8:return true;
		case 9:return true;
		case 38:return gml_node_is_simple(l__g[2]);
		case 53:return gml_node_is_simple(l__g[2])&&gml_node_is_simple(l__g[3]);
		default:return false;
	}
} else return false;

#define gml_node_is_statement
var l_q = argument[0];
if (live_enabled) {
	switch(l_q[0]){
		case 17:return true;
		case 28:return true;
		case 88:return true;
		case 24:return true;
		case 25:return true;
		default:return false;
	}
} else return false;

#define gml_node_is_in_block
var l_q = argument[0], l_p = argument[1];
if (live_enabled) {
	if(l_p==undefined)return false;
	var l__g=l_p;
	switch(l__g[0]){
		case 89:return true;
		case 90:return l_q!=l__g[2];
		case 95:return l_q!=l__g[2];
		case 97:return l_q!=l__g[3];
		case 96:return l_q!=l__g[3];
		case 98:return l_q!=l__g[2];
		case 99:return l_q!=l__g[3];
		case 92:return l_q!=l__g[2];
		default:return false;
	}
} else return false;

#define gml_node_equals_list
var l_a = argument[0], l_b = argument[1];
if (live_enabled) {
	var l_n=array_length_1d(l_a);
	if(array_length_1d(l_b)!=l_n)return false;
	var l_i=0;
	while(l_i<l_n){
		if(gml_node_equals(l_a[l_i],l_b[l_i]))++l_i; else return false;
	}
	return true;
} else return false;

#define gml_node_equals
var l_a = argument[0], l_b = argument[1];
if (live_enabled) {
	if(l_a[0]!=l_b[0])return false;
	var l_i,l_n;
	var l__g=l_a;
	switch(l__g[0]){
		case 8:return true;
		case 10:return true;
		case 9:return true;
		case 105:return true;
		case 0:return true;
		case 94:return true;
		case 104:return true;
		case 16:return true;
		case 103:return true;
		case 106:return true;
		case 3:
			var l__g3=l_b;
			if(l__g3[0]==3){
				var l_b_ctr=l__g3[3];
				return l__g[2]==l__g3[2]&&l__g[3]==l_b_ctr;
			} else return false;
		case 11:
			var l__g8=l_b;
			if(l__g8[0]==11)return l__g[2]==l__g8[2]; else return false;
		case 95:
			var l__g209=l_b;
			if(l__g209[0]==95){
				var l_b_node=l__g209[3];
				return gml_node_equals(l__g[2],l__g209[2])&&gml_node_equals(l__g[3],l_b_node);
			} else return false;
		case 31:
			var l__g39=l_b;
			if(l__g39[0]==31){
				var l_b_not=l__g39[4];
				var l_b_val=l__g39[3];
				return gml_node_equals(l__g[2],l__g39[2])&&gml_node_equals(l__g[3],l_b_val)&&l__g[4]==l_b_not;
			} else return false;
		case 2:
			var l__g2=l_b;
			if(l__g2[0]==2)return l__g[2]==l__g2[2]; else return false;
		case 25:
			var l__g30=l_b;
			if(l__g30[0]==25){
				var l_b_inc1=l__g30[3];
				return gml_node_equals(l__g[2],l__g30[2])&&l__g[3]==l_b_inc1;
			} else return false;
		case 22:
			var l__g27=l_b;
			if(l__g27[0]==22){
				var l_b_args5=l__g27[3];
				return l__g[2]==l__g27[2]&&gml_node_equals_list(l__g[3],l_b_args5);
			} else return false;
		case 7:
			var l__g7=l_b;
			if(l__g7[0]==7)return l__g[2]==l__g7[2]; else return false;
		case 67:
			var l__g82=l_b;
			if(l__g82[0]==67){
				var l_b_inc7=l__g82[4];
				var l_b_i8=l__g82[3];
				return gml_node_equals(l__g[2],l__g82[2])&&gml_node_equals(l__g[3],l_b_i8)&&l__g[4]==l_b_inc7;
			} else return false;
		case 23:
			var l__g28=l_b;
			if(l__g28[0]==23){
				var l_b_args6=l__g28[4];
				var l_b_s1=l__g28[3];
				return gml_node_equals(l__g[2],l__g28[2])&&l__g[3]==l_b_s1&&gml_node_equals_list(l__g[4],l_b_args6);
			} else return false;
		case 24:
			var l__g29=l_b;
			if(l__g29[0]==24){
				var l_b_inc=l__g29[3];
				return gml_node_equals(l__g[2],l__g29[2])&&l__g[3]==l_b_inc;
			} else return false;
		case 76:
			var l__g96=l_b;
			if(l__g96[0]==76){
				var l_b_inc10=l__g96[4];
				var l_b_i17=l__g96[3];
				return gml_node_equals(l__g[2],l__g96[2])&&gml_node_equals(l__g[3],l_b_i17)&&l__g[4]==l_b_inc10;
			} else return false;
		case 26:
			var l__g33=l_b;
			if(l__g33[0]==26){
				var l_b_o=l__g33[3];
				return gml_node_equals(l__g[2],l__g33[2])&&l__g[3]==l_b_o;
			} else return false;
		case 27:
			var l__g34=l_b;
			if(l__g34[0]==27){
				var l_b_b=l__g34[4];
				var l_b_a=l__g34[3];
				return l__g[2]==l__g34[2]&&gml_node_equals(l__g[3],l_b_a)&&gml_node_equals(l__g[4],l_b_b);
			} else return false;
		case 28:
			var l__g35=l_b;
			if(l__g35[0]==28){
				var l_b_b1=l__g35[4];
				var l_b_a1=l__g35[3];
				return l__g[2]==l__g35[2]&&gml_node_equals(l__g[3],l_b_a1)&&gml_node_equals(l__g[4],l_b_b1);
			} else return false;
		case 29:
			var l__g36=l_b;
			if(l__g36[0]==29)return gml_node_equals(l__g[2],l__g36[2]); else return false;
		case 91:
			var l__g204=l_b;
			if(l__g204[0]==91){
				var l_b_not2=l__g204[4];
				var l_b_then1=l__g204[3];
				return gml_node_equals(l__g[2],l__g204[2])&&gml_node_equals(l__g[3],l_b_then1)&&gml_node_equals(l__g[4],l_b_not2);
			} else return false;
		case 96:
			var l__g210=l_b;
			if(l__g210[0]==96){
				var l_b_cond3=l__g210[3];
				return gml_node_equals(l__g[2],l__g210[2])&&gml_node_equals(l__g[3],l_b_cond3);
			} else return false;
		case 32:
			var l__g40=l_b;
			if(l__g40[0]==32)return l__g[2]==l__g40[2]; else return false;
		case 33:
			var l__g41=l_b;
			if(l__g41[0]==33){
				var l_b_val1=l__g41[3];
				return l__g[2]==l__g41[2]&&gml_node_equals(l__g[3],l_b_val1);
			} else return false;
		case 34:
			var l__g42=l_b;
			if(l__g42[0]==34){
				var l_b_val2=l__g42[4];
				var l_b_op=l__g42[3];
				return l__g[2]==l__g42[2]&&l__g[3]==l_b_op&&gml_node_equals(l__g[4],l_b_val2);
			} else return false;
		case 35:
			var l__g43=l_b;
			if(l__g43[0]==35)return l__g[2]==l__g43[2]; else return false;
		case 36:
			var l__g44=l_b;
			if(l__g44[0]==36){
				var l_b_val3=l__g44[3];
				return l__g[2]==l__g44[2]&&gml_node_equals(l__g[3],l_b_val3);
			} else return false;
		case 37:
			var l__g45=l_b;
			if(l__g45[0]==37){
				var l_b_val4=l__g45[4];
				var l_b_op1=l__g45[3];
				return l__g[2]==l__g45[2]&&l__g[3]==l_b_op1&&gml_node_equals(l__g[4],l_b_val4);
			} else return false;
		case 38:
			var l__g46=l_b;
			if(l__g46[0]==38){
				var l_b_fd1=l__g46[3];
				return gml_node_equals(l__g[2],l__g46[2])&&l__g[3]==l_b_fd1;
			} else return false;
		case 39:
			var l__g47=l_b;
			if(l__g47[0]==39){
				var l_b_val5=l__g47[4];
				var l_b_fd2=l__g47[3];
				return gml_node_equals(l__g[2],l__g47[2])&&l__g[3]==l_b_fd2&&gml_node_equals(l__g[4],l_b_val5);
			} else return false;
		case 21:
			var l__g26=l_b;
			if(l__g26[0]==21){
				var l_b_args4=l__g26[4];
				var l_b_prop=l__g26[3];
				return gml_node_equals(l__g[2],l__g26[2])&&l__g[3]==l_b_prop&&gml_node_equals_list(l__g[4],l_b_args4);
			} else return false;
		case 20:
			var l__g25=l_b;
			if(l__g25[0]==20){
				var l_b_args3=l__g25[3];
				return gml_node_equals(l__g[2],l__g25[2])&&gml_node_equals_list(l__g[3],l_b_args3);
			} else return false;
		case 19:
			var l__g24=l_b;
			if(l__g24[0]==19){
				var l_b_args2=l__g24[4];
				var l_b_script=l__g24[3];
				return gml_node_equals(l__g[2],l__g24[2])&&l__g[3]==l_b_script&&gml_node_equals_list(l__g[4],l_b_args2);
			} else return false;
		case 6:
			var l__g6=l_b;
			if(l__g6[0]==6)return gml_node_equals(l__g[2],l__g6[2]); else return false;
		case 18:
			var l__g23=l_b;
			if(l__g23[0]==18){
				var l_b_args1=l__g23[3];
				return l__g[2]==l__g23[2]&&gml_node_equals_list(l__g[3],l_b_args1);
			} else return false;
		case 17:
			var l__g22=l_b;
			if(l__g22[0]==17){
				var l_b_args=l__g22[3];
				return gml_node_equals(l__g[2],l__g22[2])&&gml_node_equals_list(l__g[3],l_b_args);
			} else return false;
		case 49:
			var l__g57=l_b;
			if(l__g57[0]==49){
				var l_b_val10=l__g57[5];
				var l_b_op5=l__g57[4];
				var l_b_k2=l__g57[3];
				return l__g[2]==l__g57[2]&&gml_node_equals(l__g[3],l_b_k2)&&l__g[4]==l_b_op5&&gml_node_equals(l__g[5],l_b_val10);
			} else return false;
		case 1:
			var l__g1=l_b;
			if(l__g1[0]==1){
				var l_b_src=l__g1[3];
				return l__g[2]==l__g1[2]&&l__g[3]==l_b_src;
			} else return false;
		case 48:
			var l__g56=l_b;
			if(l__g56[0]==48){
				var l_b_val9=l__g56[4];
				var l_b_k1=l__g56[3];
				return l__g[2]==l__g56[2]&&gml_node_equals(l__g[3],l_b_k1)&&gml_node_equals(l__g[4],l_b_val9);
			} else return false;
		case 50:
			var l__g58=l_b;
			if(l__g58[0]==50){
				var l_b_i=l__g58[3];
				return gml_node_equals(l__g[2],l__g58[2])&&gml_node_equals(l__g[3],l_b_i);
			} else return false;
		case 51:
			var l__g59=l_b;
			if(l__g59[0]==51){
				var l_b_v4=l__g59[4];
				var l_b_i1=l__g59[3];
				return gml_node_equals(l__g[2],l__g59[2])&&gml_node_equals(l__g[3],l_b_i1)&&gml_node_equals(l__g[4],l_b_v4);
			} else return false;
		case 52:
			var l__g60=l_b;
			if(l__g60[0]==52){
				var l_b_v5=l__g60[5];
				var l_b_op6=l__g60[4];
				var l_b_i2=l__g60[3];
				return gml_node_equals(l__g[2],l__g60[2])&&gml_node_equals(l__g[3],l_b_i2)&&l__g[4]==l_b_op6&&gml_node_equals(l__g[5],l_b_v5);
			} else return false;
		case 53:
			var l__g62=l_b;
			if(l__g62[0]==53){
				var l_b_id16=l__g62[3];
				return gml_node_equals(l__g[2],l__g62[2])&&gml_node_equals(l__g[3],l_b_id16);
			} else return false;
		case 54:
			var l__g63=l_b;
			if(l__g63[0]==54){
				var l_b_v6=l__g63[4];
				var l_b_id17=l__g63[3];
				return gml_node_equals(l__g[2],l__g63[2])&&gml_node_equals(l__g[3],l_b_id17)&&gml_node_equals(l__g[4],l_b_v6);
			} else return false;
		case 55:
			var l__g64=l_b;
			if(l__g64[0]==55){
				var l_b_v7=l__g64[5];
				var l_b_o3=l__g64[4];
				var l_b_id18=l__g64[3];
				return gml_node_equals(l__g[2],l__g64[2])&&gml_node_equals(l__g[3],l_b_id18)&&l__g[4]==l_b_o3&&gml_node_equals(l__g[5],l_b_v7);
			} else return false;
		case 56:
			var l__g66=l_b;
			if(l__g66[0]==56){
				var l_b_inc2=l__g66[4];
				var l_b_i3=l__g66[3];
				return gml_node_equals(l__g[2],l__g66[2])&&gml_node_equals(l__g[3],l_b_i3)&&l__g[4]==l_b_inc2;
			} else return false;
		case 57:
			var l__g67=l_b;
			if(l__g67[0]==57){
				var l_b_inc3=l__g67[4];
				var l_b_i4=l__g67[3];
				return gml_node_equals(l__g[2],l__g67[2])&&gml_node_equals(l__g[3],l_b_i4)&&l__g[4]==l_b_inc3;
			} else return false;
		case 58:
			var l__g69=l_b;
			if(l__g69[0]==58){
				var l_b_i21=l__g69[4];
				var l_b_i11=l__g69[3];
				return gml_node_equals(l__g[2],l__g69[2])&&gml_node_equals(l__g[3],l_b_i11)&&gml_node_equals(l__g[4],l_b_i21);
			} else return false;
		case 59:
			var l__g70=l_b;
			if(l__g70[0]==59){
				var l_b_v8=l__g70[5];
				var l_b_i22=l__g70[4];
				var l_b_i12=l__g70[3];
				return gml_node_equals(l__g[2],l__g70[2])&&gml_node_equals(l__g[3],l_b_i12)&&gml_node_equals(l__g[4],l_b_i22)&&gml_node_equals(l__g[5],l_b_v8);
			} else return false;
		case 60:
			var l__g73=l_b;
			if(l__g73[0]==60){
				var l_b_v9=l__g73[6];
				var l_b_o4=l__g73[5];
				var l_b_i23=l__g73[4];
				var l_b_i13=l__g73[3];
				return gml_node_equals(l__g[2],l__g73[2])&&gml_node_equals(l__g[3],l_b_i13)&&gml_node_equals(l__g[4],l_b_i23)&&l__g[5]==l_b_o4&&gml_node_equals(l__g[6],l_b_v9);
			} else return false;
		case 61:
			var l__g74=l_b;
			if(l__g74[0]==61){
				var l_b_inc4=l__g74[5];
				var l_b_k3=l__g74[4];
				var l_b_i5=l__g74[3];
				return gml_node_equals(l__g[2],l__g74[2])&&gml_node_equals(l__g[3],l_b_i5)&&gml_node_equals(l__g[4],l_b_k3)&&l__g[5]==l_b_inc4;
			} else return false;
		case 62:
			var l__g75=l_b;
			if(l__g75[0]==62){
				var l_b_inc5=l__g75[5];
				var l_b_k4=l__g75[4];
				var l_b_i6=l__g75[3];
				return gml_node_equals(l__g[2],l__g75[2])&&gml_node_equals(l__g[3],l_b_i6)&&gml_node_equals(l__g[4],l_b_k4)&&l__g[5]==l_b_inc5;
			} else return false;
		case 63:
			var l__g76=l_b;
			if(l__g76[0]==63){
				var l_b_id19=l__g76[3];
				return gml_node_equals(l__g[2],l__g76[2])&&gml_node_equals(l__g[3],l_b_id19);
			} else return false;
		case 64:
			var l__g78=l_b;
			if(l__g78[0]==64){
				var l_b_v10=l__g78[4];
				var l_b_id20=l__g78[3];
				return gml_node_equals(l__g[2],l__g78[2])&&gml_node_equals(l__g[3],l_b_id20)&&gml_node_equals(l__g[4],l_b_v10);
			} else return false;
		case 65:
			var l__g80=l_b;
			if(l__g80[0]==65){
				var l_b_v11=l__g80[5];
				var l_b_o5=l__g80[4];
				var l_b_id21=l__g80[3];
				return gml_node_equals(l__g[2],l__g80[2])&&gml_node_equals(l__g[3],l_b_id21)&&l__g[4]==l_b_o5&&gml_node_equals(l__g[5],l_b_v11);
			} else return false;
		case 66:
			var l__g81=l_b;
			if(l__g81[0]==66){
				var l_b_inc6=l__g81[4];
				var l_b_i7=l__g81[3];
				return gml_node_equals(l__g[2],l__g81[2])&&gml_node_equals(l__g[3],l_b_i7)&&l__g[4]==l_b_inc6;
			} else return false;
		case 47:
			var l__g55=l_b;
			if(l__g55[0]==47){
				var l_b_k=l__g55[3];
				return l__g[2]==l__g55[2]&&gml_node_equals(l__g[3],l_b_k);
			} else return false;
		case 68:
			var l__g84=l_b;
			if(l__g84[0]==68){
				var l_b_i24=l__g84[4];
				var l_b_i14=l__g84[3];
				return gml_node_equals(l__g[2],l__g84[2])&&gml_node_equals(l__g[3],l_b_i14)&&gml_node_equals(l__g[4],l_b_i24);
			} else return false;
		case 69:
			var l__g87=l_b;
			if(l__g87[0]==69){
				var l_b_v12=l__g87[5];
				var l_b_i25=l__g87[4];
				var l_b_i15=l__g87[3];
				return gml_node_equals(l__g[2],l__g87[2])&&gml_node_equals(l__g[3],l_b_i15)&&gml_node_equals(l__g[4],l_b_i25)&&gml_node_equals(l__g[5],l_b_v12);
			} else return false;
		case 70:
			var l__g88=l_b;
			if(l__g88[0]==70){
				var l_b_v13=l__g88[6];
				var l_b_o6=l__g88[5];
				var l_b_i26=l__g88[4];
				var l_b_i16=l__g88[3];
				return gml_node_equals(l__g[2],l__g88[2])&&gml_node_equals(l__g[3],l_b_i16)&&gml_node_equals(l__g[4],l_b_i26)&&l__g[5]==l_b_o6&&gml_node_equals(l__g[6],l_b_v13);
			} else return false;
		case 71:
			var l__g90=l_b;
			if(l__g90[0]==71){
				var l_b_inc8=l__g90[5];
				var l_b_k5=l__g90[4];
				var l_b_i9=l__g90[3];
				return gml_node_equals(l__g[2],l__g90[2])&&gml_node_equals(l__g[3],l_b_i9)&&gml_node_equals(l__g[4],l_b_k5)&&l__g[5]==l_b_inc8;
			} else return false;
		case 72:
			var l__g91=l_b;
			if(l__g91[0]==72){
				var l_b_inc9=l__g91[5];
				var l_b_k6=l__g91[4];
				var l_b_i10=l__g91[3];
				return gml_node_equals(l__g[2],l__g91[2])&&gml_node_equals(l__g[3],l_b_i10)&&gml_node_equals(l__g[4],l_b_k6)&&l__g[5]==l_b_inc9;
			} else return false;
		case 73:
			var l__g92=l_b;
			if(l__g92[0]==73){
				var l_b_id22=l__g92[3];
				return gml_node_equals(l__g[2],l__g92[2])&&gml_node_equals(l__g[3],l_b_id22);
			} else return false;
		case 74:
			var l__g94=l_b;
			if(l__g94[0]==74){
				var l_b_v14=l__g94[4];
				var l_b_id23=l__g94[3];
				return gml_node_equals(l__g[2],l__g94[2])&&gml_node_equals(l__g[3],l_b_id23)&&gml_node_equals(l__g[4],l_b_v14);
			} else return false;
		case 75:
			var l__g95=l_b;
			if(l__g95[0]==75){
				var l_b_v15=l__g95[5];
				var l_b_o7=l__g95[4];
				var l_b_id24=l__g95[3];
				return gml_node_equals(l__g[2],l__g95[2])&&gml_node_equals(l__g[3],l_b_id24)&&l__g[4]==l_b_o7&&gml_node_equals(l__g[5],l_b_v15);
			} else return false;
		case 46:
			var l__g54=l_b;
			if(l__g54[0]==46){
				var l_b_v3=l__g54[5];
				var l_b_op4=l__g54[4];
				var l_b_fd6=l__g54[3];
				return gml_node_equals(l__g[2],l__g54[2])&&l__g[3]==l_b_fd6&&l__g[4]==l_b_op4&&gml_node_equals(l__g[5],l_b_v3);
			} else return false;
		case 15:
			var l__g21=l_b;
			if(l__g21[0]==15)return gml_node_equals(l__g[2],l__g21[2]); else return false;
		case 77:
			var l__g98=l_b;
			if(l__g98[0]==77){
				var l_b_inc11=l__g98[4];
				var l_b_i18=l__g98[3];
				return gml_node_equals(l__g[2],l__g98[2])&&gml_node_equals(l__g[3],l_b_i18)&&l__g[4]==l_b_inc11;
			} else return false;
		case 78:
			var l__g99=l_b;
			if(l__g99[0]==78){
				var l_b_id25=l__g99[3];
				return gml_node_equals(l__g[2],l__g99[2])&&gml_node_equals(l__g[3],l_b_id25);
			} else return false;
		case 79:
			var l__g100=l_b;
			if(l__g100[0]==79){
				var l_b_v16=l__g100[4];
				var l_b_id26=l__g100[3];
				return gml_node_equals(l__g[2],l__g100[2])&&gml_node_equals(l__g[3],l_b_id26)&&gml_node_equals(l__g[4],l_b_v16);
			} else return false;
		case 80:
			var l__g102=l_b;
			if(l__g102[0]==80){
				var l_b_v17=l__g102[5];
				var l_b_o8=l__g102[4];
				var l_b_id27=l__g102[3];
				return gml_node_equals(l__g[2],l__g102[2])&&gml_node_equals(l__g[3],l_b_id27)&&l__g[4]==l_b_o8&&gml_node_equals(l__g[5],l_b_v17);
			} else return false;
		case 81:
			var l__g103=l_b;
			if(l__g103[0]==81){
				var l_b_inc12=l__g103[4];
				var l_b_i19=l__g103[3];
				return gml_node_equals(l__g[2],l__g103[2])&&gml_node_equals(l__g[3],l_b_i19)&&l__g[4]==l_b_inc12;
			} else return false;
		case 82:
			var l__g104=l_b;
			if(l__g104[0]==82){
				var l_b_inc13=l__g104[4];
				var l_b_i20=l__g104[3];
				return gml_node_equals(l__g[2],l__g104[2])&&gml_node_equals(l__g[3],l_b_i20)&&l__g[4]==l_b_inc13;
			} else return false;
		case 83:
			var l__g106=l_b;
			if(l__g106[0]==83){
				var l_b_i27=l__g106[4];
				var l_b_i110=l__g106[3];
				return gml_node_equals(l__g[2],l__g106[2])&&gml_node_equals(l__g[3],l_b_i110)&&gml_node_equals(l__g[4],l_b_i27);
			} else return false;
		case 84:
			var l__g107=l_b;
			if(l__g107[0]==84){
				var l_b_v18=l__g107[5];
				var l_b_i28=l__g107[4];
				var l_b_i111=l__g107[3];
				return gml_node_equals(l__g[2],l__g107[2])&&gml_node_equals(l__g[3],l_b_i111)&&gml_node_equals(l__g[4],l_b_i28)&&gml_node_equals(l__g[5],l_b_v18);
			} else return false;
		case 85:
			var l__g108=l_b;
			if(l__g108[0]==85){
				var l_b_v19=l__g108[6];
				var l_b_o9=l__g108[5];
				var l_b_i29=l__g108[4];
				var l_b_i112=l__g108[3];
				return gml_node_equals(l__g[2],l__g108[2])&&gml_node_equals(l__g[3],l_b_i112)&&gml_node_equals(l__g[4],l_b_i29)&&l__g[5]==l_b_o9&&gml_node_equals(l__g[6],l_b_v19);
			} else return false;
		case 86:
			var l__g109=l_b;
			if(l__g109[0]==86){
				var l_b_inc14=l__g109[5];
				var l_b_k7=l__g109[4];
				var l_b_i30=l__g109[3];
				return gml_node_equals(l__g[2],l__g109[2])&&gml_node_equals(l__g[3],l_b_i30)&&gml_node_equals(l__g[4],l_b_k7)&&l__g[5]==l_b_inc14;
			} else return false;
		case 87:
			var l__g198=l_b;
			if(l__g198[0]==87){
				var l_b_inc15=l__g198[5];
				var l_b_k8=l__g198[4];
				var l_b_i31=l__g198[3];
				return gml_node_equals(l__g[2],l__g198[2])&&gml_node_equals(l__g[3],l_b_i31)&&gml_node_equals(l__g[4],l_b_k8)&&l__g[5]==l_b_inc15;
			} else return false;
		case 88:
			var l_a_value2=l__g[3];
			var l__g200=l_b;
			if(l__g200[0]==88){
				var l_b_value2=l__g200[3];
				if(l__g[2]==l__g200[2]){
					if(l_a_value2!=undefined)return l_b_value2!=undefined&&gml_node_equals(l_a_value2,l_b_value2); else return l_b_value2==undefined;
				} else return false;
			} else return false;
		case 89:
			var l__g201=l_b;
			if(l__g201[0]==89)return gml_node_equals_list(l__g[2],l__g201[2]); else return false;
		case 90:
			var l_a_not1=l__g[4];
			var l__g203=l_b;
			if(l__g203[0]==90){
				var l_b_not1=l__g203[4];
				var l_b_then=l__g203[3];
				if(gml_node_equals(l__g[2],l__g203[2])&&gml_node_equals(l__g[3],l_b_then)){
					if(l_a_not1!=undefined)return l_b_not1!=undefined&&gml_node_equals(l_a_not1,l_b_not1); else return l_b_not1==undefined;
				} else return false;
			} else return false;
		case 30:
			var l__g37=l_b;
			if(l__g37[0]==30)return gml_node_equals(l__g[2],l__g37[2]); else return false;
		case 93:
			var l__g206=l_b;
			if(l__g206[0]==93)return gml_node_equals(l__g[2],l__g206[2]); else return false;
		case 45:
			var l__g53=l_b;
			if(l__g53[0]==45){
				var l_b_v2=l__g53[4];
				var l_b_fd5=l__g53[3];
				return gml_node_equals(l__g[2],l__g53[2])&&l__g[3]==l_b_fd5&&gml_node_equals(l__g[4],l_b_v2);
			} else return false;
		case 44:
			var l__g52=l_b;
			if(l__g52[0]==44){
				var l_b_fd4=l__g52[3];
				return gml_node_equals(l__g[2],l__g52[2])&&l__g[3]==l_b_fd4;
			} else return false;
		case 112:
			var l__g225=l_b;
			if(l__g225[0]==112){
				var l_b_pl=l__g225[4];
				var l_b_x43=l__g225[3];
				return l__g[2]==l__g225[2]&&gml_node_equals(l__g[3],l_b_x43)&&l__g[4]==l_b_pl;
			} else return false;
		case 97:
			var l__g211=l_b;
			if(l__g211[0]==97){
				var l_b_cond4=l__g211[3];
				return gml_node_equals(l__g[2],l__g211[2])&&gml_node_equals(l__g[3],l_b_cond4);
			} else return false;
		case 98:
			var l__g213=l_b;
			if(l__g213[0]==98){
				var l_b_node3=l__g213[3];
				return gml_node_equals(l__g[2],l__g213[2])&&gml_node_equals(l__g[3],l_b_node3);
			} else return false;
		case 99:
			var l__g214=l_b;
			if(l__g214[0]==99){
				var l_b_loop=l__g214[5];
				var l_b_post=l__g214[4];
				var l_b_cond5=l__g214[3];
				return gml_node_equals(l__g[2],l__g214[2])&&gml_node_equals(l__g[3],l_b_cond5)&&gml_node_equals(l__g[4],l_b_post)&&gml_node_equals(l__g[5],l_b_loop);
			} else return false;
		case 100:
			var l__g215=l_b;
			if(l__g215[0]==100){
				var l_b_node4=l__g215[3];
				return gml_node_equals(l__g[2],l__g215[2])&&gml_node_equals(l__g[3],l_b_node4);
			} else return false;
		case 101:
			var l__g216=l_b;
			if(l__g216[0]==101)return gml_node_equals(l__g[2],l__g216[2]); else return false;
		case 102:
			var l__g218=l_b;
			if(l__g218[0]==102)return gml_node_equals(l__g[2],l__g218[2]); else return false;
		case 43:
			var l__g51=l_b;
			if(l__g51[0]==43){
				var l_b_val8=l__g51[4];
				var l_b_op3=l__g51[3];
				return l__g[2]==l__g51[2]&&l__g[3]==l_b_op3&&gml_node_equals(l__g[4],l_b_val8);
			} else return false;
		case 14:
			var l__g20=l_b;
			if(l__g20[0]==14)return l__g[2]==l__g20[2]; else return false;
		case 42:
			var l__g50=l_b;
			if(l__g50[0]==42){
				var l_b_val7=l__g50[3];
				return l__g[2]==l__g50[2]&&gml_node_equals(l__g[3],l_b_val7);
			} else return false;
		case 41:
			var l__g49=l_b;
			if(l__g49[0]==41)return l__g[2]==l__g49[2]; else return false;
		case 107:
			var l__g219=l_b;
			if(l__g219[0]==107)return l__g[2]==l__g219[2]; else return false;
		case 108:
			var l__g220=l_b;
			if(l__g220[0]==108){
				var l_b_x40=l__g220[3];
				return l__g[2]==l__g220[2]&&gml_node_equals(l__g[3],l_b_x40);
			} else return false;
		case 109:
			var l__g221=l_b;
			if(l__g221[0]==109){
				var l_b_s4=l__g221[3];
				return gml_node_equals(l__g[2],l__g221[2])&&l__g[3]==l_b_s4;
			} else return false;
		case 110:
			var l__g222=l_b;
			if(l__g222[0]==110){
				var l_b_x42=l__g222[3];
				return l__g[2]==l__g222[2]&&gml_node_equals(l__g[3],l_b_x42);
			} else return false;
		case 111:
			var l__g224=l_b;
			if(l__g224[0]==111)return l__g[2]==l__g224[2]; else return false;
		case 113:
			var l__g226=l_b;
			if(l__g226[0]==113){
				var l_b_pl1=l__g226[4];
				var l_b_s8=l__g226[3];
				return gml_node_equals(l__g[2],l__g226[2])&&l__g[3]==l_b_s8&&l__g[4]==l_b_pl1;
			} else return false;
		case 40:
			var l__g48=l_b;
			if(l__g48[0]==40){
				var l_b_val6=l__g48[5];
				var l_b_op2=l__g48[4];
				var l_b_fd3=l__g48[3];
				return gml_node_equals(l__g[2],l__g48[2])&&l__g[3]==l_b_fd3&&l__g[4]==l_b_op2&&gml_node_equals(l__g[5],l_b_val6);
			} else return false;
		case 13:
			var l__g10=l_b;
			if(l__g10[0]==13)return l__g[2]==l__g10[2]; else return false;
		case 4:
			var l__g4=l_b;
			if(l__g4[0]==4)return gml_node_equals_list(l__g[2],l__g4[2]); else return false;
		case 12:
			var l__g9=l_b;
			if(l__g9[0]==12)return l__g[2]==l__g9[2]; else return false;
		case 5:
			var l_m1=l__g[3];
			var l__g5=l_b;
			if(l__g5[0]==5){
				var l_m2=l__g5[3];
				var l_k2=l__g5[2];
				l_n=array_length_1d(l_m1);
				if(array_length_1d(l_m2)==l_n){
					l_i=0;
					while(l_i<l_n){
						if(gml_std_haxe_boot_wget(l__g[2],l_i)==l_k2[l_i]&&gml_node_equals(l_m1[l_i],l_m2[l_i]))++l_i; else break;
					}
					return l_i>=l_n;
				} else return false;
			} else return false;
		case 92:
			var l_o1=l__g[4];
			var l_m11=l__g[3];
			var l__g205=l_b;
			if(l__g205[0]==92){
				var l_o2=l__g205[4];
				var l_m21=l__g205[3];
				if(gml_node_equals(l__g[2],l__g205[2])&&(l_o1!=undefined&&l_o2!=undefined&&gml_node_equals(l_o1,l_o2)||l_o1==undefined&&l_o2==undefined)){
					l_n=array_length_1d(l_m11);
					if(array_length_1d(l_m21)!=l_n)return false;
					l_i=0;
					while(l_i<l_n){
						if(gml_node_equals(gml_std_haxe_boot_wget(l_m11[l_i],1),gml_std_haxe_boot_wget(l_m21[l_i],1))&&gml_node_equals_list(gml_std_haxe_boot_wget(l_m11[l_i],0),gml_std_haxe_boot_wget(l_m21[l_i],0)))++l_i; else break;
					}
					return l_i>=l_n;
				} else return false;
			} else return false;
	}
} else return false;

#define gml_node_clone_opt
var l_q = argument[0];
if (live_enabled) {
	if(l_q!=undefined)return gml_node_clone(l_q); else return undefined;
} else return undefined;

#define gml_node_clone
var l_q = argument[0];
if (live_enabled) {
	var l_xw,l_i,l_n,l_fi;
	var l_d=l_q[1];
	var l__g=l_q;
	switch(l__g[0]){
		case 0:return [0,l_d];
		case 10:return [10,l_d];
		case 5:
			l_xw=gml_std_array_hx_copy(l__g[3]);
			l_fi=array_length_1d(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_clone(l_xw[l_fi]);
			}
			var l_cop = [];
			array_copy(l_cop, 0, l__g[2], 0, array_length_1d(l__g[2]));
			return [5,l_d,l_cop,l_xw];
		case 6:return [6,l_d,gml_node_clone(l__g[2])];
		case 7:return [7,l_d,l__g[2]];
		case 8:return [8,l_d];
		case 2:return [2,l_d,l__g[2]];
		case 31:return [31,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4]];
		case 11:return [11,l_d,l__g[2]];
		case 3:return [3,l_d,l__g[2],l__g[3]];
		case 14:return [14,l_d,l__g[2]];
		case 15:return [15,l_d,gml_node_clone(l__g[2])];
		case 16:return [16,l_d];
		case 17:
			l_xw=gml_std_array_hx_copy(l__g[3]);
			l_fi=array_length_1d(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_clone(l_xw[l_fi]);
			}
			return [17,l_d,gml_node_clone(l__g[2]),l_xw];
		case 18:
			l_xw=gml_std_array_hx_copy(l__g[3]);
			l_fi=array_length_1d(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_clone(l_xw[l_fi]);
			}
			return [18,l_d,l__g[2],l_xw];
		case 19:
			l_xw=gml_std_array_hx_copy(l__g[4]);
			l_fi=array_length_1d(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_clone(l_xw[l_fi]);
			}
			return [19,l_d,gml_node_clone(l__g[2]),l__g[3],l_xw];
		case 20:
			l_xw=gml_std_array_hx_copy(l__g[3]);
			l_fi=array_length_1d(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_clone(l_xw[l_fi]);
			}
			return [20,l_d,gml_node_clone(l__g[2]),l_xw];
		case 21:
			l_xw=gml_std_array_hx_copy(l__g[4]);
			l_fi=array_length_1d(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_clone(l_xw[l_fi]);
			}
			return [21,l_d,gml_node_clone(l__g[2]),l__g[3],l_xw];
		case 22:
			l_xw=gml_std_array_hx_copy(l__g[3]);
			l_fi=array_length_1d(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_clone(l_xw[l_fi]);
			}
			return [22,l_d,l__g[2],l_xw];
		case 23:
			l_xw=gml_std_array_hx_copy(l__g[4]);
			l_fi=array_length_1d(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_clone(l_xw[l_fi]);
			}
			return [23,l_d,gml_node_clone(l__g[2]),l__g[3],l_xw];
		case 24:return [24,l_d,gml_node_clone(l__g[2]),l__g[3]];
		case 25:return [25,l_d,gml_node_clone(l__g[2]),l__g[3]];
		case 26:return [26,l_d,gml_node_clone(l__g[2]),l__g[3]];
		case 27:return [27,l_d,l__g[2],gml_node_clone(l__g[3]),gml_node_clone(l__g[4])];
		case 28:return [28,l_d,l__g[2],gml_node_clone(l__g[3]),gml_node_clone(l__g[4])];
		case 29:return [29,l_d,gml_node_clone(l__g[2])];
		case 9:return [9,l_d];
		case 94:return [94,l_d];
		case 32:return [32,l_d,l__g[2]];
		case 33:return [33,l_d,l__g[2],gml_node_clone(l__g[3])];
		case 34:return [34,l_d,l__g[2],l__g[3],gml_node_clone(l__g[4])];
		case 35:return [35,l_d,l__g[2]];
		case 36:return [36,l_d,l__g[2],gml_node_clone(l__g[3])];
		case 37:return [37,l_d,l__g[2],l__g[3],gml_node_clone(l__g[4])];
		case 38:return [38,l_d,gml_node_clone(l__g[2]),l__g[3]];
		case 39:return [39,l_d,gml_node_clone(l__g[2]),l__g[3],gml_node_clone(l__g[4])];
		case 41:return [41,l_d,l__g[2]];
		case 42:return [42,l_d,l__g[2],gml_node_clone(l__g[3])];
		case 43:return [43,l_d,l__g[2],l__g[3],gml_node_clone(l__g[4])];
		case 44:return [44,l_d,gml_node_clone(l__g[2]),l__g[3]];
		case 45:return [45,l_d,gml_node_clone(l__g[2]),l__g[3],gml_node_clone(l__g[4])];
		case 46:return [46,l_d,gml_node_clone(l__g[2]),l__g[3],l__g[4],gml_node_clone(l__g[5])];
		case 47:return [47,l_d,l__g[2],gml_node_clone(l__g[3])];
		case 48:return [48,l_d,l__g[2],gml_node_clone(l__g[3]),gml_node_clone(l__g[4])];
		case 49:return [49,l_d,l__g[2],gml_node_clone(l__g[3]),l__g[4],gml_node_clone(l__g[5])];
		case 50:return [50,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3])];
		case 51:return [51,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4])];
		case 52:return [52,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4],gml_node_clone(l__g[5])];
		case 53:return [53,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3])];
		case 54:return [54,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4])];
		case 55:return [55,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4],gml_node_clone(l__g[5])];
		case 56:return [56,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4]];
		case 57:return [57,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4]];
		case 58:return [58,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4])];
		case 59:return [59,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4]),gml_node_clone(l__g[5])];
		case 60:return [60,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4]),l__g[5],gml_node_clone(l__g[6])];
		case 61:return [61,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4]),l__g[5]];
		case 62:return [62,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4]),l__g[5]];
		case 63:return [63,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3])];
		case 64:return [64,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4])];
		case 65:return [65,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4],gml_node_clone(l__g[5])];
		case 66:return [66,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4]];
		case 67:return [67,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4]];
		case 68:return [68,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4])];
		case 69:return [69,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4]),gml_node_clone(l__g[5])];
		case 70:return [70,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4]),l__g[5],gml_node_clone(l__g[6])];
		case 71:return [71,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4]),l__g[5]];
		case 72:return [72,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4]),l__g[5]];
		case 73:return [73,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3])];
		case 74:return [74,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4])];
		case 75:return [75,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4],gml_node_clone(l__g[5])];
		case 76:return [76,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4]];
		case 77:return [77,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4]];
		case 78:return [78,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3])];
		case 79:return [79,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4])];
		case 80:return [80,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4],gml_node_clone(l__g[5])];
		case 81:return [81,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4]];
		case 82:return [82,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),l__g[4]];
		case 83:return [83,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4])];
		case 84:return [84,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4]),gml_node_clone(l__g[5])];
		case 85:return [85,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4]),l__g[5],gml_node_clone(l__g[6])];
		case 86:return [86,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4]),l__g[5]];
		case 87:return [87,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4]),l__g[5]];
		case 88:return [88,l_d,l__g[2],gml_node_clone_opt(l__g[3])];
		case 89:
			l_xw=gml_std_array_hx_copy(l__g[2]);
			l_fi=array_length_1d(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_clone(l_xw[l_fi]);
			}
			return [89,l_d,l_xw];
		case 90:return [90,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone_opt(l__g[4])];
		case 91:return [91,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4])];
		case 30:return [30,l_d,gml_node_clone(l__g[2])];
		case 93:return [93,l_d,gml_node_clone(l__g[2])];
		case 113:return [113,l_d,gml_node_clone(l__g[2]),l__g[3],l__g[4]];
		case 95:return [95,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3])];
		case 96:return [96,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3])];
		case 97:return [97,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3])];
		case 98:return [98,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3])];
		case 99:return [99,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3]),gml_node_clone(l__g[4]),gml_node_clone(l__g[5])];
		case 100:return [100,l_d,gml_node_clone(l__g[2]),gml_node_clone(l__g[3])];
		case 101:return [101,l_d,gml_node_clone(l__g[2])];
		case 102:return [102,l_d,gml_node_clone(l__g[2])];
		case 103:return [103,l_d];
		case 104:return [104,l_d];
		case 105:return [105,l_d];
		case 106:return [106,l_d];
		case 107:return [107,l_d,l__g[2]];
		case 108:return [108,l_d,l__g[2],gml_node_clone(l__g[3])];
		case 109:return [109,l_d,gml_node_clone(l__g[2]),l__g[3]];
		case 110:return [110,l_d,l__g[2],gml_node_clone(l__g[3])];
		case 111:return [111,l_d,l__g[2]];
		case 112:return [112,l_d,l__g[2],gml_node_clone(l__g[3]),l__g[4]];
		case 40:return [40,l_d,gml_node_clone(l__g[2]),l__g[3],l__g[4],gml_node_clone(l__g[5])];
		case 13:return [13,l_d,l__g[2]];
		case 4:
			l_xw=gml_std_array_hx_copy(l__g[2]);
			l_fi=array_length_1d(l_xw);
			while(--l_fi>=0){
				l_xw[@l_fi]=gml_node_clone(l_xw[l_fi]);
			}
			return [4,l_d,l_xw];
		case 1:return [1,l_d,l__g[2],l__g[3]];
		case 12:return [12,l__g[1],l__g[2],l__g[3]];
		case 92:
			var l_m=l__g[3];
			l_m=gml_std_array_hx_copy(l_m);
			l_n=array_length_1d(l_m);
			for(l_i=0;l_i<l_n;++l_i){
				var l_cc=l_m[l_i];
				l_xw=gml_std_array_hx_copy(l_cc[0]);
				l_fi=array_length_1d(l_xw);
				while(--l_fi>=0){
					l_xw[@l_fi]=gml_node_clone(l_xw[l_fi]);
				}
				l_cc=array_create(3);
				l_cc[1,0] = "GmlNodeCase";
				l_cc[0]=l_xw;
				l_cc[1]=gml_node_clone(l_cc[1]);
				l_cc[2]=l_cc[2];
				l_m[@l_i]=l_cc;
				l_xw=gml_std_array_hx_copy(l_cc[2]);
				l_fi=array_length_1d(l_xw);
				while(--l_fi>=0){
					l_xw[@l_fi]=gml_node_clone(l_xw[l_fi]);
				}
				l_cc[@2]=l_xw;
			}
			return [92,l__g[1],gml_node_clone(l__g[2]),l_m,gml_node_clone_opt(l__g[4])];
	}
} else return undefined;

#define gml_node_seek_all_out
var l_q = argument[0], l_st = argument[1], l_c = argument[2], l_si = argument[3];
if (live_enabled) {
	var l_x,l_w,l_i,l_n;
	var l_par=l_st[|l_si];
	if(l_par==undefined)return false;
	var l__g=l_par;
	switch(l__g[0]){
		case 89:
			l_w=l__g[2];
			l_i=array_length_1d(l_w);
			while(--l_i>=0){
				if(l_w[l_i]==l_q)break;
			}
			while(--l_i>=0){
				if(script_execute(l_c,l_w[l_i],undefined))return true;
			}
			break;
		case 90:
			var l_c1=l__g[2];
			if(l_c1!=l_q&&script_execute(l_c,l_c1,undefined))return true;
			break;
		case 95:
			var l_c3=l__g[2];
			if(l_c3!=l_q&&script_execute(l_c,l_c3,undefined))return true;
			break;
		case 97:
			var l_c5=l__g[2];
			if(l_c5!=l_q&&script_execute(l_c,l_c5,undefined))return true;
			break;
		case 96:
			var l_c4=l__g[2];
			if(l_c4!=l_q&&script_execute(l_c,l_c4,undefined))return true;
			break;
		case 98:
			var l_c6=l__g[2];
			if(l_c6!=l_q&&script_execute(l_c,l_c6,undefined))return true;
			break;
		case 99:
			var l_c7=l__g[2];
			if(l_c7!=l_q&&script_execute(l_c,l_c7,undefined))return true;
			break;
		case 92:
			var l_c2=l__g[2];
			if(l_c2!=l_q&&script_execute(l_c,l_c2,undefined))return true;
			break;
		case 100:
			var l_c8=l__g[2];
			if(l_c8!=l_q&&script_execute(l_c,l_c8,undefined))return true;
			break;
		case 109:break;
		case 108:break;
		case 110:break;
		case 112:break;
		case 113:break;
		default:show_error("Can't seekAllOut over "+gml_pos_to_string(l_par[1])+" "+g_gml_node_names[l_par[0]],false);
	}
	return gml_node_seek_all_out(l_par,l_st,l_c,l_si+1);
} else return false;

#define gml_node_seek_all
var l_q = argument[0], l_st = argument[1], l_c = argument[2];
if (live_enabled) {
	if(l_st!=undefined)ds_list_insert(l_st,0,l_q);
	var l_r,l_x,l_w,l_i,l_n;
	var l__g=l_q;
	switch(l__g[0]){
		case 6:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 109:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 15:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 93:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 30:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 33:l_r=script_execute(l_c,l__g[3],undefined);break;
		case 102:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 101:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 25:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 24:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 43:l_r=script_execute(l_c,l__g[4],undefined);break;
		case 42:l_r=script_execute(l_c,l__g[3],undefined);break;
		case 108:l_r=script_execute(l_c,l__g[3],undefined);break;
		case 37:l_r=script_execute(l_c,l__g[4],undefined);break;
		case 110:l_r=script_execute(l_c,l__g[3],undefined);break;
		case 29:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 36:l_r=script_execute(l_c,l__g[3],undefined);break;
		case 112:l_r=script_execute(l_c,l__g[3],undefined);break;
		case 113:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 34:l_r=script_execute(l_c,l__g[4],undefined);break;
		case 3:l_r=false;break;
		case 11:l_r=false;break;
		case 10:l_r=false;break;
		case 94:l_r=false;break;
		case 2:l_r=false;break;
		case 0:l_r=false;break;
		case 104:l_r=false;break;
		case 106:l_r=false;break;
		case 7:l_r=false;break;
		case 107:l_r=false;break;
		case 8:l_r=false;break;
		case 103:l_r=false;break;
		case 35:l_r=false;break;
		case 111:l_r=false;break;
		case 105:l_r=false;break;
		case 16:l_r=false;break;
		case 12:l_r=false;break;
		case 9:l_r=false;break;
		case 1:l_r=false;break;
		case 14:l_r=false;break;
		case 41:l_r=false;break;
		case 32:l_r=false;break;
		case 13:l_r=false;break;
		case 27:
			switch(l__g[2]){
				case 80:
					var l_b=l__g[4];
					l_r=script_execute(l_c,l__g[3],undefined)&&script_execute(l_c,l_b,undefined);
					break;
				case 96:l_r=script_execute(l_c,l__g[3],undefined);break;
				default:
					var l_l_b=l__g[4];
					l_r=script_execute(l_c,l__g[3],undefined)||script_execute(l_c,l_l_b,undefined);
			}
			break;
		case 5:
			l_w=l__g[3];
			l_n=array_length_1d(l_w);
			for(l_i=0;l_i<l_n;++l_i){
				if(script_execute(l_c,l_w[l_i],undefined))break;
			}
			l_r=l_i<l_n;
			break;
		case 4:
			l_w=l__g[2];
			l_n=array_length_1d(l_w);
			for(l_i=0;l_i<l_n;++l_i){
				if(script_execute(l_c,l_w[l_i],undefined))break;
			}
			l_r=l_i<l_n;
			break;
		case 88:
			var l_v=l__g[3];
			l_r=l_v!=undefined&&script_execute(l_c,l_v,undefined);
			break;
		case 26:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 89:
			l_w=l__g[2];
			l_n=array_length_1d(l_w);
			for(l_i=0;l_i<l_n;++l_i){
				if(script_execute(l_c,l_w[l_i],undefined))break;
			}
			l_r=l_i<l_n;
			break;
		case 20:
			var l_m3=l__g[3];
			if(script_execute(l_c,l__g[2],undefined)){
				l_r=true;
			} else {
				l_w=l_m3;
				l_n=array_length_1d(l_w);
				for(l_i=0;l_i<l_n;++l_i){
					if(script_execute(l_c,l_w[l_i],undefined))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 17:
			var l_m=l__g[3];
			if(script_execute(l_c,l__g[2],undefined)){
				l_r=true;
			} else {
				l_w=l_m;
				l_n=array_length_1d(l_w);
				for(l_i=0;l_i<l_n;++l_i){
					if(script_execute(l_c,l_w[l_i],undefined))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 21:
			var l_m4=l__g[4];
			if(script_execute(l_c,l__g[2],undefined)){
				l_r=true;
			} else {
				l_w=l_m4;
				l_n=array_length_1d(l_w);
				for(l_i=0;l_i<l_n;++l_i){
					if(script_execute(l_c,l_w[l_i],undefined))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 19:
			var l_m2=l__g[4];
			if(script_execute(l_c,l__g[2],undefined)){
				l_r=true;
			} else {
				l_w=l_m2;
				l_n=array_length_1d(l_w);
				for(l_i=0;l_i<l_n;++l_i){
					if(script_execute(l_c,l_w[l_i],undefined))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 23:
			var l_m6=l__g[4];
			if(script_execute(l_c,l__g[2],undefined)){
				l_r=true;
			} else {
				l_w=l_m6;
				l_n=array_length_1d(l_w);
				for(l_i=0;l_i<l_n;++l_i){
					if(script_execute(l_c,l_w[l_i],undefined))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 22:
			l_w=l__g[3];
			l_n=array_length_1d(l_w);
			for(l_i=0;l_i<l_n;++l_i){
				if(script_execute(l_c,l_w[l_i],undefined))break;
			}
			l_r=l_i<l_n;
			break;
		case 18:
			l_w=l__g[3];
			l_n=array_length_1d(l_w);
			for(l_i=0;l_i<l_n;++l_i){
				if(script_execute(l_c,l_w[l_i],undefined))break;
			}
			l_r=l_i<l_n;
			break;
		case 90:
			var l_b2=l__g[4];
			var l_a2=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||l_b2!=undefined&&script_execute(l_c,l_a2,undefined)&&script_execute(l_c,l_b2,undefined);
			break;
		case 91:
			var l_b3=l__g[4];
			var l_a3=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_a3,undefined)&&script_execute(l_c,l_b3,undefined);
			break;
		case 99:
			var l_c6=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_c6,undefined);
			break;
		case 95:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 100:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 97:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 96:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 98:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 92:
			var l__d=l__g[4];
			var l__cc=l__g[3];
			if(script_execute(l_c,l__g[2],undefined)){
				l_r=true;
			} else {
				l_x=l__d;
				if(l_x!=undefined&&script_execute(l_c,l_x,undefined)){
					l_n=array_length_1d(l__cc);
					l_i=0;
					while(l_i<l_n){
						if(script_execute(l_c,l_x,undefined))++l_i; else break;
					}
					l_r=l_i>=l_n;
				} else l_r=false;
			}
			break;
		case 28:
			var l_l_b1=l__g[4];
			l_r=script_execute(l_c,l__g[3],undefined)||script_execute(l_c,l_l_b1,undefined);
			break;
		case 31:
			var l_l_val=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_val,undefined);
			break;
		case 47:l_r=script_execute(l_c,l__g[3],undefined);break;
		case 48:
			var l_l_val3=l__g[4];
			l_r=script_execute(l_c,l__g[3],undefined)||script_execute(l_c,l_l_val3,undefined);
			break;
		case 49:
			var l_l_val4=l__g[5];
			l_r=script_execute(l_c,l__g[3],undefined)||script_execute(l_c,l_l_val4,undefined);
			break;
		case 50:
			var l_l_i=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i,undefined);
			break;
		case 51:
			var l_l_v2=l__g[4];
			var l_l_i1=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i1,undefined)||script_execute(l_c,l_l_v2,undefined);
			break;
		case 52:
			var l_l_v3=l__g[5];
			var l_l_i2=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i2,undefined)||script_execute(l_c,l_l_v3,undefined);
			break;
		case 53:
			var l_l_id3=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_id3,undefined);
			break;
		case 54:
			var l_l_v4=l__g[4];
			var l_l_id4=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_id4,undefined)||script_execute(l_c,l_l_v4,undefined);
			break;
		case 55:
			var l_l_v5=l__g[5];
			var l_l_id5=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_id5,undefined)||script_execute(l_c,l_l_v5,undefined);
			break;
		case 56:
			var l_l_i3=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i3,undefined);
			break;
		case 57:
			var l_l_i4=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i4,undefined);
			break;
		case 58:
			var l_l_i21=l__g[4];
			var l_l_i11=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i11,undefined)||script_execute(l_c,l_l_i21,undefined);
			break;
		case 59:
			var l_l_v6=l__g[5];
			var l_l_i22=l__g[4];
			var l_l_i12=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i12,undefined)||script_execute(l_c,l_l_i22,undefined)||script_execute(l_c,l_l_v6,undefined);
			break;
		case 60:
			var l_l_v7=l__g[6];
			var l_l_i23=l__g[4];
			var l_l_i13=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i13,undefined)||script_execute(l_c,l_l_i23,undefined)||script_execute(l_c,l_l_v7,undefined);
			break;
		case 61:
			var l_l_k3=l__g[4];
			var l_l_i5=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i5,undefined)||script_execute(l_c,l_l_k3,undefined);
			break;
		case 62:
			var l_l_k4=l__g[4];
			var l_l_i6=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i6,undefined)||script_execute(l_c,l_l_k4,undefined);
			break;
		case 63:
			var l_l_id6=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_id6,undefined);
			break;
		case 64:
			var l_l_v8=l__g[4];
			var l_l_id7=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_id7,undefined)||script_execute(l_c,l_l_v8,undefined);
			break;
		case 65:
			var l_l_v9=l__g[5];
			var l_l_id8=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_id8,undefined)||script_execute(l_c,l_l_v9,undefined);
			break;
		case 66:
			var l_l_i7=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i7,undefined);
			break;
		case 67:
			var l_l_i8=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i8,undefined);
			break;
		case 68:
			var l_l_i24=l__g[4];
			var l_l_i14=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i14,undefined)||script_execute(l_c,l_l_i24,undefined);
			break;
		case 69:
			var l_l_v10=l__g[5];
			var l_l_i25=l__g[4];
			var l_l_i15=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i15,undefined)||script_execute(l_c,l_l_i25,undefined)||script_execute(l_c,l_l_v10,undefined);
			break;
		case 70:
			var l_l_v11=l__g[6];
			var l_l_i26=l__g[4];
			var l_l_i16=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i16,undefined)||script_execute(l_c,l_l_i26,undefined)||script_execute(l_c,l_l_v11,undefined);
			break;
		case 71:
			var l_l_k5=l__g[4];
			var l_l_i9=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i9,undefined)||script_execute(l_c,l_l_k5,undefined);
			break;
		case 72:
			var l_l_k6=l__g[4];
			var l_l_i10=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i10,undefined)||script_execute(l_c,l_l_k6,undefined);
			break;
		case 38:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 39:
			var l_l_val1=l__g[4];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_val1,undefined);
			break;
		case 40:
			var l_l_val2=l__g[5];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_val2,undefined);
			break;
		case 44:l_r=script_execute(l_c,l__g[2],undefined);break;
		case 45:
			var l_l_v=l__g[4];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_v,undefined);
			break;
		case 46:
			var l_l_v1=l__g[5];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_v1,undefined);
			break;
		case 73:
			var l_l_id9=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_id9,undefined);
			break;
		case 74:
			var l_l_v12=l__g[4];
			var l_l_id10=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_id10,undefined)||script_execute(l_c,l_l_v12,undefined);
			break;
		case 75:
			var l_l_v13=l__g[5];
			var l_l_id11=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_id11,undefined)||script_execute(l_c,l_l_v13,undefined);
			break;
		case 76:
			var l_l_i17=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i17,undefined);
			break;
		case 77:
			var l_l_i18=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i18,undefined);
			break;
		case 78:
			var l_l_id12=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_id12,undefined);
			break;
		case 79:
			var l_l_v14=l__g[4];
			var l_l_id13=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_id13,undefined)||script_execute(l_c,l_l_v14,undefined);
			break;
		case 80:
			var l_l_v15=l__g[5];
			var l_l_id14=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_id14,undefined)||script_execute(l_c,l_l_v15,undefined);
			break;
		case 81:
			var l_l_i19=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i19,undefined);
			break;
		case 82:
			var l_l_i20=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i20,undefined);
			break;
		case 83:
			var l_l_i27=l__g[4];
			var l_l_i110=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i110,undefined)||script_execute(l_c,l_l_i27,undefined);
			break;
		case 84:
			var l_l_v16=l__g[5];
			var l_l_i28=l__g[4];
			var l_l_i111=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i111,undefined)||script_execute(l_c,l_l_i28,undefined)||script_execute(l_c,l_l_v16,undefined);
			break;
		case 85:
			var l_l_v17=l__g[6];
			var l_l_i29=l__g[4];
			var l_l_i112=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i112,undefined)||script_execute(l_c,l_l_i29,undefined)||script_execute(l_c,l_l_v17,undefined);
			break;
		case 86:
			var l_l_k7=l__g[4];
			var l_l_i30=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i30,undefined)||script_execute(l_c,l_l_k7,undefined);
			break;
		case 87:
			var l_l_k8=l__g[4];
			var l_l_i31=l__g[3];
			l_r=script_execute(l_c,l__g[2],undefined)||script_execute(l_c,l_l_i31,undefined)||script_execute(l_c,l_l_k8,undefined);
			break;
	}
	if(l_st!=undefined)ds_list_delete(l_st,0);
	return false;
} else return false;

#define gml_node_seek
var l_q = argument[0], l_st = argument[1], l_c = argument[2];
if (live_enabled) {
	if(l_st!=undefined)ds_list_insert(l_st,0,l_q);
	var l_r,l_x,l_w,l_i,l_n,l_k,l_l;
	var l__g=l_q;
	switch(l__g[0]){
		case 0:l_r=false;break;
		case 10:l_r=false;break;
		case 5:
			l_w=l__g[3];
			l_n=array_length_1d(l_w);
			for(l_i=0;l_i<l_n;++l_i){
				if(script_execute(l_c,l_w[l_i],l_st))break;
			}
			l_r=l_i<l_n;
			break;
		case 6:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 7:l_r=false;break;
		case 8:l_r=false;break;
		case 2:l_r=false;break;
		case 31:
			var l_l_val=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_val,l_st);
			break;
		case 11:l_r=false;break;
		case 3:l_r=false;break;
		case 14:l_r=false;break;
		case 15:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 16:l_r=false;break;
		case 17:
			var l_l_args=l__g[3];
			if(script_execute(l_c,l__g[2],l_st)){
				l_r=true;
			} else {
				l_w=l_l_args;
				l_n=array_length_1d(l_w);
				for(l_i=0;l_i<l_n;++l_i){
					if(script_execute(l_c,l_w[l_i],l_st))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 18:
			l_w=l__g[3];
			l_n=array_length_1d(l_w);
			for(l_i=0;l_i<l_n;++l_i){
				if(script_execute(l_c,l_w[l_i],l_st))break;
			}
			l_r=l_i<l_n;
			break;
		case 19:
			var l_l_args2=l__g[4];
			if(script_execute(l_c,l__g[2],l_st)){
				l_r=true;
			} else {
				l_w=l_l_args2;
				l_n=array_length_1d(l_w);
				for(l_i=0;l_i<l_n;++l_i){
					if(script_execute(l_c,l_w[l_i],l_st))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 20:
			var l_l_args3=l__g[3];
			if(script_execute(l_c,l__g[2],l_st)){
				l_r=true;
			} else {
				l_w=l_l_args3;
				l_n=array_length_1d(l_w);
				for(l_i=0;l_i<l_n;++l_i){
					if(script_execute(l_c,l_w[l_i],l_st))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 21:
			var l_l_args4=l__g[4];
			if(script_execute(l_c,l__g[2],l_st)){
				l_r=true;
			} else {
				l_w=l_l_args4;
				l_n=array_length_1d(l_w);
				for(l_i=0;l_i<l_n;++l_i){
					if(script_execute(l_c,l_w[l_i],l_st))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 22:
			l_w=l__g[3];
			l_n=array_length_1d(l_w);
			for(l_i=0;l_i<l_n;++l_i){
				if(script_execute(l_c,l_w[l_i],l_st))break;
			}
			l_r=l_i<l_n;
			break;
		case 23:
			var l_l_args6=l__g[4];
			if(script_execute(l_c,l__g[2],l_st)){
				l_r=true;
			} else {
				l_w=l_l_args6;
				l_n=array_length_1d(l_w);
				for(l_i=0;l_i<l_n;++l_i){
					if(script_execute(l_c,l_w[l_i],l_st))break;
				}
				l_r=l_i<l_n;
			}
			break;
		case 24:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 25:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 26:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 27:
			var l_l_b=l__g[4];
			l_r=script_execute(l_c,l__g[3],l_st)||script_execute(l_c,l_l_b,l_st);
			break;
		case 28:
			var l_l_b1=l__g[4];
			l_r=script_execute(l_c,l__g[3],l_st)||script_execute(l_c,l_l_b1,l_st);
			break;
		case 29:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 9:l_r=false;break;
		case 94:l_r=false;break;
		case 32:l_r=false;break;
		case 33:l_r=script_execute(l_c,l__g[3],l_st);break;
		case 34:l_r=script_execute(l_c,l__g[4],l_st);break;
		case 35:l_r=false;break;
		case 36:l_r=script_execute(l_c,l__g[3],l_st);break;
		case 37:l_r=script_execute(l_c,l__g[4],l_st);break;
		case 38:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 39:
			var l_l_val5=l__g[4];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_val5,l_st);
			break;
		case 41:l_r=false;break;
		case 42:l_r=script_execute(l_c,l__g[3],l_st);break;
		case 43:l_r=script_execute(l_c,l__g[4],l_st);break;
		case 44:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 45:
			var l_l_v2=l__g[4];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_v2,l_st);
			break;
		case 46:
			var l_l_v3=l__g[5];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_v3,l_st);
			break;
		case 47:l_r=script_execute(l_c,l__g[3],l_st);break;
		case 48:
			var l_l_val9=l__g[4];
			l_r=script_execute(l_c,l__g[3],l_st)||script_execute(l_c,l_l_val9,l_st);
			break;
		case 49:
			var l_l_val10=l__g[5];
			l_r=script_execute(l_c,l__g[3],l_st)||script_execute(l_c,l_l_val10,l_st);
			break;
		case 50:
			var l_l_i=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i,l_st);
			break;
		case 51:
			var l_l_v4=l__g[4];
			var l_l_i1=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i1,l_st)||script_execute(l_c,l_l_v4,l_st);
			break;
		case 52:
			var l_l_v5=l__g[5];
			var l_l_i2=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i2,l_st)||script_execute(l_c,l_l_v5,l_st);
			break;
		case 53:
			var l_l_id16=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_id16,l_st);
			break;
		case 54:
			var l_l_v6=l__g[4];
			var l_l_id17=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_id17,l_st)||script_execute(l_c,l_l_v6,l_st);
			break;
		case 55:
			var l_l_v7=l__g[5];
			var l_l_id18=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_id18,l_st)||script_execute(l_c,l_l_v7,l_st);
			break;
		case 56:
			var l_l_i3=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i3,l_st);
			break;
		case 57:
			var l_l_i4=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i4,l_st);
			break;
		case 58:
			var l_l_i21=l__g[4];
			var l_l_i11=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i11,l_st)||script_execute(l_c,l_l_i21,l_st);
			break;
		case 59:
			var l_l_v8=l__g[5];
			var l_l_i22=l__g[4];
			var l_l_i12=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i12,l_st)||script_execute(l_c,l_l_i22,l_st)||script_execute(l_c,l_l_v8,l_st);
			break;
		case 60:
			var l_l_v9=l__g[6];
			var l_l_i23=l__g[4];
			var l_l_i13=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i13,l_st)||script_execute(l_c,l_l_i23,l_st)||script_execute(l_c,l_l_v9,l_st);
			break;
		case 61:
			var l_l_k3=l__g[4];
			var l_l_i5=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i5,l_st)||script_execute(l_c,l_l_k3,l_st);
			break;
		case 62:
			var l_l_k4=l__g[4];
			var l_l_i6=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i6,l_st)||script_execute(l_c,l_l_k4,l_st);
			break;
		case 63:
			var l_l_id19=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_id19,l_st);
			break;
		case 64:
			var l_l_v10=l__g[4];
			var l_l_id20=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_id20,l_st)||script_execute(l_c,l_l_v10,l_st);
			break;
		case 65:
			var l_l_v11=l__g[5];
			var l_l_id21=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_id21,l_st)||script_execute(l_c,l_l_v11,l_st);
			break;
		case 66:
			var l_l_i7=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i7,l_st);
			break;
		case 67:
			var l_l_i8=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i8,l_st);
			break;
		case 68:
			var l_l_i24=l__g[4];
			var l_l_i14=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i14,l_st)||script_execute(l_c,l_l_i24,l_st);
			break;
		case 69:
			var l_l_v12=l__g[5];
			var l_l_i25=l__g[4];
			var l_l_i15=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i15,l_st)||script_execute(l_c,l_l_i25,l_st)||script_execute(l_c,l_l_v12,l_st);
			break;
		case 70:
			var l_l_v13=l__g[6];
			var l_l_i26=l__g[4];
			var l_l_i16=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i16,l_st)||script_execute(l_c,l_l_i26,l_st)||script_execute(l_c,l_l_v13,l_st);
			break;
		case 71:
			var l_l_k5=l__g[4];
			var l_l_i9=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i9,l_st)||script_execute(l_c,l_l_k5,l_st);
			break;
		case 72:
			var l_l_k6=l__g[4];
			var l_l_i10=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i10,l_st)||script_execute(l_c,l_l_k6,l_st);
			break;
		case 73:
			var l_l_id22=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_id22,l_st);
			break;
		case 74:
			var l_l_v14=l__g[4];
			var l_l_id23=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_id23,l_st)||script_execute(l_c,l_l_v14,l_st);
			break;
		case 75:
			var l_l_v15=l__g[5];
			var l_l_id24=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_id24,l_st)||script_execute(l_c,l_l_v15,l_st);
			break;
		case 76:
			var l_l_i17=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i17,l_st);
			break;
		case 77:
			var l_l_i18=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i18,l_st);
			break;
		case 78:
			var l_l_id25=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_id25,l_st);
			break;
		case 79:
			var l_l_v16=l__g[4];
			var l_l_id26=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_id26,l_st)||script_execute(l_c,l_l_v16,l_st);
			break;
		case 80:
			var l_l_v17=l__g[5];
			var l_l_id27=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_id27,l_st)||script_execute(l_c,l_l_v17,l_st);
			break;
		case 81:
			var l_l_i19=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i19,l_st);
			break;
		case 82:
			var l_l_i20=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i20,l_st);
			break;
		case 83:
			var l_l_i27=l__g[4];
			var l_l_i110=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i110,l_st)||script_execute(l_c,l_l_i27,l_st);
			break;
		case 84:
			var l_l_v18=l__g[5];
			var l_l_i28=l__g[4];
			var l_l_i111=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i111,l_st)||script_execute(l_c,l_l_i28,l_st)||script_execute(l_c,l_l_v18,l_st);
			break;
		case 85:
			var l_l_v19=l__g[6];
			var l_l_i29=l__g[4];
			var l_l_i112=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i112,l_st)||script_execute(l_c,l_l_i29,l_st)||script_execute(l_c,l_l_v19,l_st);
			break;
		case 86:
			var l_l_k7=l__g[4];
			var l_l_i30=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i30,l_st)||script_execute(l_c,l_l_k7,l_st);
			break;
		case 87:
			var l_l_k8=l__g[4];
			var l_l_i31=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_i31,l_st)||script_execute(l_c,l_l_k8,l_st);
			break;
		case 88:
			var l_l_value2=l__g[3];
			l_r=l_l_value2!=undefined&&script_execute(l_c,l_l_value2,l_st);
			break;
		case 89:
			l_w=l__g[2];
			l_n=array_length_1d(l_w);
			for(l_i=0;l_i<l_n;++l_i){
				if(script_execute(l_c,l_w[l_i],l_st))break;
			}
			l_r=l_i<l_n;
			break;
		case 90:
			var l_l_not1=l__g[4];
			var l_l_then=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_then,l_st)||l_l_not1!=undefined&&script_execute(l_c,l_l_not1,l_st);
			break;
		case 91:
			var l_l_not2=l__g[4];
			var l_l_then1=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_then1,l_st)||script_execute(l_c,l_l_not2,l_st);
			break;
		case 30:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 93:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 113:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 95:
			var l_l_node=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_node,l_st);
			break;
		case 96:
			var l_l_cond3=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_cond3,l_st);
			break;
		case 97:
			var l_l_cond4=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_cond4,l_st);
			break;
		case 98:
			var l_l_node3=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_node3,l_st);
			break;
		case 99:
			var l_l_loop=l__g[5];
			var l_l_post=l__g[4];
			var l_l_cond5=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_cond5,l_st)||script_execute(l_c,l_l_post,l_st)||script_execute(l_c,l_l_loop,l_st);
			break;
		case 100:
			var l_l_node4=l__g[3];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_node4,l_st);
			break;
		case 101:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 102:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 103:l_r=false;break;
		case 104:l_r=false;break;
		case 105:l_r=false;break;
		case 106:l_r=false;break;
		case 107:l_r=false;break;
		case 108:l_r=script_execute(l_c,l__g[3],l_st);break;
		case 109:l_r=script_execute(l_c,l__g[2],l_st);break;
		case 110:l_r=script_execute(l_c,l__g[3],l_st);break;
		case 111:l_r=false;break;
		case 112:l_r=script_execute(l_c,l__g[3],l_st);break;
		case 40:
			var l_l_val6=l__g[5];
			l_r=script_execute(l_c,l__g[2],l_st)||script_execute(l_c,l_l_val6,l_st);
			break;
		case 13:l_r=false;break;
		case 4:
			l_w=l__g[2];
			l_n=array_length_1d(l_w);
			for(l_i=0;l_i<l_n;++l_i){
				if(script_execute(l_c,l_w[l_i],l_st))break;
			}
			l_r=l_i<l_n;
			break;
		case 1:l_r=false;break;
		case 12:l_r=false;break;
		case 92:
			var l_o=l__g[4];
			var l_m=l__g[3];
			if(script_execute(l_c,l__g[2],l_st)){
				l_r=true;
			} else {
				l_n=array_length_1d(l_m);
				for(l_i=0;l_i<l_n;++l_i){
					l_w=gml_std_haxe_boot_wget(l_m[l_i],0);
					l_l=array_length_1d(l_w);
					for(l_k=0;l_k<l_l;++l_k){
						if(script_execute(l_c,l_w[l_k],l_st))break;
					}
					if(l_k<l_l||script_execute(l_c,gml_std_haxe_boot_wget(l_m[l_i],1),l_st))break;
				}
				if(l_i<l_n)l_r=true; else l_r=l_o!=undefined&&script_execute(l_c,l_o,l_st);
			}
			break;
	}
	if(l_st!=undefined)ds_list_delete(l_st,0);
	return l_r;
} else return false;

