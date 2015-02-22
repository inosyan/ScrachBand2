
function scripts(){
	whenFlagClicked(function(){
		hide();
		hideVariable(soundPlayerInstanceNumber);
	});
	whenIStartAsAClone(function(){
		show();
		gotoFront();
		showVariable(soundPlayerInstanceNumber);
	});
	whenIReceive(SOUNDPLAYER_PLAY_COMPLETE, function(){
		hideVariable(soundPlayerInstanceNumber);
		deleteThisClone();
	});
	whenIReceive(MSG_STOP_SOUND, function(){
		hideVariable(soundPlayerInstanceNumber);
		deleteThisClone();
	});
}