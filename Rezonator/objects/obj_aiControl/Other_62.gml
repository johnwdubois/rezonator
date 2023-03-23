//show_debug_message("async http, _http: " + string(_http));
//show_debug_message("async_load: " + json_encode(async_load));

var _id = async_load[? "id"];
var _status = async_load[? "http_status"];
if (_id == httpRequestID && _status == 200) {
	
	var _result = async_load[? "result"];
	
	// result should be a json string
	if (!is_string(_result)) {
		show_debug_message("obj_aiControl, Async HTTP _result is not a string: " + string(_result));
		exit;
	}
	
	// parse json and get choices field
	var _resultParse = json_parse(_result);
	var _choices = _resultParse.choices;
	
	show_debug_message("_result: " + string(_result));
	show_debug_message("_resultParse: " + string(_resultParse));
	show_debug_message("_choices: " + string(_choices));
	
	// get first choice
	var _firstChoice = _choices[0];
	show_debug_message("_firstChoice: " + string(_firstChoice));
	
	var _message = _firstChoice.message;
	var _text = _message.content;
	
	/*
	var _text = _firstChoice.text;
	show_debug_message("_text: " + string(_text));
	*/
	
	//_text = string_replace_all(_text, "\r", "");
	//_text = string_replace_all(_text, "\n", " ");
	
	scr_aiNewMessage("ChatGPT", _text, true);
	
}