
var inst, note, beat;

function scripts(){
	whenIStartAsAClone(function(){
		soundPlayerInstanceNumber++;
		note = soundPlayerPlayingNoteList[1];
		inst = soundPlayerPlayingInstList[1];
		beat = soundPlayerPlayingBeatList[1];

		deleteOf(1, soundPlayerPlayingNoteList);
		deleteOf(1, soundPlayerPlayingInstList);
		deleteOf(1, soundPlayerPlayingBeatList);

		// 楽器
		setInstrumentTo(inst);
		if(note == 0){
			// ドラム
			playDrum(inst, beat);
		}else{
			// 楽器
			setInstrumentTo(inst);
			volume = 100; // ボリュームはいまのところ固定
			playNote(note, beat);
		}
		soundPlayerInstanceNumber--;
		deleteThisClone();
	});
}