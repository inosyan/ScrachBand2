

var isVertical;
var kind;

// 汎用
var tmp, tmp2, i, outValue, rate;

// 押されたかどうか
var isPressed;
// 押された時間
var pressedTime;
// マウスが押された時のタブの座標
var tabMouseDownTab;
// マウスが押された時のマウスの座標
var tabMouseDownMouse;
// タブポジションの最小値
var tabPosMin, tabPosMax;
// ローカルのスクロールポジション
var localScrollPosition;

function scripts(){
	whenFlagClicked(function(){
		hide();
	});
	
	whenIReceive(MSG_INITIALIZE_COMPLETE, function(){
		pressedTime = 0;
		isScrollRunning = -1;
		
		// 縦
		tabPosMin = 160;
		tabPosMax = -60;
		isVertical = 1;
		kind = "bar";
		createCloneOf(CLONETARGET_MYSELF);
		kind = "tab";
		createCloneOf(CLONETARGET_MYSELF);
		kind = "minus";
		createCloneOf(CLONETARGET_MYSELF);
		kind = "plus";
		createCloneOf(CLONETARGET_MYSELF);
		
		// 横
		tabPosMin = -220;
		tabPosMax = 160;
		isVertical = -1;
		kind = "bar";
		createCloneOf(CLONETARGET_MYSELF);
		kind = "tab";
		createCloneOf(CLONETARGET_MYSELF);
		kind = "minus";
		createCloneOf(CLONETARGET_MYSELF);
		kind = "plus";
		createCloneOf(CLONETARGET_MYSELF);
	});
	
	whenIStartAsAClone(function(){
		initialize();
		loop();
	});
	
	whenThisSpriteClicked(function(){
		onClicked();
	});
}

[ProcDef(fastmode="true")]
function initialize(){
	show();
	isPressed = -1;
	if(isVertical == 1){
		if(kind == "bar"){
			gotoXY(220, 180);
			switchCostumeTo("barV");
		}
		if(kind == "tab"){
			gotoXY(220, 160);
			switchCostumeTo("tabV");
		}
		if(kind == "minus"){
			gotoXY(220, 180);
			switchCostumeTo("arrowUp");
		}
		if(kind == "plus"){
			gotoXY(220, -100);
			switchCostumeTo("arrowDown");
		}
	}else{
		if(kind == "bar"){
			gotoXY(-240, -120);
			switchCostumeTo("barH");
		}
		if(kind == "tab"){
			gotoXY(-220, -120);
			switchCostumeTo("tabH");
		}
		if(kind == "minus"){
			gotoXY(-240, -120);
			switchCostumeTo("arrowLeft");
		}
		if(kind == "plus"){
			gotoXY(200, -120);
			switchCostumeTo("arrowRight");
		}
	}
}

function loop(){
	if(isVertical == 1){
		loopVertical();
	}else{
		loopHorizontal();
	}
}

function loopVertical(){
	forever(){
		if(verticalScrillMax == 0){
			if(kind == "tab"){
				hide();
			}
			if(kind == "minus" || kind == "plus"){
				setEffectTo(EFFECT_GHOST, 50);
			}
		}else{
			if(kind == "minus" || kind == "plus"){
				clearGraphicEffects();
				isMouseInRange(xpos, ypos, xpos+20, ypos-20);
				if(mouseDown){
					if(outValue == 1 && isPressed == -1 && isScrollRunning == -1){
						isScrollRunning = 1;
						isPressed = 1;
						pressedTime = timer;
					}
				}else{
					if(isPressed == 1){
						isScrollRunning = -1;
						isPressed = -1;
					}
				}
				tmp = timer - pressedTime;
				tmp2 = tmp == 0 || tmp > 0.5;
				if(isPressed == 1 && tmp2){
					if(kind == "minus"){
						if(verticalScrollPosition > 0){
							verticalScrollPosition--;
							broadcast(MSG_VERTICALSCROLL_CHANGED);
						}
					}
					if(kind == "plus"){
						if(verticalScrollPosition < verticalScrillMax){
							verticalScrollPosition++;
							broadcast(MSG_VERTICALSCROLL_CHANGED);
						}
					}
				}
			}
			if(kind == "tab"){
				show();
				isMouseInRange(xpos, ypos, xpos+20, ypos-40);
				if(mouseDown){
					if(outValue == 1 && isPressed == -1 && isScrollRunning == -1){
						isScrollRunning = 1;
						isPressed = 1;
						tabMouseDownTab = ypos;
						tabMouseDownMouse = mouseY;
					}
				}else{
					if(isPressed == 1){
						isScrollRunning = -1;
						isPressed = -1;
					}
				}
				if(isPressed == 1){
					// タブドラッグ中はタブの座標にスクロールポジションをあわせる
					ypos = mouseY - tabMouseDownMouse + tabMouseDownTab;
					if(tabPosMin < ypos){
						ypos = tabPosMin;
					}
					if(tabPosMax > ypos){
						ypos = tabPosMax;
					}
					tmp = ypos - tabPosMin;
					tmp2 = tabPosMax - tabPosMin;
					verticalScrollPosition = round(tmp / tmp2 * verticalScrillMax);
					broadcast(MSG_VERTICALSCROLL_CHANGED);
					localScrollPosition = -1;
					//localScrollPosition = verticalScrollPosition;
				}else{
					// それ以外はスクロールポジションにタブの座標をあわせる
					if(!(localScrollPosition == verticalScrollPosition)){
						rate = verticalScrollPosition / verticalScrillMax;
						ypos = tabPosMin - mathAbs(tabPosMin - tabPosMax) * rate;
						localScrollPosition = verticalScrollPosition;
					}
				}
			}
		}
	}
}

function loopHorizontal(){
	forever(){
		if(horizontalScrillMax == 0){
			if(kind == "tab"){
				hide();
			}
			if(kind == "minus" || kind == "plus"){
				setEffectTo(EFFECT_GHOST, 50);
			}
		}else{
			if(kind == "minus" || kind == "plus"){
				clearGraphicEffects();
				isMouseInRange(xpos, ypos, xpos+20, ypos-20);
				if(mouseDown){
					if(outValue == 1 && isPressed == -1 && isScrollRunning == -1){
						isScrollRunning = 1;
						isPressed = 1;
						pressedTime = timer;
					}
				}else{
					if(isPressed == 1){
						isScrollRunning = -1;
						isPressed = -1;
					}
				}
				tmp = timer - pressedTime;
				tmp2 = tmp == 0 || tmp > 0.5;
				if(isPressed == 1 && tmp2){
					if(kind == "minus"){
						if(horizontalScrollPosition > 0){
							horizontalScrollPosition--;
							broadcast(MSG_HORIZONTALSCROLL_CHANGED);
						}
					}
					if(kind == "plus"){
						if(horizontalScrollPosition < horizontalScrillMax){
							horizontalScrollPosition++;
							broadcast(MSG_HORIZONTALSCROLL_CHANGED);
						}
					}
				}
			}
			if(kind == "tab"){
				show();
				isMouseInRange(xpos, ypos, xpos+40, ypos-20);
				if(mouseDown){
					if(outValue == 1 && isPressed == -1 && isScrollRunning == -1){
						isScrollRunning = 1;
						isPressed = 1;
						tabMouseDownTab = xpos;
						tabMouseDownMouse = mouseX;
					}
				}else{
					if(isPressed == 1){
						isScrollRunning = -1;
						isPressed = -1;
					}
				}
				if(isPressed == 1){
					// タブドラッグ中はタブの座標にスクロールポジションをあわせる
					xpos = mouseX - tabMouseDownMouse + tabMouseDownTab;
					if(tabPosMin > xpos){
						xpos = tabPosMin;
					}
					if(tabPosMax < xpos){
						xpos = tabPosMax;
					}
					tmp = xpos - tabPosMin;
					tmp2 = tabPosMax - tabPosMin;
					horizontalScrollPosition = round(tmp / tmp2 * horizontalScrillMax);
					localScrollPosition = -1;
					broadcast(MSG_HORIZONTALSCROLL_CHANGED);
				}else{
					// それ以外はスクロールポジションにタブの座標をあわせる
					if(!(localScrollPosition == horizontalScrollPosition)){
						rate = horizontalScrollPosition / horizontalScrillMax;
						xpos = tabPosMin + mathAbs(tabPosMin - tabPosMax) * rate;
						localScrollPosition = horizontalScrollPosition;
					}
				}
			}
		}
	}
}



// マウスがおされたかどうかをチェック
function isMouseInRange(left:int, top:int, right:int, bottom:int){
	outValue = -1;
	if(left < mouseX && mouseX < right && bottom < mouseY && mouseY < top){
		outValue = 1;
	}
}

function onClicked(){
	if(isVertical == 1){
		if(!(verticalScrillMax == 0)){			
			if(kind == "bar"){
				updateTabPosY(mouseY);
			}
		}
	}else{
		if(!(horizontalScrillMax == 0)){
			if(kind == "bar"){
				updateTabPosX(mouseX);
			}
		}
	}
}

[ProcDef(fastmode="true")]
function updateTabPosY(yValue:Number){
	i = yValue;
	if(tabPosMin < i){
		i = tabPosMin;
	}
	if(tabPosMax > i){
		i = tabPosMax;
	}
	tmp = i - tabPosMin;
	tmp2 = tabPosMax - tabPosMin;
	verticalScrollPosition = round(tmp / tmp2 * verticalScrillMax);
	if(!(localScrollPosition == verticalScrollPosition)){
		broadcast(MSG_VERTICALSCROLL_CHANGED);
	}
}

[ProcDef(fastmode="true")]
function updateTabPosX(xValue:Number){
	i = xValue;
	if(tabPosMin > i){
		i = tabPosMin;
	}
	if(tabPosMax < i){
		i = tabPosMax;
	}
	tmp = i - tabPosMin;
	tmp2 = tabPosMax - tabPosMin;
	horizontalScrollPosition = round(tmp / tmp2 * horizontalScrillMax);
	if(!(localScrollPosition == horizontalScrollPosition)){
		broadcast(MSG_HORIZONTALSCROLL_CHANGED);
	}
}



}
