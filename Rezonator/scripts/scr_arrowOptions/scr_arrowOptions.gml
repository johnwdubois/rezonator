// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_arrowOptions(optionSelected){
	switch(optionSelected)
	{
		case "All":
			if(obj_chain.showTrackArrows and obj_chain.showRezArrows){
				obj_chain.showTrackArrows = false;
				obj_chain.showRezArrows = false;
				instance_destroy(obj_dropDown);
				break;
			}
			else if(!obj_chain.showTrackArrows and !obj_chain.showRezArrows){
				obj_chain.showTrackArrows = true;
				obj_chain.showRezArrows = true;	
				instance_destroy(obj_dropDown);
				break;
			}
			else{
				obj_chain.showTrackArrows = false;
				obj_chain.showRezArrows = false;
				instance_destroy(obj_dropDown);
				break;
			}
		
		case "Track Arrows":
			obj_chain.showTrackArrows = !obj_chain.showTrackArrows;
			instance_destroy(obj_dropDown);
			break;
		case "Rez Arrows":
			obj_chain.showRezArrows = !obj_chain.showRezArrows;
			instance_destroy(obj_dropDown);
			break;
	}
}