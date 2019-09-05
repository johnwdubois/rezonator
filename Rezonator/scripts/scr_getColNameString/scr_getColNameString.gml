var grid = argument0;
var col = argument1;

var colName = "";

if (grid == obj_control.unitGrid) {
	switch (col) {
		case obj_control.unitGrid_colUnitID:
			colName = "unitID";
			break;
		case obj_control.unitGrid_colUtteranceID:
			colName = "uID";
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
		case obj_control.unitGrid_colParticipantColor:
			colName = "participantColor";
			break;
		case obj_control.unitGrid_colAudioFile:
			colName = "audioFile";
			break;
		default:
			break;
	}
}
else if (grid == obj_control.lineGrid or grid == obj_control.filterGrid or grid == obj_control.searchGrid) {
	switch (col) {
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
			colName = "uID";
			break;
		case obj_control.lineGrid_colPixelY:
			colName = "pixelY";
			break;
		case obj_control.lineGrid_colLineState:
			colName = "lineState";
			break;
		case obj_control.lineGrid_colWordIDList:
			if (grid == obj_control.searchGrid) {
				colName = "hitIDList";
			}
			else {
				colName = "wordIDList";
			}
			break;
		case obj_control.lineGrid_colAlignedWordID:
			colName = "alignedWordID";
			break;
		case obj_control.lineGrid_colUnitStart:
			colName = "unitStart";
			break;
		case obj_control.lineGrid_colUnitEnd:
			colName = "unitEnd";
			break;
		case obj_control.lineGrid_colVoidMax:
			colName = "voidMax";
			break;
		case obj_control.lineGrid_colVoidSum:
			colName = "voidSum";
			break;
		case obj_control.lineGrid_colPixelYOriginal:
			colName = "pixelYOriginal";
			break;
		default:
			break;
	}
}
else if (grid == obj_control.hitGrid) {
	switch (col) {
		case obj_control.hitGrid_colWordID:
			colName = "wordID";
			break;
		case obj_control.hitGrid_colUnitID:
			colName = "unitID";
			break;
		case obj_control.hitGrid_colHitID:
			colName = "hitID";
			break;
		case obj_control.hitGrid_colWordState:
			colName = "wordState";
			break;
		case obj_control.hitGrid_colHitBool:
			colName = "hitBool";
			break;
		case obj_control.hitGrid_colDisplayCol:
			colName = "displayCol";
			break;
		case obj_control.hitGrid_colPixelX:
			colName = "pixelX";
			break;
		default:
			break;
	}
}
else if (grid == obj_control.wordGrid) {
	switch (col) {
		case obj_control.wordGrid_colWordID:
			colName = "wordID";
			break;
		case obj_control.wordGrid_colWID:
			colName = "wID";
			break;
		case obj_control.wordGrid_colUnitID:
			colName = "unitID";
			break;
		case obj_control.wordGrid_colUtteranceID:
			colName = "uID";
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
else if (grid == obj_control.wordDrawGrid) {
	switch (col) {
		case obj_control.wordDrawGrid_colBorder:
			colName = "border";
			break;
		case obj_control.wordDrawGrid_colBorderRounded:
			colName = "borderRounded";
			break;
		case obj_control.wordDrawGrid_colFillRect:
			colName = "fillRect";
			break;
		case obj_control.wordDrawGrid_colTextColor:
			colName = "textColor";
			break;
		case obj_control.wordDrawGrid_colEffectColor:
			colName = "effectColor";
			break;
		case obj_control.wordDrawGrid_colVisible:
			colName = "visible";
			break;
		case obj_control.wordDrawGrid_colFocused:
			colName = "focused";
			break;
		default:
			break;
	}
}
else if (grid == obj_control.dynamicWordGrid) {
	switch (col) {
		case obj_control.dynamicWordGrid_colWordID:
			colName = "wordID";
			break;
		case obj_control.dynamicWordGrid_colWID:
			colName = "wID";
			break;
		case obj_control.dynamicWordGrid_colUtteranceID:
			colName = "uID";
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
		case obj_control.dynamicWordGrid_colInBoxList:
			colName = "inBoxList";
			break;
		case obj_control.dynamicWordGrid_colAligned:
			colName = "aligned";
			break;
		case obj_control.dynamicWordGrid_colVoid:
			colName = "void";
			break;
		case obj_control.dynamicWordGrid_colStretch:
			colName = "stretch";
			break;
		case obj_control.dynamicWordGrid_colReplaceWord:
			colName = "replaceWord";
			break;
		default:
			break;
	}
}
else if (grid == obj_chain.linkGrid or grid == obj_chain.rezPlayLinkGrid) {
	switch (col) {
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
		case obj_chain.linkGrid_colDead:
			colName = "dead";
			break;
		case obj_chain.linkGrid_colTilt:
			colName = "tilt";
			break;
		case obj_chain.linkGrid_colSourceClickTime:
			colName = "sourceClickTime";
			break;
		case obj_chain.linkGrid_colGoalClickTime:
			colName = "sourceGoalTime";
			break;
		default:
			break;
	}
}
else if (grid == obj_chain.vizLinkGrid) {
	switch (col) {
		case obj_chain.vizLinkGrid_colTier:
			colName = "tier";
			break;
		case obj_chain.vizLinkGrid_colChainID:
			colName = "chainID";
			break;
		case obj_chain.vizLinkGrid_colLinkID:
			colName = "linkID";
			break;
		case obj_chain.vizLinkGrid_colSource:
			colName = "source";
			break;
		case obj_chain.vizLinkGrid_colGoal:
			colName = "goal";
			break;
		case obj_chain.vizLinkGrid_colFocus:
			colName = "focus";
			break;
		case obj_chain.vizLinkGrid_colTilt:
			colName = "tilt";
			break;
		case obj_chain.vizLinkGrid_colCross:
			colName = "cross";
			break;
		case obj_chain.vizLinkGrid_colStretch:
			colName = "stretch";
			break;
		case obj_chain.vizLinkGrid_colAlign:
			colName = "align";
			break;
		default:
			break;
	}
}
else if (grid == obj_chain.rezChainGrid or grid == obj_chain.trackChainGrid or grid == obj_chain.stackChainGrid or grid == obj_chain.cliqueDisplayGrid or grid == obj_chain.placeChainGrid) {
	switch (col) {
		case obj_chain.chainGrid_colChainID:
			colName = "chainID";
			break;
		case obj_chain.chainGrid_colChainState:
			colName = "chainState";
			break;
		case obj_chain.chainGrid_colWordIDList:
			if (grid == obj_chain.stackChainGrid or grid == obj_chain.cliqueDisplayGrid) {
				colName = "unitIDList";
			}
			else {
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
		case obj_chain.chainGrid_colAlign:
			colName = "align";
			break;
		case obj_chain.chainGrid_colTiltSum:
			colName = "tiltSum";
			break;
		case obj_chain.chainGrid_colCaption:
			colName = "caption";
			break;
		case obj_chain.chainGrid_colAuthor:
			colName = "author";
			break;
		default:
			break;
	}
}
else if (grid == obj_chain.chunkGrid) {
	switch (col) {
		case obj_chain.chainGrid_colChainID:
			colName = "chainID";
			break;
		case obj_chain.chainGrid_colChainState:
			colName = "chainState";
			break;
		case obj_chain.chainGrid_colWordIDList:
			colName = "unitIDList";
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
		case obj_chain.chainGrid_colAlign:
			colName = "align";
			break;
		case obj_chain.chainGrid_colTiltSum:
			colName = "tiltSum";
			break;
		case obj_chain.chunkGrid_colBoxWordIDList:
			colName = "boxWordList";
			break;
		case obj_chain.chunkGrid_colNest:
			colName = "Nest";
			break;
		default:
			break;
	}
}
else if (grid == obj_chain.unitInStackGrid) {
	switch (col) {
		case obj_chain.unitInStackGrid_colUnitID:
			colName = "unitID";
			break;
		case obj_chain.unitInStackGrid_colStack:
			colName = "stackID";
			break;
		default:
			break;
	}
}
else if (grid == obj_chain.cliqueGrid) {
	switch (col) {
		case obj_chain.cliqueGrid_colCliqueID:
			colName = "cliqueID";
			break;
		case obj_chain.cliqueGrid_colChainIDList:
			colName = "chainIDList";
			break;
		case obj_chain.cliqueGrid_colUnitIDList:
			colName = "unitIDList";
			break;
		case obj_chain.cliqueGrid_colRangeStart:
			colName = "rangeStart";
			break;
		case obj_chain.cliqueGrid_colRangeEnd:
			colName = "rangeEnd";
			break;
		case obj_chain.cliqueGrid_colFlankLeft:
			colName = "flankLeft";
			break;
		case obj_chain.cliqueGrid_colFlankRight:
			colName = "flankRight";
			break;
		case obj_chain.cliqueGrid_colLength:
			colName = "length";
			break;
		case obj_chain.cliqueGrid_colBreak:
			colName = "break";
			break;
		case obj_chain.cliqueGrid_colTilt:
			colName = "tilt";
			break;
		case obj_chain.cliqueGrid_colName:
			colName = "name";
			break;
		default:
			break;
	}
}
else if (grid == obj_chain.DepRelLinkGrid) {
	switch (col) {
		case obj_chain.DepRelLinkGrid_colDepRelLinkID:
			colName = "DepRelLinkID";
			break;
		case obj_chain.DepRelLinkGrid_colSource:
			colName = "source";
			break;
		case obj_chain.DepRelLinkGrid_colGoal:
			colName = "goal";
			break;
		case obj_chain.DepRelLinkGrid_colRole:
			colName = "role";
			break;
		case obj_chain.DepRelLinkGrid_colLabel:
			colName = "label";
			break;
		case obj_chain.DepRelLinkGrid_colTag:
			colName = "tag";
			break;
		default:
			break;
	}
}
else if (grid == obj_chain.goldStandardGrid) {
	switch (col) {
		case obj_chain.goldStandardGrid_colStackID:
			colName = "StackID";
			break;
		case obj_chain.goldStandardGrid_colWordIDList:
			colName = "WordIDList";
			break;
		case obj_chain.goldStandardGrid_colUser:
			colName = "User";
			break;
		case obj_chain.goldStandardGrid_colScore:
			colName = "Score";
			break;
		default:
			break;
	}
}

return colName;