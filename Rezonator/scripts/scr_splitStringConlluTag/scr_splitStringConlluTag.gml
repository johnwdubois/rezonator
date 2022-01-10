// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_splitStringConlluTag(key, keyList){
  var str = string_copy(key, 1, string_length(key));
  var strLength = string_length(key);
  var insertString = "";
  var openBracketPos = 0;
  var closeBracketPos = 0;
  var i = 0; //max iterator failsafe
  show_debug_message(string(string_length(str)));
  while(string_length(str) > 0 and i < 1000){
	  i++;
	  if(string_char_at(str,1) == "("){
		insertString += "(";
		str = string_delete(str,1,1);
		openBracketPos = string_pos("(", str);
		closeBracketPos = string_pos(")", str);
		if(openBracketPos != 0 and closeBracketPos != 0){
			insertString += string_copy(str,1,min(openBracketPos-1,closeBracketPos));
			str = string_delete(str, 1, min(openBracketPos-1,closeBracketPos));
		}
		else if(openBracketPos == 0 and closeBracketPos != 0){ //close bracket exists and openbracket doesn't
			insertString += string_copy(str, 1, closeBracketPos);
			str = string_delete(str, 1, closeBracketPos);
		}
		else if(openBracketPos != 0 and closeBracketPos == 0){
			insertString += string_copy(str, 1, openBracketPos-1);
			str = string_delete(str, 1, openBracketPos-1);
		}
		else{
			insertString += string_copy(str, 1, string_length(str));
			str = string_delete(str, 1, string_length(str));
		}
	  }
	  else{
		closeBracketPos = string_pos(")",str);
		insertString = string_copy(str, 1, closeBracketPos);
		str = string_delete(str, 1, closeBracketPos);
	  }
	  ds_list_add(keyList, insertString);
	  insertString = "";
  }
}