
package {
	//----------------------------------
	//  Motion
	//----------------------------------
	
	/** 
	 * Motion : move 
	 * @param step Number
	 */
	function move(step:Number){}
	
	/** 
	 * Motion : turnRight
	 * @param degree Number 
	 */
	function turnRight(degree:Number);
	
	/** 
	 * Motion : turnLeft
	 * @param degree Number
	 */
	function turnLeft(degree:Number);
	
	/** Mouse */
	var TARGET_MOUSE;
	
	/** 
	 * Motion : pointTowards 
	 * @param target TARGET_MOUSE or Sprite name
	 */
	function pointTowards(target:String);
	
	/** 
	 * Motion : gotoXY
	 * @param x Number
	 * @param y Number 
	 */ 
	function gotoXY(x:Number, y:Number);
	
	/**
	 * Motion : goto
	 * @param target TARGET_MOUSE or Sprite name
	 */
	function goto(target:String);
	
	/**
	 * Motion : glide
	 * @param secs Number
	 * @param x Number
	 * @param y Number
	 */
	function glide(secs:Number, x:Number, y:Number);
	
	/**
	 * Motion : bounce
	 */
	function bounce();
	
	/** Left Right */
	var ROTATIONSTYLE_LEFT_RIGHT;
	
	/** Dont Rotate */
	var ROTATIONSTYLE_DONT_ROTATE;
	
	/** All Around */
	var ROTATIONSTYLE_ALL_AROUND;
	
	/**
	 * Motion : setRotationStyle
	 * @param value ROTATIONSTYLE_LEFT_RIGHT, ROTATIONSTYLE_DONT_ROTATE, ROTATIONSTYLE_ALL_AROUND
	 */
	function setRotationStyle(value:String);
	
	/** 
	 * Motion : xpos
	 * <listing>Read / Write</listing>
	 */
	
	var xpos;
	/**
	 * Motion : ypos 
	 * <listing>Read / Write</listing>
	 */
	
	var ypos;
	/**
	 * Motion : direction 
	 * <listing>Read / Write</listing>
	 */
	var direction;
	
	//----------------------------------
	//  Looks
	//----------------------------------
	
	/**
	 * Looks : sayForSecs
	 * @param sentence String
	 * @param duration Number
	 */
	function sayForSecs(sentence:String, duration:Number);
	
	/**
	 * Looks : say
	 * @param sentence String
	 */
	function say(sentence:String);
	
	/**
	 * Looks : thinkForSecs
	 * @param sentence String
	 * @param duration
	 */
	function thinkForSecs(sentence:String, duration:Number);
	
	/**
	 * Looks : think
	 * @param sentence String
	 */
	function think(sentence:String);
	
	/** 
	 * Looks : show
	 */
	function show();
	
	/**
	 * Looks : hide
	 */
	function hide();
	
	/**
	 * Looks : switchCostumeTo
	 * @param costume Costume name or Number
	 */
	function switchCostumeTo(costume:*);
	
	/**
	 * Looks : nextCostume
	 */
	function nextCostume();
	
	/**
	 * Looks : switchBackgroundTo
	 * @param costume Costume name or Number
	 */
	function switchBackgroundTo(costume:*);
	
	/** Color */
	var EFFECT_COLOR;
	
	/** Fisheye */
	var EFFECT_FISHEYE;
	
	/** Whirl */
	var EFFECT_WHIRL; 
	
	/** Pixelate */
	var EFFECT_PIXELATE;
	
	/** Mosaic */
	var EFFECT_MOSAIC; 
	
	/** Brightness */
	var EFFECT_BRIGHTNESS;
	
	/** Ghost */
	var EFFECT_GHOST;
	
	/** 
	 * Looks : changeEffectBy
	 * @param kind EFFECT_COLOR, EFFECT_FISHEYE, 
	 * EFFECT_WHIRL, EFFECT_PIXELATE, EFFECT_MOSAIC, EFFECT_BRIGHTNESS, EFFECT_GHOST
	 * @param value Number
	 */
	function changeEffectBy(kind:String, value:Number);
	
	/** 
	 * Looks : setEffectTo
	 * @param kind EFFECT_COLOR, EFFECT_FISHEYE, 
	 * EFFECT_WHIRL, EFFECT_PIXELATE, EFFECT_MOSAIC, EFFECT_BRIGHTNESS, EFFECT_GHOST
	 * @param value Number
	 */
	function setEffectTo(kind:String, value:Number);
	
	/**
	 * Looks : clearGraphicEffects
	 */
	function clearGraphicEffects();
	
	/**
	 * Looks : gotoFront
	 */
	function gotoFront();
	
	/**
	 * Looks : goBackLayers
	 * @param layerNum Number
	 */
	function goBackLayers(layerNum:int);
	
	/** 
	 * Looks : costumeNumber
	 * <listing>Read only</listing> 
	 */
	var costumeNumber;
	
	/** 
	 * Looks : backdropName
	 * <listing>Read only</listing> 
	 */
	var backdropName;
	
	/** 
	 * Looks : size
	 * <listing>Read / Write</listing> 
	 */
	var size;
	
	//----------------------------------
	//  Sound
	//----------------------------------
	
	/**
	 * Sound : playSound
	 * @param soundName String
	 */
	function playSound(soundName:String);
	
	/**
	 * Sound : playSoundUntilDone
	 * @param soundName String
	 */
	function playSoundUntilDone(soundName:String);
	
	/**
	 * Sound : stopAllSounds
	 */
	function stopAllSounds();
	
	/**
	 * Sound : playDrum
	 * @param drumID int
	 * @param beats Number
	 */
	function playDrum(drunID:int, beats:Number);
	
	/**
	 * Sound : rest
	 * @param beats Number
	 */
	function rest(beats);
	
	/**
	 * Sound : playNote
	 * @param noteID int
	 * @param beats Number
	 */
	function playNote(noteID:int, beats:Number);
	
	/**
	 * Sound : setInstrumentTo
	 * @param instrumentID int
	 */
	function setInstrumentTo(instrumentID:int);
	
	/** 
	 * Sound : volume
	 * <listing>Read / Write</listing> 
	 */
	var volume;
	
	/** 
	 * Sound : tempo
	 * <listing>Read / Write</listing> 
	 */
	var tempo;
	
	//----------------------------------
	//  Pen
	//----------------------------------
	/**
	 * Pen : clear
	 */
	function clear();
	
	/**
	 * Pen : stamp
	 */
	function stamp();
	
	/**
	 * Pen : penDown
	 */
	function penDown();
	
	/**
	 * Pen : penUp
	 */
	function penUp();
	
	/** 
	 * Pen : penColor (e.g. 0xFFFFFF)
	 * <listing>Write only</listing> 
	 */
	var penColor;
	
	/** 
	 * Pen : penHue
	 * <listing>Write and ++, +=, --, -=, *=, /=</listing> 
	 */
	var penHue;
	
	/** 
	 * Pen : penShade
	 * <listing>Write and ++, +=, --, -=, *=, /=</listing>  
	 */
	var penShade;
	
	/** 
	 * Pen : penSize
	 * <listing>Write and ++, +=, --, -=, *=, /=</listing>  
	 */
	var penSize;
	
	//----------------------------------
	//  Data
	//----------------------------------
	
	/**
	 * Data : showVariable
	 * @param variableName String
	 */
	function showVariable(variableName:String);
	
	/**
	 * Data : hideVariable
	 * @param variableName String
	 */
	function hideVariable(variableName:String);
	
	/**
	 * Data : addTo
	 * @param thing * String or Number
	 * @param listName String
	 */
	function addTo(thing:*, listName:String);
	
	/**
	 * Data : deleteOf
	 * @param lineIndex int
	 * @param listName String
	 */
	function deleteOf(lineIndex:int, listName:String);
	
	/**
	 * Data : insertAtOf
	 * @param thing String or Number
	 * @param listNumber int
	 * @param listName String
	 */
	function insertAtOf(thing:*, listNumber:int, listName:String);
	
	/**
	 * Data : lengthOf
	 * @param listName String
	 */
	function lengthOf(listName:String);
	
	/**
	 * Data : contains
	 * @param listName String
	 * @param thing String or Number
	 */
	function contains(listName:String, thing:*);
	
	/**
	 * Data : showList
	 * @param listName String
	 */
	function showList(listName:String);
	
	/**
	 * Data : hideList
	 * @param listName String
	 */
	function hideList(listName:String);
	
	//----------------------------------
	//  Events
	//----------------------------------
	
	/**
	 * Events : whenFlagClicked
	 * @param handler Function
	 */
	function whenFlagClicked(handler:Function);
	
	/**
	 * Events : whenKeyPressed
	 * @param key KEY_SPACE, KEY_UP_ARROW, KEY_DOWN_ARROW, KEY_RIGHT_ARROW, KEY_LEFT_ARROW, or key name (e.g. 'a')
	 * @param handler Function
	 */
	function whenKeyPressed(key:String, handler:Function);
	
	/**
	 * Events : whenThisSpriteClicked
	 * @param handler Function
	 */
	function whenThisSpriteClicked(handler:Function);
	
	/**
	 * Events : whenBackdropSwitchesTo
	 * @param costumeName String
	 * @param handler Function
	 */
	function whenBackdropSwitchesTo(costumeName:String, handler:Function);
	
	/** Loudness */
	var SENSOR_LOUDNESS;
	
	/** Timer */
	var SENSOR_TIMER;
	
	/** Video */
	var SENSOR_VIDEO;
	
	/** Motion */
	var SENSOR_MOTION;
	
	/**
	 * Events : whenSensorGreaterThan
	 * @param kind SENSOR_LOUDNESS, SENSOR_TIMER, SENSOR_VIDEO, SENSOR_MOTION
	 * @param handler Function
	 */
	function whenSensorGreaterThan(kind:String, handler:Function);
	
	/**
	 * Events : whenIReceive
	 * @param message String
	 * @param handler Function
	 */
	function whenIReceive(message:String, handler:Function);
	
	/**
	 * Events : broadcast
	 * @param message String
	 */
	function broadcast(message:String);
	
	/**
	 * Events : broadcastAndWait
	 * @param message String
	 */
	function broadcastAndWait(message:String);
	
	//----------------------------------
	//  Control
	//----------------------------------
	
	/**
	 * Control : wait
	 * @param sec Number
	 */
	function wait(sec:Number);
	
	/**
	 * Control : repeat
	 * @param count int
	 */
	function repeat(count:int);
	
	/**
	 * Control : forever
	 */
	function forever();
	
	/**
	 * Control : waitUntil
	 * @param 
	 */
	function waitUntil(conditional:*);
	
	/**
	 * Control : repeatUntil
	 * @param 
	 */
	function repeatUntil(conditional:*);
	
	/** All */
	var STOPTARGET_ALL;
	
	/** This script */
	var STOPTARGET_THIS_SCRIPT;
	
	/** Other scripts */ 
	var STOPTARGET_OTHER_SCRIPTS;
	
	/** In sprite */
	var STOPTARGET_IN_SPRITE;
	
	/**
	 * Control : stop
	 * @param target STOPTARGET_ALL, STOPTARGET_THIS_SCRIPT, STOPTARGET_OTHER_SCRIPTS, STOPTARGET_IN_SPRITE
	 */
	function stop(target:String);
	
	/**
	 * Control : whenIStartAsAClone
	 * @param handler Function
	 */
	function whenIStartAsAClone(handler:Function);
	
	/** Myself */
	var CLONETARGET_MYSELF;
	
	/**
	 * Control : createCloneOf
	 * @param target CLONETARGET_MYSELF or Sprite Name
	 */
	function createCloneOf(target:String);
	
	/**
	 * Control : deleteThisClone
	 */
	function deleteThisClone();
	
	//----------------------------------
	//  Sensing
	//----------------------------------
	
	/** Mouse */
	var TOUCHTARGET_MOUSE;
	
	/** Edge */
	var TOUCHTARGET_EDGE;
	
	/**
	 * Sensing : touching
	 * @param target TOUCHTARGET_MOUSE, TOUCHTARGET_EDGE or Sprite Name
	 */
	function touching(target:String):Boolean;
	
	/**
	 * Sensing : touchingColor
	 * @param color uint
	 */
	function touchingColor(color:uint):Boolean;
	
	/**
	 * Sensing : colorIsTouching
	 * @param myColor uint
	 * @param otherColor uint
	 */
	function colorIsTouching(myColor:uint, otherColor:uint):Boolean;
	
	/** Mouse */
	var DISTANCETARGET_MOUSE;
	
	/**
	 * Sensing : distanceTo
	 * @param target DISTANCETARGET_MOUSE or Sprite Name
	 */
	function distanceTo(target:String):int;
	
	/**
	 * Sensing : askAndWait
	 * @param sentence String
	 */
	function askAndWait(sentence:String);
	
	/**
	 * Sensing : answer
	 * <listing>Read only</listing>
	 */  
	var answer;
	
	/** Space */
	var KEY_SPACE;
	
	/** Up Arrow */
	var KEY_UP_ARROW;
	
	/** Down Arrow */
	var KEY_DOWN_ARROW;
	
	/** Right Arrow */
	var KEY_RIGHT_ARROW;
	
	/** Left Arrow */
	var KEY_LEFT_ARROW;
	
	/**
	 * Sensing : keyPressed
	 * @param key KEY_SPACE, KEY_UP_ARROW, KEY_DOWN_ARROW, KEY_RIGHT_ARROW, KEY_LEFT_ARROW, or key name (e.g. 'a')
	 */
	function keyPressed(key:String):Boolean;
	
	/**
	 * Sensing : mouseDown
	 * <listing>Read only</listing>
	 */  
	var mouseDown:Boolean;
	
	/**
	 * Sensing : mouseX
	 * <listing>Read only</listing>
	 */  
	var mouseX;
	
	/**
	 * Sensing : mouseY
	 * <listing>Read only</listing>
	 */  
	var mouseY;
	
	/**
	 * Sensing : loudness
	 * <listing>Read only</listing>
	 */  
	var loudness;
	
	/** Motion */
	var VIDEOON_KIND_MOTION;
	
	/** Direction */
	var VIDEOON_KIND_DIRECTION; 
	
	/** This Sprite */
	var VIDEOON_TARGET_THISSPRITE;
	
	/** Stage */
	var VIDEOON_TARGET_STAGE;
	
	/**
	 * Setting : videoOn
	 * @param kind VIDEOON_MOTION, VIDEOON_DIRECTION
	 * @param target VIDEOON_TARGET_THISSPRITE, VIDEOON_TARGET_STAGE
	 */
	function videoOn(kind:String, target:String);
	
	/** On */
	var VIDEOSTATE_ON;
	
	/** Off */
	var VIDEOSTATE_OFF;
	
	/** On flipped */
	var VIDEOSTATE_ON_FLIPPED; 
	
	/**
	 * Sensing : turnVideo
	 * @param videoState VIDEOSTATE_ON, VIDEOSTATE_OFF, VIDEOSTATE_ON_FLIPPED
	 */
	function turnVideo(videoState:String);
	
	/**
	 * Sensing : setVideoTransparencyTo
	 * @param value Number
	 */
	function setVideoTransparencyTo(value:Number);
	
	/**
	 * Sensing : timer
	 * <listing>Read only</listing>
	 */  
	var timer;
	
	/**
	 * Sensing : resetTimer
	 */
	function resetTimer();
	
	/** XPos */
	var ATTRIBUTE_XPOS;
	
	/** YPos */
	var ATTRIBUTE_YPOS;
	
	/** Direction */
	var ATTRIBUTE_DIRECTION;
	
	/** Costume number */
	var ATTRIBUTE_COSTUME_NUMBER;
	
	/** Costume Name */
	var ATTRIBUTE_COSTUME_NAME;
	
	/** Size */
	var ATTRIBUTE_SIZE;
	
	/** Volume */
	var ATTRIBUTE_VOLUME;
	
	/**
	 * Sensing : getAttribute
	 * @param kind ATTRIBUTE_XPOS, ATTRIBUTE_YPOS, ATTRIBUTE_DIRECTION, 
	 * ATTRIBUTE_COSTUME_NUMBER, ATTRIBUTE_COSTUME_NAME, 
	 * ATTRIBUTE_SIZE, ATTRIBUTE_VOLUME
	 * @param target Sprite name
	 */
	function getAttribute(kind:String, target:String);
	
	/** Year */
	var CURRENT_YEAR;
	
	/** Month */
	var CURRENT_MONTH;
	
	/** Date */
	var CURRENT_DATE;
	
	/** Day of week */
	var CURRENT_DAY_OF_WEEK;
	
	/** Hour */
	var CURRENT_HOUR;
	
	/** Minute */
	var CURRENT_MINUTE;
	
	/** Second */
	var CURRENT_SECOND;
	
	/**
	 * Sensing : current
	 * @param kind CURRENT_YEAR, CURRENT_MONTH, CURRENT_DATE, CURRENT_DAY_OF_WEEK, 
	 * CURRENT_HOUR, CURRENT_MINUTE, CURRENT_SECOND
	 */
	function current(kind:String);
	
	/**
	 * Sensing : userName
	 * <listing>Read only</listing>
	 */
	
	var userName;
	/**
	 * Sensing : daysSince2000
	 * <listing>Read only</listing>
	 */
	var daysSince2000;
	
	//----------------------------------
	//  Operators
	//----------------------------------
	
	/**
	 * Operators : pickRandomTo
	 * @param from Number
	 * @param to Number
	 */
	function pickRandomTo(from:Number, to:Number);
	
	/**
	 * Operators : join
	 * @param word1 String
	 * @param word2 String
	 */
	function join(word1:String, word2:String);
	
	/**
	 * Operators : letterOf
	 * @param index int
	 * @param word String
	 */
	function letterOf(index:int, word:String);
	
	/**
	 * Operators : stringLength
	 * @param word String
	 */
	function stringLength(word:String);
	
	/**
	 * Operators : round
	 * @param value Number
	 */
	function round(value:Number);
	
	/**
	 * Operators : mathAbs
	 * @param value Number
	 */
	function mathAbs(value:Number);
	
	/**
	 * Operators : mathFloor
	 * @param value Number
	 */
	function mathFloor(value:Number);
	
	/**
	 * Operators : mathCeiling
	 * @param value Number
	 */
	function mathCeiling(value:Number);
	
	/**
	 * Operators : mathSqrt
	 * @param value Number
	 */
	function mathSqrt(value:Number);
	
	/**
	 * Operators : mathSin
	 * @param value Number
	 */
	function mathSin(value:Number);
	
	/**
	 * Operators : mathCos
	 * @param value Number
	 */
	function mathCos(value:Number);
	
	/**
	 * Operators : mathTan
	 * @param value Number
	 */
	function mathTan(value:Number);
	
	/**
	 * Operators : mathASin
	 * @param value Number
	 */
	function mathASin(value:Number);
	
	/**
	 * Operators : mathACos
	 * @param value Number
	 */
	function mathACos(value:Number);
	
	/**
	 * Operators : mathATan
	 * @param value Number
	 */
	function mathATan(value:Number);
	
	/**
	 * Operators : mathLn (natural logarithm)
	 * @param value Number
	 */
	function mathLn(value:Number);
	
	/**
	 * Operators : mathLog
	 * @param value Number
	 */
	function mathLog(value:Number);
	
	/**
	 * Operators : mathPowE (e^)
	 * @param value Number
	 */
	function mathPowE(value:Number);
	
	/**
	 * Operators : mathPow10 (10^)
	 * @param value Number
	 */
	function mathPow10(value:Number); 
}
