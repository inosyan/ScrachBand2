
function play(soundData:String){
	dataForSoundPlayer = soundData;
	broadcast(SOUNDPLAYER_PLAY);
}

/**
* サウンドプレイヤー 準備
*/
function prepare(musicNumber:int, soundData:String){
	dataForSoundPlayer = soundData;
	soundPlayerMusicNumber = musicNumber;
	broadcastAndWait(SOUNDPLAYER_PREPARE);
}

/**
* サウンドプレイヤー 曲名を指定して再生
*/
function playWithNumber(musicNumber:int){
	broadcast(join(SOUNDPLAYER_PLAY_PREFIX, musicNumber));
}

/**
* サウンドプレイヤー 曲名を指定して停止
*/
function stopWithNumber(musicNumber:int){
	soundPlayerMusicNumber = musicNumber;
	broadcast(SOUNDPLAYER_STOP_WITH_NUMBER);
}

/**
* サウンドプレイヤー ダイレクトプレイ
*/
function directPlay(){
	broadcast(SOUNDPLAYER_DIRECT_PLAY);
}

/**
* サウンドプレイヤー 停止
*/
function stop(){
	broadcast(SOUNDPLAYER_STOP);
}
