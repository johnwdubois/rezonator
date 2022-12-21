function FirebaseREST_asyncFunction_Firestore(event,obj,url,method_,header_json,body)
{
	var ins = instance_create_depth(0,0,0,obj);
	ins.event = event
	ins.url = url
	ins.method_ = method_
	ins.header_json = header_json
	ins.body = body
	//ins.from = id
	
	show_debug_message("event: " + string(event));
	show_debug_message("url: " + string(url));
	show_debug_message("method_: " + string(method_));
	show_debug_message("header_json: " + string(header_json));
	show_debug_message("body: " + string(body));
	
	ins.alarm[0] = 1
    
	return(ins)
}
