
import flash.net.dns.AAAARecord;

// 仮
/*
[List(name="waitList", visible=true, x=10, y=20, width=100, height=300)]
var waitList = [];
[List(name="instList", visible=true, x=210, y=20, width=100, height=300)]
var instList = [];

[Variable(name="stageDebug", visible=true, x=0, y=20, mode=1, sliderMin=0, sliderMax=100)]
var stageDebug;
*/




// サウンドプレイヤー用
var dataForSoundPlayer;
const SOUNDPLAYER_PLAY = "soundplayer_play";	// 即実行
const SOUNDPLAYER_PREPARE = "soundplayer_prepare";	// 曲準備
const SOUNDPLAYER_DIRECT_PLAY = "soundplayer_direct_play";	// ダイレクトモードで実行
const SOUNDPLAYER_PLAY_COMPLETE = "soundplayer_play_complete";
const SOUNDPLAYER_STOP = "soundplayer_stop";
// 曲番号を指定
const SOUNDPLAYER_PLAY_PREFIX = "soundplayer_play_";
const SOUNDPLAYER_STOP_WITH_NUMBER = "soundplayer_stop_with_number";
// 曲の数だけメッセージを分けておく必要がある
const SOUNDPLAYER_PLAY_1  = "soundplayer_play_1";	
const SOUNDPLAYER_PLAY_2  = "soundplayer_play_2";
const SOUNDPLAYER_PLAY_3  = "soundplayer_play_3";
const SOUNDPLAYER_PLAY_4  = "soundplayer_play_4";
const SOUNDPLAYER_PLAY_5  = "soundplayer_play_5";
const SOUNDPLAYER_PLAY_6  = "soundplayer_play_6";
const SOUNDPLAYER_PLAY_7  = "soundplayer_play_7";
const SOUNDPLAYER_PLAY_8  = "soundplayer_play_8";
const SOUNDPLAYER_PLAY_9  = "soundplayer_play_9";
const SOUNDPLAYER_PLAY_10 = "soundplayer_play_10";

// 最小単位
var minimumBeat = 32;
// 再生中に使う一時的なリスト
var soundPlayerPlayingNoteList = [];
var soundPlayerPlayingBeatList = [];
var soundPlayerPlayingInstList = [];
// ダイレクトプレイで使うもの
var soundPlayerDirectPlayTempo;
var soundPlayerDirectPlayIsLoopMode;
var soundPlayerDirectPlayWaitList = [];
var soundPlayerDirectPlayNoteList = [];
var soundPlayerDirectPlayBeatList = [];
var soundPlayerDirectPlayInstList = [];
// インスタンス数
[Variable(name="soundPlayerInstanceNumber", visible=false, x=224, y=217, mode=2, sliderMin=0, sliderMax=100)]
var soundPlayerInstanceNumber = 0;
// 曲番号
var soundPlayerMusicNumber = -1;


// ズームレベル(2:2分音符, 4:４分音符。。。)
//[Variable(name="zoomLevel", visible=true, x=200, y=20, mode=1, sliderMin=0, sliderMax=100)]
var zoomLevel = 8;

// スクロール用
var verticalScrollPosition;
var verticalScrillMax;

var horizontalScrollPosition;
var horizontalScrillMax;

var isScrollRunning;

// プレイ中かどうか
var isPlaying;

// 画面中のセルの数
const MAX_CELL_W = 22;
const MAX_CELL_H = 14;
// ノートの数
const MAX_NOTE = 108;
// デフォルトのタイムラインの数
const DEFAULT_TIMELINE_NUMBER = 512;

// ドラム1をNoteに換算した数
const DRUM1_NOTENUM = 60;
// ドラムの数
const DRUM_MAX = 18;

// 楽器
[Variable(name="instrumentName", visible=false, x=4, y=333, mode=2, sliderMin=0, sliderMax=100)]
var instrumentName;
var instrumentIndex;

// タイムラインリスト
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
var timelineNumber;

// 拍数
[Variable(name="beatNumber", visible=false, x=136, y=333, mode=2, sliderMin=0, sliderMax=100)]
var beatNumber;

// 保存用
[List(name="SAVE DATA", visible=false, x=0, y=0, width=480, height=320)]
var saveDataList = [];

// サンプル用
[List(name="sampleSelectList", visible=false, x=0, y=0, width=480, height=360)]
var sampleSelectList = [
];
var selectedSampleData;
var sampleDataIndex = 0;


// 編集モード
var editMode;
const EDITMODE_CELL = "editModeCell";
const EDITMODE_STARTLINE = "editStartLine";
const EDITMODE_ENDLINE = "editEndLine";

// スタート／エンドライン
var startLineTime;
var endLineTime;

// UI無効
var disableUI;

// ループモード
var isLoopMode;

// テンポ
[Variable(name="tempoValue", visible=false, x=202, y=333, mode=2, sliderMin=0, sliderMax=100)]
var tempoValue;

// トラック
[Variable(name="trackNumberLabel", visible=false, x=268, y=333, mode=2, sliderMin=0, sliderMax=100)]
var trackNumberLabel;
var trackNumber;
var maxTrackNumber = 3;

// ドラムモード
var isDrumMode;

// セッティング用変数
[Variable(name="settingVariable", visible=false, x=215, y=160, mode=2, sliderMin=0, sliderMax=100)]
var settingVariable;

// イベント
const MSG_TITLE_COMPLETE = "msgTitleComplete";
const MSG_PLAY_SOUND = "msgPlaySound";
const MSG_STOP_SOUND = "msgStopSound";
const MSG_INITIALIZE = "initialize";
const MSG_INITIALIZE_COMPLETE = "initializeComplete";
const MSG_LOAD_DATA_COMPLETE = "loadDataComplete";
const MSG_SAVE_DATA = "msgSaveData";
const MSG_LOAD_DATA = "msgLoadData";
const MSG_EDITMODE_CHANGED = "msgEditModeChanged";
const MSG_INSTRUMENTINDEX_CHANGED = "msgInstrumentIndexChanged";
const MSG_BEATNUMBER_CHANGED = "msgBeatNumberIndexChanged";
const MSG_VERTICALSCROLL_CHANGED = "msgVerticalScrollChanged";
const MSG_HORIZONTALSCROLL_CHANGED = "msgHorizontalScrollChanged";
const MSG_LOOPMODE_CHANGED = "msgLoopModeChanged";
const MSG_TRACKNUMBER_CHANGED = "msgTrackNumberChanged";
const MSG_DRUMMODE_CHANGED = "msgDrumModeChanged";
const MSG_EXTEND_TIMELINE = "msgExtendTimeline";
const MSG_CREAR_TIMELINE = "msgClearTimeline";
const MSG_ZOOMLEVEL_CHANGED = "msgZoomLevelChanged";
//const MSG_SAMPLE_OPEN = "msgSampleOpen";
// セッティング用イベント
const MSG_SETTING_INNERMSG_CANCEL 		= "msgSettingInnerMsgCancel";
const MSG_SETTING_INNERMSG_OK 			= "msgSettingInnerMsgOK";
const MSG_SETTING_INNERMSG_MINUMUMBEAT 	= "msgSettingInnerMsgMinimumBeat";
const MSG_SETTING_INNERMSG_MAXTRACKNUMBER = "msgSettingInnerMsgMaxTrackNumber";

const MSG_SETTING_MINUMUMBEAT_CHANGED 	= "msgSettingMinimumBeatChanged";
const MSG_SETTING_MAXTRACKNUMBER_CHANGED = "msgSettingMaxTrackNumberChanged";
// サンプル用イベント
const MSG_SAMPLE_CANCEL = "msgSampleCancel";
const MSG_LOAD_SAMPLE_DATA = "msgLoadSampleData";
const MSG_SAMPLE_INDEX_CHANGED = "msgSampleIndexChanged";

function scripts(){
	whenFlagClicked(function(){
		switchBackgroundTo("bknd");
		broadcast(MSG_INITIALIZE);
	});
}





