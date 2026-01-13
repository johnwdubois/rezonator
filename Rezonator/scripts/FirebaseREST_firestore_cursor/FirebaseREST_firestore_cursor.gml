function FirebaseREST_firestore_cursor(value,before) {
	// https://firebase.google.com/docs/firestore/reference/rest/v1/StructuredQuery#Cursor

	var map = ds_map_create()

	var list = ds_list_create()
	// ds_list_add(list,FirebaseREST_firestore_value(value))
	// alexluu: fix syntactic errors (Rezonator 1.4.3)
	// https://manual.gamemaker.io/monthly/en/#t=GameMaker_Language%2FGML_Overview%2FData_Types.htm
	ds_list_add(list,FirebaseREST_firestore_value(value, typeof(value)))	
	ds_list_mark_as_map(list,0)
	ds_map_add_list(map,"values",list)
	if(before)
		map[?"before"] = "true"
	else
		map[?"before"] = "false"
	return map
}
