
function scripts(){
	whenFlagClicked(function(){
		hide();
	});
	
	whenIStartAsAClone(function(){
		show();
		gotoFront();
	});
	
	whenIReceive(MSG_HIDE_WAIT, function(){
		deleteThisClone();
	});
}