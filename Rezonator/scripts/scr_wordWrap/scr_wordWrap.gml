function scr_wordWrap(text_current, width, split){
	
    var pos_space, pos_current, text_output;
    pos_space = -1;
    pos_current = 1;
	var lineBreakChar = "\n";
    text_output = "";
    while (string_length(text_current) >= pos_current) {
        if (string_width(string_copy(text_current,1,pos_current)) > width) {
            //if there is a space in this line then we can break there
            if (pos_space != -1) {
                text_output += string_copy(text_current,1,pos_space) + string(lineBreakChar);
                //remove the text we just looked at from the current text string
                text_current = string_copy(text_current,pos_space+1,string_length(text_current)-(pos_space));
                pos_current = 1;
                pos_space = -1;
            } else if (split) {
                //if not, we can force line breaks
                text_output += string_copy(text_current,1,pos_current-1) + string(lineBreakChar);
                //remove the text we just looked at from the current text string
                text_current = string_copy(text_current,pos_current,string_length(text_current)-(pos_current-1));
                pos_current = 1;
                pos_space = -1;
            }
        }
        pos_current += 1;
        if (string_char_at(text_current,pos_current) == " ") pos_space = pos_current;
    }
    if (string_length(text_current) > 0) text_output += text_current;
    return text_output;
	
}