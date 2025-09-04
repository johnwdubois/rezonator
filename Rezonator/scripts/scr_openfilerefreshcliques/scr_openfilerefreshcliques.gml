function scr_openFileRefreshCliques() {
	
	show_debug_message("scr_openFileRefreshCliques, cliqueList size before: " + string(ds_list_size(obj_chain.cliqueList)));
	
	// when opening a rez file, we need to make sure that every rezchain is in a clique
	var cliqueList = obj_chain.cliqueList;
	var resonanceList = global.nodeMap[? "resonanceList"];
	var resonanceListSize = ds_list_size(resonanceList);
	for (var i = 0; i < resonanceListSize; i++) {
		
		var currentChain = resonanceList[| i];
		var currentChainSubMap = global.nodeMap[? currentChain];
		var currentChainInClique = currentChainSubMap[? "inClique"];
		
		// if this chain is not in a clique...
		if (!is_string(currentChainInClique) || currentChainInClique == "") {
			
			// spawn a new clique & refresh it
			currentChainInClique = scr_newClique(currentChain, undefined);
			currentChainSubMap[? "inClique"] = currentChainInClique;
			scr_refreshClique(currentChainInClique);
		}
		
		// make sure that this chain's clique is in cliquelist
		if (is_string(currentChainInClique) && currentChainInClique != "") {
			scr_addToListOnce(cliqueList, currentChainInClique);
		}
	}
	
	// let's also check each clique's chains to make sure they exist
	var _cliqueListSize = ds_list_size(cliqueList);
	for (var i = 0; i < _cliqueListSize; i++) {
		var _cliqueID = cliqueList[| i];
		var _cliqueSubMap = global.cliqueMap[? _cliqueID];
		if (!scr_isNumericAndExists(_cliqueSubMap, ds_type_map)) continue;
		
		// get current clique's chain list 
		var _cliqueChainList = _cliqueSubMap[? "chainList"];
		if (!scr_isNumericAndExists(_cliqueChainList, ds_type_list)) continue;
		
		// create an empty list of any chains that we will keep
		var _cliqueChainListFiltered = ds_list_create();
		
		var _cliqueChainListSize = ds_list_size(_cliqueChainList);
		for (var j = 0; j < _cliqueChainListSize; j++) {
			
			var _cliqueChainID = _cliqueChainList[| j];
			if (!is_string(_cliqueChainID) || _cliqueChainID == "") continue;
			
			var _cliqueChainSubMap = global.nodeMap[? _cliqueChainID];
			if (!scr_isNumericAndExists(_cliqueChainSubMap, ds_type_map)) continue;
			
			ds_list_add(_cliqueChainListFiltered, _cliqueChainID);
		}
		
		// destroy old list, put in filtered list
		ds_map_delete(_cliqueSubMap, "chainList");
		ds_list_destroy(_cliqueChainList);
		ds_map_add_list(_cliqueSubMap, "chainList", _cliqueChainListFiltered);
		
		// refresh unit list now that we have a refreshed chain list
		var _cliqueUnitList = _cliqueSubMap[? "unitList"];
		ds_list_clear(_cliqueUnitList);
		
		_cliqueChainList = _cliqueSubMap[? "chainList"];
		_cliqueChainListSize = ds_list_size(_cliqueChainList);
		for (var j = 0; j < _cliqueChainListSize; j++) {
			var _chainID = _cliqueChainList[| j];
			var _chainSubMap = global.nodeMap[? _chainID];
			var _chainSetIDList = _chainSubMap[? "setIDList"];
			var _chainSetIDListSize = ds_list_size(_chainSetIDList);
			
			for (var k = 0; k < _chainSetIDListSize; k++) {
				var _entryID = _chainSetIDList[| k];
				var _entrySubMap = global.nodeMap[? _entryID];
				var _tokenID = _entrySubMap[? "token"];
				var _tokenSubMap = global.nodeMap[? _tokenID];
				var _unitID = _tokenSubMap[? "unit"];
				scr_addToListOnce(_cliqueUnitList, _unitID);
			}
		}
	}
	
	// get rid of any empty cliques
	var _cliqueListFiltered = ds_list_create();
	for (var i = 0; i < _cliqueListSize; i++) {
		
		var _cliqueID = cliqueList[| i];
		var _cliqueSubMap = global.cliqueMap[? _cliqueID];
		if (!scr_isNumericAndExists(_cliqueSubMap, ds_type_map)) continue;
		
		// get current clique's chain list and unit list
		var _chainList = _cliqueSubMap[? "chainList"];
		var _unitList = _cliqueSubMap[? "unitList"];
		
		// skip this clique if its chain/unit list is invalid or empty
		if (!scr_isNumericAndExists(_chainList, ds_type_list) || !scr_isNumericAndExists(_unitList, ds_type_list)) continue;
		if (ds_list_size(_chainList) <= 0 || ds_list_size(_unitList) <= 0) continue;
		
		ds_list_add(_cliqueListFiltered, _cliqueID);
	}
	
	ds_list_destroy(cliqueList);
	obj_chain.cliqueList = _cliqueListFiltered;
	show_debug_message("scr_openFileRefreshCliques, cliqueList size after: " + string(ds_list_size(obj_chain.cliqueList)));

}