
// timer を使っている関係上、再生途中で resetTimer がよばれるとおかしくなります。

// インスタンスの種類
var kind;
const KIND_ORIGINAL = "kindOriginal";
const KIND_GENERATOR = "kindGenerator";

// 与えられた音
var soundData;

// 汎用
var i, j, s, cnt, tmp, tmp2;
var outValue;

// メインループが音を解析する用
var tempoValue;
var wholeLength;
var isLoopMode;
var waitTime;

var waitList = [];
var noteList = [];
var instList = [];
var beatList = [];

var currentIndex;

// 最小単位
var minBeat;
// 次の時間
var nextTime, currentTime;

// クローンが音を鳴らす用
var inst, note, beat;

var bin = new BinaryUtility();
var trackTimeline1 = [];
var trackTimeline2 = [];
var trackTimeline3 = [];
var trackTimeline4 = [];
var trackTimeline5 = [];
var trackTimeline6 = [];
var trackTimeline7 = [];
var trackTimeline8 = [];
var trackTimeline9 = [];
var trackTimeline10 = [];
var endLineTime;
var tnum;
var trackIsDrumMode1, trackInstrument1;
var trackIsDrumMode2, trackInstrument2;
var trackIsDrumMode3, trackInstrument3;
var trackIsDrumMode4, trackInstrument4;
var trackIsDrumMode5, trackInstrument5;
var trackIsDrumMode6, trackInstrument6;
var trackIsDrumMode7, trackInstrument7;
var trackIsDrumMode8, trackInstrument8;
var trackIsDrumMode9, trackInstrument9;
var trackIsDrumMode10, trackInstrument10;
var cnt, position1, position2, dataSize, sizeSub, tag, time;
var isDirectPlay = -1;
var isLoopRunning = -1;
// 曲番号
var musicNumber = -1;
// 最大トラック数
var maxTNum = 3;

function scripts(){
	whenFlagClicked(function(){
		kind = KIND_ORIGINAL;
		deleteOf(LIST_DELETE_ALL, soundPlayerPlayingNoteList);
		deleteOf(LIST_DELETE_ALL, soundPlayerPlayingBeatList);
		deleteOf(LIST_DELETE_ALL, soundPlayerPlayingInstList);
		soundPlayerInstanceNumber = 0;
	});
	
	whenIReceive(SOUNDPLAYER_PLAY, function(){
		if(kind == KIND_ORIGINAL){
			// オリジナルは音を鳴らすためにジェネレーターを作る
			musicNumber = -1;
			isDirectPlay = -1;
			kind = KIND_GENERATOR;
			soundData = dataForSoundPlayer;
			createCloneOf(CLONETARGET_MYSELF);
			kind = KIND_ORIGINAL;
		}
	});
	
	
	
	whenIReceive(SOUNDPLAYER_PREPARE, function(){
		if(kind == KIND_ORIGINAL){
			musicNumber = soundPlayerMusicNumber;
			isDirectPlay = -1;
			kind = KIND_GENERATOR;
			soundData = dataForSoundPlayer;
			createCloneOf(CLONETARGET_MYSELF);
			kind = KIND_ORIGINAL;
		}
	});
	
	// 曲の数だけメッセージをわけておく
	// そうしないと、ジェネレーターのループがが自分の曲じゃないメッセージをうけて止まってしまう
	whenIReceive(SOUNDPLAYER_PLAY_1,  function(){ startSoundLoop(1);});
	whenIReceive(SOUNDPLAYER_PLAY_2,  function(){ startSoundLoop(2);});
	whenIReceive(SOUNDPLAYER_PLAY_3,  function(){ startSoundLoop(3);});
	whenIReceive(SOUNDPLAYER_PLAY_4,  function(){ startSoundLoop(4);});
	whenIReceive(SOUNDPLAYER_PLAY_5,  function(){ startSoundLoop(5);});
	whenIReceive(SOUNDPLAYER_PLAY_6,  function(){ startSoundLoop(6);});
	whenIReceive(SOUNDPLAYER_PLAY_7,  function(){ startSoundLoop(7);});
	whenIReceive(SOUNDPLAYER_PLAY_8,  function(){ startSoundLoop(8);});
	whenIReceive(SOUNDPLAYER_PLAY_9,  function(){ startSoundLoop(9);});
	whenIReceive(SOUNDPLAYER_PLAY_10, function(){ startSoundLoop(10);});
	
	
	whenIReceive(SOUNDPLAYER_DIRECT_PLAY, function(){
		if(kind == KIND_ORIGINAL){
			// オリジナルは音を鳴らすためにジェネレーターを作る
			musicNumber = -1;
			isDirectPlay = 1;
			kind = KIND_GENERATOR;
			createCloneOf(CLONETARGET_MYSELF);
			kind = KIND_ORIGINAL;
		}
	});
	
	
	
	whenIReceive(SOUNDPLAYER_STOP, function(){
		if(kind == KIND_GENERATOR){
			soundPlayerInstanceNumber--;
			isLoopRunning = -1;
			deleteThisClone();
		}
	});
	
	whenIReceive(SOUNDPLAYER_STOP_WITH_NUMBER, function(){
		if(kind == KIND_GENERATOR && musicNumber == soundPlayerMusicNumber){
			isLoopRunning = -1;
		}
	});
	
	whenIStartAsAClone(function(){
		if(kind == KIND_GENERATOR){
			soundPlayerInstanceNumber++;
			
			// GENERATORはクローンされたら音を解析する
			if(isDirectPlay == -1){
				createDataList();
			}else{
				tempoValue = soundPlayerDirectPlayTempo;
				isLoopMode = soundPlayerDirectPlayIsLoopMode;
			}
			tempo = tempoValue;
			
			// 曲名が指定されてないときだけ鳴らす
			if(musicNumber == -1){				
				currentIndex = 1;
				
				nextTime = 0;
				currentTime = 0;
				
				isLoopRunning = 1;
				checkForSoundLoop();
			}
		}
	});
}

function startSoundLoop(selectedNumber:int){
	if(kind == KIND_GENERATOR && !(musicNumber == -1) && musicNumber == selectedNumber){
		currentIndex = 1;
		
		nextTime = 0;
		currentTime = 0;
		
		isLoopRunning = 1;
		checkForSoundLoop();
	}
}

// (ジェネレーター)メインループが待ち時間と、トーンのセットを抽出する
[ProcDef(fastmode="true")]
function createDataList(){
	
	deleteOf(LIST_DELETE_ALL, waitList);
	deleteOf(LIST_DELETE_ALL, noteList);
	deleteOf(LIST_DELETE_ALL, instList);
	deleteOf(LIST_DELETE_ALL, beatList);
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
	
	if(!(soundData == "")){
		if(letterOf(1, soundData) == "#"){
			createDataListOneNote();
		}else{
			createDataListBinary();
		}
	}
}

[ProcDef(fastmode="true")]
function createDataListOneNote(){
	isLoopMode = -1;
	
	j = 2;
	cnt = 0;
	tmp = "";
	repeat(stringLength(soundData)){
		s = letterOf(j, soundData);
		if(s == "/"){
			if(cnt == 0){ inst = tmp; }
			if(cnt == 1){ note = tmp; }
			if(cnt == 2){ beat = tmp; }
			cnt++;
			tmp = "";
		}else{
			tmp = join(tmp, s);
		}
		j++;
	}
	addTo(0, waitList);
	addTo(inst, instList);
	addTo(note, noteList);
	addTo(beat, beatList);
	
	
	addTo(0.5, waitList);
	addTo("end", instList);
	tempoValue = 60;
}


[ProcDef(fastmode="true")]
function createDataListBinary(){
	bin.init();
	bin.setKanji(soundData);
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
				minBeat = tmp;
				
				// 最後の時間
				bin.readUInt16();
				endLineTime = bin.result + 1;
				
				// テンポ（まだ今は１個だけ）
				bin.readUInt16();
				bin.readUInt8(); // 一個当たりのビット数
				// テンポの各アイテム
				bin.readUInt16(); // ポジション
				bin.readUInt11(tempoValue); // テンポ数
				tempoValue = bin.result;
				
				// 最初の時間
				if(bin.position < position1 + dataSize){
					bin.readUInt16(); // 読み取るだけで特になにもしない
				}
				
				// 最大トラック数
				if(bin.position < position1 + dataSize){
					bin.readUInt4();
					maxTNum = bin.result;
				}
				
				// エンドタイムまでタイムラインを伸ばす
				i = 1;
				repeat(maxTNum){
					repeat(endLineTime){
						addTo("", join("trackTimeline", i));
					}
					i++;
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
				//bin.readUInt8(); // パターン番号（いまはまだ使わない）
				bin.readUInt16(); // 個数
				cnt = bin.result;
				bin.readUInt16(); // 一個当たりのビット数
				sizeSub = bin.result;
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
				repeat(cnt){
					position2 = bin.position;
					bin.readUInt16(); // 開始時間
					time = bin.result + 1;
					//bin.readBit(); // パターンかどうか (いまはまだ使わない)
					bin.readUInt8(); // 音の高さ／ドラムの種類
					note = bin.result;
					bin.readUInt11(); // 長さ
					beat = bin.result;
					beat /= minBeat; // 1マス ○分音符
					
					if(tnum == 1 && trackIsDrumMode1 == 1 || tnum == 2 && trackIsDrumMode2 == 1 || tnum == 3 && trackIsDrumMode3 == 1
					|| tnum == 4 && trackIsDrumMode4 == 1 || tnum == 5 && trackIsDrumMode5 == 1 || tnum == 6 && trackIsDrumMode6 == 1
					|| tnum == 7 && trackIsDrumMode7 == 1 || tnum == 8 && trackIsDrumMode8 == 1 || tnum == 9 && trackIsDrumMode9 == 1
					|| tnum == 10 && trackIsDrumMode10 == 1){
						// ドラムモードなので調整
						inst = note;
						note = 0;
					}else{
						// Piano, Guitar, Electric Guitar, Vibraphone, Music Box, Steel Drum, Marimba
						if(inst == 1 || inst == 4 || inst == 5 || inst == 16 || inst == 17 || inst == 18 || inst == 19){
							if(beat < 1){
								beat = 1;
							}
						}
					}
					
					// サンプル 1/1/67/0.5/$
					if(tnum == 1){ s = trackTimeline1[time]; }
					if(tnum == 2){ s = trackTimeline2[time]; }
					if(tnum == 3){ s = trackTimeline3[time]; }
					if(tnum == 4){ s = trackTimeline4[time]; }
					if(tnum == 5){ s = trackTimeline5[time]; }
					if(tnum == 6){ s = trackTimeline6[time]; }
					if(tnum == 7){ s = trackTimeline7[time]; }
					if(tnum == 8){ s = trackTimeline8[time]; }
					if(tnum == 9){ s = trackTimeline9[time]; }
					if(tnum == 10){ s = trackTimeline10[time]; }
					s =  join(s, join(inst, join("/", join(note, join("/", join(beat, "/$"))))));
					if(tnum == 1){ trackTimeline1[time] = s; }
					if(tnum == 2){ trackTimeline2[time] = s; }
					if(tnum == 3){ trackTimeline3[time] = s; }
					if(tnum == 4){ trackTimeline4[time] = s; }
					if(tnum == 5){ trackTimeline5[time] = s; }
					if(tnum == 6){ trackTimeline6[time] = s; }
					if(tnum == 7){ trackTimeline7[time] = s; }
					if(tnum == 8){ trackTimeline8[time] = s; }
					if(tnum == 9){ trackTimeline9[time] = s; }
					if(tnum == 10){ trackTimeline10[time] = s; }
					bin.position = position2 + sizeSub;
				}
				
			}
			bin.position = position1 + dataSize;
			
		}
	}
	
	
	// タイムラインから waitListとnoteListを作る
	i = 1;
	repeat(endLineTime){
		tnum = 1;
		repeat(maxTNum){
			if(tnum == 1){ tmp2 = trackTimeline1[i]; }
			if(tnum == 2){ tmp2 = trackTimeline2[i]; }
			if(tnum == 3){ tmp2 = trackTimeline3[i]; }
			if(tnum == 4){ tmp2 = trackTimeline4[i]; }
			if(tnum == 5){ tmp2 = trackTimeline5[i]; }
			if(tnum == 6){ tmp2 = trackTimeline6[i]; }
			if(tnum == 7){ tmp2 = trackTimeline7[i]; }
			if(tnum == 8){ tmp2 = trackTimeline8[i]; }
			if(tnum == 9){ tmp2 = trackTimeline9[i]; }
			if(tnum == 10){ tmp2 = trackTimeline10[i]; }
			if(!(tmp2 == "")){
				time = i - 1;
				time /= minBeat;
				
				j = 1;
				cnt = 0;
				tmp = "";
				repeat(stringLength(tmp2)){
					s = letterOf(j, tmp2);
					if(s == "/"){
						if(cnt == 0){ inst = tmp; }
						if(cnt == 1){ note = tmp; }
						if(cnt == 2){ beat = tmp; }
						cnt++;
						tmp = "";
					}else{
						if(s == "$") {
							addTo(time, waitList);
							addTo(inst, instList);
							addTo(note, noteList);
							addTo(beat, beatList);
							cnt = 0;
							tmp = "";
						} else {
							tmp = join(tmp, s);
						}
					}
					j++;
				}
			}
			tnum++;
		}
		i++;
	}
	// 最後の時間を入れる
	time = endLineTime - 1;
	time = time / minBeat; // 1マス ○分音符
	addTo(time, waitList);
	addTo("end", instList);
}

// (ジェネレーター)メインループが音を鳴らす時間になったら鳴らす
function checkForSoundLoop(){
	checkForSoundLoopSub();
	if(currentTime < nextTime){
		waitTime = nextTime - currentTime;
		wait(waitTime);
		currentTime = nextTime;
		if(isLoopRunning == 1){
			checkForSoundLoop();
		}
	}
}

[ProcDef(fastmode="true")]
function checkForSoundLoopSub(){
	repeatUntil(currentTime < nextTime || isLoopRunning == -1){
		tmp2 = 60 / tempoValue;
		if(isDirectPlay == 1) {
			nextTime = soundPlayerDirectPlayWaitList[currentIndex] * tmp2;
		}else{
			nextTime = waitList[currentIndex] * tmp2;
		}
		if(currentTime == nextTime){
			// 時間が来たので鳴らす
			if(isDirectPlay == 1) {
				tmp = soundPlayerDirectPlayInstList[currentIndex];
			}else{
				tmp = instList[currentIndex];
			}
			if( tmp == "end" ){
				// これが来たらループ
				if(isLoopMode == 1){
					currentIndex = 1;
					currentTime = 0;
					nextTime = 0;
				}else{
					// 終了
					// 曲番号が指定されている場合は、また呼び出されるかもしれないのでインスタンスを消さない
					if(musicNumber == -1){ 
						broadcast(SOUNDPLAYER_PLAY_COMPLETE);
						soundPlayerInstanceNumber--;
						deleteThisClone();
					}else{
						isLoopRunning = -1;
					}
				}
			}else{
				executePlay();
				// インデックス増やす
				currentIndex++;
			}
		}
	}
}

// (ジェネレーター)データを解析してクローンを作って鳴らす
[ProcDef(fastmode="true")]
function executePlay(){
	if (isDirectPlay == 1) {
		inst = soundPlayerDirectPlayInstList[currentIndex];
		note = soundPlayerDirectPlayNoteList[currentIndex];
		beat = soundPlayerDirectPlayBeatList[currentIndex];
	}else{
		inst = instList[currentIndex];
		note = noteList[currentIndex];
		beat = beatList[currentIndex];
	}
	addTo(note, soundPlayerPlayingNoteList);
	addTo(inst, soundPlayerPlayingInstList);
	addTo(beat, soundPlayerPlayingBeatList);
	
	createCloneOf("SoundPlayerNote");
}

