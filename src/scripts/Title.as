
var sp = new SoundPlayerBase();

function scripts(){
	whenFlagClicked(function(){
		show();
		setEffectTo(EFFECT_GHOST, 0);
		gotoFront();
	});
	
	whenIReceive(MSG_INITIALIZE_COMPLETE, function(){
		//起動音
		sp.play("右空一火日一車一一算光一円通一円車一音日一右三一一丸右車一音入一右三一一丸右車一音年一右三一一丸右二一玉組一音一出一一名花一一花妹一一右九車一一七王一一雨前光光一火黄一一一百光一火谷一一一文毎");
		gotoFront();
		wait(2);
		fadeout();
	});
	
	whenThisSpriteClicked(function(){
		fadeout();
	});
}

function fadeout(){
	repeat(10){
		changeEffectBy(EFFECT_GHOST, 10);
	}
	hide();
	broadcast(MSG_TITLE_COMPLETE);
}