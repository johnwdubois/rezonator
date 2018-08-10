functionChainList = 0;
functionChainContents = 1;
functionFilter = 2;

functionChainList_tabRezBrush = 0;
functionChainList_tabAnaphBrush = 1;
functionChainList_tabStackBrush = 2;
functionChainList_currentTab = functionChainList_tabRezBrush;
functionChainList_maxScrollRange = 5;
functionChainList_tabName[0] = "Rez";
functionChainList_tabName[1] = "Anaph";
functionChainList_tabName[2] = "Stack";
functionChainList_scrollRangeMin[0] = 0;
functionChainList_scrollRangeMax[0] = functionChainList_maxScrollRange;
functionChainList_scrollRangeMin[1] = 0;
functionChainList_scrollRangeMax[1] = functionChainList_maxScrollRange;
functionChainList_scrollRangeMin[2] = 0;
functionChainList_scrollRangeMax[2] = functionChainList_maxScrollRange;

functionChainContents_IDList = 0;
functionChainContents_infoCol[0] = 0;
functionChainContents_infoCol[1] = 1;
functionChainContents_infoCol[2] = 2;
functionChainContents_maxScrollRange = 8;
functionChainContents_scrollRangeMin[0] = 0;
functionChainContents_scrollRangeMax[0] = functionChainContents_maxScrollRange;

for (var i = 0; i < 3; i++)
{
	functionFilter_peek[i] = false;
	functionFilter_peekList[i] = ds_list_create();
}



//windowWidth = 300;
//windowHeight = 150;