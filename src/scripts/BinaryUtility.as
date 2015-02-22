
// 汎用
var val, tmp, tmp2;
var res, res2,res3;
var i, j, k, s, l, l2;
var sign, sign2, total, cnt;
var intVal, intBin, flag, debug;
var floatVal, ignore, index

var kanjiList = [
"一","右","雨","円","王","音","下","火","花","貝","学","気","九","休","玉","金",
"空","月","犬","見","五","口","校","左","三","山","子","四","糸","字","耳","七",
"車","手","十","出","女","小","上","森","人","水","正","生","青","夕","石","赤",
"千","川","先","早","草","足","村","大","男","竹","中","虫","町","天","田","土",
"二","日","入","年","白","八","百","文","木","本","名","目","立","力","林","六",
"引","羽","雲","園","遠","何","科","夏","家","歌","画","回","会","絵","海","外",
"角","楽","活","間","丸","岩","顔","汽","記","帰","弓","牛","魚","京","強","教",
"近","兄","形","計","元","言","原","戸","古","午","後","語","工","公","広","交",
"光","考","行","高","黄","合","谷","国","黒","今","才","細","作","算","止","市",
"矢","姉","思","紙","寺","自","時","室","社","弱","首","秋","週","春","書","少",
"場","色","食","心","新","親","図","数","西","声","星","晴","切","雪","船","線",
"前","組","走","多","太","体","台","地","池","知","茶","昼","長","鳥","朝","直",
"通","弟","店","点","電","刀","冬","当","東","答","頭","同","道","読","内","南",
"肉","馬","売","買","麦","半","番","父","風","分","聞","米","歩","母","方","北",
"毎","妹","万","明","鳴","毛","門","夜","野","友","用","曜","来","里","理","話",
"悪","安","暗","医","委","意","育","員","院","飲","運","泳","駅","央","横","屋"
];

// ビット配列
var bitArray = [];
// ヘッダーの位置
var position = 0;
// 結果
var result;


[ProcDef(fastmode="true")]
function init(){
	deleteOf(LIST_DELETE_ALL, bitArray);
	position = 0;
	result = "";
}

/** 漢字データをセット */
[ProcDef(fastmode="true")]
function setKanji(kanjiString:String){
	cnt = stringLength(kanjiString);
	k = 1;
	repeat(cnt){
		s = letterOf(k, kanjiString);
		getKanjiIndex(s);
		if(!(index == -1)){
			writeUInt8(index);
		}
		k++;
	}
}

/** 漢字データをゲット */
[ProcDef(fastmode="true")]
function getKanji(){
	position = 0;
	cnt = mathFloor(lengthOf(bitArray) / 8);
	res3 = "";
	repeat(cnt){
		readUInt8();
		s = kanjiList[res + 1];
		res3 = join(res3, s);
	}
	result = res3;
}

[ProcDef(fastmode="true")]
function getKanjiIndex(kanji:String){
	l = lengthOf(kanjiList);
	j = 1;
	index = -1;
	repeat(l){
		if(kanji == kanjiList[j]){
			index = j - 1;
			stop(STOPTARGET_THIS_SCRIPT);
		}
		j++;
	}
}

/** ビット書き込み */
[ProcDef(fastmode="true")]
function writeBit(value:int){
	val = value;
	if(!(val == 1)) val = 0;
	checkBlankBits(1);
	bitArray[position + 1] = val;
	position++;
}

// 空白のビットが足りてるかチェック（なければ足す）
[ProcDef(fastmode="true")]
function checkBlankBits(minAddCount:int){
	l2 = lengthOf(bitArray);
	// きりのいいビット数の時にはセルを増やす
	if(l2 < position + minAddCount){
		cnt = mathCeiling(minAddCount / 8) * 8;
		repeat(cnt){
			addTo(0, bitArray);
		}
	}
}

/** 整数書き込み -8 ~ 7 */
[ProcDef(fastmode="true")]
function writeInt4(value:int){
	_writeIntCommon(value, 4);
}

/** 整数書き込み 0 ~ 15 */
[ProcDef(fastmode="true")]
function writeUInt4(value:int){
	writeInt4(value);
}

/** 整数書き込み -128 ~ 127 */
[ProcDef(fastmode="true")]
function writeInt8(value:int){
	_writeIntCommon(value, 8);
}

/** 整数書き込み 0 ~ 255 */
[ProcDef(fastmode="true")]
function writeUInt8(value:int){
	writeInt8(value);
}

/** 整数書き込み -1024 ~ 1023 */
[ProcDef(fastmode="true")]
function writeInt11(value:int){
	_writeIntCommon(value, 11);
}

/** 整数書き込み 0 ~ 2047 */
[ProcDef(fastmode="true")]
function writeUInt11(value:int){
	writeInt11(value);
}

/** 整数書き込み -32768 ~ 32767 */
[ProcDef(fastmode="true")]
function writeInt16(value:int){
	_writeIntCommon(value, 16);
}

/** 整数書き込み 0 ~ 65535 */
[ProcDef(fastmode="true")]
function writeUInt16(value:int){
	writeInt16(value);
}

/** 整数書き込み -8388608 ~ 8388607 */
[ProcDef(fastmode="true")]
function writeInt24(value:int){
	_writeIntCommon(value, 24);
}

/** 整数書き込み 0 ~ 16777215 */
[ProcDef(fastmode="true")]
function writeUInt24(value:int){
	writeInt24(value);
}

/** 整数書き込み -2147483648 ~ 2147483647 */
[ProcDef(fastmode="true")]
function writeInt32(value:int){
	_writeIntCommon(value, 32);
}

/** 整数書き込み 0 ~ 4294967295 */
[ProcDef(fastmode="true")]
function writeUInt32(value:int){
	writeInt32(value);
}

/** 浮動小数書き込み */
[ProcDef(fastmode="true")]
function writeFloat(value:Number){
	float2bin(value);
	_writeBinCommon(res);
	result = res;
}

[ProcDef(fastmode="true")]
function _writeIntCommon(value:int, digit:int){
	int2bin(value, digit);
	_writeBinCommon(res);
}

[ProcDef(fastmode="true")]
function _writeBinCommon(binary:String){
	l = stringLength(binary);
	i = 1;
	checkBlankBits(l);
	repeat(l){
		s = letterOf(i, binary);
		bitArray[position + 1] = s;
		position++;
		i++;
	}
}

/** 十進数の整数から二進数へ変換 */
[ProcDef(fastmode="true")]
function int2bin(value:int, digit:int){
	val = value;
	res = "";
	repeatUntil(val == 0 || val == -1){
		tmp = val % 2;
		val = mathFloor(val / 2);
		if(stringLength(res) < digit){
			res = join(tmp, res);
		}
	}
	// 0(または1)埋め
	if(stringLength(res) < digit){
		repeat(digit - stringLength(res)){
			if(value < 0){
				res = join("1", res);
			}else{
				res = join("0", res);
			}
		}
	}
}

/** 十進数の浮動小数から二進数へ変換 */
[ProcDef(fastmode="true")]
function float2bin(value:int){
	val = value;
	// 符号
	sign = 0;
	val = mathAbs(val);
	if(value < 0) sign = 1;
	// 整数部を2進数になおす
	intVal = mathFloor(val);
	floatVal = val;
	int2bin(intVal,32);
	intBin = res;
	
	if(value == 0){
		cnt = 127;
		intVal = 0;
		floatVal = 0;
	}else{
		i = 1;
		s = 0;
		repeatUntil(i > 32 || s == 1){
			s = letterOf(i, intBin);
			i++;
		}
		
		// 桁数
		cnt = 127 + 32 - i + 1;
		
		if(floatVal < 1){
			// 1に満たないもの
			cnt = 127;
			tmp = 1;
			repeatUntil(floatVal * tmp >= 1 ){
				tmp *= 2;
				cnt--;
			}
			intVal = 1;
			floatVal *= tmp;
		}
		floatVal -= intVal;
	}
	
	// 小数部
	// バイナリを組み立てる
	// 符号
	res2 = sign;
	
	// 桁数
	int2bin(cnt, 8);
	res2 = join(res2, res);
	
	// 整数部
	int2bin(intVal, 32);
	intBin = res;
	i = 1;
	flag = 0;
	ignore = 1;
	repeatUntil(i > 32 || stringLength(res2) == 32){
		s = 	letterOf(i, intBin);
		if(s == 1) flag = 1;
		if(flag == 1){
			if(stringLength(res2) == 9 && ignore == 1){
				// 一個目は無視
				ignore = 0;
			}else{
				res2 = join(res2, s);
			}
		}
		i++;
	}
	// 小数部
	tmp = 0.5;
	repeatUntil(stringLength(res2) == 32){
		if(floatVal > tmp){
			res2 = join(res2, 1);
			floatVal -= tmp;
		}else{
			res2 = join(res2, 0);
		}
		tmp /= 2;
	}
	res = res2;
}

/** ビット読み込み */
[ProcDef(fastmode="true")]
function readBit(){
	result = bitArray[position + 1];
	position++;
}

/** 整数読み込み -8 ~ 7 */
[ProcDef(fastmode="true")]
function readInt4(){
	readIntCommon(4, 0);
	result = res;
}

/** 整数読み込み 0 ~ 15 */
[ProcDef(fastmode="true")]
function readUInt4(){
	readIntCommon(4, 1);
	result = res;
}

/** 整数読み込み -128 ~ 127 */
[ProcDef(fastmode="true")]
function readInt8(){
	readIntCommon(8, 0);
	result = res;
}

/** 整数読み込み 0 ~ 255 */
[ProcDef(fastmode="true")]
function readUInt8(){
	readIntCommon(8, 1);
	result = res;
}

/** 整数読み込み -1024 ~ 1023 */
[ProcDef(fastmode="true")]
function readInt11(){
	readIntCommon(11, 0);
	result = res;
}

/** 整数読み込み 0 ~ 2047 */
[ProcDef(fastmode="true")]
function readUInt11(){
	readIntCommon(11, 1);
	result = res;
}

/** 整数読み込み -32768 ~ 32767 */
[ProcDef(fastmode="true")]
function readInt16(){
	readIntCommon(16, 0);
	result = res;
}

/** 整数読み込み 0 ~ 65535 */
[ProcDef(fastmode="true")]
function readUInt16(){
	readIntCommon(16, 1);
	result = res;
}

/** 整数読み込み -8388608 ~ 8388607 */
[ProcDef(fastmode="true")]
function readInt24(){
	readIntCommon(24, 0);
	result = res;
}

/** 整数読み込み 0 ~ 16777215 */
[ProcDef(fastmode="true")]
function readUInt24(){
	readIntCommon(24, 1);
	result = res;
}

/** 整数読み込み -2147483648 ~ 2147483647 */
[ProcDef(fastmode="true")]
function readInt32(){
	readIntCommon(32, 0);
	result = res;
}

/** 整数読み込み 0 ~ 4294967295 */
[ProcDef(fastmode="true")]
function readUInt32(){
	readIntCommon(32, 1);
	result = res;
}

[ProcDef(fastmode="true")]
function readIntCommon(digit:int, isUnsign:int){
	val = "";
	repeat(digit){
		val = join(val, bitArray[position + 1]);
		position++;
	}
	bin2int(val, digit, isUnsign);
	result = res;
}

/** 二進数から十進数の整数に変換 */
[ProcDef(fastmode="true")]
function bin2int(value:String, digit:int, isUnsign:int){
	i = digit;	
	j = 1;
	res = 0;
	total = 1;
	sign = 1;
	if(isUnsign == 0 && letterOf(1, value) == 1) sign = -1; 
	repeat(digit){
		s = letterOf(i, value);
		res = res + s * j;
		total = total + j;
		i--;
		j *= 2;
	}
	if(sign == -1) res = res - total;
}

/** 浮動小数読み込み */
[ProcDef(fastmode="true")]
function readFloat(){
	val = "";
	repeat(32){
		val = join(val, bitArray[position + 1]);
		position++;
	}
	bin2float(val);
	result = res;
}

/** 二進数から十進数の浮動小数に変換 */
[ProcDef(fastmode="true")]
function bin2float(binary:String){
	// 符号
	sign2 = 1;
	tmp = letterOf(1, binary);
	if(tmp == "1"){ 
		sign2 = -1;
	}
	// 桁数
	i = 2;
	tmp = "";
	repeat(8){
		tmp = join(tmp, letterOf(i, binary));
		i++;
	}
	bin2int(tmp, 8, 1);
	cnt = res - 127;
	// 指数が+だったらスタート位置を調整
	if(cnt > 0){
		tmp = 1;
		repeat(cnt){
			tmp *= 2;
		}
		res = tmp;
		tmp /= 2;
	}else{
		res = 1;
		tmp = 0.5;
	}
	i = 10;
	repeatUntil(i > 32){
		s = letterOf(i, binary);
		if(s == 1) res += tmp;
		tmp /= 2;
		i++;
	}
	if(cnt < 0){
		repeatUntil(cnt == 0){
			res /= 2;
			cnt++;
		}
	}
	res *= sign2;
}








