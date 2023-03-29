function scr_splitSentence(str){
	
	// sentence delimiters
	var delims = ds_list_create();
	ds_list_add(delims, ". ", "! ", "? ", ", ");
	
	// delimiter exceptions
	var exceptions = ds_list_create();
	ds_list_add(exceptions, "Mr.", "Mrs.", "No.", "pp.", "St.", "no.", "Sr.", "Jr.", "Bros.", "etc.", "vs.");
	ds_list_add(exceptions, "esp.", "Fig.", "fig.", "Jan.", "Feb.", "Mar.", "Apr.", "Jun.", "Jul.", "Aug.", "Sep.", "Sept.", "Oct.", "Okt.");
	ds_list_add(exceptions, "Nov.", "Dec.", "Ph.D.", "PhD.", "al.", "cf.", "Inc.", "Ms.", "Gen.", "Sen.", "Prof.", "Dr.", "Corp.", "Co");	
	ds_list_add(exceptions, "Adj.", "Adm.", "Adv.", "Asst.", "Bart.", "Bldg.", "Brig.", "Bros.", "Capt.", "Cmdr.");
	ds_list_add(exceptions, "Col.", "Comdr.", "Con.", "Corp.", "Cpl.", "DR.", "Dr.", "Drs.", "Ens.", "Gen.", "Gov.");
	ds_list_add(exceptions, "Hon.", "Hr.", "Hosp.", "Insp.", "Lt.", "MM.", "MR.", "MRS.", "MS.", "Maj.", "Messrs.");
	ds_list_add(exceptions, "Mlle.", "Mme.", "Mr.", "Mrs.", "Ms.", "Msgr.", "Op.", "Ord.", "Pfc.", "Ph.", "Prof.");
	ds_list_add(exceptions, "Pvt.", "Rep.", "Reps.", "Res.", "Rev.", "Rt.", "Sen.", "Sens.", "Sfc.", "Sgt.", "Sr.");
	ds_list_add(exceptions, "St.", "Supt.", "Surg.");
	ds_list_add(exceptions, "v.", "i.e.", "rev.", "e.g.");
	
	// split on delimiters using exceptions
	var split = scr_splitStringMulti(str, delims, true, -1, exceptions);
	
	// don't need these anymore
	ds_list_destroy(delims);
	ds_list_destroy(exceptions);
	
	return split;

}