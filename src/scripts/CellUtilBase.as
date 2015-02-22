
var tmp2, k, cnt, num1, num2, s;
// セルのnum1とnum2を調べる
[ProcDef(fastmode="true")]
function checkNum1Num2(cellValue:String){
	k = 1;
	tmp2 = "";
	cnt = 0;
	repeat(stringLength(cellValue)){
		s = letterOf(k, cellValue);
		if(s == "/"){
			if(cnt == 0){
				num1 = tmp2;
			}
			if(cnt == 1){
				num2 = tmp2;
			}
			cnt++;
			tmp2 = "";
		}else{
			tmp2 = join(tmp2, s);
		}
		k++;
	}
}