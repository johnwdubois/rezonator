// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.
// Feather disable all

// tokenizes the source code!
if(live_enabled)
function gml_parser_set_version(l_ver){
	if(l_ver<10){
		show_error("Supported versions are 14,20,23",true);
	} else if(l_ver<20){
		gml_parser_default_version=api_api_version_v1;
	} else if(l_ver<23){
		gml_parser_default_version=api_api_version_v2;
	} else gml_parser_default_version=api_api_version_v23;
}

if(live_enabled)
function gml_parser_error(l_text,l_pos,l_tkl){
	ds_list_destroy(l_tkl);
	gml_parser_error_text=l_pos.h_to_string()+": "+l_text;
	gml_parser_error_pos=l_pos;
	return undefined;
}

if(live_enabled)
function gml_parser_buf_sub(l_buf,l_str,l_start,l_end){
	var l_len=l_end-l_start;
	buffer_copy(l_buf,l_start,l_len,l_str,0);
	buffer_poke(l_str,l_len,buffer_u8,0);
	buffer_seek(l_str,buffer_seek_start,0);
	return buffer_read(l_str,buffer_string);
}

if(live_enabled)
function gml_parser_run(l_src,l_temStart){
	if(l_temStart==undefined)l_temStart=-1;
	if(false)show_debug_message(argument[1]);
	var l_z,l_s,l_i,l_n,l_row,l_rowStart,l_pos,l_tks;
	var l_ver=l_src.h_version;
	if(l_ver==undefined){
		l_ver=gml_parser_default_version;
		l_src.h_version=l_ver;
	}
	var l_out=ds_list_create();
	if(l_temStart>=0){
		l_row=gml_parser_tem_row;
		l_rowStart=gml_parser_tem_row_start;
		l_pos=l_temStart;
	} else {
		l_row=1;
		l_rowStart=0;
		l_pos=0;
	}
	var l_code=l_src.h_code;
	var l_len=string_byte_length(l_code);
	var l_buf=gml_parser_src_buf;
	var l_str=gml_parser_str_buf;
	if(l_temStart<0){
		if(buffer_get_size(l_str)<l_len)buffer_resize(l_str,l_len);
		buffer_seek(l_str,buffer_seek_start,0);
		buffer_write(l_str,buffer_string,l_code);
		if(buffer_get_size(l_buf)<l_len)buffer_resize(l_buf,l_len);
		buffer_copy(gml_parser_str_buf,0,l_len,l_buf,0);
	}
	var l_sub_buf=gml_parser_buf_sub_buf;
	var l_checkLine=false;
	var l_brackets=0;
	while(l_pos<l_len){
		var l_c=buffer_peek(l_buf,l_pos++,buffer_u8);
		switch(l_c){
			case 9:case 13:case 32:continue;
			case 10:
				if(l_checkLine){
					l_i=ds_list_size(l_out)-1;
					var l__g=ds_list_find_value(l_out,l_i);
					if(l__g.__enumIndex__==0){
						if(l__g.h_lb==false)ds_list_set(l_out,l_i,gml_token_header(l__g.h_d,l__g.h_name,true));
					}
				}
				l_row++;
				l_rowStart=l_pos;
				continue;
		}
		var l_start=l_pos-1;
		var l_d=new gml_pos(l_src,l_row,l_pos-l_rowStart);
		var l_op;
		switch(l_c){
			case 59:ds_list_add(l_out,gml_token_semico(l_d));break;
			case 44:ds_list_add(l_out,gml_token_comma(l_d));break;
			case 46:
				l_c=buffer_peek(l_buf,l_pos,buffer_u8);
				if(l_c>=48&&l_c<=57){
					while(true){
						l_pos++;
						l_c=buffer_peek(l_buf,l_pos,buffer_u8);
						if(!(l_c>=48&&l_c<=57))break;
					}
					l_s=gml_parser_buf_sub(l_buf,l_sub_buf,l_start,l_pos);
					ds_list_add(l_out,gml_token_number(l_d,gml_std_Std_parseFloat(l_s),l_s));
				} else ds_list_add(l_out,gml_token_period(l_d));
				break;
			case 58:ds_list_add(l_out,gml_token_colon(l_d));break;
			case 63:
				if(buffer_peek(l_buf,l_pos,buffer_u8)==63){
					l_pos++;
					if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
						l_pos++;
						ds_list_add(l_out,gml_token_null_co_set(l_d));
					} else ds_list_add(l_out,gml_token_null_co(l_d));
				} else ds_list_add(l_out,gml_token_qmark(l_d));
				break;
			case 64:
				if(l_ver.h_has_literal_strings){
					l_c=buffer_peek(l_buf,l_pos,buffer_u8);
					if(l_c==34||l_c==39){
						l_pos++;
						l_n=l_pos;
						l_i=buffer_peek(l_buf,l_pos,buffer_u8);
						if(l_c>=192){
							if(l_c>=224){
								if(l_c>=240)l_rowStart+=3; else l_rowStart+=2;
							} else l_rowStart++;
						}
						while(l_i!=l_c&&l_pos<l_len){
							if(l_i==10){
								l_row++;
								l_rowStart=l_pos;
							}
							l_pos++;
							l_i=buffer_peek(l_buf,l_pos,buffer_u8);
							if(l_c>=192){
								if(l_c>=224){
									if(l_c>=240)l_rowStart+=3; else l_rowStart+=2;
								} else l_rowStart++;
							}
						}
						if(l_pos<l_len){
							l_s=gml_parser_buf_sub(l_buf,l_sub_buf,l_n,l_pos++);
						} else {
							ds_list_destroy(l_out);
							gml_parser_error("Unclosed string",l_d,l_out);
							l_s=undefined;
						}
						ds_list_add(l_out,gml_token_cstring(l_d,l_s));
					} else ds_list_add(l_out,gml_token_at_sign(l_d));
				} else ds_list_add(l_out,gml_token_at_sign(l_d));
				break;
			case 61:
				if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
					l_pos++;
					ds_list_add(l_out,gml_token_bin_op(l_d,64));
				} else ds_list_add(l_out,gml_token_set_op(l_d,-1));
				break;
			case 43:
				switch(buffer_peek(l_buf,l_pos,buffer_u8)){
					case 61:
						l_pos++;
						ds_list_add(l_out,gml_token_set_op(l_d,16));
						break;
					case 43:
						l_pos++;
						ds_list_add(l_out,gml_token_adjfix(l_d,true));
						break;
					default:ds_list_add(l_out,gml_token_bin_op(l_d,16));
				}
				break;
			case 45:
				switch(buffer_peek(l_buf,l_pos,buffer_u8)){
					case 61:
						l_pos++;
						ds_list_add(l_out,gml_token_set_op(l_d,17));
						break;
					case 45:
						l_pos++;
						ds_list_add(l_out,gml_token_adjfix(l_d,false));
						break;
					default:ds_list_add(l_out,gml_token_bin_op(l_d,17));
				}
				break;
			case 47:
				switch(buffer_peek(l_buf,l_pos,buffer_u8)){
					case 47:
						l_pos++;
						l_start=l_pos;
						while(l_pos<l_len){
							l_i=buffer_peek(l_buf,l_pos,buffer_u8);
							if(l_i==10||l_i==13)break; else l_pos++;
						}
						break;
					case 42:
						l_pos++;
						while(true){
							l_c=buffer_peek(l_buf,l_pos,buffer_u8);
							if(l_c>=192){
								if(l_c>=224){
									if(l_c>=240)l_rowStart+=3; else l_rowStart+=2;
								} else l_rowStart++;
							}
							if(l_c==10){
								l_row++;
								l_rowStart=l_pos;
							}
							l_pos++;
							if(l_pos<l_len){
								l_z=true;
								if(l_c==42){
									if(buffer_peek(l_buf,l_pos,buffer_u8)==47)l_z=false;
								}
							} else l_z=false;
							if(!l_z)break;
						}
						l_i=l_pos;
						l_z=true;
						l_pos++;
						while(++l_i<l_len){
							switch(buffer_peek(l_buf,l_i,buffer_u8)){
								case 9:case 32:continue;
								case 10:case 13:break;
								default:l_z=false;
							}
							break;
						}
						break;
					case 61:
						l_pos++;
						ds_list_add(l_out,gml_token_set_op(l_d,1));
						break;
					default:
						l_op=1;
						if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
							l_pos++;
							ds_list_add(l_out,gml_token_set_op(l_d,l_op));
						} else ds_list_add(l_out,gml_token_bin_op(l_d,l_op));
				}
				break;
			case 42:
				l_op=0;
				if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
					l_pos++;
					ds_list_add(l_out,gml_token_set_op(l_d,l_op));
				} else ds_list_add(l_out,gml_token_bin_op(l_d,l_op));
				break;
			case 37:
				l_op=2;
				if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
					l_pos++;
					ds_list_add(l_out,gml_token_set_op(l_d,l_op));
				} else ds_list_add(l_out,gml_token_bin_op(l_d,l_op));
				break;
			case 38:
				if(buffer_peek(l_buf,l_pos,buffer_u8)==38){
					l_pos++;
					l_op=80;
					if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
						l_pos++;
						ds_list_add(l_out,gml_token_set_op(l_d,l_op));
					} else ds_list_add(l_out,gml_token_bin_op(l_d,l_op));
				} else {
					l_op=49;
					if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
						l_pos++;
						ds_list_add(l_out,gml_token_set_op(l_d,l_op));
					} else ds_list_add(l_out,gml_token_bin_op(l_d,l_op));
				}
				break;
			case 124:
				if(buffer_peek(l_buf,l_pos,buffer_u8)==124){
					l_pos++;
					l_op=96;
					if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
						l_pos++;
						ds_list_add(l_out,gml_token_set_op(l_d,l_op));
					} else ds_list_add(l_out,gml_token_bin_op(l_d,l_op));
				} else {
					l_op=48;
					if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
						l_pos++;
						ds_list_add(l_out,gml_token_set_op(l_d,l_op));
					} else ds_list_add(l_out,gml_token_bin_op(l_d,l_op));
				}
				break;
			case 94:
				if(buffer_peek(l_buf,l_pos,buffer_u8)==94){
					l_pos++;
					l_op=65;
					if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
						l_pos++;
						ds_list_add(l_out,gml_token_set_op(l_d,l_op));
					} else ds_list_add(l_out,gml_token_bin_op(l_d,l_op));
				} else {
					l_op=50;
					if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
						l_pos++;
						ds_list_add(l_out,gml_token_set_op(l_d,l_op));
					} else ds_list_add(l_out,gml_token_bin_op(l_d,l_op));
				}
				break;
			case 62:
				switch(buffer_peek(l_buf,l_pos,buffer_u8)){
					case 61:
						l_pos++;
						ds_list_add(l_out,gml_token_bin_op(l_d,69));
						break;
					case 62:
						l_pos++;
						l_op=33;
						if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
							l_pos++;
							ds_list_add(l_out,gml_token_set_op(l_d,l_op));
						} else ds_list_add(l_out,gml_token_bin_op(l_d,l_op));
						break;
					default:ds_list_add(l_out,gml_token_bin_op(l_d,68));
				}
				break;
			case 60:
				switch(buffer_peek(l_buf,l_pos,buffer_u8)){
					case 61:
						l_pos++;
						ds_list_add(l_out,gml_token_bin_op(l_d,67));
						break;
					case 60:
						l_pos++;
						l_op=32;
						if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
							l_pos++;
							ds_list_add(l_out,gml_token_set_op(l_d,l_op));
						} else ds_list_add(l_out,gml_token_bin_op(l_d,l_op));
						break;
					case 62:
						l_pos++;
						l_op=65;
						if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
							l_pos++;
							ds_list_add(l_out,gml_token_set_op(l_d,l_op));
						} else ds_list_add(l_out,gml_token_bin_op(l_d,l_op));
						break;
					default:ds_list_add(l_out,gml_token_bin_op(l_d,66));
				}
				break;
			case 33:
				if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
					l_pos++;
					l_op=65;
					if(buffer_peek(l_buf,l_pos,buffer_u8)==61){
						l_pos++;
						ds_list_add(l_out,gml_token_set_op(l_d,l_op));
					} else ds_list_add(l_out,gml_token_bin_op(l_d,l_op));
				} else ds_list_add(l_out,gml_token_un_op(l_d,1));
				break;
			case 126:ds_list_add(l_out,gml_token_un_op(l_d,2));break;
			case 40:ds_list_add(l_out,gml_token_par_open(l_d));break;
			case 41:ds_list_add(l_out,gml_token_par_close(l_d));break;
			case 91:ds_list_add(l_out,gml_token_sqb_open(l_d));break;
			case 93:ds_list_add(l_out,gml_token_sqb_close(l_d));break;
			case 123:
				l_brackets++;
				ds_list_add(l_out,gml_token_cub_open(l_d));
				break;
			case 125:
				l_brackets--;
				if(l_temStart>=0&&l_brackets<0){
					if(l_temStart>=0){
						gml_parser_tem_end=l_pos;
						gml_parser_tem_row=l_row;
						gml_parser_tem_row_start=l_rowStart;
					} else if(l_src.h___eof==undefined){
						l_src.h___eof=new gml_pos(l_src,l_row,l_pos-l_rowStart);
					}
					l_n=ds_list_size(l_out);
					l_tks=array_create(l_n);
					for(l_i=0;l_i<l_n;l_i++){
						l_tks[@l_i]=ds_list_find_value(l_out,l_i);
					}
					gml_parser_tokens_found=ds_list_size(l_out);
					ds_list_destroy(l_out);
					return l_tks;
				} else ds_list_add(l_out,gml_token_cub_close(l_d));
				break;
			case 34:
				if(l_ver.h_has_string_escape_characters){
					l_z=true;
					l_c=buffer_peek(l_buf,l_pos,buffer_u8);
					if(l_c>=192){
						if(l_c>=224){
							if(l_c>=240)l_rowStart+=3; else l_rowStart+=2;
						} else l_rowStart++;
					}
					while(l_pos<l_len){
						switch(l_c){
							case 34:break;
							case 10:case 13:
								ds_list_destroy(l_out);
								return gml_parser_error("Unclosed string",l_d,l_out);
							case 92:
								if(l_z){
									l_z=false;
									buffer_seek(l_str,buffer_seek_start,0);
								}
								l_s=gml_parser_buf_sub(l_buf,l_sub_buf,l_start+1,l_pos);
								buffer_write(l_str,buffer_text,l_s);
								l_pos++;
								l_c=buffer_peek(l_buf,l_pos,buffer_u8);
								if(l_c>=192){
									if(l_c>=224){
										if(l_c>=240)l_rowStart+=3; else l_rowStart+=2;
									} else l_rowStart++;
								}
								switch(l_c){
									case 114:buffer_write(l_str,buffer_u8,13);break;
									case 110:buffer_write(l_str,buffer_u8,10);break;
									case 116:buffer_write(l_str,buffer_u8,9);break;
									case 98:buffer_write(l_str,buffer_u8,8);break;
									case 102:buffer_write(l_str,buffer_u8,12);break;
									case 118:buffer_write(l_str,buffer_u8,11);break;
									case 92:buffer_write(l_str,buffer_u8,92);break;
									case 97:buffer_write(l_str,buffer_u8,7);break;
									case 10:
										l_row++;
										l_rowStart=l_pos;
										break;
									case 117:case 120:
										l_n=0;
										if(l_c==117)l_i=12; else l_i=4;
										while(l_i>=0){
											l_pos++;
											l_c=buffer_peek(l_buf,l_pos,buffer_u8);
											if(l_c>=48&&l_c<=57){
												l_c-=48;
											} else if(l_c>=65&&l_c<=70){
												l_c-=55;
											} else if(l_c>=97&&l_c<=102){
												l_c-=87;
											} else l_c=0;
											l_n|=(l_c<<l_i);
											l_i-=4;
										}
										if(l_n<=127){
											buffer_write(l_str,buffer_u8,l_n);
										} else if(l_n<=2047){
											buffer_write(l_str,buffer_u8,(192|(l_n>>6)));
											buffer_write(l_str,buffer_u8,(128|(l_n&63)));
										} else if(l_n<=65535){
											buffer_write(l_str,buffer_u8,(192|(l_n>>12)));
											buffer_write(l_str,buffer_u8,(128|((l_n>>6)&63)));
											buffer_write(l_str,buffer_u8,(128|(l_n&63)));
										} else {
											buffer_write(l_str,buffer_u8,(192|(l_n>>18)));
											buffer_write(l_str,buffer_u8,(128|((l_n>>12)&63)));
											buffer_write(l_str,buffer_u8,(128|((l_n>>6)&63)));
											buffer_write(l_str,buffer_u8,(128|(l_n&63)));
										}
										break;
									default:
										buffer_write(l_str,buffer_u8,l_c);
										if(l_c==13){
											l_pos++;
											if(buffer_peek(l_buf,l_pos,buffer_u8)==10)buffer_write(l_str,buffer_u8,10); else l_pos--;
										}
								}
								l_start=l_pos;
								l_pos++;
								l_c=buffer_peek(l_buf,l_pos,buffer_u8);
								if(l_c>=192){
									if(l_c>=224){
										if(l_c>=240)l_rowStart+=3; else l_rowStart+=2;
									} else l_rowStart++;
								}
								continue;
							default:
								l_pos++;
								l_c=buffer_peek(l_buf,l_pos,buffer_u8);
								if(l_c>=192){
									if(l_c>=224){
										if(l_c>=240)l_rowStart+=3; else l_rowStart+=2;
									} else l_rowStart++;
								}
								continue;
						}
						break;
					}
					if(l_pos>=l_len){
						ds_list_destroy(l_out);
						return gml_parser_error("Unclosed string",l_d,l_out);
					} else l_pos++;
					if(l_z){
						l_s=gml_parser_buf_sub(l_buf,l_sub_buf,l_start+1,l_pos-1);
					} else {
						l_s=gml_parser_buf_sub(l_buf,l_sub_buf,l_start+1,l_pos-1);
						buffer_write(l_str,buffer_text,l_s);
						buffer_write(l_str,buffer_u8,0);
						buffer_seek(l_str,buffer_seek_start,0);
						l_s=buffer_read(l_str,buffer_string);
					}
					ds_list_add(l_out,gml_token_cstring(l_d,l_s));
				} else {
					l_n=l_pos;
					l_i=buffer_peek(l_buf,l_pos,buffer_u8);
					if(l_c>=192){
						if(l_c>=224){
							if(l_c>=240)l_rowStart+=3; else l_rowStart+=2;
						} else l_rowStart++;
					}
					while(l_i!=l_c&&l_pos<l_len){
						if(l_i==10){
							l_row++;
							l_rowStart=l_pos;
						}
						l_pos++;
						l_i=buffer_peek(l_buf,l_pos,buffer_u8);
						if(l_c>=192){
							if(l_c>=224){
								if(l_c>=240)l_rowStart+=3; else l_rowStart+=2;
							} else l_rowStart++;
						}
					}
					if(l_pos<l_len){
						l_s=gml_parser_buf_sub(l_buf,l_sub_buf,l_n,l_pos++);
					} else {
						ds_list_destroy(l_out);
						gml_parser_error("Unclosed string",l_d,l_out);
						l_s=undefined;
					}
					if(l_s==undefined)return undefined;
					ds_list_add(l_out,gml_token_cstring(l_d,gml_parser_buf_sub(l_buf,l_sub_buf,l_start+1,l_pos-1)));
				}
				break;
			case 39:
				if(l_ver.h_has_string_escape_characters){
					ds_list_destroy(l_out);
					return gml_parser_error("Single quotes are not allowed for strings.",l_d,l_out);
				} else {
					l_n=l_pos;
					l_i=buffer_peek(l_buf,l_pos,buffer_u8);
					if(l_c>=192){
						if(l_c>=224){
							if(l_c>=240)l_rowStart+=3; else l_rowStart+=2;
						} else l_rowStart++;
					}
					while(l_i!=l_c&&l_pos<l_len){
						if(l_i==10){
							l_row++;
							l_rowStart=l_pos;
						}
						l_pos++;
						l_i=buffer_peek(l_buf,l_pos,buffer_u8);
						if(l_c>=192){
							if(l_c>=224){
								if(l_c>=240)l_rowStart+=3; else l_rowStart+=2;
							} else l_rowStart++;
						}
					}
					if(l_pos<l_len){
						l_s=gml_parser_buf_sub(l_buf,l_sub_buf,l_n,l_pos++);
					} else {
						ds_list_destroy(l_out);
						gml_parser_error("Unclosed string",l_d,l_out);
						l_s=undefined;
					}
					if(l_s==undefined)return undefined;
					ds_list_add(l_out,gml_token_cstring(l_d,gml_parser_buf_sub(l_buf,l_sub_buf,l_start+1,l_pos-1)));
				}
				break;
			case 35:
				l_start=l_pos;
				while(l_pos<l_len){
					l_c=buffer_peek(l_buf,l_pos,buffer_u8);
					if(l_c==95||l_c>=97&&l_c<=122||l_c>=65&&l_c<=90||l_c>=48&&l_c<=57)l_pos++; else break;
				}
				var l_ident=gml_parser_buf_sub(l_buf,l_sub_buf,l_start,l_pos);
				switch(l_ident){
					case "define":
						l_start=l_pos;
						while(l_pos<l_len){
							l_c=buffer_peek(l_buf,l_pos,buffer_u8);
							if(l_c==32||l_c==9)l_pos++; else break;
						}
						if((l_c==95||l_c>=97&&l_c<=122||l_c>=65&&l_c<=90)&&l_pos<l_len){
							l_start=l_pos;
							l_pos++;
							while(l_pos<l_len){
								l_c=buffer_peek(l_buf,l_pos,buffer_u8);
								if(l_c==95||l_c>=97&&l_c<=122||l_c>=65&&l_c<=90||l_c>=48&&l_c<=57)l_pos++; else break;
							}
							ds_list_add(l_out,gml_token_header(l_d,gml_parser_buf_sub(l_buf,l_sub_buf,l_start,l_pos),false));
							l_checkLine=true;
						} else {
							ds_list_destroy(l_out);
							return gml_parser_error("Expected a script name",l_d,l_out);
						}
						break;
					case "macro":ds_list_add(l_out,gml_token_macro(l_d));break;
					case "endregion":case "region":
						while(l_pos<l_len){
							l_i=buffer_peek(l_buf,l_pos,buffer_u8);
							if(l_i==10||l_i==13)break; else l_pos++;
						}
						break;
					default:
						l_z=true;
						if(string_length(l_ident)==6){
							l_z=false;
							l_n=-1;
							l_i=0;
							while(++l_n<6){
								l_c=string_ord_at(l_ident,l_n+1);
								if(l_c>=48&&l_c<=57){
									l_i=((l_i<<4)|l_c-48);
								} else if(l_c>=97&&l_c<=102){
									l_i=((l_i<<4)|l_c-87);
								} else if(l_c>=65&&l_c<=70){
									l_i=((l_i<<4)|l_c-55);
								} else {
									l_z=true;
									break;
								}
							}
							if(!l_z){
								l_i=(((l_i&65280)|((l_i&16711680)>>16))|((l_i&255)<<16));
								ds_list_add(l_out,gml_token_number(l_d,l_i,undefined));
							}
						}
						if(l_z){
							ds_list_add(l_out,gml_token_hash(l_d));
							l_pos=l_start;
						}
				}
				break;
			case 36:
				l_i=0;
				while(l_pos<l_len){
					l_c=buffer_peek(l_buf,l_pos,buffer_u8);
					if(l_c>=48&&l_c<=57){
						l_i=((l_i<<4)|l_c-48);
					} else if(l_c>=97&&l_c<=102){
						l_i=((l_i<<4)|l_c-87);
					} else if(l_c>=65&&l_c<=70){
						l_i=((l_i<<4)|l_c-55);
					} else break;
					l_pos++;
				}
				if(l_pos>l_start+1)ds_list_add(l_out,gml_token_number(l_d,l_i,gml_parser_buf_sub(l_buf,l_sub_buf,l_start,l_pos))); else ds_list_add(l_out,gml_token_dollar_sign(l_d));
				break;
			default:
				if(l_c>=97&&l_c<=122||l_c>=65&&l_c<=90||l_c==95){
					while(l_pos<l_len){
						l_c=buffer_peek(l_buf,l_pos,buffer_u8);
						if(l_c==95||l_c>=97&&l_c<=122||l_c>=65&&l_c<=90||l_c>=48&&l_c<=57)l_pos++; else break;
					}
					l_s=gml_parser_buf_sub(l_buf,l_sub_buf,l_start,l_pos);
					switch(l_s){
						case "global":ds_list_add(l_out,gml_token_keyword(l_d,0));break;
						case "true":ds_list_add(l_out,gml_token_number(l_d,1,undefined));break;
						case "false":ds_list_add(l_out,gml_token_number(l_d,0,undefined));break;
						case "all":ds_list_add(l_out,gml_token_number(l_d,-3,undefined));break;
						case "noone":ds_list_add(l_out,gml_token_number(l_d,-4,undefined));break;
						case "undefined":ds_list_add(l_out,gml_token_undefined_hx(l_d));break;
						case "begin":ds_list_add(l_out,gml_token_cub_open(l_d));break;
						case "end":ds_list_add(l_out,gml_token_cub_close(l_d));break;
						case "globalvar":ds_list_add(l_out,gml_token_keyword(l_d,1));break;
						case "var":ds_list_add(l_out,gml_token_keyword(l_d,2));break;
						case "enum":ds_list_add(l_out,gml_token_keyword(l_d,3));break;
						case "if":ds_list_add(l_out,gml_token_keyword(l_d,4));break;
						case "then":ds_list_add(l_out,gml_token_keyword(l_d,5));break;
						case "else":ds_list_add(l_out,gml_token_keyword(l_d,6));break;
						case "switch":ds_list_add(l_out,gml_token_keyword(l_d,7));break;
						case "case":ds_list_add(l_out,gml_token_keyword(l_d,8));break;
						case "default":ds_list_add(l_out,gml_token_keyword(l_d,9));break;
						case "for":ds_list_add(l_out,gml_token_keyword(l_d,14));break;
						case "repeat":ds_list_add(l_out,gml_token_keyword(l_d,10));break;
						case "while":ds_list_add(l_out,gml_token_keyword(l_d,11));break;
						case "do":ds_list_add(l_out,gml_token_keyword(l_d,13));break;
						case "until":ds_list_add(l_out,gml_token_keyword(l_d,12));break;
						case "with":ds_list_add(l_out,gml_token_keyword(l_d,15));break;
						case "exit":ds_list_add(l_out,gml_token_keyword(l_d,19));break;
						case "return":ds_list_add(l_out,gml_token_keyword(l_d,18));break;
						case "break":ds_list_add(l_out,gml_token_keyword(l_d,17));break;
						case "continue":ds_list_add(l_out,gml_token_keyword(l_d,16));break;
						case "try":if(l_ver.h_has_try_catch)ds_list_add(l_out,gml_token_keyword(l_d,21)); else ds_list_add(l_out,gml_token_ident(l_d,l_s));break;
						case "catch":if(l_ver.h_has_try_catch)ds_list_add(l_out,gml_token_keyword(l_d,22)); else ds_list_add(l_out,gml_token_ident(l_d,l_s));break;
						case "throw":if(l_ver.h_has_try_catch)ds_list_add(l_out,gml_token_keyword(l_d,23)); else ds_list_add(l_out,gml_token_ident(l_d,l_s));break;
						case "new":if(l_ver.h_has_constructor)ds_list_add(l_out,gml_token_keyword(l_d,25)); else ds_list_add(l_out,gml_token_ident(l_d,l_s));break;
						case "delete":if(l_ver.h_has_delete)ds_list_add(l_out,gml_token_keyword(l_d,29)); else ds_list_add(l_out,gml_token_ident(l_d,l_s));break;
						case "function":if(l_ver.h_has_func_literal)ds_list_add(l_out,gml_token_keyword(l_d,24)); else ds_list_add(l_out,gml_token_ident(l_d,l_s));break;
						case "div":ds_list_add(l_out,gml_token_bin_op(l_d,3));break;
						case "mod":ds_list_add(l_out,gml_token_bin_op(l_d,2));break;
						case "and":ds_list_add(l_out,gml_token_bin_op(l_d,80));break;
						case "or":ds_list_add(l_out,gml_token_bin_op(l_d,96));break;
						case "xor":ds_list_add(l_out,gml_token_bin_op(l_d,65));break;
						case "not":ds_list_add(l_out,gml_token_un_op(l_d,1));break;
						case "argument":ds_list_add(l_out,gml_token_keyword(l_d,26));break;
						case "argument_count":ds_list_add(l_out,gml_token_keyword(l_d,27));break;
						default:
							if(gml_std_StringTools_startsWith(l_s,"argument")){
								var l_s_8=gml_std_string_substring(l_s,8);
								if(string_digits(l_s_8)==l_s_8)ds_list_add(l_out,gml_token_arg_const(l_d,gml_std_Std_parseInt(l_s_8))); else ds_list_add(l_out,gml_token_ident(l_d,l_s));
							} else ds_list_add(l_out,gml_token_ident(l_d,l_s));
					}
				} else if(l_c>=48&&l_c<=57||l_c==46){
					if(buffer_peek(l_buf,l_pos,buffer_u8)==120){
						l_pos++;
						l_i=0;
						while(l_pos<l_len){
							l_c=buffer_peek(l_buf,l_pos,buffer_u8);
							if(l_c>=48&&l_c<=57){
								l_i=((l_i<<4)|l_c-48);
							} else if(l_c>=97&&l_c<=102){
								l_i=((l_i<<4)|l_c-87);
							} else if(l_c>=65&&l_c<=70){
								l_i=((l_i<<4)|l_c-55);
							} else break;
							l_pos++;
						}
						ds_list_add(l_out,gml_token_number(l_d,l_i,gml_parser_buf_sub(l_buf,l_sub_buf,l_start,l_pos)));
					} else {
						l_pos--;
						l_z=false;
						l_s=undefined;
						while(l_pos<l_len){
							l_c=buffer_peek(l_buf,l_pos,buffer_u8);
							if(l_c==46){
								if(l_z){
									ds_list_destroy(l_out);
									return gml_parser_error("Extra dot in a number",l_d,l_out);
								} else {
									l_pos++;
									l_c=buffer_peek(l_buf,l_pos,buffer_u8);
									if(l_c==95||l_c>=97&&l_c<=122||l_c>=65&&l_c<=90){
										l_s=gml_parser_buf_sub(l_buf,l_sub_buf,l_start,l_pos-1);
										ds_list_add(l_out,gml_token_number(l_d,gml_std_Std_parseFloat(l_s),l_s));
										l_d=new gml_pos(l_src,l_row,l_pos-l_rowStart);
										ds_list_add(l_out,gml_token_period(l_d));
										break;
									}
									l_z=true;
								}
							} else if(l_c>=48&&l_c<=57){
								l_pos++;
							} else break;
						}
						if(l_s==undefined){
							while(buffer_peek(l_buf,l_start,buffer_u8)==48){
								l_start++;
								if(l_start>=l_pos){
									l_start--;
									break;
								} else if(buffer_peek(l_buf,l_start,buffer_u8)==46){
									l_start--;
									break;
								}
							}
							l_s=gml_parser_buf_sub(l_buf,l_sub_buf,l_start,l_pos);
							var l_f=gml_std_Std_parseFloat(l_s);
							if(!l_z){
								if(string_format(l_f,0,0)!=l_s){
									var l_i64=int64(l_s);
									if(string(l_i64)==l_s)l_f=l_i64;
								}
							}
							ds_list_add(l_out,gml_token_number(l_d,l_f,l_s));
						}
					}
				} else {
					var l_text="Unexpected character `"+chr(l_c)+"`";
					ds_list_destroy(l_out);
					return gml_parser_error(l_text,l_d,l_out);
				}
		}
	}
	if(l_temStart>=0){
		gml_parser_tem_end=l_pos;
		gml_parser_tem_row=l_row;
		gml_parser_tem_row_start=l_rowStart;
	} else if(l_src.h___eof==undefined){
		l_src.h___eof=new gml_pos(l_src,l_row,l_pos-l_rowStart);
	}
	l_n=ds_list_size(l_out);
	l_tks=array_create(l_n);
	for(l_i=0;l_i<l_n;l_i++){
		l_tks[@l_i]=ds_list_find_value(l_out,l_i);
	}
	gml_parser_tokens_found=ds_list_size(l_out);
	ds_list_destroy(l_out);
	return l_tks;
}
