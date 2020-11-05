// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_preImportInitiate(){

	// preImport map will have a node for every type of import
	global.preImportMap = ds_map_create();
	var importTypeListSize = ds_list_size(importTypeList);
	for (var i = 0; i < importTypeListSize; i++) {
	
		var importTypeStr = ds_list_find_value(importTypeList, i);
		var currentImportTypeMap = ds_map_create();
	
		// figure out what example/description/links to put for each type of import
		var exampleList = ds_list_create();
		var descriptionList = ds_list_create();
		var linksList = ds_list_create();
		
		// Plain text
		if (importTypeStr == "Plain text") {
			// example
			ds_list_add(exampleList, "We shall overcome,","We shall overcome,","We shall overcome, some day.","","Oh, deep in my heart,","I do believe","We shall overcome, some day.","","We'll walk hand in hand,","We'll walk hand in hand,","We'll walk hand in hand, some day.","","Oh, deep in my heart,","","We shall live in peace,","We shall live in peace,","We shall live in peace, some day.","","Oh, deep in my heart,","","We shall all be free,","We shall all be free,","We shall all be free, some day.","","Oh, deep in my heart,","","We are not afraid,","We are not afraid,","We are not afraid, TODAY","","Oh, deep in my heart,","","We shall overcome,","We shall overcome,","We shall overcome, some day.","","Oh, deep in my heart,","I do believe","We shall overcome, some day.");
			// description
			ds_list_add(descriptionList, "• file extension: *.txt", "• songs, poems, etc.", "• short meaningful lines");
			// links
			ds_list_add(linksList, "https://rezonator.com", "https://genius.com");
		}
		
		// Tab delimied
		else if (importTypeStr == "Tab delimited") {
			// example
			ds_list_add(exampleList, "LENORE;        0.0     9.21    … So you don't need to go … borrow equipment from anybody,","LENORE;        9.21    9.52    to —","LENORE;        9.52    14.1    … to do the feet?","LENORE;        14.1    15.78    … [Do the hooves]?","LENORE;        56.94    57.79    [Did they train you-] —","LENORE;        58.34    59.29    [2Did] they train you that — ","LENORE;        59.29    60.06    #[3#]*","LENORE;        60.73    61.8    ‥ [So you have your] own equipment,","LENORE;        61.8      62.05    but,","LENORE;        131.39    131.59    yeah,","LENORE;        131.59    131.93    [I bet].","LENORE;        166.65    167.05    [mhm].","LENORE;        178.23    178.44    [really].","LENORE;        252.54    252.74    [(AHEM)]","LENORE;        254.12    254.64    [2(AHEM)]","LENORE;        265.43    265.73    [farrier]?","LENORE;        297.67    299.69    You sai[d you never] made the horseshoes,","LENORE;        299.69    299.9    but,","LENORE;        352.07    352.57    [So every] —","LENORE;        352.57    353.42    [2every] uh:,","LENORE;        353.42    354.53    horseshoe is made —","LENORE;        354.53    355.62    custom-made for the horse then?","LENORE;        400.94    401.15    [Right].","LENORE;        411.19    411.54    [(AHEM)]","LENORE;        421.78    422.69    [How many have you got].","LENORE;        424.04    424.29    twen[ty].","LENORE;        497.85    498.29    [#What].","LENORE;        516.71    519.309    [I thought] they used the (AHEM) the horsehooves in ‥ for gelatin,","LENORE;        519.309    520.059    That's not so?","LENORE;        636.97    637.34    [Right].","LENORE;        725.31    726.08    … [Yeah].","LENORE;        726.69    726.89    [2#]","LENORE;        737.16    737.44    [Yeah].","LENORE;        873.35    873.76    M[hm],","LENORE;        908.36    909.06    (TSK) Why:.");
			// description
			ds_list_add(descriptionList, "• file extension: *.txt", "• fields separated by tabs");			
			// links
			ds_list_add(linksList, "https://rezonator.com");
		}
		
		// IGT
		else if (importTypeStr == "Interlinear Glossed Text") {
			// example
			ds_list_add(exampleList, "\\ref","\\m","\\gl","\\tln","","1","(...) (H) Ee x-Ø-inw-il-anh ,","(...) (H) FOC CP-3.ABS-1.ERG-see-TV ,","(...) (H) What I saw was","","2","(.) x-Ø-aq'hn jun achenh ,","(.) CP-3.ABS-ascend one man ,","(.) a man climbed up, ","","3","(.) ch-u' chee' ,","(.) at-top tree ,","(.) in a tree,","","4","(...) (H) x-Ø-a-r: (...) ch'up-o' niky'aj péera-s .","(...) (H) CP-3.ABS-LAT-3.ERG (...) pick-DEP some pear-PL .","(...) (H) he went and (...) picked some pears.","","5","(...) Tik'ara' Ø-Ø-qaaj-uu:l ,","(...) then CP-3.ABS-descend-hither ,","(...) Then he came dow:n,","","6","(...) Ø-Ø-r-su' r-iij juu:n ,","(...) CP-3.ABS-3.ERG-wipe 3.ERG-back one ,","(...) he wiped one off,","","7","(...) (H) ii despwee:s ,","(...) (H) and then ,","(...) (H) and the:n,","","8","(...) (H) x-Ø-r-ya' qaj p l chikech ,","(...) (H) CP-3.ABS-3.ERG-put down at the basket ,","(...) (H) he put it in the basket,","","9","Ø-Ø-r-alsa-aj p l r:- (...) komo ber gabaacha .","CP-3.ABS-3.ERG-remove-TV at the 3.ERG (...) like see apron .","he removed it from his: (...) um like apron.","","10","(...) Despwees tik'ara' ,","(...) then then ,","(...) Then,","","11","(...) Ø-Ø-pee jun aj-laab' ,","(...) CP-3.ABS-come one DIM-boy ,","(...) a little boy came,","","12","(.) ch-ij bisikleeta ,","(.) at-back bicycle ,","(.) on a bicycle,","","13","(...) (H) xaq x-Ø-a-r-k'am-a' jun chkech peera .","(...) (H) just CP-3.ABS-LAT-3.ERG-take-DEP one basket pear .","(...) (H) he just came and took a basket of pears.");
			// description
			ds_list_add(descriptionList, "• file extension: *.txt", "• fields separated by lines", "• blocks of lines denote units");
			// links
			ds_list_add(linksList, "https://scription.digitallinguistics.io/");
		}
		
		// CSV
		else if (importTypeStr == "CSV") {
			// example
			ds_list_add(exampleList, "longId,discoId,unitId,tokenId,order,place,agent,transcript,transcript_LDC,text,text_LDC,kind,endNote,back,clitic,hostId,noSpaceAfter,unitStart,unitEnd,unitLen,wordStart,wordEnd,wordTimeExact,POS_Spacy,tag_Spacy,DepRel_Spacy,Head,Lemma,Norm,Prefix,Suffix,Is Alpha,overlap,Is Overlap,lag,Is Lag,pause,microPause,laugh,unclear,%word,_word,Pre-phonation,Pseudograph,turnId,turnOrder","0,1,1,1,1,,LENORE;,(...),...,(...),...,Pause,,,null,0,FALSE,0,9.21,15,0,6.82,TRUE,PUNCT,:,punct,LENORE:,...,...,.,...,False,,False,0,False,1,0,,,,,,,1,1","1,1,1,2,2,1,LENORE;,So,So,So,So,Word,,11,null,0,FALSE,0,9.21,15,6.82,7,TRUE,ADV,RB,advmod,need,so,so,S,So,True,,False,0,False,0,0,,,,,,,1,2","2,1,1,3,3,2,LENORE;,you,you,you,you,Word,,10,null,0,FALSE,0,9.21,15,7,7.14,TRUE,PRON,PRP,nsubj,need,-PRON-,you,y,you,True,,False,0,False,0,0,,,,,,,1,3","3,1,1,4,4,3,LENORE;,do,do,do,do,Word,,9,host,0,TRUE,0,9.21,15,7.14,7.25,TRUE,VERB,VBP,aux,need,do,do,d,do,True,,False,0,False,0,0,,,,,,,1,4","4,1,1,5,5,4,LENORE;,n't,n't,n't,n't,Word,,8,clitic,4,FALSE,0,9.21,15,7.14,7.25,TRUE,ADV,RB,neg,need,not,not,n,n't,False,,False,0,False,0,0,,,,,,,1,5","5,1,1,6,6,5,LENORE;,need,need,need,need,Word,,7,null,0,FALSE,0,9.21,15,7.25,7.39,TRUE,VERB,VB,acl,LENORE:,need,need,n,eed,True,,False,0,False,0,0,,,,,,,1,6","6,1,1,7,7,6,LENORE;,to,to,to,to,Word,,6,null,0,FALSE,0,9.21,15,7.39,7.45,TRUE,PART,TO,aux,go,to,to,t,to,True,,False,0,False,0,0,,,,,,,1,7","7,1,1,8,8,7,LENORE;,go,go,go,go,Word,,5,null,0,FALSE,0,9.21,15,7.45,7.65,TRUE,VERB,VB,xcomp,need,go,go,g,go,True,,False,0,False,0,0,,,,,,,1,8","8,1,1,9,9,,LENORE;,(...),...,(...),...,Pause,,,null,0,FALSE,0,9.21,15,7.65,8.02,TRUE,PUNCT,NFP,punct,need,...,...,.,...,False,,False,0,False,1,0,,,,,,,1,9","9,1,1,10,10,8,LENORE;,borrow,borrow,borrow,borrow,Word,,4,null,0,FALSE,0,9.21,15,8.02,8.26,TRUE,VERB,VB,conj,need,borrow,borrow,b,row,True,,False,0,False,0,0,,,,,,,1,10","10,1,1,11,11,9,LENORE;,equipment,equipment,equipment,equipment,Word,,3,null,0,FALSE,0,9.21,15,8.32,8.62,TRUE,NOUN,NN,dobj,borrow,equipment,equipment,e,ent,True,,False,0,False,0,0,,,,,,,1,11","11,1,1,12,12,10,LENORE;,from,from,from,from,Word,,2,null,0,FALSE,0,9.21,15,8.62,8.86,TRUE,ADP,IN,prep,borrow,from,from,f,rom,True,,False,0,False,0,0,,,,,,,1,12","12,1,1,13,13,11,LENORE;,anybody,anybody,anybody,anybody,Word,,1,null,0,TRUE,0,9.21,15,8.86,9.210023,TRUE,NOUN,NN,pobj,from,anybody,anybody,a,ody,True,,False,0,False,0,0,,,,,,,1,13","13,1,1,14,14,,LENORE;,\",\",\",\",\",\",\",\",EndNote,continuing,,null,0,TRUE,0,9.21,15,9.21,9.21,TRUE,PUNCT,\",\",punct,need,\",\",\",\",\",\",\",\",False,,False,0,False,0,0,,,,,,,1,14","14,1,1,15,15,,LENORE;,\"\",\"\",\"\",\"\",Newline,,,null,0,TRUE,0,9.21,15,9.21,9.21,TRUE,SPACE,_SP,,\",\",\"\",\"\",\"\",\"\",False,,False,0,False,0,0,,,,,,,1,15","15,1,2,16,1,1,LENORE;,to,to,to,to,Word,,1,null,0,FALSE,9.21,9.52,3,9.21,9.37,TRUE,ADP,IN,prep,9.52,to,to,t,to,True,,False,0,False,0,0,,,,,,,1,16","16,1,2,17,2,,LENORE;,—,--,—,--,EndNote,break,,null,0,TRUE,9.21,9.52,3,9.37,9.519978,TRUE,PUNCT,:,punct,need,--,-,-,--,False,,False,0,False,0,0,,,,,,,1,17","17,1,2,18,3,,LENORE;,\"\",\"\",\"\",\"\",Newline,,,null,0,TRUE,9.21,9.52,3,9.52,13.39,TRUE,SPACE,_SP,,--,\"\",\"\",\"\",\"\",False,,False,0,False,0,0,,,,,,,1,18","18,1,3,19,1,,LENORE;,(...),...,(...),...,Pause,,,null,0,FALSE,9.52,14.1,7,13.39,13.39,TRUE,PUNCT,:,punct,need,...,...,.,...,False,,False,0,False,1,0,,,,,,,1,19","19,1,3,20,2,1,LENORE;,to,to,to,to,Word,,4,null,0,FALSE,9.52,14.1,7,13.39,13.47,TRUE,PART,TO,aux,do,to,to,t,to,True,,False,0,False,0,0,,,,,,,1,20","20,1,3,21,3,2,LENORE;,do,do,do,do,Word,,3,null,0,FALSE,9.52,14.1,7,13.5,13.62,TRUE,VERB,VB,xcomp,need,do,do,d,do,True,,False,0,False,0,0,,,,,,,1,21","21,1,3,22,4,3,LENORE;,the,the,the,the,Word,,2,null,0,FALSE,9.52,14.1,7,13.62,13.72,TRUE,DET,DT,det,feet,the,the,t,the,True,,False,0,False,0,0,,,,,,,1,22");
			// description
			ds_list_add(descriptionList, "• file extension: *.csv", "• One word per line");
			// links
			ds_list_add(linksList, "https://rezonator.com");
		}
		
		// CoNLL-U
		else if (importTypeStr == "CoNLL-U") {
			// example
			ds_list_add(exampleList, "# newdoc id = GUM_interview_cyclone","# sent_id = GUM_interview_cyclone-1","# text = Wikinews interviews meteorological experts on Cyclone Phalin","# s_type=decl","1	Wikinews	Wikinews	PROPN	NNP	Number=Sing	2	subj	_	Entity=(organization-1)","2	interviews	interview	VERB	VBZ	Mood=IndNumber=SingPerson=3Tense=PresVerbForm=Fin	0	root	_	_","3	meteorological	meteorological	ADJ	JJ	Degree=Pos	4	mod	_	Entity=(person-2","4	experts	expert	NOUN	NNS	Number=Plur	2	compobj	_	Entity=person-2)","5	on	on	ADP	IN	_	2	udep	_	_","6	Cyclone	Cyclone	PROPN	NNP	Number=Sing	5	compobj	_	Entity=(event-3","7	Phalin	Phalin	PROPN	NNP	Number=Sing	6	flat	_	Entity=event-3)","","# sent_id = GUM_interview_cyclone-2","# text = File photo of interviewee David Titley.","# s_type=frag","1	File	File	NOUN	NN	Number=Sing	2	compound	_	Entity=(object-4","2	photo	photo	NOUN	NN	Number=Sing	0	root	_	_","3	of	of	ADP	IN	_	2	udep	_	_","4	interviewee	interviewee	NOUN	NN	Number=Sing	3	compobj	_	Entity=(person-5","5	David	David	PROPN	NNP	Number=Sing	4	flat	_	_","6	Titley	Titley	PROPN	NNP	Number=Sing	4	flat	_	Entity=object-4)person-5)SpaceAfter=No","7	.	.	PUNCT	.	_	2	punct	_	_","","# sent_id = GUM_interview_cyclone-3","# text = Image David Titley.","# s_type=frag","1	Image	image	NOUN	NN	Number=Sing	0	root	_	Entity=(object-4)SpaceAfter=No","2			PUNCT		_	3	punct	_	_","3	David	David	PROPN	NNP	Number=Sing	1	unk	_	Entity=(person-5","4	Titley	Titley	PROPN	NNP	Number=Sing	3	flat	_	Entity=person-5)SpaceAfter=No","5	.	.	PUNCT	.	_	1	punct	_	_");
			// description
			ds_list_add(descriptionList, "• file extension: *.txt");
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
}