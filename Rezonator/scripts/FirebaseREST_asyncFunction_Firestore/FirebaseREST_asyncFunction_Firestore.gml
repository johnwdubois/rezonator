function FirebaseREST_asyncFunction_Firestore(_event, _obj, _url, _method_, _header_json, _body)
{
	var ins = instance_create_depth(0,0,0,_obj);
	ins.event = _event
	ins.url = _url
	ins.method_ = _method_
	ins.header_json = _header_json
	ins.body = _body
	//ins.from = id
	
	ins.alarm[0] = 1
    
	return(ins)
}
