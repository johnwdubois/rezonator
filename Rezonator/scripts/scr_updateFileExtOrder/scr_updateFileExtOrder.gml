//update the default file order string
var openedFile = argument[0];

var lastUsedExt = filename_ext(openedFile);

if(string_pos(lastUsedExt,global.fileExtentionOrder) > 11){
	
	if(lastUsedExt == ".csv"){
		global.fileExtentionOrder = "CSV file|*.csv|TXT file|*.txt|XML file|*.xml|JSON file|*.json";
	}
	else if(lastUsedExt == ".txt"){
		global.fileExtentionOrder = "TXT file|*.txt|XML file|*.xml|CSV file|*.csv|JSON file|*.json";
	}
	else if(lastUsedExt == ".xml"){
		global.fileExtentionOrder = "XML file|*.xml|TXT file|*.txt|CSV file|*.csv|JSON file|*.json";
	}
	else if(lastUsedExt == ".json"){
		global.fileExtentionOrder = "JSON file|*.json|TXT file|*.txt|XML file|*.xml|CSV file|*.csv";
	}
	
}