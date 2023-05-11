function scr_saveREZMini(stackingID = "Default"){
	
	// get node list
	var nodeList = global.nodeMap[? "nodeList"];
	if (!scr_isNumericAndExists(nodeList, ds_type_list)) {
		show_debug_message("scr_saveREZMini, nodeList does not exist");
		exit;
	}
	
	var root = {};
	var fullUnitArr = [];
	
	var nodeListSize = ds_list_size(nodeList);
	for (var i = 0; i < nodeListSize; i++) {
		
		// get current node, make sure it exists
		var _nodeID = nodeList[| i];
		var _nodeSubMap = global.nodeMap[? _nodeID];
		if (!scr_isNumericAndExists(_nodeSubMap, ds_type_map)) continue;
		
		// check type of node
		var _nodeType = _nodeSubMap[? "type"];
		if (_nodeType == "unit") {
			
			// create new struct to be saved
			var _unitStruct = {};
			
			// get participant from unit, set value in struct
			var _participant = "";
			var _tagMap = _nodeSubMap[? "tagMap"];
			if (scr_isNumericAndExists(_tagMap, ds_type_map)) _participant = _tagMap[? global.participantField];
			_unitStruct[$ "participant"] = _participant;
			
			var _tokenArr = [];
			var _entryList = _nodeSubMap[? "entryList"];
			if (scr_isNumericAndExists(_entryList, ds_type_list)) {
				var _entryListSize = ds_list_size(_entryList);
				for (var j = 0; j < _entryListSize; j++) {
					
					// get current entry ID and submap
					var _entryID = _entryList[| j];
					var _entrySubMap = global.nodeMap[? _entryID];
					if (!scr_isNumericAndExists(_entrySubMap, ds_type_map)) continue;
					
					// get current token ID and submap
					var _tokenID = _entrySubMap[? "token"];
					var _tokenSubMap = global.nodeMap[? _tokenID];
					if (!scr_isNumericAndExists(_tokenSubMap, ds_type_map)) continue;
					
					// get token text and kind
					var _tokenTagMap = _tokenSubMap[? "tagMap"];
					if (!scr_isNumericAndExists(_tokenTagMap, ds_type_map)) continue;
					var _tokenText = _tokenTagMap[? "text"];
					var _tokenKind = _tokenTagMap[? "kind"];
					
					// create token struct, add it to token array
					var _tokenStruct = {
						id : _tokenID,
						text : _tokenText,
						kind : _tokenKind
					};
					array_push(_tokenArr, _tokenStruct);
				}
			}
			
			// save token array to unit struct
			_unitStruct[$ "tokens"] = _tokenArr;
			
			// save unit struct to root struct
			root[$ _nodeID] = _unitStruct;
			
			// add unit ID to unit array
			array_push(fullUnitArr, _nodeID);
		}
	}
	
	// save unit array to root struct
	root[$ "unitList"] = fullUnitArr;
	
	// save json
	//var json = json_stringify(root, true);
	//var filename = get_save_filename_ext("JSON file|*.json", "", program_directory, "Save JSON");
	//scr_saveFileBuffer(filename, json);
	//show_debug_message($"scr_saveREZMini, json: {json}");
	
	global.firebaseProjectID = "exampleexperiment-e2a4d";
	var collectionID = "sbc002";
	
	// collect every unitID that is within the given stacking
	var subUnitArr = [];
	if (is_string(stackingID) && stackingID != "") {
		
		// get current stack
		var stackList = global.nodeMap[? "stackList"];
		var stackListSize = ds_list_size(stackList);
		for (var i = 0; i < stackListSize; i++) {
			var _stackID = stackList[| i];
			var _stackSubMap = global.nodeMap[? _stackID];
			if (!scr_isNumericAndExists(_stackSubMap, ds_type_map)) continue;
			
			// check if this stack is part of the desired stacking
			var _stacking = _stackSubMap[? "stacking"];
			if (_stacking == stackingID) {
				var _vizSetIDList = _stackSubMap[? "vizSetIDList"];
				if (!scr_isNumericAndExists(_vizSetIDList, ds_type_list)) continue;
				var _vizSetIDListSize = ds_list_size(_vizSetIDList);
				
				// collect every unit within the stack into subUnitArr and _setUnitArr
				var _setUnitArr = [];
				for (var j = 0; j < _vizSetIDListSize; j++) {
					var _entryID = _vizSetIDList[| j];
					var _entrySubMap = global.nodeMap[? _entryID];
					if (!scr_isNumericAndExists(_entrySubMap, ds_type_map)) continue;
					var _unitID = _entrySubMap[? "unit"];
					if (is_string(_unitID) && _unitID != "") {
						array_push(subUnitArr, _unitID);
						array_push(_setUnitArr, _unitID);
					}
				}
				
				// send json to Firebase for this set of units
				var _json = json_stringify({units: _setUnitArr});
				var _setID = scr_generateRandomID();
				FirebaseFirestore(collectionID + "/windows/sets/" + _setID).Set(_json);
			}
		}
	}
	
	var unitArrLen = array_length(subUnitArr);
	if (unitArrLen >= 1) {
		
		// send root doc to firebase
		FirebaseFirestore(collectionID + "/doc/units/unitList").Set(json_stringify(fullUnitArr));
	
		// send unit docs to firebase
		for (var i = 0; i < unitArrLen; i++) {
			var _unitID = subUnitArr[i];
			var _unitStruct = root[$ _unitID];
			var _json = json_stringify(_unitStruct);
			show_debug_message($"_unitID: {_unitID}, _json: {_json}");
			FirebaseFirestore(collectionID + "/doc/units/" + string(_unitID)).Set(_json);
		}
	}
	
}