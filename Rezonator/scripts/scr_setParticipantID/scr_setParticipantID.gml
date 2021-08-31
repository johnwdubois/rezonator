// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setParticipantID(unitID){
	
	// make sure this function is called after the tags are set for each unit!
	
	var participantID = "0";
	var unitSubMap = global.nodeMap[? unitID];
	if (scr_isNumericAndExists(unitSubMap, ds_type_map)) {
		
		var unitTagMap = unitSubMap[? "tagMap"];
		if (scr_isNumericAndExists(unitTagMap, ds_type_map)) {
			if (global.participantField != "" && ds_map_exists(unitTagMap, global.participantField)) {
				var participantTag = unitTagMap[? global.participantField];
					
				// now that we have this unit's tag for the participant field, let's check if we've encountered this tag before
				if (ds_map_exists(global.participantMap, participantTag)) {
					// in this case, we have encountered this participant tag before, so we'll take whatever ID it was assigned to
					participantID = global.participantMap[? participantTag];
				}
				else {
					// in this case, we have not encountered this participant tag before, so we'll create a new participant ID
					participantID = string(ds_map_size(global.participantMap));
					global.participantMap[? participantTag] = participantID;
				}
			}
		}
			
		// assign the participant ID to the new unit
		unitSubMap[? "participantID"] = participantID;
	}
	
}