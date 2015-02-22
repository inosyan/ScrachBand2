
var isClone;
var kind;

// 楽器名
var instrumentList = ["Piano", "Electric Piano", "Organ", "Guitar", "Electric Guitar", "Bass",
"Pizzicato", "Cello", "Trombone", "Clarinet", "Saxophone", "Flute", "Wooden Flute",
"Bassoon", "Choir", "Vibraphone", "Music Box", "Steel Drum", "Marimba", "Synth Lead", "Synth Pad"];
var instLocalIndex;

// 編集モード
var localEditMode;

// ループモード
var localLoopMode;

// トラックナンバー
var localTrackNumber;

// ドラムモード
var localDrumMode;

var tmp;

function scripts(){
	whenFlagClicked(function(){
		isClone = -1;
		hide();
		
		hideVariable(instrumentName);
		hideVariable(beatNumber);
		hideVariable(tempoValue);
		hideVariable(trackNumberLabel);
	});
	
	whenIReceive(MSG_INITIALIZE_COMPLETE, function(){
		if(isClone == -1){			
			// 楽器
			kind = "instUp";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "instDown";
			createCloneOf(CLONETARGET_MYSELF);
			instLocalIndex = -1;
			onInstrumentIndexChanged();
			
			// 拍数
			kind = "beatUp";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "beatDown";
			createCloneOf(CLONETARGET_MYSELF);
			
			// プレイボタン
			kind = "playBtn";
			createCloneOf(CLONETARGET_MYSELF);
			
			// 保存と開く
			kind = "saveBtn";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "loadBtn";
			createCloneOf(CLONETARGET_MYSELF);
			
			// エディットモードボタン
			kind = "editModeBtn";
			createCloneOf(CLONETARGET_MYSELF);
			localEditMode = "";
			
			// ループ
			kind = "loopBtn";
			createCloneOf(CLONETARGET_MYSELF);
			localLoopMode = -1;
			
			// テンポ
			kind = "tempoUp";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "tempoDown";
			createCloneOf(CLONETARGET_MYSELF);
			
			// トラック
			kind = "trackUp";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "trackDown";
			createCloneOf(CLONETARGET_MYSELF);
			localTrackNumber = -1;
			onTrackNumberChanged();
			
			// トラック
			kind = "drumBtn";
			createCloneOf(CLONETARGET_MYSELF);
			localDrumMode = -1;
			
			// ズーム
			kind = "zoomInBtn";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "zoomOutBtn";
			createCloneOf(CLONETARGET_MYSELF);
			
			// サンプル
			kind = "sampleBtn";
			createCloneOf(CLONETARGET_MYSELF);
			
			// 設定
			kind = "settingBtn";
			createCloneOf(CLONETARGET_MYSELF);	
		}
	});
	
	whenIReceive(MSG_TITLE_COMPLETE, function(){
		showVariable(instrumentName);
		showVariable(beatNumber);
		showVariable(tempoValue);
		showVariable(trackNumberLabel);
	});
	
	whenIStartAsAClone(function(){
		isClone = 1;
		initialize();
		if(kind == "editModeBtn"){
			onEditModeChanged();
		}
	});
	
	whenThisSpriteClicked(function(){
		onClick();
	});
	
	whenIReceive(MSG_EDITMODE_CHANGED, function(){
		if(kind == "editModeBtn"){
			onEditModeChanged();
		}
	});
	
	whenIReceive(MSG_INSTRUMENTINDEX_CHANGED, function(){
		if(kind == "instUp"){
			onInstrumentIndexChanged();
		}
	});	
	
	whenIReceive(SOUNDPLAYER_PLAY_COMPLETE, function(){
		if(kind == "playBtn"){
			isPlaying = -1;
			switchCostumeTo("playBtnOff");
		}		
	});
	
	whenIReceive(MSG_LOOPMODE_CHANGED, function(){
		if(kind == "loopBtn"){
			onLoopModeChanged();
		}
	});
	
	whenIReceive(MSG_TRACKNUMBER_CHANGED, function(){
		if(kind == "trackUp"){
			onTrackNumberChanged();
		}
	});
	
	whenIReceive(MSG_DRUMMODE_CHANGED, function(){
		if(kind == "drumBtn"){
			onDrumModeChanged();
		}
		if(kind == "instUp" || kind == "instDown"){
			if(isDrumMode == 1){
				hide();
				hideVariable(instrumentName);
			}else{
				show();
				showVariable(instrumentName);
			}
		}
	});
}

[ProcDef(fastmode="true")]
function initialize(){
	show();
	if(kind == "instUp"){
		gotoXY(-115, -161);
		switchCostumeTo("selectorUp");
	}
	if(kind == "instDown"){
		gotoXY(-115, -171);
		switchCostumeTo("selectorDown");
	}
	if(kind == "beatUp"){
		gotoXY(-49, -161);
		switchCostumeTo("selectorUp");
	}
	if(kind == "beatDown"){
		gotoXY(-49, -171);
		switchCostumeTo("selectorDown");
	}
	if(kind == "playBtn"){
		gotoXY(105, -166);
		switchCostumeTo("playBtnOff");
	}
	if(kind == "saveBtn"){
		gotoXY(201, -168);
		switchCostumeTo("saveBtn");
	}
	if(kind == "loadBtn"){
		gotoXY(225, -168);
		switchCostumeTo("loadBtn");
	}
	if(kind == "okBtn"){
		gotoXY(0, -160);
		switchCostumeTo("btnOK");
		gotoFront();
	}
	if(kind == "loopBtn"){
		gotoXY(130, -169);
		switchCostumeTo("loopOff");
	}
	if(kind == "editModeBtn"){
		gotoXY(152, -169);
		switchCostumeTo("modeCell");
	}
	if(kind == "drumBtn"){
		gotoXY(174, -169);
		switchCostumeTo("drumBtnOff");
	}
	if(kind == "tempoUp"){
		gotoXY(17, -161);
		switchCostumeTo("selectorUp");
	}
	if(kind == "tempoDown"){
		gotoXY(17, -171);
		switchCostumeTo("selectorDown");
	}
	if(kind == "trackUp"){
		gotoXY(83, -161);
		switchCostumeTo("selectorUp");
	}
	if(kind == "trackDown"){
		gotoXY(83, -171);
		switchCostumeTo("selectorDown");
	}
	if(kind == "zoomInBtn"){
		gotoXY(230, -150);
		switchCostumeTo("zoomInBtn");
	}
	if(kind == "zoomOutBtn"){
		gotoXY(213, -150);
		switchCostumeTo("zoomOutBtn");
	}
	if(kind == "sampleBtn"){
		gotoXY(195, -150);
		switchCostumeTo("sampleBtn");
	}
	if(kind == "settingBtn"){
		gotoXY(178, -150);
		switchCostumeTo("settingBtn");
	}
}

[ProcDef(fastmode="true")]
function onInstrumentIndexChanged(){
	if(!(instLocalIndex == instrumentIndex)){
		instLocalIndex = instrumentIndex;
		instrumentName = instrumentList[instLocalIndex];
	}
}

[ProcDef(fastmode="true")]
function onEditModeChanged(){
	if(!(localEditMode == editMode)){
		localEditMode = editMode;
		if(localEditMode == EDITMODE_ENDLINE){
			switchCostumeTo("modeEndLine");
		}else{
			if(localEditMode == EDITMODE_STARTLINE){
				switchCostumeTo("modeStartLine");
			}else{
				switchCostumeTo("modeCell");
			}
		}
	}
}

[ProcDef(fastmode="true")]
function onLoopModeChanged(){
	if(!(localLoopMode == isLoopMode)){
		localLoopMode = isLoopMode;
		if(isLoopMode == -1){
			switchCostumeTo("loopOff");
		}else{
			switchCostumeTo("loopOn");
		}
	}
}

[ProcDef(fastmode="true")]
function onTrackNumberChanged(){
	if(!(localTrackNumber == trackNumber)){
		localTrackNumber = trackNumber;
		trackNumberLabel = join("TR", localTrackNumber);
	}
}

[ProcDef(fastmode="true")]
function onDrumModeChanged(){
	if(!(localDrumMode == isDrumMode)){
		localDrumMode = isDrumMode;
		if(isDrumMode == 1){
			switchCostumeTo("drumBtnOn");
		}else{
			switchCostumeTo("drumBtnOff");
		}
	}
}

[ProcDef(fastmode="true")]
function onClick(){
	if(kind == "instUp" || kind == "instDown"){
		onClickInst();
	}
	if(kind == "beatUp" || kind == "beatDown"){
		onClickBeat();
	}
	if(kind == "playBtn"){
		isPlaying *= -1;
		if(isPlaying == 1){
			switchCostumeTo("playBtnOn");
			broadcast(MSG_PLAY_SOUND);
			createCloneOf("Playing");
		}else{
			switchCostumeTo("playBtnOff");
			broadcast(MSG_STOP_SOUND);
		}
	}
	if(kind == "saveBtn"){
		broadcast(MSG_SAVE_DATA);
		kind = "okBtn";
		disableUI = 1; // UIを無効にする
		createCloneOf(CLONETARGET_MYSELF);
		kind = "saveBtn";
	}
	if(kind == "loadBtn"){
		broadcast(MSG_LOAD_DATA);
	}
	if(kind == "okBtn"){
		deleteOf(LIST_DELETE_ALL, saveDataList);
		hideList(saveDataList);
		disableUI = -1; // UIを有効にする
		deleteThisClone();
	}
	if(kind == "editModeBtn"){
		if(editMode == EDITMODE_ENDLINE){
			editMode = EDITMODE_CELL;
		}else{
			if(editMode == EDITMODE_STARTLINE){
				editMode = EDITMODE_ENDLINE;
			}else{
				editMode = EDITMODE_STARTLINE;
			}
		}
		broadcast(MSG_EDITMODE_CHANGED);
	}
	if(kind == "loopBtn"){
		isLoopMode *= -1;
		broadcast(MSG_LOOPMODE_CHANGED);
	}
	if(kind == "tempoUp"){
		tempoValue += 1;
		if(tempoValue > 300){tempoValue = 300; }
	}
	if(kind == "tempoDown"){
		tempoValue -= 1;
		if(tempoValue < 10){tempoValue = 10; }
	}
	if(kind == "trackUp"){
		trackNumber++;
		if(trackNumber > maxTrackNumber){trackNumber = 1; }
		broadcast(MSG_TRACKNUMBER_CHANGED);
	}
	if(kind == "trackDown"){
		trackNumber--;
		if(trackNumber < 1){trackNumber = maxTrackNumber; }
		broadcast(MSG_TRACKNUMBER_CHANGED);
	}
	if(kind == "drumBtn"){
		isDrumMode *= -1;
		broadcast(MSG_CREAR_TIMELINE);
		broadcast(MSG_DRUMMODE_CHANGED);
	}
	if(kind == "zoomInBtn"){
		if(zoomLevel < minimumBeat){
			zoomLevel *= 2;
			horizontalScrillMax = timelineNumber * zoomLevel / minimumBeat - MAX_CELL_W;
			horizontalScrollPosition *= 2;
			broadcast(MSG_ZOOMLEVEL_CHANGED);
		} 
	}
	if(kind == "zoomOutBtn"){
		if(zoomLevel > 2){
			zoomLevel /= 2;
			horizontalScrillMax = timelineNumber * zoomLevel / minimumBeat - MAX_CELL_W;
			horizontalScrollPosition = mathFloor(horizontalScrollPosition / 2);
			broadcast(MSG_ZOOMLEVEL_CHANGED);
		}
	}
	if(kind == "sampleBtn"){
		createCloneOf("Sample");
	}
	if(kind == "settingBtn"){
		createCloneOf("Setting");
	}
}

[ProcDef(fastmode="true")]
function onClickInst(){
	tmp = instrumentIndex;
	if(kind == "instUp"){
		tmp--;
		if(tmp < 1){
			tmp = lengthOf(instrumentList);
		}
	}else{
		tmp++;
		if(tmp > lengthOf(instrumentList)){
			tmp = 1;
		}
	}
	instrumentIndex = tmp;
	broadcast(MSG_INSTRUMENTINDEX_CHANGED);
}

[ProcDef(fastmode="true")]
function onClickBeat(){
	tmp = beatNumber;
	if(kind == "beatUp"){
		tmp++;
		if(tmp > 32){
			tmp = 1;
		}
	}else{
		tmp--;
		if(tmp < 1){
			tmp = 128
		}
	}
	beatNumber = tmp;
	broadcast(MSG_BEATNUMBER_CHANGED);
}




