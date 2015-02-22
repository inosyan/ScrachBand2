
const MODE_MIMIMUM_BEAT = "miminumBeat";
const MODE_MAX_TRACK_NUMBER = "maxTrackNumber";

var kind; 
var mode;

function scripts(){
	whenFlagClicked(function(){
		kind = "original";
		hide();
		hideVariable(settingVariable);
	});
	
	whenIStartAsAClone(function(){
		gotoFront();
		show();
		if(kind == "original"){
			switchCostumeTo("settingBknd");
			// 1ページ目
			kind = "settingMinumumBeat";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "settingMaxTrackNumber";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "settingCancel";
			createCloneOf(CLONETARGET_MYSELF);
			
			// 2ページ目 MinimumBeat
			kind = "settingMinumumBeat_OK";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "settingMinumumBeat_Cancel";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "settingMinumumBeat_up";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "settingMinumumBeat_down";
			createCloneOf(CLONETARGET_MYSELF);
			
			// 2ページ目 MaxTrackNumber
			kind = "settingMaxTrackNumber_OK";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "settingMaxTrackNumber_Cancel";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "settingMaxTrackNumber_up";
			createCloneOf(CLONETARGET_MYSELF);
			kind = "settingMaxTrackNumber_down";
			createCloneOf(CLONETARGET_MYSELF);
			
			kind = "original";
		}
		// 1ページ目
		if(kind == "settingMinumumBeat"){
			gotoXY(0, 24);
			switchCostumeTo("settingMinumumBeat");
		}
		if(kind == "settingMaxTrackNumber"){
			gotoXY(0, -2);
			switchCostumeTo("settingMaxTrackNumber");
		}
		if(kind == "settingCancel"){
			gotoXY(0, -27);
			switchCostumeTo("settingCancel");
		}
		// 2ページ目 (Minumum Beat)
		if(kind == "settingMinumumBeat_OK"){
			gotoXY(47, -26);
			switchCostumeTo("settingOk");
			hide();
		}
		if(kind == "settingMinumumBeat_Cancel"){
			gotoXY(-47, -26);
			switchCostumeTo("settingCancel");
			hide();
		}
		if(kind == "settingMinumumBeat_up"){
			gotoXY(31, 11);
			switchCostumeTo("selectorUp");
			hide();
		}
		if(kind == "settingMinumumBeat_down"){
			gotoXY(31, 1);
			switchCostumeTo("selectorDown");
			hide();
		}
		// 2ページ目 (Max Track Number)
		if(kind == "settingMaxTrackNumber_OK"){
			gotoXY(47, -26);
			switchCostumeTo("settingOk");
			hide();
		}
		if(kind == "settingMaxTrackNumber_Cancel"){
			gotoXY(-47, -26);
			switchCostumeTo("settingCancel");
			hide();
		}
		if(kind == "settingMaxTrackNumber_up"){
			gotoXY(31, 11);
			switchCostumeTo("selectorUp");
			hide();
		}
		if(kind == "settingMaxTrackNumber_down"){
			gotoXY(31, 1);
			switchCostumeTo("selectorDown");
			hide();
		}
	});
	
	whenThisSpriteClicked(function(){
		// 1ページ目
		if(kind == "settingMinumumBeat"){
			broadcast(MSG_SETTING_INNERMSG_MINUMUMBEAT);
		}
		if(kind == "settingMaxTrackNumber"){
			broadcast(MSG_SETTING_INNERMSG_MAXTRACKNUMBER);
		}
		if(kind == "settingCancel"){
			broadcast(MSG_SETTING_INNERMSG_CANCEL);
		}
		// mimnumumBeat
		if(kind == "settingMinumumBeat_OK"){
			broadcast(MSG_SETTING_INNERMSG_OK);
		}
		if(kind == "settingMinumumBeat_Cancel"){
			broadcast(MSG_SETTING_INNERMSG_CANCEL);
		}
		if(kind == "settingMinumumBeat_up"){
			if(settingVariable < 128){
				settingVariable *= 2;
			}
		}
		if(kind == "settingMinumumBeat_down"){
			if(settingVariable > 8){
				settingVariable /= 2;
			}
		}
		// MaxTrackNumber
		if(kind == "settingMaxTrackNumber_OK"){
			broadcast(MSG_SETTING_INNERMSG_OK);
		}
		if(kind == "settingMaxTrackNumber_Cancel"){
			broadcast(MSG_SETTING_INNERMSG_CANCEL);
		}
		if(kind == "settingMaxTrackNumber_up"){
			if(settingVariable < 10){
				settingVariable++;
			}
		}
		if(kind == "settingMaxTrackNumber_down"){
			if(settingVariable > 1){
				settingVariable--;
			}
		}
		
		
	});
	
	whenIReceive(MSG_SETTING_INNERMSG_CANCEL, function(){
		finish();
	});
	
	whenIReceive(MSG_SETTING_INNERMSG_OK, function(){
		if(kind == "original"){
			if(mode == MODE_MIMIMUM_BEAT){
				broadcast(MSG_SETTING_MINUMUMBEAT_CHANGED);
			}
			if(mode == MODE_MAX_TRACK_NUMBER){
				broadcast(MSG_SETTING_MAXTRACKNUMBER_CHANGED);
			}
		}
		finish();
	});
	
	whenIReceive(MSG_SETTING_INNERMSG_MINUMUMBEAT, function(){
		if(kind == "original"){ 
			mode = MODE_MIMIMUM_BEAT;
			settingVariable = minimumBeat;
			showVariable(settingVariable); 
		}
		if(kind == "settingMinumumBeat" || kind == "settingMaxTrackNumber" || kind == "settingCancel"){ deleteThisClone(); }
		if(kind == "settingMinumumBeat_OK" || kind == "settingMinumumBeat_Cancel"
		|| kind == "settingMinumumBeat_up" || kind == "settingMinumumBeat_down"){ show(); }
	});
	
	whenIReceive(MSG_SETTING_INNERMSG_MAXTRACKNUMBER, function(){
		if(kind == "original"){ 
			mode = MODE_MAX_TRACK_NUMBER;
			settingVariable = maxTrackNumber;
			showVariable(settingVariable); 
		}
		if(kind == "settingMinumumBeat" || kind == "settingMaxTrackNumber" || kind == "settingCancel"){ deleteThisClone(); }
		if(kind == "settingMaxTrackNumber_OK" || kind == "settingMaxTrackNumber_Cancel"
		|| kind == "settingMaxTrackNumber_up" || kind == "settingMaxTrackNumber_down"){ show(); }
	});
	
	
}

function finish(){
	if(kind == "original"){ hideVariable(settingVariable); }
	deleteThisClone();
}

