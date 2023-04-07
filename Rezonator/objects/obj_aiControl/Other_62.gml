var _id = async_load[? "id"];
var _status = async_load[? "http_status"];
//show_debug_message("obj_aiControl, async http, _id: {0}, _status: {1}", _id, _status);

if (_id == httpRequestID) {
	
	aiErrorMsg = "";
	awaitingResponseTime = current_time;
	showAwaitingResponse = false;
	
	// result should be a json string
	var _result = async_load[? "result"];
	if (!is_string(_result)) {
		show_debug_message("obj_aiControl, Async HTTP _result is not a string: " + string(_result));
		exit;
	}
	
	// try to parse json
	var _resultParse = "";
	try {
		_resultParse = json_parse(_result);
	}
	catch (e) {
		// if we couldn't parse, show an alert box
		scr_createDialogBox(DIALOG_AICHAT_ERROR);
		aiErrorMsg = "Could not parse AI response.";
		show_debug_message("obj_aiControl, Async HTTP could not parse json");
		exit;
	}
	
	// successful callback
	if (_status == 200) {
		// create new ai message
		scr_aiNewMessage("ChatGPT", _resultParse);
	}
	else {
		// unsuccessful request
		
		// see if we can get an error message from result
		var _errorMsg = "Empty AI response";
		show_debug_message("_result: " + string(_result));
		if (variable_struct_exists(_resultParse, "error")) {
			var _error = _resultParse[$ "error"];
			if (is_struct(_error)) {
				if (variable_struct_exists(_error, "message")) _errorMsg = string(_error[$ "message"]);
			}
		}
		
		// create alert box to display error
		scr_createDialogBox(DIALOG_AICHAT_ERROR);
		aiErrorMsg = _errorMsg;
	}
}