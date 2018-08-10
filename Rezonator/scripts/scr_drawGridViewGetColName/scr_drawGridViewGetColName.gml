var grid = argument0;
var col = argument1;

var colName = "";

if (grid == obj_control.unitGrid)
{
	switch (col)
	{
		case obj_control.unitGrid_colUnitID:
			colName = "unitID";
			break;
		case obj_control.unitGrid_colUtteranceID:
			colName = "utteranceID";
			break;
		case obj_control.unitGrid_colWordIDList:
			colName = "wordIDList";
			break;
		case obj_control.unitGrid_colDiscoID:
			colName = "discoID";
			break;
		case obj_control.unitGrid_colpID:
			colName = "pID";
			break;
		case obj_control.unitGrid_colParticipantName:
			colName = "participantName";
			break;
		case obj_control.unitGrid_colUnitStart:
			colName = "unitStart";
			break;
		case obj_control.unitGrid_colUnitEnd:
			colName = "unitEnd";
			break;
		case obj_control.unitGrid_colParticipantColorIndex:
			colName = "participantColorIndex";
			break;
		default:
			break;
	}
}
else if (grid == obj_control.lineGrid or grid == obj_control.filterGrid)
{
	switch (col)
	{
		case obj_control.lineGrid_colDisplayRow:
			colName = "displayRow";
			break;
		case obj_control.lineGrid_colDiscoID:
			colName = "discoID";
			break;
		case obj_control.lineGrid_colUnitID:
			colName = "unitID";
			break;
		case obj_control.lineGrid_colLineNumberLabel:
			colName = "lineNumberLabel";
			break;
		case obj_control.lineGrid_colPixelY:
			colName = "pixelY";
			break;
		case obj_control.lineGrid_colLineState:
			colName = "lineState";
			break;
		case obj_control.lineGrid_colWordIDList:
			colName = "wordIDList";
			break;
		case obj_control.lineGrid_colAlignedWordID:
			colName = "alignedWordID";
			break;
		default:
			break;
	}
}
else if (grid == obj_control.wordGrid)
{
	switch (col)
	{
		case obj_control.wordGrid_colWordID:
			colName = "wordID";
			break;
		case obj_control.wordGrid_colUnitID:
			colName = "unitID";
			break;
		case obj_control.wordGrid_colWordSeq:
			colName = "wordSeq";
			break;
		case obj_control.wordGrid_colWordToken:
			colName = "wordToken";
			break;
		case obj_control.wordGrid_colWordTranscript:
			colName = "wordTranscript";
			break;
		default:
			break;
	}
}
else if (grid == obj_control.dynamicWordGrid)
{
	switch (col)
	{
		case obj_control.dynamicWordGrid_colWordID:
			colName = "wordID";
			break;
		case obj_control.dynamicWordGrid_colDisplayWordSeq:
			colName = "displayWordSeq";
			break;
		case obj_control.dynamicWordGrid_colDisplayCol:
			colName = "displayCol";
			break;
		case obj_control.dynamicWordGrid_colPixelX:
			colName = "pixelX";
			break;
		case obj_control.dynamicWordGrid_colWordState:
			colName = "wordState";
			break;
		case obj_control.dynamicWordGrid_colDisplayString:
			colName = "displayString";
			break;
		case obj_control.dynamicWordGrid_colInChainList:
			colName = "inChainList";
			break;
		default:
			break;
	}
}
else if (grid == obj_chain.linkGrid)
{
	switch (col)
	{
		case obj_chain.linkGrid_colTier:
			colName = "tier";
			break;
		case obj_chain.linkGrid_colChainID:
			colName = "chainID";
			break;
		case obj_chain.linkGrid_colLinkID:
			colName = "linkID";
			break;
		case obj_chain.linkGrid_colSource:
			colName = "source";
			break;
		case obj_chain.linkGrid_colGoal:
			colName = "goal";
			break;
		case obj_chain.linkGrid_colFocus:
			colName = "focus";
			break;
		default:
			break;
	}
}
else if (grid == obj_chain.rezChainGrid or grid == obj_chain.anaphChainGrid or grid == obj_chain.stackChainGrid)
{
	switch (col)
	{
		case obj_chain.chainGrid_colChainID:
			colName = "chainID";
			break;
		case obj_chain.chainGrid_colChainState:
			colName = "chainState";
			break;
		case obj_chain.chainGrid_colWordIDList:
			if (grid == obj_chain.stackChainGrid)
			{
				colName = "unitIDList";
			}
			else
			{
				colName = "wordList";
			}
			break;
		case obj_chain.chainGrid_colName:
			colName = "name";
			break;
		case obj_chain.chainGrid_colColor:
			colName = "color";
			break;
		case obj_chain.chainGrid_colInFilter:
			colName = "inFilter";
			break;
		default:
			break;
	}
}

return colName;