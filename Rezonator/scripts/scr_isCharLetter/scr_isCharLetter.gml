function scr_isCharLetter(char){
	
	// check if the character is a letter, so that we can figure out the "bounds" of a word
	// we could use GM's string_letters function, but that function only works for A-Z characters
	
	return (char != " " && char != "	" && char != "." && char != "," && char != ":" && char != ";" && char != "<" && char != ">"
			&& char != "?" && char != "!" && char != "/" && char != "\\" && char != "@" && char != "#" && char != "$" && char != "%"
			&& char != "^" && char != "&" && char != "*" && char != "(" && char != ")" && char != "[" && char != "]" && char != "{"
			&& char != "}" && char != "-" && char != "=" && char != "+" && char != "|" && ord(char) != 13 && ord(char) != 8 && char != "" && char != "\n" && char != "\r\n" && char != "\n\r" && char != "\r");
	
}