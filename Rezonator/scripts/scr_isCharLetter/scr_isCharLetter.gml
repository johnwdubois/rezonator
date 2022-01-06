function scr_isCharLetter(char){
	
	// check if the character is a letter, so that we can figure out the "bounds" of a word
	// we could use GM's string_letters function, but that function only works for A-Z characters
	
	return (char != " " && char != "	" && char != "." && char != "," && char != ":" && char != ";" && char != "<" && char != ">"
			&& char != "?" && char != "!" && char != "/" && char != "\\" && char != "@" && char != "#" && char != "$" && char != "%"
			&& char != "^" && char != "&" && char != "*" && char != "(" && char != ")" && char != "[" && char != "]" && char != "{"
			&& char != "}" && char != "-" && char != "=" && char != "+" && char != "|");
	
}