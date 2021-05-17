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
			ds_list_add(exampleList, "We shall overcome,","We shall overcome,","We shall overcome someday.","","Oh, deep in my heart I do believe","We shall overcome someday.","","We'll walk hand in hand,","we'll walk hand in hand,","We'll walk hand in hand someday.","","Oh, deep in my heart I do believe","We shall overcome someday.","","We shall live in peace,","we shall live in peace,","We shall live in peace someday.","","Oh, deep in my heart I do believe","We shall overcome someday.","","We shall brothers be,","we shall brothers be,","We shall brothers be someday.","","Oh, deep in my heart I do believe","We shall overcome someday.","","We shall organize,","we shall organize,","We shall organize today.","","Oh, deep in my heart I do believe","We shall overcome someday.","","The truth shall make us free,","truth shall make us free,","The truth shall make us free someday.","","Oh, deep in my heart I do believe","We shall overcome someday.","","We are not afraid,","we are not afraid,","We are not afraid today.","","Oh, deep in my heart I do believe,","We shall overcome someday.","","We shall overcome,","We shall overcome,","We shall overcome someday.","","Oh, deep in my heart I do believe","We shall overcome someday.");
			// description
			ds_list_add(descriptionList, "• file extension: *.txt", "• songs, poems, etc.", "• short meaningful lines");
			// links
			ds_list_add(linksList, "https://rezonator.com", "https://genius.com");
		}

		// Paragraph
		if (importTypeStr == global.importType_Paragraph) {
			
			// example
			ds_list_add(exampleList, "--","Wuthering Heights  ","by Emily Brontë ","---","","---","CHAPTER I ","---","","1801—I have just returned from a visit to my landlord—the solitary neighbour","that I shall be troubled with. This is certainly a beautiful country! In all England,","I do not believe that I could have fixed on a situation so completely removed from the","stir of society. A perfect misanthropist’s Heaven—and Mr. Heathcliff and I are such a","suitable pair to divide the desolation between us. A capital fellow! He little imagined","how my heart warmed towards him when I beheld his black eyes withdraw so suspiciously","under their brows, as I rode up, and when his fingers sheltered themselves, with a","jealous resolution, still further in his waistcoat, as I announced my name.  ","“Mr. Heathcliff?” I said.  ","A nod was the answer.  ","“Mr. Lockwood, your new tenant, sir. I do myself the honour of calling as soon","as possible after my arrival, to express the hope that I have not inconvenienced","you by my perseverance in soliciting the occupation of Thrushcross Grange: I heard","yesterday you had had some thoughts—”", "“Thrushcross Grange is my own, sir,” he interrupted, wincing. “I should not allow", "any one to inconvenience me, if I could hinder it—walk in!”");
			// description
			ds_list_add(descriptionList, "• file extension: *.txt", "• songs, poems, etc.", "• short meaningful lines");
			// links
			ds_list_add(linksList, "https://rezonator.com", "https://genius.com");
		}
		
		// Transcription
		else if (importTypeStr == global.importType_Transcription) {
			
			// example (contains a list of lists)
			var transcriptionCol1 = ds_list_create();
			var transcriptionCol2 = ds_list_create();
			ds_list_add(transcriptionCol1, "DARRYL;","","","PAMELA;","DARRYL;","PAMELA;","DARRYL;","","","PAMELA;","DARRYL;","","","","PAMELA;");	// example is "A Book About Death (sbc006: Santa Barbara Corpus of Spoken American English)"
			ds_list_add(transcriptionCol2, "I didn't like the book,","the way I —","the minute I looked at it.","(...) You didn't. ","No.","That's cause you,","(...) That's because I have my own ideas about it,","I guess.","That I'm (.) pretty comfortable with.","(...) Ah.","(...) I don't like re- -","I don't like reading books about what other people think about dying.","(...) And I,","(.) consider myself a real free [thinker when it comes to that] stuff.","[(TSK) (H) Well].");
			ds_list_add(exampleList, transcriptionCol1, transcriptionCol2);
			
			// description
			ds_list_add(descriptionList, "• file extension: *.txt", "• fields separated by tabs");			
			// links
			ds_list_add(linksList, "https://rezonator.com");
		}
		
		// Tab-delimited (Elan)
		else if (importTypeStr == global.importType_TabDelimited) {
			
			// example (contains a list of lists)
			var tabDelimCol1 = ds_list_create();
			var tabDelimCol2 = ds_list_create();
			var tabDelimCol3 = ds_list_create();
			var tabDelimCol4 = ds_list_create();
			ds_list_add(tabDelimCol1, "0.00","9.21","9.52","14.10","15.01","16.78","18.33","18.85","20.69","21.19","21.26","22.24","22.28","24.25","25.07","26.14","26.62","26.87","28.37","30.10");
			ds_list_add(tabDelimCol2, "9.21","9.52","14.10","15.78","16.78","18.32","18.85","20.69","21.19","21.74","22.24","23.23","24.25","25.07","26.14","26.62","26.87","28.37","30.10","32.36");
			ds_list_add(tabDelimCol3, "LENORE;","","","","LYNNE;","","","","DORIS;","","LYNNE;","DORIS;","LYNNE;","","","","","","","");
			ds_list_add(tabDelimCol4, "… So you don't need to go … borrow equipment from anybody,","to —","… to do the feet?","… [Do the hooves]?","[(H):] <YAWN> Well,","we're gonna have to find somewhere,","to get,","(Hx) … something (Hx) </YAWN>.","‥ So,","[~Mae-] —","[I'm gonna] (Hx) —","[2~Mae ~Lynne ##]","[2(H) We're not] gonna do the feet today,","I'm gonna wait till like,","early in the morning:,","‥ to do those,","cause y- —","I mean you get s:o ti:red.","(H) … n- you just,","… it takes (%) —");
			ds_list_add(exampleList, tabDelimCol1, tabDelimCol2, tabDelimCol3, tabDelimCol4);
			
			// description
			ds_list_add(descriptionList, "• file extension: *.txt", "• fields separated by tabs");			
			// links
			ds_list_add(linksList, "https://rezonator.com");
		}
		
		// IGT
		else if (importTypeStr == global.importType_IGT) {
			
			// example
			var igtCol1 = ds_list_create();
			var igtCol2 = ds_list_create();
			var igtCol3 = ds_list_create();
			var igtCol4 = ds_list_create();
			var igtCol5 = ds_list_create();
			ds_list_add(igtCol1, "waa","wa;","and","and","We never lack food to eat from low tide.",	"",		"hhaa'iisatlquu","hha:'i:satl-qu:","tide.gets.low-COND.3","when.tides.are.low","At low tides, we went digging clams.",	"",	"qwaatlaa","qwa:-tla;","thus-also","also","We also went out hunting harbor seals.",	"",	"'uushyuuya","'u:sh-yu:ya","some-at.the.time","sometimes","Sometimes we caught deer.","","waa,","wa;","and","and","We never went hungry.");
			ds_list_add(igtCol2, "wik\'aatat","wik-'a;ta-'at","not-lacking-SHIFT","we.never.lack", "", "", "ch'iitaa'at,","ch'i:t-(y)a;-'at","digging.clams-CONT-SHIFT","digging.clams", "", "", "'acyuu","'ac-yu;","go.out.hunting-done","be.out.hunting","", "","muwach","muwach","deer","deer","", "","wiktimnish","wik-tim-nish","not-??-IND.1PL","we.didn't");
			ds_list_add(igtCol3, "ha'ukw'at","ha'uk-'at","eat-SHIFT","we.eat","","","y'a'isi","y'a'isi","butter.clam","butter.clam","","","kuukuhhw'isa","ku:kuhhw'isa","hair.seal","hair.seal","","","'uu'ip'at","'u-'i:p-'at","it-get-SHIFT","we.got","","","kinhhak,","kinhh-ak","starve-DUR","starving");
			ds_list_add(igtCol4, "'u'iic'at","'u-'i;c-'at","it-eat-SHIFT","eating","","","'u'u'iihh\'at","DUP-'u-'i:hh-'at","???-it-collecting-SHIFT","collect.it","","","","","","","","","","","","","","","kinhhak","kinhh-ak","starve-DUR","starving");
			ds_list_add(igtCol5, "hach\'inshtup","hach\'inshtup","food.from.deep.water","food.from.deep.water");
			ds_list_add(exampleList, igtCol1, igtCol2, igtCol3, igtCol4, igtCol5);
			
			//ds_list_add(exampleList, "\\ref","\\m","\\gl","\\tln","","1","(...) (H) Ee x-Ø-inw-il-anh ,","(...) (H) FOC CP-3.ABS-1.ERG-see-TV ,","(...) (H) What I saw was","","2","(.) x-Ø-aq'hn jun achenh ,","(.) CP-3.ABS-ascend one man ,","(.) a man climbed up, ","","3","(.) ch-u' chee' ,","(.) at-top tree ,","(.) in a tree,","","4","(...) (H) x-Ø-a-r: (...) ch'up-o' niky'aj péera-s .","(...) (H) CP-3.ABS-LAT-3.ERG (...) pick-DEP some pear-PL .","(...) (H) he went and (...) picked some pears.","","5","(...) Tik'ara' Ø-Ø-qaaj-uu:l ,","(...) then CP-3.ABS-descend-hither ,","(...) Then he came dow:n,","","6","(...) Ø-Ø-r-su' r-iij juu:n ,","(...) CP-3.ABS-3.ERG-wipe 3.ERG-back one ,","(...) he wiped one off,","","7","(...) (H) ii despwee:s ,","(...) (H) and then ,","(...) (H) and the:n,","","8","(...) (H) x-Ø-r-ya' qaj p l chikech ,","(...) (H) CP-3.ABS-3.ERG-put down at the basket ,","(...) (H) he put it in the basket,","","9","Ø-Ø-r-alsa-aj p l r:- (...) komo ber gabaacha .","CP-3.ABS-3.ERG-remove-TV at the 3.ERG (...) like see apron .","he removed it from his: (...) um like apron.","","10","(...) Despwees tik'ara' ,","(...) then then ,","(...) Then,","","11","(...) Ø-Ø-pee jun aj-laab' ,","(...) CP-3.ABS-come one DIM-boy ,","(...) a little boy came,","","12","(.) ch-ij bisikleeta ,","(.) at-back bicycle ,","(.) on a bicycle,","","13","(...) (H) xaq x-Ø-a-r-k'am-a' jun chkech peera .","(...) (H) just CP-3.ABS-LAT-3.ERG-take-DEP one basket pear .","(...) (H) he just came and took a basket of pears.");
			// description
			ds_list_add(descriptionList, "• one unit per block","• blocks have 2+ lines","• blocks separated by a blank line","• split morphs on whitespace & hyphen","• file type: plain text (.txt)","• example: Nuuchanulth");
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
			ds_list_add(conlluCol1, "ID","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26");
			ds_list_add(conlluCol2, "FORM","Cyclone","Phailin","has","winds","that","have","been","measured","at","200","km","/","h",",","as","it","surges","over","land","will","it","begin","to","lose","strength","?");
			ds_list_add(conlluCol3, "LEMMA","Cyclone","Phailin","have","wind","that","have","be","measure","at","200","km","/","h",",","as","it","surge","over","land","will","it","begin","to","lose","strength","?");
			ds_list_add(conlluCol4, "UPOSTAG","PROPN","PROPN","VERB","NOUN","PRON","AUX","AUX","VERB","ADP","NUM","NOUN","SYM","NOUN","PUNCT","SCONJ","PRON","VERB","ADP","NOUN","AUX","PRON","VERB","PART","VERB","NOUN","PUNCT");
			ds_list_add(conlluCol5, "XPOSTAG","NNP","NNP","VBZ","NNS","WDT","VBP","VBN","VBN","IN","CD","NNS","SYM","NN",",","IN","PRP","VBZ","IN","NN","MD","PRP","VB","TO","VB","NN",".");
			ds_list_add(conlluCol6, "FEATS","Number=Sing","Number=Sing","Mood=Ind|Number=Sing|Person=3|Tense=Pres|VerbForm=Fin","Number=Plur","PronType=Rel","Mood=Ind|Tense=Pres|VerbForm=Fin","Tense=Past|VerbForm=Part","Tense=Past|VerbForm=Part","_","NumType=Card","Number=Plur","_","Number=Sing","_","_","Case=Nom|Gender=Neut|Number=Sing|Person=3|PronType=Prs","Mood=Ind|Number=Sing|Person=3|Tense=Pres|VerbForm=Fin","_","Number=Sing","VerbForm=Fin","Case=Nom|Gender=Neut|Number=Sing|Person=3|PronType=Prs","VerbForm=Inf","_","VerbForm=Inf","Number=Sing","_");
			ds_list_add(conlluCol7, "HEAD","3","1","0","3","8","8","8","4","11","11","8","13","8","17","17","17","3","19","17","22","22","17","24","22","24","3");
			ds_list_add(conlluCol8, "DEPREL","nsubj","flat","root","obj","nsubj:pass","aux","aux:pass","acl:relcl","case","nummod","obl","dep","ccomp","punct","mark","nsubj","advcl","case","obl","aux","nsubj","advcl","mark","xcomp","obj","punct");
			ds_list_add(conlluCol9, "DEPS","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_");
			ds_list_add(conlluCol10, "MISC","Discourse=background:5->8|Entity=(event-3","Entity=event-3)","_","Entity=(abstract-6","Discourse=elaboration:6->5","_","_","_","_","Entity=(abstract-7","_","_","Entity=abstract-6)abstract-7)|SpaceAfter=No","_","Discourse=circumstance:7->8","Entity=(event-3)","_","_","Entity=(place-8)","Discourse=question:8->9","Entity=(event-3)","_","_","_","Entity=(abstract-9)|SpaceAfter=No","_");
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
	var transcriptionWidthList = ds_list_create();
	ds_list_add(transcriptionWidthList, 25, 75);
	ds_map_add_list(global.preImportMap, "transcriptionWidthList", transcriptionWidthList);
	var tabDelimWidthList = ds_list_create();
	ds_list_add(tabDelimWidthList, 12, 12, 18, 58);
	ds_map_add_list(global.preImportMap, "tabDelimWidthList", tabDelimWidthList);
	var csvWidthList = ds_list_create();
	ds_list_add(csvWidthList, 14, 14, 14, 14, 14, 14, 14);
	ds_map_add_list(global.preImportMap, "csvWidthList", csvWidthList);
	var conlluWidthList = ds_list_create();
	ds_list_add(conlluWidthList, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
	ds_map_add_list(global.preImportMap, "conlluWidthList", conlluWidthList);
	var igtWidthList = ds_list_create();
	ds_list_add(igtWidthList, 20, 20, 20, 20, 20);
	ds_map_add_list(global.preImportMap, "igtWidthList", igtWidthList);
	
	
	
	
	
	// create a hard-coded grid for the preImportScreen, to explain the info for each import type
	preImportInfoGridWidth = 2;
	preImportInfoGrid_colChoose = 0;
	preImportInfoGrid_colDataType = 1;
	preImportInfoGrid = ds_grid_create(preImportInfoGridWidth, ds_list_size(global.importTypeList));
	
	// fill the preImportInfoGrid
	for (var i = 0; i < importTypeListSize; i++) {
		
		var currentImportType = ds_list_find_value(global.importTypeList, i);
		var currentDataType = currentImportType;

		ds_grid_set(preImportInfoGrid, preImportInfoGrid_colDataType, i, currentDataType);

	}
}