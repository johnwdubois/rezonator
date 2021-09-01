// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_arrowOptions(optionSelected){
	switch(optionSelected)
	{
		case "menu_all":
			if(obj_chain.showTrackArrows and obj_chain.showRezArrows){
				obj_chain.showTrackArrows = false;
				obj_chain.showRezArrows = false;
				break;
			}
			else if(!obj_chain.showTrackArrows and !obj_chain.showRezArrows){
				obj_chain.showTrackArrows = true;
				obj_chain.showRezArrows = true;	
				break;
			}
			else{
				obj_chain.showTrackArrows = false;
				obj_chain.showRezArrows = false;
				break;
			}
		
		case "menu_track-arrows":
			obj_chain.showTrackArrows = !obj_chain.showTrackArrows;
			break;
		case "menu_rez-arrows":
			obj_chain.showRezArrows = !obj_chain.showRezArrows;
			break;
	}
}