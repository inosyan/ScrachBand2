
var bin = new BinaryUtility();

var cnt, cnt2, cnt3;
var i, j, k, l, m, tmp, tmp2, tmp3, s;
var tnum, beat, note, time;
var index, inst;
var scaleVal;

var s1cnt2;
var s2cnt2;
var s3cnt2;
var s4tmp, num1, num2;

//[Variable(name="analyzedData", visible=true, x=10, y=100, mode=1, sliderMin=0, sliderMax=100)]
var analyzedData;

//[Variable(name="debug", visible=true, x=10, y=130, mode=1, sliderMin=0, sliderMax=100)]
//var debug;

// セルユーティリティ
var cellUtil = new CellUtilBase();

// サウンドプレイヤー
var sp = new SoundPlayerBase();

// トラックタイムラインデータ
var trackInstrument1;
var trackInstrument2;
var trackInstrument3;
var trackInstrument4;
var trackInstrument5;
var trackInstrument6;
var trackInstrument7;
var trackInstrument8;
var trackInstrument9;
var trackInstrument10;
var trackIsDrumMode1;
var trackIsDrumMode2;
var trackIsDrumMode3;
var trackIsDrumMode4;
var trackIsDrumMode5;
var trackIsDrumMode6;
var trackIsDrumMode7;
var trackIsDrumMode8;
var trackIsDrumMode9;
var trackIsDrumMode10;
var localTrackNumber;

var position1, position2, position3, position4, dataSize, sizeSub, tag;

// 前回のデータ（保存したときにとっておく）
var previousSavedData;

// タイムライン延長のための一時的なリスト
var tempListForExtends = [];

function scripts(){
	whenFlagClicked(function(){
		hide();
	});
	
	whenIReceive(MSG_INITIALIZE, function(){
		if(previousSavedData == "" || previousSavedData == 0){
			resetParam();
		}else{
			loadData(previousSavedData, 0);
		}
		broadcast(MSG_INITIALIZE_COMPLETE);
	});
	
	whenIReceive(MSG_PLAY_SOUND, function(){
		copyTimelineToOldTrack();
		analyzeTimelineDirect();
		sp.directPlay();
		//analyzeTimeline(1);
		//sp.play(analyzedData);
	});
	
	whenIReceive(MSG_STOP_SOUND, function(){
		sp.stop();
	});
	
	whenIReceive(MSG_SAVE_DATA, function(){
		copyTimelineToOldTrack();
		analyzeTimeline(-1);
		deleteOf(LIST_DELETE_ALL, saveDataList);
		addTo(analyzedData, saveDataList);
		showList(saveDataList);
		// 保存したデータを次回起動用にとっておく
		previousSavedData = analyzedData;
	});
	
	whenIReceive(MSG_LOAD_DATA, function(){
		askAndWait("Please input save data.");
		if(!(answer == "") && letterOf(1, answer) == "#"){
			loadDataOld(answer);
		}else{
			loadData(answer, 0);
		}
	});
	
	whenIReceive(MSG_LOAD_SAMPLE_DATA, function(){
		if(!(selectedSampleData == "")){
			loadData(selectedSampleData, 0);
		}
	});
	
	whenIReceive(MSG_TRACKNUMBER_CHANGED, function(){
		onTrackNumberChanged();
	});
	
	whenIReceive(MSG_CREAR_TIMELINE, function(){
		clearCurrentTimeline();
	});
	
	whenIReceive(MSG_EXTEND_TIMELINE, function(){
		createCloneOf("Wait");
		extendTimeline();
		broadcast(MSG_HIDE_WAIT);
	});
	
	whenIReceive(MSG_SETTING_MINUMUMBEAT_CHANGED, function(){
		changeMinumumBeat();
	});
	
	whenIReceive(MSG_SETTING_MAXTRACKNUMBER_CHANGED, function(){
		changeMaxTrackNumber();
	});
}

[ProcDef(fastmode="true")]
function clearCurrentTimeline(){
	i = 1;
	cnt = timelineNumber * MAX_NOTE;
	repeat(cnt){
		if(trackNumber == 1){ trackTimeline1[i] = 0; }
		if(trackNumber == 2){ trackTimeline2[i] = 0; }
		if(trackNumber == 3){ trackTimeline3[i] = 0; }
		if(trackNumber == 4){ trackTimeline4[i] = 0; }
		if(trackNumber == 5){ trackTimeline5[i] = 0; }
		if(trackNumber == 6){ trackTimeline6[i] = 0; }
		if(trackNumber == 7){ trackTimeline7[i] = 0; }
		if(trackNumber == 8){ trackTimeline8[i] = 0; }
		if(trackNumber == 9){ trackTimeline9[i] = 0; }
		if(trackNumber == 10){ trackTimeline10[i] = 0; }
		i++;
	}
	broadcast(MSG_LOAD_DATA_COMPLETE);
}

[ProcDef(fastmode="true")]
function resetParam(){
	zoomLevel = 8;
	timelineNumber = DEFAULT_TIMELINE_NUMBER;
	verticalScrillMax = MAX_NOTE - MAX_CELL_H;
	verticalScrollPosition = round(verticalScrillMax / 2) - 11;
	horizontalScrollPosition = 0;
	horizontalScrillMax = timelineNumber * zoomLevel / minimumBeat - MAX_CELL_W;
	instrumentIndex = 1;
	beatNumber = 4; // デフォルトは 2分音符
	deleteOf(LIST_DELETE_ALL, saveDataList);
	hideList(saveDataList);
	editMode = EDITMODE_CELL;
	startLineTime = 1;
	endLineTime = 1;
	disableUI = -1;
	isLoopMode = -1;
	tempoValue = 60;
	isPlaying = -1;
	trackNumber = 1;
	localTrackNumber = 1;
	trackInstrument1 = 1;
	trackInstrument2 = 1;
	trackInstrument3 = 1;
	trackInstrument4 = 1;
	trackInstrument5 = 1;
	trackInstrument6 = 1;
	trackInstrument7 = 1;
	trackInstrument8 = 1;
	trackInstrument9 = 1;
	trackInstrument10= 1;
	trackIsDrumMode1 = -1;
	trackIsDrumMode2 = -1;
	trackIsDrumMode3 = -1;
	trackIsDrumMode4 = -1;
	trackIsDrumMode5 = -1;
	trackIsDrumMode6 = -1;
	trackIsDrumMode7 = -1;
	trackIsDrumMode8 = -1;
	trackIsDrumMode9 = -1;
	trackIsDrumMode10= -1;
	
	isDrumMode = -1;
	maxTrackNumber = 3;
	
	broadcast(MSG_INSTRUMENTINDEX_CHANGED);
	broadcast(MSG_BEATNUMBER_CHANGED);
	broadcast(MSG_VERTICALSCROLL_CHANGED);
	broadcast(MSG_HORIZONTALSCROLL_CHANGED);
	broadcast(MSG_LOOPMODE_CHANGED);
	broadcast(MSG_TRACKNUMBER_CHANGED);
	broadcast(MSG_DRUMMODE_CHANGED);
	
	createTimelineList();
}


[ProcDef(fastmode="true")]
function createTimelineList(){
	deleteOf(LIST_DELETE_ALL, trackTimeline1);
	deleteOf(LIST_DELETE_ALL, trackTimeline2);
	deleteOf(LIST_DELETE_ALL, trackTimeline3);
	deleteOf(LIST_DELETE_ALL, trackTimeline4);
	deleteOf(LIST_DELETE_ALL, trackTimeline5);
	deleteOf(LIST_DELETE_ALL, trackTimeline6);
	deleteOf(LIST_DELETE_ALL, trackTimeline7);
	deleteOf(LIST_DELETE_ALL, trackTimeline8);
	deleteOf(LIST_DELETE_ALL, trackTimeline9);
	deleteOf(LIST_DELETE_ALL, trackTimeline10);
	cnt = timelineNumber * MAX_NOTE;
	i = 1;
	repeat(10){
		repeat(cnt){
			addTo(0, join("trackTimeline", i));
		}
		i++;
	}
	deleteOf(LIST_DELETE_ALL, tempListForExtends);
	repeat(cnt){
		addTo(0, tempListForExtends);
	}
}

// タイムラインを解析する
[ProcDef(fastmode="true")]
function analyzeTimeline(useStartLineTime:int){
	bin.init();
	// ファイルフォーマットバージョン
	bin.writeUInt8(1);
	
	////// 全体 //////
	bin.writeUInt4(1); // 「全体」のタグ 01
	position1 = bin.position; // サイズを書き込むためにポジションをとっておく
	bin.writeUInt24(0); // サイズ（あとで書き込む）
	// ループ
	if(isLoopMode == 1){
		bin.writeBit(1) 
	}else{
		bin.writeBit(0)
	}
	
	// 最小単位(8 ~ 128)
	tmp = round(minimumBeat / 8);
	tmp2 = 0;
	repeatUntil(tmp == 1){
		tmp = round(tmp / 2);
		tmp2++;
	}
	bin.writeUInt4(tmp2);
	
	// 最後の時間（あとで書き込む）
	tmp2 = endLineTime - 1;
	// スタートラインの分を補正
	if(useStartLineTime == 1){tmp2 -= startLineTime - 1;}
	if(tmp2 < 0){tmp2 = 0};
	bin.writeUInt16(tmp2);
	
	
	// テンポ（まだ今は１個だけ）
	bin.writeUInt16(1); // 個数1
	bin.writeUInt8(27); // 一個当たりのビット数
	// テンポの各アイテム
	bin.writeUInt16(0); // ポジション
	bin.writeUInt11(tempoValue); // テンポ数
	
	// 最初の時間
	tmp2 = startLineTime - 1;
	if(tmp2 < 0){tmp2 = 0};
	bin.writeUInt16(tmp2);
	
	// 最大トラック数
	bin.writeUInt4(maxTrackNumber);
	
	// サイズを記録
	position2 = bin.position;
	dataSize = position2 - position1;
	bin.position = position1;
	bin.writeUInt24(dataSize);
	bin.position = position2;
	
	////// トラック //////
	tnum = 1;
	repeat(maxTrackNumber){
		bin.writeUInt4(2); // 「トラック」のタグ 02
		position1 = bin.position; // サイズを書き込むためにポジションをとっておく
		bin.writeUInt24(0); // サイズ（あとで書き込む）
		bin.writeUInt4(tnum); // トラック番号
		// ボリューム（まだ今は１個だけ）
		bin.writeUInt16(1); // 個数
		bin.writeUInt8(24); // 一個当たりのビット数
		// ボリュームの各アイテム
		bin.writeUInt16(0); // ポジション
		bin.writeUInt8(100); // ボリューム
		// 楽器
		if(tnum == 1){ inst = trackInstrument1; }
		if(tnum == 2){ inst = trackInstrument2; }
		if(tnum == 3){ inst = trackInstrument3; }
		if(tnum == 4){ inst = trackInstrument4; }
		if(tnum == 5){ inst = trackInstrument5; }
		if(tnum == 6){ inst = trackInstrument6; }
		if(tnum == 7){ inst = trackInstrument7; }
		if(tnum == 8){ inst = trackInstrument8; }
		if(tnum == 9){ inst = trackInstrument9; }
		if(tnum == 10){ inst = trackInstrument10; }
		if(tnum == 1 && trackIsDrumMode1 == 1 || tnum == 2 && trackIsDrumMode2 == 1 || tnum == 3 && trackIsDrumMode3 == 1
		|| tnum == 4 && trackIsDrumMode4 == 1 || tnum == 5 && trackIsDrumMode5 == 1 || tnum == 6 && trackIsDrumMode6 == 1
		|| tnum == 7 && trackIsDrumMode7 == 1 || tnum == 8 && trackIsDrumMode8 == 1 || tnum == 9 && trackIsDrumMode9 == 1
		|| tnum == 10 && trackIsDrumMode10 == 1){
			// ドラムモードなので調整
			inst = 0;
		}
		bin.writeUInt8(inst);
		
		// サイズを記録
		position2 = bin.position;
		dataSize = position2 - position1;
		bin.position = position1;
		bin.writeUInt24(dataSize);
		bin.position = position2;
		
		tnum++;
	}
	
	////// タイムライン //////
	tnum = 1;
	repeat(maxTrackNumber){
		bin.writeUInt4(4); // 「タイムライン」のタグ 04
		position1 = bin.position; // サイズを書き込むためにポジションをとっておく
		bin.writeUInt24(0); // サイズ（あとで書き込む）
		bin.writeUInt4(tnum); // トラック番号
		// bin.writeUInt8(0); // パターン番号 封印
		position3 = bin.position; // 個数を書き込むためにポジションをとっておく
		bin.writeUInt16(0); // 個数（あとで書き込む）
		bin.writeUInt16(35); // 一個当たりのビット数
		cnt = 0; // 個数を数え始める
		
		j = 0;
		if(useStartLineTime == 1){j = startLineTime - 1;}
		repeatUntil( j == endLineTime ){
			i = 0;
			repeat(MAX_NOTE){
				if(tnum == 1){ if(lengthOf(trackTimeline4) == 0){ s = 0; }else{ s = trackTimeline1[i * timelineNumber + j + 1]}}
				if(tnum == 2){ if(lengthOf(trackTimeline4) == 0){ s = 0; }else{ s = trackTimeline2[i * timelineNumber + j + 1]}}
				if(tnum == 3){ if(lengthOf(trackTimeline4) == 0){ s = 0; }else{ s = trackTimeline3[i * timelineNumber + j + 1]}}
				if(tnum == 4){ if(lengthOf(trackTimeline4) == 0){ s = 0; }else{ s = trackTimeline4[i * timelineNumber + j + 1]}} 
				if(tnum == 5){ if(lengthOf(trackTimeline4) == 0){ s = 0; }else{ s = trackTimeline5[i * timelineNumber + j + 1]}}
				if(tnum == 6){ if(lengthOf(trackTimeline4) == 0){ s = 0; }else{ s = trackTimeline6[i * timelineNumber + j + 1]}}
				if(tnum == 7){ if(lengthOf(trackTimeline4) == 0){ s = 0; }else{ s = trackTimeline7[i * timelineNumber + j + 1]}}
				if(tnum == 8){ if(lengthOf(trackTimeline4) == 0){ s = 0; }else{ s = trackTimeline8[i * timelineNumber + j + 1]}}
				if(tnum == 9){ if(lengthOf(trackTimeline4) == 0){ s = 0; }else{ s = trackTimeline9[i * timelineNumber + j + 1]}}
				if(tnum == 10){ if(lengthOf(trackTimeline4) == 0){ s = 0; }else{ s = trackTimeline10[i * timelineNumber + j + 1]}}
				if(!(s == 0)){
					cellUtil.checkNum1Num2(s);
					if(cellUtil.num1 == 1){
						tmp3 = j;
						// スタートラインの分を補正
						if(useStartLineTime == 1){tmp3 -= startLineTime - 1;}
						if(tmp3 >= 0){
							time = tmp3;
							beat = cellUtil.num2;
							note = MAX_NOTE - i;
							if(tnum == 1 && trackIsDrumMode1 == 1 || tnum == 2 && trackIsDrumMode2 == 1 || tnum == 3 && trackIsDrumMode3 == 1
							|| tnum == 4 && trackIsDrumMode4 == 1 || tnum == 5 && trackIsDrumMode5 == 1 || tnum == 6 && trackIsDrumMode6 == 1
							|| tnum == 7 && trackIsDrumMode7 == 1 || tnum == 8 && trackIsDrumMode8 == 1 || tnum == 9 && trackIsDrumMode9 == 1
							|| tnum == 10 && trackIsDrumMode10 == 1){
								// ドラムモードなので調整
								note = note - DRUM1_NOTENUM + 1;
							}
							// 書き込み
							bin.writeUInt16(time); // 開始時間
							// bin.writeBit(0); // パターンかどうか 封印
							bin.writeUInt8(note); // 音の高さ／ドラムの種類
							bin.writeUInt11(beat); // 長さ
							cnt++;
						}
					}
				}
				i++;
			}
			j++;
		}
		
		
		// 個数を記録
		position4 = bin.position;
		bin.position = position3;
		bin.writeUInt16(cnt);
		bin.position = position4;
		// サイズを記録
		position2 = bin.position;
		dataSize = position2 - position1;
		bin.position = position1;
		bin.writeUInt24(dataSize);
		bin.position = position2;
		tnum++;
	}
	
	// 最後のタグ
	bin.writeUInt4(15); // 「最後」のタグ 15
	
	bin.getKanji();
	analyzedData = bin.result;
}

// ダイレクトプレイ用にタイムラインを解析する
[ProcDef(fastmode="true")]
function analyzeTimelineDirect(useStartLineTime:int){
	
	soundPlayerDirectPlayTempo = tempoValue;
	soundPlayerDirectPlayIsLoopMode = isLoopMode;
	
	deleteOf(LIST_DELETE_ALL, soundPlayerDirectPlayWaitList);
	deleteOf(LIST_DELETE_ALL, soundPlayerDirectPlayNoteList);
	deleteOf(LIST_DELETE_ALL, soundPlayerDirectPlayBeatList);
	deleteOf(LIST_DELETE_ALL, soundPlayerDirectPlayInstList);
	
	j = startLineTime - 1;
	tmp = "";
	repeat(endLineTime - startLineTime){
		i = 0;
		repeat(MAX_NOTE){
			tnum = 1;
			repeat(maxTrackNumber){
				if(tnum == 1){ s = trackTimeline1[i * timelineNumber + j + 1]; inst = trackInstrument1; }
				if(tnum == 2){ s = trackTimeline2[i * timelineNumber + j + 1]; inst = trackInstrument2; }
				if(tnum == 3){ s = trackTimeline3[i * timelineNumber + j + 1]; inst = trackInstrument3; }
				if(tnum == 4){ s = trackTimeline4[i * timelineNumber + j + 1]; inst = trackInstrument4; }
				if(tnum == 5){ s = trackTimeline5[i * timelineNumber + j + 1]; inst = trackInstrument5; }
				if(tnum == 6){ s = trackTimeline6[i * timelineNumber + j + 1]; inst = trackInstrument6; }
				if(tnum == 7){ s = trackTimeline7[i * timelineNumber + j + 1]; inst = trackInstrument7; }
				if(tnum == 8){ s = trackTimeline8[i * timelineNumber + j + 1]; inst = trackInstrument8; }
				if(tnum == 9){ s = trackTimeline9[i * timelineNumber + j + 1]; inst = trackInstrument9; }
				if(tnum == 10){ s = trackTimeline10[i * timelineNumber + j + 1]; inst = trackInstrument10; }
				
				if(!(s == 0)){
					cellUtil.checkNum1Num2(s);
					if(cellUtil.num1 == 1){
						tmp3 = j;
						// スタートラインの分を補正
						tmp3 -= startLineTime - 1;
						if(tmp3 >= 0){
							time = tmp3 / minimumBeat; // 1マス ○分音符;
							beat = cellUtil.num2;
							beat /= minimumBeat; // 1マス ○分音符
							note = MAX_NOTE - i;
							if(tnum == 1 && trackIsDrumMode1 == 1 || tnum == 2 && trackIsDrumMode2 == 1 || tnum == 3 && trackIsDrumMode3 == 1
							|| tnum == 4 && trackIsDrumMode4 == 1 || tnum == 5 && trackIsDrumMode5 == 1 || tnum == 6 && trackIsDrumMode6 == 1
							|| tnum == 7 && trackIsDrumMode7 == 1 || tnum == 8 && trackIsDrumMode8 == 1 || tnum == 9 && trackIsDrumMode9 == 1
							|| tnum == 10 && trackIsDrumMode10 == 1){
								// ドラムモードなので調整
								inst = note - DRUM1_NOTENUM + 1;
								note = 0;
							}else{
								// Piano, Guitar, Electric Guitar, Vibraphone, Music Box, Steel Drum, Marimba
								if(inst == 1 || inst == 4 || inst == 5 || inst == 16 || inst == 17 || inst == 18 || inst == 19){
									if(beat < 1){
										beat = 1;
									}
								}
							}
							addTo(time, soundPlayerDirectPlayWaitList);
							addTo(note, soundPlayerDirectPlayNoteList);
							addTo(inst, soundPlayerDirectPlayInstList);
							addTo(beat, soundPlayerDirectPlayBeatList);
						}
					}
				}
				tnum++;
			}
			i++;
		}
		j++;
	}
	
	// 最後の時間を入れる
	time = endLineTime - startLineTime;
	time /= minimumBeat; // 1マス ○分音符
	addTo(time, soundPlayerDirectPlayWaitList);
	addTo("end", soundPlayerDirectPlayInstList);
}

// セーブデータを開く
[ProcDef(fastmode="true")]
function loadData(saveData:String, minimumBeatValue:int){
	// いったんクリア
	resetParam();
	if(!(saveData == "")){
		bin.init();
		bin.setKanji(saveData);
		bin.position = 0;
		
		// ファイルフォーマットバージョン
		bin.readUInt8();
		tag = 0;
		repeatUntil(tag == 15){
			bin.readUInt4(); // タグ
			tag = bin.result;
			if(!(tag == 15)){
				position1 = bin.position;
				bin.readUInt24();
				dataSize = bin.result;
				if(tag == 1){
					////// 全体 //////
					// ループ
					bin.readBit();
					if(bin.result == 1){
						isLoopMode = 1;
					}else{
						isLoopMode = -1;
					}
					
					// 最小単位(8 ~ 128)
					bin.readUInt4();
					tmp = 8;
					repeat(bin.result){
						tmp *= 2;
					}
					if(minimumBeatValue == 0){
						minimumBeat = tmp;
						scaleVal = 1;
					}else{
						minimumBeat = minimumBeatValue;
						scaleVal = minimumBeatValue / tmp; 
					}
					
					// 最後の時間
					bin.readUInt16();
					endLineTime = bin.result;//
					endLineTime = mathFloor(endLineTime * scaleVal);
					endLineTime += 1;
					
					// テンポ（まだ今は１個だけ）
					bin.readUInt16();
					bin.readUInt8(); // 一個当たりのビット数
					// テンポの各アイテム
					bin.readUInt16(); // ポジション
					bin.readUInt11(tempoValue); // テンポ数
					tempoValue = bin.result;
					
					// 最初の時間
					if(bin.position < position1 + dataSize){
						bin.readUInt16();
						startLineTime = mathFloor(bin.result * scaleVal);
						startLineTime += 1;
					}
					// 最大トラック数
					if(bin.position < position1 + dataSize){
						bin.readUInt4();
						maxTrackNumber = bin.result;
					}
					// もしエンドタイムが長ければタイムラインを長くする
					tmp = mathCeiling(endLineTime / DEFAULT_TIMELINE_NUMBER) * DEFAULT_TIMELINE_NUMBER;
					if(timelineNumber < tmp){
						timelineNumber = tmp;
						horizontalScrillMax = timelineNumber * zoomLevel / minimumBeat - MAX_CELL_W;
						createTimelineList();
					}
				}
				if(tag == 2){
					////// トラック //////
					// トラック番号
					bin.readUInt4();
					tnum = bin.result;
					
					// ボリューム（まだ今は１個だけ）（今はまだ使ってない）
					bin.readUInt16(); // 個数
					bin.readUInt8(); // 一個当たりのビット数
					// ボリュームの各アイテム
					bin.readUInt16(); // ポジション
					bin.readUInt8(); // ボリューム
					// 楽器
					bin.readUInt8();
					inst = bin.result;
					
					if(inst == 0){
						if(tnum == 1){ trackIsDrumMode1 = 1; }
						if(tnum == 2){ trackIsDrumMode2 = 1; }
						if(tnum == 3){ trackIsDrumMode3 = 1; }
						if(tnum == 4){ trackIsDrumMode4 = 1; }
						if(tnum == 5){ trackIsDrumMode5 = 1; }
						if(tnum == 6){ trackIsDrumMode6 = 1; }
						if(tnum == 7){ trackIsDrumMode7 = 1; }
						if(tnum == 8){ trackIsDrumMode8 = 1; }
						if(tnum == 9){ trackIsDrumMode9 = 1; }
						if(tnum == 10){ trackIsDrumMode10 = 1; }
					}else{
						if(tnum == 1){ trackInstrument1 = inst; }
						if(tnum == 2){ trackInstrument2 = inst; }
						if(tnum == 3){ trackInstrument3 = inst; }
						if(tnum == 4){ trackInstrument4 = inst; }
						if(tnum == 5){ trackInstrument5 = inst; }
						if(tnum == 6){ trackInstrument6 = inst; }
						if(tnum == 7){ trackInstrument7 = inst; }
						if(tnum == 8){ trackInstrument8 = inst; }
						if(tnum == 9){ trackInstrument9 = inst; }
						if(tnum == 10){ trackInstrument10 = inst; }
					}
				}
				if(tag == 4){
					// トラック番号
					bin.readUInt4();
					tnum = bin.result;
					//bin.readUInt8(); // パターン番号（いまはまだ使わないので封印）
					bin.readUInt16(); // 個数
					cnt = bin.result;
					bin.readUInt16(); // 一個当たりのビット数
					sizeSub = bin.result;
					repeat(cnt){
						position2 = bin.position;
						bin.readUInt16(); // 開始時間
						time = mathFloor(bin.result * scaleVal);
						//bin.readBit(); // パターンかどうか (いまはまだ使わない)
						bin.readUInt8(); // 音の高さ／ドラムの種類
						note = bin.result;
						if(tnum == 1 && trackIsDrumMode1 == 1 || tnum == 2 && trackIsDrumMode2 == 1 || tnum == 3 && trackIsDrumMode3 == 1
						|| tnum == 4 && trackIsDrumMode4 == 1 || tnum == 5 && trackIsDrumMode5 == 1 || tnum == 6 && trackIsDrumMode6 == 1
						|| tnum == 7 && trackIsDrumMode7 == 1 || tnum == 8 && trackIsDrumMode8 == 1 || tnum == 9 && trackIsDrumMode9 == 1
						|| tnum == 10 && trackIsDrumMode10 == 1){
							// ドラムモードなので調整
							note = note + DRUM1_NOTENUM - 1;
						}
						i = MAX_NOTE - note;
						bin.readUInt11(); // 長さ
						beat = mathFloor(bin.result * scaleVal);
						
						j = time;
						num1 = 1;
						num2 = beat;
						repeat(beat){
							s = join(num1, join("/", join(num2, "/")));
							if(tnum == 1){ trackTimeline1[i * timelineNumber + j + 1] = s; }
							if(tnum == 2){ trackTimeline2[i * timelineNumber + j + 1] = s; }
							if(tnum == 3){ trackTimeline3[i * timelineNumber + j + 1] = s; }
							if(tnum == 4){ trackTimeline4[i * timelineNumber + j + 1] = s; }
							if(tnum == 5){ trackTimeline5[i * timelineNumber + j + 1] = s; }
							if(tnum == 6){ trackTimeline6[i * timelineNumber + j + 1] = s; }
							if(tnum == 7){ trackTimeline7[i * timelineNumber + j + 1] = s; }
							if(tnum == 8){ trackTimeline8[i * timelineNumber + j + 1] = s; }
							if(tnum == 9){ trackTimeline9[i * timelineNumber + j + 1] = s; }
							if(tnum == 10){ trackTimeline10[i * timelineNumber + j + 1] = s; }
							num1++;
							j++;
						}
						bin.position = position2 + sizeSub;
					}
				}
				bin.position = position1 + dataSize;
			}
		}
		
	}
	
	// タイムラインに書き写す
	copyTimelineFromNewTrack();
	
	horizontalScrillMax = timelineNumber * zoomLevel / minimumBeat - MAX_CELL_W;
	
	broadcast(MSG_INSTRUMENTINDEX_CHANGED);
	broadcast(MSG_DRUMMODE_CHANGED);
	broadcast(MSG_LOAD_DATA_COMPLETE);		
}


// セーブデータを開く(古いデータ)
[ProcDef(fastmode="true")]
function loadDataOld(saveData:String){
	// いったんクリア
	resetParam();	
	if(!(saveData == "")){
		i = 2;
		cnt = stringLength(saveData);
		cnt2 = 0;
		tmp = "";
		repeat(cnt){
			s = letterOf(i, saveData);
			if(s == "|"){
				if(cnt2 == 0){tempoValue = tmp;}
				if(cnt2 == 1){
					endLineTime = mathFloor(tmp * 8 * minimumBeat / 8) + 1;
					// もしエンドタイムが長ければタイムラインを長くする
					tmp = mathCeiling(endLineTime / DEFAULT_TIMELINE_NUMBER) * DEFAULT_TIMELINE_NUMBER;
					if(timelineNumber < tmp){
						horizontalScrillMax += tmp - timelineNumber;
						timelineNumber = tmp;
						createTimelineList();
					}
				}
				if(cnt2 == 2){isLoopMode = tmp;}
				if(cnt2 > 2){s1cnt2 = 0;}
				cnt2++;
				tmp = "";
			}else{
				if(s == "@"){
					if(s1cnt2 == 0){time = tmp;}
					if(s1cnt2 == 1){
						s2cnt2 = 0;
						s3cnt2 = 0;
					}
					s1cnt2++;
					tmp = "";
				}else{
					if(s == "$"){
						s3cnt2 = 0;
						tmp = "";
					}else{
						if(s == "/"){
							if(s3cnt2 == 0){ tnum = tmp;}
							if(s3cnt2 == 1){ inst = tmp;}
							if(s3cnt2 == 2){ note = tmp; }
							if(s3cnt2 == 3){ beat = tmp; }
							if(s3cnt2 == 3){ 
								if(!(inst == 0 && note == 0 && beat == 0)){
									if(note == 0){
										// ドラムモード
										if(tnum == 1){ trackIsDrumMode1 = 1; }
										if(tnum == 2){ trackIsDrumMode2 = 1; }
										if(tnum == 3){ trackIsDrumMode3 = 1; }
										note = inst + DRUM1_NOTENUM - 1;
									}else{
										if(tnum == 1){ trackInstrument1 = inst; }
										if(tnum == 2){ trackInstrument2 = inst; }
										if(tnum == 3){ trackInstrument3 = inst; }
									}
									loadDataWriteCell();
								}
							}
							s3cnt2++;
							tmp = "";
						}else{
							tmp = join(tmp, s);
						}
					}
				}
			}
			i++;
		}
	}
	// タイムラインに書き写す
	copyTimelineFromNewTrack();
	
	horizontalScrillMax = timelineNumber * zoomLevel / minimumBeat - MAX_CELL_W;
	
	broadcast(MSG_INSTRUMENTINDEX_CHANGED);
	broadcast(MSG_DRUMMODE_CHANGED);
	broadcast(MSG_LOAD_DATA_COMPLETE);	
}

[ProcDef(fastmode="true")]
function loadDataWriteCell(){
	s4tmp = MAX_NOTE - note;
	s4tmp = s4tmp * timelineNumber + round(time / 0.125 * minimumBeat / 8);
	index = s4tmp + 1;
	num2 = beat / 0.125 * minimumBeat / 8;
	num1 = 1;
	
	repeat(num2){
		s4tmp = join(num1, join("/", join(num2, "/")));
		
		if(tnum == 1){ trackTimeline1[index] = s4tmp; }
		if(tnum == 2){ trackTimeline2[index] = s4tmp; }
		if(tnum == 3){ trackTimeline3[index] = s4tmp; }
		if(tnum == 4){ trackTimeline4[index] = s4tmp; }
		if(tnum == 5){ trackTimeline5[index] = s4tmp; }
		if(tnum == 6){ trackTimeline6[index] = s4tmp; }
		if(tnum == 7){ trackTimeline7[index] = s4tmp; }
		if(tnum == 8){ trackTimeline8[index] = s4tmp; }
		if(tnum == 9){ trackTimeline9[index] = s4tmp; }
		if(tnum == 10){ trackTimeline10[index] = s4tmp; }
		
		num1++;
		index++;
	}
}

// トラックナンバーが変わったらタイムラインを変える
[ProcDef(fastmode="true")]
function onTrackNumberChanged(){
	if(!(localTrackNumber == trackNumber)){
		// タイムラインを古いトラックに書き写す
		copyTimelineToOldTrack();
		
		localTrackNumber = trackNumber;
		
		// 新しいトラックをタイムラインに書き写す
		copyTimelineFromNewTrack();
		
		broadcast(MSG_INSTRUMENTINDEX_CHANGED);
		broadcast(MSG_DRUMMODE_CHANGED);
		broadcast(MSG_LOAD_DATA_COMPLETE);
	}
}

[ProcDef(fastmode="true")]
function copyTimelineToOldTrack(){
	// 楽器を古いトラックに書き写す
	if(localTrackNumber == 1){ trackInstrument1 = instrumentIndex; }
	if(localTrackNumber == 2){ trackInstrument2 = instrumentIndex; }
	if(localTrackNumber == 3){ trackInstrument3 = instrumentIndex; }
	if(localTrackNumber == 4){ trackInstrument4 = instrumentIndex; }
	if(localTrackNumber == 5){ trackInstrument5 = instrumentIndex; }
	if(localTrackNumber == 6){ trackInstrument6 = instrumentIndex; }
	if(localTrackNumber == 7){ trackInstrument7 = instrumentIndex; }
	if(localTrackNumber == 8){ trackInstrument8 = instrumentIndex; }
	if(localTrackNumber == 9){ trackInstrument9 = instrumentIndex; }
	if(localTrackNumber == 10){ trackInstrument10 = instrumentIndex; }
	// ドラムモードを古いトラックに書き写す
	if(localTrackNumber == 1){ trackIsDrumMode1 = isDrumMode; }
	if(localTrackNumber == 2){ trackIsDrumMode2 = isDrumMode; }
	if(localTrackNumber == 3){ trackIsDrumMode3 = isDrumMode; }
	if(localTrackNumber == 4){ trackIsDrumMode4 = isDrumMode; }
	if(localTrackNumber == 5){ trackIsDrumMode5 = isDrumMode; }
	if(localTrackNumber == 6){ trackIsDrumMode6 = isDrumMode; }
	if(localTrackNumber == 7){ trackIsDrumMode7 = isDrumMode; }
	if(localTrackNumber == 8){ trackIsDrumMode8 = isDrumMode; }
	if(localTrackNumber == 9){ trackIsDrumMode9 = isDrumMode; }
	if(localTrackNumber == 10){ trackIsDrumMode10 = isDrumMode; }
}

[ProcDef(fastmode="true")]
function copyTimelineFromNewTrack(){
	// 新しいトラックを楽器に書き写す
	if(localTrackNumber == 1){ instrumentIndex = trackInstrument1; }
	if(localTrackNumber == 2){ instrumentIndex = trackInstrument2; }
	if(localTrackNumber == 3){ instrumentIndex = trackInstrument3; }
	if(localTrackNumber == 4){ instrumentIndex = trackInstrument4; }
	if(localTrackNumber == 5){ instrumentIndex = trackInstrument5; }
	if(localTrackNumber == 6){ instrumentIndex = trackInstrument6; }
	if(localTrackNumber == 7){ instrumentIndex = trackInstrument7; }
	if(localTrackNumber == 8){ instrumentIndex = trackInstrument8; }
	if(localTrackNumber == 9){ instrumentIndex = trackInstrument9; }
	if(localTrackNumber == 10){ instrumentIndex = trackInstrument10; }
	// 新しいトラックをドラムモードに書き写す
	if(localTrackNumber == 1){ isDrumMode = trackIsDrumMode1; }
	if(localTrackNumber == 2){ isDrumMode = trackIsDrumMode2; }
	if(localTrackNumber == 3){ isDrumMode = trackIsDrumMode3; }
	if(localTrackNumber == 4){ isDrumMode = trackIsDrumMode4; }
	if(localTrackNumber == 5){ isDrumMode = trackIsDrumMode5; }
	if(localTrackNumber == 6){ isDrumMode = trackIsDrumMode6; }
	if(localTrackNumber == 7){ isDrumMode = trackIsDrumMode7; }
	if(localTrackNumber == 8){ isDrumMode = trackIsDrumMode8; }
	if(localTrackNumber == 9){ isDrumMode = trackIsDrumMode9; }
	if(localTrackNumber == 10){ isDrumMode = trackIsDrumMode10; }
}

[ProcDef(fastmode="true")]
function extendTimeline(){	
	k = 1;
	repeat(maxTrackNumber){
		// 一時リストにコピー
		i = 1;
		repeat(timelineNumber * MAX_NOTE){
			if(k == 1){ tempListForExtends[i] = trackTimeline1[i]; }
			if(k == 2){ tempListForExtends[i] = trackTimeline2[i]; }
			if(k == 3){ tempListForExtends[i] = trackTimeline3[i]; }
			if(k == 4){ tempListForExtends[i] = trackTimeline4[i]; }
			if(k == 5){ tempListForExtends[i] = trackTimeline5[i]; }
			if(k == 6){ tempListForExtends[i] = trackTimeline6[i]; }
			if(k == 7){ tempListForExtends[i] = trackTimeline7[i]; }
			if(k == 8){ tempListForExtends[i] = trackTimeline8[i]; }
			if(k == 9){ tempListForExtends[i] = trackTimeline9[i]; }
			if(k == 10){ tempListForExtends[i] = trackTimeline10[i]; }
			i++;
		}
		
		// 空にする
		deleteOf(LIST_DELETE_ALL, join("trackTimeline", k));
		// 長くする
		m = timelineNumber + DEFAULT_TIMELINE_NUMBER;
		m *= MAX_NOTE;
		repeat(m){
			addTo(0, join("trackTimeline", k));
		}
		
		// 値を埋める
		m = timelineNumber + DEFAULT_TIMELINE_NUMBER;
		j = MAX_NOTE - 1;
		repeat(MAX_NOTE){
			i = 0;
			repeat(timelineNumber){
				index = j * m + i + 1;
				l = j * timelineNumber + i + 1;
				if(k == 1){ trackTimeline1[index] = tempListForExtends[l]; }
				if(k == 2){ trackTimeline2[index] = tempListForExtends[l]; }
				if(k == 3){ trackTimeline3[index] = tempListForExtends[l]; }
				if(k == 4){ trackTimeline4[index] = tempListForExtends[l]; }
				if(k == 5){ trackTimeline5[index] = tempListForExtends[l]; }
				if(k == 6){ trackTimeline6[index] = tempListForExtends[l]; }
				if(k == 7){ trackTimeline7[index] = tempListForExtends[l]; }
				if(k == 8){ trackTimeline8[index] = tempListForExtends[l]; }
				if(k == 9){ trackTimeline9[index] = tempListForExtends[l]; }
				if(k == 10){ trackTimeline10[index] = tempListForExtends[l]; }
				i++;
			}
			j--;
		}
		k++;
	}
	
	// tempリストも長くしとく
	i = 1;
	repeat(DEFAULT_TIMELINE_NUMBER * MAX_NOTE){
		addTo(0, tempListForExtends);
		i++;
	}
	
	
	/*
	j = MAX_NOTE - 1;
	repeat(MAX_NOTE){
		i = timelineNumber - 1;
		repeat(DEFAULT_TIMELINE_NUMBER){
			index = j * timelineNumber + i + 1;
			insertAtOf(0, index, trackTimeline1);
			insertAtOf(0, index, trackTimeline2);
			insertAtOf(0, index, trackTimeline3);
			insertAtOf(0, index, trackTimeline4);
			insertAtOf(0, index, trackTimeline5);
			insertAtOf(0, index, trackTimeline6);
			insertAtOf(0, index, trackTimeline7);
			insertAtOf(0, index, trackTimeline8);
			insertAtOf(0, index, trackTimeline9);
			insertAtOf(0, index, trackTimeline10);
			i++;
		}
		j--;
	}
	*/
	timelineNumber += DEFAULT_TIMELINE_NUMBER;
	horizontalScrillMax = timelineNumber * zoomLevel / minimumBeat - MAX_CELL_W;
	horizontalScrollPosition++;
}

// MinimumBeat
function changeMinumumBeat(){
	copyTimelineToOldTrack();
	analyzeTimeline(-1);
	previousSavedData = analyzedData;
	changeMinumumBeatSub();
}
function changeMinumumBeatSub(){
	loadData(previousSavedData, settingVariable);
}
// MaxTrackNumber
function changeMaxTrackNumber(){
	copyTimelineToOldTrack();
	maxTrackNumber = settingVariable;
	analyzeTimeline(-1);
	previousSavedData = analyzedData;
	changeMaxTrackNumberSub();
}

function changeMaxTrackNumberSub(){
	loadData(previousSavedData, 0);
}
