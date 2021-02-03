function scr_getColNameString(grid, col) {
	// Store and return the strings of Grid Column names

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
				colName = "Unit Start";
				break;
			case obj_control.unitGrid_colUnitEnd:
				colName = "Unit End";
				break;
			case obj_control.unitGrid_colParticipantColor:
				colName = "participantColor";
				break;
			//case obj_control.unitGrid_colTag:
			//	colName = "Tag";
			//	break;
			case obj_control.unitGrid_colDiscoColor:
				colName = "DiscoColor";
				break;
			default:
				break;
		}
	}
	else if (grid == obj_control.lineGrid or grid == obj_control.filterGrid or grid == obj_control.searchGrid  or grid == obj_control.quickFilterGrid ) {
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
				colName = "Unit Start";
				break;
			case obj_control.lineGrid_colUnitEnd:
				colName = "Unit End";
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
			case obj_control.dynamicWordGrid_colDisplayRow:
				colName = "displayRow";
				break;
			default:
				break;
		}
	}
	else if (grid == obj_chain.trackSeqGrid) {
		switch (col) {
			case obj_chain.trackSeqGrid_colChainID:
				colName = "ChainID";
				break;
			case obj_chain.trackSeqGrid_colChainName:
				colName = "ChainName";
				break;
			case obj_chain.trackSeqGrid_colChainSeq:
				colName = "ChainSeq";
				break;
			case obj_chain.trackSeqGrid_colTrackSeq:
				colName = "TrackSeq";
				break;
			case obj_chain.trackSeqGrid_colWordID:
				colName = "WordID";
				break;
			case obj_chain.trackSeqGrid_colText:
				colName = "Text";
				break;
			case obj_chain.trackSeqGrid_colTranscript:
				colName = "Transcript";
				break;
			case obj_chain.trackSeqGrid_colUnitText:
				colName = "UnitText";
				break;
			case obj_chain.trackSeqGrid_colGapUnits:
				colName = "GapUnits";
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
			case obj_chain.unitInStackGrid_colStackType:
				colName = "stackType";
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
	else if (grid == global.importGrid) {
	
		colName = ds_list_find_value(global.importGridColNameList, col);
	
	}
	else if (grid == obj_control.morphGrid) {
		switch (col) {
			case obj_control.morphGrid_colUnitID:
				colName = "unitID";
				break;
			case obj_control.morphGrid_colWordID:
				colName = "wordID";
				break;
			case obj_control.morphGrid_colParticipant:
				colName = "participant";
				break;
			case obj_control.morphGrid_colMorph:
				colName = "morph";
				break;
			case obj_control.morphGrid_colAffix:
				colName = "affix";
				break;
			case obj_control.morphGrid_colUnitStart:
				colName = "Unit Start";
				break;
			case obj_control.morphGrid_colUnitEnd:
				colName = "Unit End";
				break;
			case obj_control.morphGrid_colGloss:
				colName = "gloss";
				break;
			default:
				break;
		}
	}
	else if (grid == global.customLabelGrid) {
		switch (col) {
			case global.customLabelGrid_colLevel:
				colName = "level";
				break;
			case global.customLabelGrid_colMarker:
				colName = "label";
				break;
			case global.customLabelGrid_colTagList:
				colName = "tagList";
				break;
			default:
				break;
		}
	}
	else if (grid == global.tokenImportGrid) {

		colName = ds_list_find_value(global.tokenImportColNameList, col);
	}
	else if (grid == global.wordImportGrid) {

		colName = ds_list_find_value(global.wordImportColNameList, col);
	}
	else if (grid == global.unitImportGrid) {

		colName = ds_list_find_value(global.unitImportColNameList, col);
	}

	return colName;


}
