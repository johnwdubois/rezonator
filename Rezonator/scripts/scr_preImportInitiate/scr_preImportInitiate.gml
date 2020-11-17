// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_preImportInitiate(){

	// preImport map will have a node for every type of import
	global.preImportMap = ds_map_create();
	var importTypeListSize = ds_list_size(global.importTypeList);
	for (var i = 0; i < importTypeListSize; i++) {
	
		var importTypeStr = ds_list_find_value(global.importTypeList, i);
		var currentImportTypeMap = ds_map_create();
	
		// figure out what example/description/links to put for each type of import
		var exampleList = ds_list_create();
		var descriptionList = ds_list_create();
		var linksList = ds_list_create();
		
		// Plain text
		if (importTypeStr == global.importType_PlainText) {
			// example
			ds_list_add(exampleList, "---","Danny Boy","---","Oh, Danny boy, the pipes, the pipes are calling","From glen to glen, and down the mountain side.","The summer's gone, and all the roses falling,","It's you, It's you must go and I must bide.","But come ye back when summer's in the meadow,","Or when the valley's hushed and white with snow,","It's I'll be here in sunshine or in shadow,—","Oh, Danny boy, O Danny boy, I love you so!","","But when ye come, and all the flowers are dying,","If I am dead, as dead I well may be,","Ye'll come and find the place where I am lying,","And kneel and say an Avè there for me.","And I shall hear, though soft you tread above me,","And all my grave will warmer, sweeter be,","For you will bend and tell me that you love me,","And I shall sleep in peace until you come to me!");
			// description
			ds_list_add(descriptionList, "• file extension: *.txt", "• songs, poems, etc.", "• short meaningful lines");
			// links
			ds_list_add(linksList, "https://rezonator.com", "https://genius.com");
		}
		
		// Tab delimied
		else if (importTypeStr == global.importType_TabDelimited) {
			// example (contains a list of lists)
			var tabDelimCol1 = ds_list_create();
			var tabDelimCol2 = ds_list_create();
			var tabDelimCol3 = ds_list_create();
			var tabDelimCol4 = ds_list_create();
			ds_list_add(tabDelimCol1, "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;", "LENORE;");
			ds_list_add(tabDelimCol2, "0.0", "9.21", "9.52", "14.1", "56.94", "58.34", "59.29", "60.73", "61.8", "131.39", "131.59", "166.65", "178.23", "252.54", "254.12", "265.43", "297.67", "299.69", "352.07", "352.57");
			ds_list_add(tabDelimCol3, "9.21", "9.52", "14.1", "15.78", "57.79", "59.29", "60.06", "61.8", "62.05", "131.59", "131.93", "167.05", "178.44", "252.74", "254.64", "265.73", "299.69", "299.9", "352.57", "353.42");
			ds_list_add(tabDelimCol4, "… So you don't need to go … borrow equipment from anybody,","to —","… to do the feet?","… [Do the hooves]?","[Did they train you-] —","[2Did] they train you that — ","#[3#]*","‥ [So you have your] own equipment,","but,","yeah,","[I bet].","[mhm].","[really].","[(AHEM)]","[2(AHEM)]","[farrier]?","You sai[d you never] made the horseshoes,","but,","[So every] —","[2every] uh:,");
			ds_list_add(exampleList, tabDelimCol1, tabDelimCol2, tabDelimCol3, tabDelimCol4);
			
			// description
			ds_list_add(descriptionList, "• file extension: *.txt", "• fields separated by tabs");			
			// links
			ds_list_add(linksList, "https://rezonator.com");
		}
		
		// IGT
		else if (importTypeStr == global.importType_IGT) {
			// example
			ds_list_add(exampleList, "\\ref","\\m","\\gl","\\tln","","1","(...) (H) Ee x-Ø-inw-il-anh ,","(...) (H) FOC CP-3.ABS-1.ERG-see-TV ,","(...) (H) What I saw was","","2","(.) x-Ø-aq'hn jun achenh ,","(.) CP-3.ABS-ascend one man ,","(.) a man climbed up, ","","3","(.) ch-u' chee' ,","(.) at-top tree ,","(.) in a tree,","","4","(...) (H) x-Ø-a-r: (...) ch'up-o' niky'aj péera-s .","(...) (H) CP-3.ABS-LAT-3.ERG (...) pick-DEP some pear-PL .","(...) (H) he went and (...) picked some pears.","","5","(...) Tik'ara' Ø-Ø-qaaj-uu:l ,","(...) then CP-3.ABS-descend-hither ,","(...) Then he came dow:n,","","6","(...) Ø-Ø-r-su' r-iij juu:n ,","(...) CP-3.ABS-3.ERG-wipe 3.ERG-back one ,","(...) he wiped one off,","","7","(...) (H) ii despwee:s ,","(...) (H) and then ,","(...) (H) and the:n,","","8","(...) (H) x-Ø-r-ya' qaj p l chikech ,","(...) (H) CP-3.ABS-3.ERG-put down at the basket ,","(...) (H) he put it in the basket,","","9","Ø-Ø-r-alsa-aj p l r:- (...) komo ber gabaacha .","CP-3.ABS-3.ERG-remove-TV at the 3.ERG (...) like see apron .","he removed it from his: (...) um like apron.","","10","(...) Despwees tik'ara' ,","(...) then then ,","(...) Then,","","11","(...) Ø-Ø-pee jun aj-laab' ,","(...) CP-3.ABS-come one DIM-boy ,","(...) a little boy came,","","12","(.) ch-ij bisikleeta ,","(.) at-back bicycle ,","(.) on a bicycle,","","13","(...) (H) xaq x-Ø-a-r-k'am-a' jun chkech peera .","(...) (H) just CP-3.ABS-LAT-3.ERG-take-DEP one basket pear .","(...) (H) he just came and took a basket of pears.");
			// description
			ds_list_add(descriptionList, "• file extension: *.txt", "• fields separated by lines", "• blocks of lines denote units");
			// links
			ds_list_add(linksList, "https://scription.digitallinguistics.io/");
		}
		
		// CSV
		else if (importTypeStr == global.importType_CSV) {
			// example (contains a list of lists)
			var csvCol1 = ds_list_create();
			var csvCol2 = ds_list_create();
			var csvCol3 = ds_list_create();
			var csvCol4 = ds_list_create();
			var csvCol5 = ds_list_create();
			var csvCol6 = ds_list_create();
			var csvCol7 = ds_list_create();
			ds_list_add(csvCol1, "longId","0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18");
			ds_list_add(csvCol2, "discoId","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1");
			ds_list_add(csvCol3, "unitId","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","2","2","2","3");
			ds_list_add(csvCol4, "tokenId","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19");
			ds_list_add(csvCol5, "agent","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;","LENORE;");
			ds_list_add(csvCol6, "text_LDC","...","So","you","do","n't","need","to","go","...","borrow","equipment","from","anybody",",","","to","--","","...");
			ds_list_add(csvCol7, "DepRel_Spacy","punct","advmod","nsubj","aux","neg","acl","aux","xcomp","punct","conj","dobj","prep","pobj","punct","","prep","punct","","punct");
			ds_list_add(exampleList, csvCol1, csvCol2, csvCol3, csvCol4, csvCol5, csvCol6, csvCol7);
			
			// description
			ds_list_add(descriptionList, "• file extension: *.csv", "• one word per line", "• unit delimiting field is required");
			// links
			ds_list_add(linksList, "https://rezonator.com");
		}
		
		// CoNLL-U
		else if (importTypeStr == global.importType_CoNLLU) {
			// example
			var conlluCol1 = ds_list_create();
			var conlluCol2 = ds_list_create();
			var conlluCol3 = ds_list_create();
			var conlluCol4 = ds_list_create();
			var conlluCol5 = ds_list_create();
			var conlluCol6 = ds_list_create();
			var conlluCol7 = ds_list_create();
			var conlluCol8 = ds_list_create();
			var conlluCol9 = ds_list_create();
			var conlluCol10 = ds_list_create();
			ds_list_add(conlluCol1, "1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27");
			ds_list_add(conlluCol2, "Once","a","storm","moves","over","any","appreciably","sized","piece","of","land",",","the","moisture","source","is","removed","and","the","storm","begins","to","dissipate",".");
			ds_list_add(conlluCol3, "once","a","storm","move","over","any","appreciably","size","piece","of","land",",","the","moisture","source","be","remove","and","the","storm","begin","to","dissipate",".");
			ds_list_add(conlluCol4, "ADV","DET","NOUN","VERB","ADP","DET","ADV","VERB","NOUN","ADP","NOUN","PUNCT","DET","NOUN","NOUN","AUX","VERB","CCONJ","DET","NOUN","VERB","PART","VERB","PUNCT");
			ds_list_add(conlluCol5, "RB","DT","NN","VBZ","IN","DT","RB","VBN","NN","IN","NN",",","DT","NN","NN","VBZ","VBN","CC","DT","NN","VBZ","TO","VB",".");
			ds_list_add(conlluCol6, "NumType=Mult","Definite=IndPronType=Art","Number=Sing","Mood=IndNumber=SingPerson=3Tense=PresVerbForm=Fin","_","_","_","Tense=PastVerbForm=Part","Number=Sing","_","Number=Sing","_","Definite=DefPronType=Art","Number=Sing","Number=Sing","Mood=IndNumber=SingPerson=3Tense=PresVerbForm=Fin","Tense=PastVerbForm=Part","_","Definite=DefPronType=Art","Number=Sing","Mood=IndNumber=SingPerson=3Tense=PresVerbForm=Fin","_","VerbForm=Inf","_");
			ds_list_add(conlluCol7, "4","3","4","16","4","9","8","9","5","9","10","4","15","15","16","0","16","21","20","21","16","21","22","16");
			ds_list_add(conlluCol8, "mod","det","subj","mod","udep","det","mod","mod","compobj","udep","compobj","punct","det","compound","subj@pass","root","compaux@pass","cc","det","subj","conj","comppred","compobj","punct");
			ds_list_add(conlluCol9, "_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_");
			ds_list_add(conlluCol10, "_","Entity=(event-12","Entity=event-12)","_","_","Entity=(place-13","_","_","_","_","Entity=place-13)SpaceAfter=No","_","Entity=(abstract-14","Entity=(abstract-15)","Entity=abstract-14)","_","_","_","Entity=(event-12","Entity=event-12)","_","_","SpaceAfter=No","_");			
			ds_list_add(exampleList, conlluCol1, conlluCol2, conlluCol3, conlluCol4, conlluCol5, conlluCol6, conlluCol7, conlluCol8, conlluCol9, conlluCol10);
			
			// description
			ds_list_add(descriptionList, "• file extension: *.txt", "• unit fields denoted with # character", "• token fields delimited by tabs");
			// links
			ds_list_add(linksList, "https://universaldependencies.org/format.html");
		}
	
		// add example/description/links to currentImportTypeMap
		ds_map_add_list(currentImportTypeMap, "example", exampleList);
		ds_map_add_list(currentImportTypeMap, "description", descriptionList);
		ds_map_add_list(currentImportTypeMap, "links", linksList);
	
		// add currentImportTypeMap to preImportMap
		ds_map_add_map(global.preImportMap, importTypeStr, currentImportTypeMap);
	}
	
	
	
	// add example column width lists to preImportMap
	// these lists will tell Rezonator how wide to draw each column in the "Example" window on preImportScreen
	var tabDelimWidthList = ds_list_create();
	ds_list_add(tabDelimWidthList, 20, 15, 15, 50);
	ds_map_add_list(global.preImportMap, "tabDelimWidthList", tabDelimWidthList);
	var csvWidthList = ds_list_create();
	ds_list_add(csvWidthList, 14, 14, 14, 14, 14, 14, 14);
	ds_map_add_list(global.preImportMap, "csvWidthList", csvWidthList);
	var conlluWidthList = ds_list_create();
	ds_list_add(conlluWidthList, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
	ds_map_add_list(global.preImportMap, "conlluWidthList", conlluWidthList);
}