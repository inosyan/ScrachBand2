
var sp = new SoundPlayerBase();

//[Variable(name="DEBUG", visible=true, x=10, y=100, mode=1, sliderMin=0, sliderMax=100)]
//var debug;

// 汎用
var i, j, s, k, cnt;
var tmp, val, tmp2, tmp3, index;
var outValue;

// スクロール値
var localScrollH;
var localScrollV;

// 垂直スクロール用
var note;

// マウスダウン用
var isMouseDown;
var posX, posY;

// セルユーティリティ
var cellUtil = new CellUtilBase();



function scripts(){
	whenFlagClicked(function(){
		hide();
	});
	
	whenIReceive(MSG_LOAD_DATA, function(){
		// ロード中はクリックを無効にするためいったん消す
		hide();
	});
	
	whenIReceive(MSG_INITIALIZE_COMPLETE, function(){
		reset();
	});
	
	whenIReceive(MSG_LOAD_DATA_COMPLETE, function(){
		reset();
	});
	
	whenIReceive(MSG_VERTICALSCROLL_CHANGED, function(){
		onVerticalScrollChanged();
	});
	
	whenIReceive(MSG_HORIZONTALSCROLL_CHANGED, function(){
		onHorizontalScrollChanged();
	});
	
	whenIReceive(MSG_ZOOMLEVEL_CHANGED, function(){
		draw();
	});
	
	whenThisSpriteClicked(function(){
		flip();
	});
}

function reset(){
	localScrollH = 0;
	isMouseDown = -1;
	draw();
	//loop();
}

[ProcDef(fastmode="true")]
function draw(){
	clear();
	show();
	drawCell();
	drawTime();
	if(isDrumMode == 1){
		drawDrum();
	}else{
		drawNote();
	}
	//hide();
	switchCostumeTo("cellArea");
	gotoXY(-220, 160);
}

[ProcDef(fastmode="true")]
function drawCell(){
	j = 1;
	note = MAX_NOTE - verticalScrollPosition;
	repeat(MAX_CELL_H){
		
		tmp = note % 12;
		
		i = 1;
		repeat(MAX_CELL_W){
			
			tmp2 = MAX_NOTE - note;
			tmp3 = i + horizontalScrollPosition - 1;
			tmp3 *= minimumBeat / zoomLevel;
			tmp3 += 1; // 配列は1からはじまるので
			
			if(trackNumber == 1){ val = trackTimeline1[ tmp2 * timelineNumber + tmp3 ]; }
			if(trackNumber == 2){ val = trackTimeline2[ tmp2 * timelineNumber + tmp3 ]; }
			if(trackNumber == 3){ val = trackTimeline3[ tmp2 * timelineNumber + tmp3 ]; }
			if(trackNumber == 4){ val = trackTimeline4[ tmp2 * timelineNumber + tmp3 ]; }
			if(trackNumber == 5){ val = trackTimeline5[ tmp2 * timelineNumber + tmp3 ]; }
			if(trackNumber == 6){ val = trackTimeline6[ tmp2 * timelineNumber + tmp3 ]; }
			if(trackNumber == 7){ val = trackTimeline7[ tmp2 * timelineNumber + tmp3 ]; }
			if(trackNumber == 8){ val = trackTimeline8[ tmp2 * timelineNumber + tmp3 ]; }
			if(trackNumber == 9){ val = trackTimeline9[ tmp2 * timelineNumber + tmp3 ]; }
			if(trackNumber == 10){ val = trackTimeline10[ tmp2 * timelineNumber + tmp3 ]; }
			if(val == 0){
				if(isDrumMode == 1){
					if(DRUM1_NOTENUM <= note && note < DRUM1_NOTENUM + DRUM_MAX){
						switchCostumeTo("blank1");
					}else{
						switchCostumeTo("blank2");
					}
				}else{
					if(tmp == 0 || tmp == 2 || tmp == 4 || tmp == 5 || tmp == 7 || tmp == 9 || tmp == 11){
						switchCostumeTo("blank1");
					}else{
						switchCostumeTo("blank2");
					}
				}
				if(tmp3 == startLineTime){
					switchCostumeTo("startcell");
				}
				if(tmp3 == endLineTime){
					switchCostumeTo("endcell");
				}
			}else{
				drawSelectedCell(val);
			}
			gotoXY(-240 + i * 20, 180 - j * 20);
			stamp();
			i++;
		}
		note--;
		j++;
	}
}

// 選ばれたセルを描画（セルをつなげたりする）
[ProcDef(fastmode="true")]
function drawSelectedCell(cellValue:String){
	cellUtil.checkNum1Num2(cellValue);
	if(cellUtil.num1 == 1 && cellUtil.num2 == 1){
		// 一つのセル
		switchCostumeTo("sel");
	}else{
		// 続きのセル
		if(cellUtil.num1 == 1){
			// はじめのセル
			switchCostumeTo("sel_l");
		}else{
			if(cellUtil.num1 == cellUtil.num2){
				// 最後のセル
				switchCostumeTo("sel_r");
			}else{
				// まんなかのセル
				switchCostumeTo("sel_c");
			}
		}
	}
}

[ProcDef(fastmode="true")]
function drawTime(){
	j = 0;
	tmp = horizontalScrollPosition;
	repeat(MAX_CELL_W){
		if(tmp % 8 == 0){
			gotoXY(-220 + 4 + j * 20, 180 - 12);
			drawLabel(tmp / zoomLevel);
		}
		j++;
		tmp++;
	}
}

[ProcDef(fastmode="true")]
function drawNote(){
	j = 0;
	note = MAX_NOTE - verticalScrollPosition;
	repeat(MAX_CELL_H){
		tmp = note % 12;
		if(tmp == 0){
			gotoXY(-240 + 5, 160 - 10 - j * 20);
			drawLabel(join("c", mathFloor(note / 12) - 1));
		}
		note--;
		j++;
	}
}

[ProcDef(fastmode="true")]
function drawDrum(){
	j = 0;
	note = MAX_NOTE - verticalScrollPosition;
	repeat(MAX_CELL_H){
		if(DRUM1_NOTENUM <= note && note < DRUM1_NOTENUM + DRUM_MAX){
			tmp = note - DRUM1_NOTENUM + 1;
			if(tmp < 10){
				gotoXY(-240 + 10, 160 - 10 - j * 20);
			}else{
				gotoXY(-240 + 5, 160 - 10 - j * 20);
			}
			drawLabel(tmp);
			// ラベル
			gotoXY(-195, 160 - 10 - j * 20);
			switchCostumeTo(join("drum", tmp));
			stamp();
		}
		note--;
		j++;
	}
}


[ProcDef(fastmode="true")]
function drawLabel(label:String){
	i = 1;
	repeat(stringLength(label)){
		s = letterOf(i, label);
		switchCostumeTo(join("n", s));
		stamp();
		xpos += 10;
		i++;
	}
}

[ProcDef(fastmode="true")]
function onVerticalScrollChanged(){
	if(disableUI == -1){ // 保存データ表示中は無視する
		if(!(localScrollV == verticalScrollPosition)){
			localScrollV = verticalScrollPosition;
			draw();
		}
	}
}

[ProcDef(fastmode="true")]
function onHorizontalScrollChanged(){
	if(disableUI == -1){ // 保存データ表示中は無視する
		if(!(localScrollH == horizontalScrollPosition)){
			localScrollH = horizontalScrollPosition;
			draw();
		}
	}
}

//[ProcDef(fastmode="true")]
function flip(){
	// 左上基準、Yが下に増えるように直す
	posX = mouseX + 220;
	posY = mouseY - 160;
	posY *= -1;
	// セルに直す
	posX = mathFloor(posX / 20);
	posY = mathFloor(posY / 20);
	// スクロールを考慮
	posX += horizontalScrollPosition;
	posY += verticalScrollPosition;
	// ズームを考慮
	posX *= minimumBeat / zoomLevel;
	note = MAX_NOTE - posY;
	if(isDrumMode == -1 || DRUM1_NOTENUM <= note && note < DRUM1_NOTENUM + DRUM_MAX){
		// 端っこだったらタイムラインを伸ばす
		extend(posX);
		if(editMode == EDITMODE_ENDLINE){
			// エンドラインを編集
			endLineTime = posX + 1;
			if(endLineTime < startLineTime){
				endLineTime = startLineTime;
			}
			draw();
		}else{
			if(editMode == EDITMODE_STARTLINE){
				// スタートラインを編集
				startLineTime = posX + 1;
				if(endLineTime < startLineTime){
					startLineTime = endLineTime;
				}
				draw();
			}else{
				flipSub();
			}
		}
	}
}

[ProcDef(fastmode="true")]
function flipSub(){
	// インデックス
	index = posY * timelineNumber + posX + 1;
	// セルに値を入力
	if(trackNumber == 1){ tmp = trackTimeline1[index]; }
	if(trackNumber == 2){ tmp = trackTimeline2[index]; }
	if(trackNumber == 3){ tmp = trackTimeline3[index]; }
	if(trackNumber == 4){ tmp = trackTimeline4[index]; }
	if(trackNumber == 5){ tmp = trackTimeline5[index]; }
	if(trackNumber == 6){ tmp = trackTimeline6[index]; }
	if(trackNumber == 7){ tmp = trackTimeline7[index]; }
	if(trackNumber == 8){ tmp = trackTimeline8[index]; }
	if(trackNumber == 9){ tmp = trackTimeline9[index]; }
	if(trackNumber == 10){ tmp = trackTimeline10[index]; }
	
	if(tmp == 0){
		// 指定された長さのものが入力できるかチェック
		cnt = beatNumber * minimumBeat / zoomLevel; // ズームレベルを考慮
		checkVacant(index, cnt);
		if(outValue == 1){
			i = 1;
			repeat(cnt){
				s = join(i, join("/", join(cnt, "/")));
				if(trackNumber == 1){ trackTimeline1[index] = s; }
				if(trackNumber == 2){ trackTimeline2[index] = s; }
				if(trackNumber == 3){ trackTimeline3[index] = s; }
				if(trackNumber == 4){ trackTimeline4[index] = s; }
				if(trackNumber == 5){ trackTimeline5[index] = s; }
				if(trackNumber == 6){ trackTimeline6[index] = s; }
				if(trackNumber == 7){ trackTimeline7[index] = s; }
				if(trackNumber == 8){ trackTimeline8[index] = s; }
				if(trackNumber == 9){ trackTimeline9[index] = s; }
				if(trackNumber == 10){ trackTimeline10[index] = s; }
				i++;
				index++;
			}
			// エンドライン延長
			if(posX + cnt + 1 > endLineTime){
				endLineTime = posX + cnt + 1;
			}
			// 音を鳴らす
			if(isDrumMode == 1){
				tmp = join("#", join(note - DRUM1_NOTENUM + 1, join("/", join(0, "/0.5/$"))));
			}else{
				tmp = join("#", join(instrumentIndex, join("/", join(note, "/0.5/$"))));
			}
			sp.play(tmp);
		}
	}else{
		deleteCell(index, tmp);
	}
	draw();
}


// 端っこだったらタイムラインを伸ばす
//[ProcDef(fastmode="true")]
function extend(posXVal:int){
	if(timelineNumber - posXVal < 32){
		broadcastAndWait(MSG_EXTEND_TIMELINE);
	}
}


// セルが空いているか調べる
[ProcDef(fastmode="true")]
function checkVacant(indexVal:int, length:int){
	tmp = indexVal;
	outValue = 1;
	repeat(length){
		if(trackNumber == 1){ s = trackTimeline1[tmp]; }
		if(trackNumber == 2){ s = trackTimeline2[tmp]; }
		if(trackNumber == 3){ s = trackTimeline3[tmp]; }
		if(trackNumber == 4){ s = trackTimeline4[tmp]; }
		if(trackNumber == 5){ s = trackTimeline5[tmp]; }
		if(trackNumber == 6){ s = trackTimeline6[tmp]; }
		if(trackNumber == 7){ s = trackTimeline7[tmp]; }
		if(trackNumber == 8){ s = trackTimeline8[tmp]; }
		if(trackNumber == 9){ s = trackTimeline9[tmp]; }
		if(trackNumber == 10){ s = trackTimeline10[tmp]; }
		if(!(s == 0)){
			outValue = -1;
		}
		tmp++;
	}
}

// 繋がっているセルを削除する
[ProcDef(fastmode="true")]
function deleteCell(indexVal:int, cellValue:String){
	cellUtil.checkNum1Num2(cellValue);
	tmp = indexVal;
	tmp -= cellUtil.num1;
	tmp++;
	repeat(cellUtil.num2){
		if(trackNumber == 1){ trackTimeline1[tmp] = 0; }
		if(trackNumber == 2){ trackTimeline2[tmp] = 0; }
		if(trackNumber == 3){ trackTimeline3[tmp] = 0; }
		if(trackNumber == 4){ trackTimeline4[tmp] = 0; }
		if(trackNumber == 5){ trackTimeline5[tmp] = 0; }
		if(trackNumber == 6){ trackTimeline6[tmp] = 0; }
		if(trackNumber == 7){ trackTimeline7[tmp] = 0; }
		if(trackNumber == 8){ trackTimeline8[tmp] = 0; }
		if(trackNumber == 9){ trackTimeline9[tmp] = 0; }
		if(trackNumber == 10){ trackTimeline10[tmp] = 0; }
		tmp++;
	}
}





