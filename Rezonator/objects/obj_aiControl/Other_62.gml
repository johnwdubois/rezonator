var _id = async_load[? "id"];
var _status = async_load[? "http_status"];
if (_id == httpRequestID && _status == 200) {
	
	// result should be a json string
	var _result = async_load[? "result"];
	if (!is_string(_result)) {
		show_debug_message("obj_aiControl, Async HTTP _result is not a string: " + string(_result));
		exit;
	}
	
	try {
		// parse json and create new ai message
		var _resultParse = json_parse(_result);
		scr_aiNewMessage("ChatGPT", _resultParse);
	}
	catch (e) {
		show_debug_message("obj_aiControl, Async HTTP could not parse json");
	}
}