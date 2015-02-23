
const ORIGINAL = "original";
const GENERATOR = "generator";
const BTN_CANCEL = "btnCancel";
const BTN_PLAY = "btnPlay";
const BTN_LOAD = "btnLoad";
const BTN_PREV = "btnPrev";
const BTN_NEXT = "btnNext";

var sampleDataList = [
"Chopin 24 Preludes op.28-4",
"右空一火日右場一一算光一右一右年車一音日一右三一一丸右車一音入一右三一一丸右車一音年一右三一一丸右二音女日雨家一出一三虫一通円東毎花一考糸九一空車一二雨円前花一二強右一貝空一車右手風王一女大一光音花一空一場来雨一五四光二雨電一花一家原右一気休通車右行一王一千虫一光下下毎空一馬一雨一子字光二円年近花一近矢雨一玉空一車右弟風王一男大一光火黒一空一悪来雨一耳四光二王王近千一光光右一空玉二車雨右前王一白二一光花国車空右空風雨一女車一二王高矢花一矢魚右一見空一車雨楽東王一立村一光学火毎空右二鳴雨一人四一二音年悪花一西形右一口休光車雨店二花一家土一光気火車空右角風雨一石七光二音点矢花一池魚右一三月通通円右院王一角竹一光九下場空右矢駅雨一先糸光二下年引花一肉広右一子玉二車円日西王一魚土一光休国車空右前麦雨一男七一二火円矢花一毎弓右一字金光車円色東王一元足一光金貝一車右毎院雨一町糸一二火高引花一院工右一七玉一車円妹西王一光文円一空火通空雨一毎雨一二子一二花年毎花右花近右一手休一車王日悪王一黒男一光月下光空雨千院雨一百糸一二花点二花右車工右一女休通車王考場王一寺田一光犬谷毎空雨引肉雨一立出一光貝高肉花右千強右一上休一車王妹野王一週大一光見谷光空雨考五九一引耳一二学円近花右二記右一水金一車音手池王一新草一光口火光空雨場歩雨一遠子一二学点通花右家強右一生休一車音考毎王一前村一光校下光空雨肉悪雨一画四一二気年二花右近止雨一石金一車音弟前王一池草一光左国光空雨悪風雨一海子一二九王引千右光古右一千休光車下右場王一電町一光三谷通空円空肉雨一丸耳一二九高角花右矢記右一早金一車下楽前王一道草一光子火光空円二風雨一記山光二休年通花右西魚右一足九通車下店男花一風町一光四下通空円角道雨一強耳一二休点角花右池顔右一男月二通火右毎王一毎村一光糸下二空円矢悪雨一形四一二玉年車花右肉古右一中休光車火日矢王一来町一光字谷通空円前東雨一古耳一二金円角花右毎丸右一天金一車火色前王一委先一光七花毎三円毎悪雨一工四一二金高車花右院古右一土休光車火妹矢王一横八一二車花場角王一悪雨一光子光二空円車花雨花古右一日休二車花手矢王右花町一光手下場空王車東雨一谷耳一二空点引花雨三丸右一白玉通車花考西王右空先一光十国角空王引麦雨一才山一二月黄二車雨千原右一百休二車花弟矢王右糸虫一光出谷場空王近東雨一矢字光二犬円二花雨二角右一本玉通車貝手場王右女千一光小花場空王場鳴雨一寺子一二犬高一花雨家止右一目玉二車貝楽場王右青千一光上貝二空王通鳴雨一社子一二見円一花雨記矢右一力玉二車貝色場王右草千一光森花一空王毎鳴雨一週子一二見高一花雨古才右一六玉二車貝妹場王右町千一光人花二角音一鳴雨一場子一二五雨悪花雨黒形右一羽休一車学手古王右木竹一光水下角空音車長雨一図糸光二五点千花雨社海右一遠玉二車学考場王右引千一光正国車空音引肉雨一星三一二口黄引空雨前形右一科休一車学弟光王右会竹一光生谷光空音近通雨一前手右光校円矢花雨通顔右一家気通車気手東王右丸早一光青合毎空音場鳴雨一太山光二校行悪花雨風形右一回九通車気楽古王右近竹一光石下光空音通通雨一茶糸光二左年二花雨野角右一絵馬通花気店人花右古竹一光赤下光空音毎通雨一朝糸光二左点二花雨院角右一角空通車九右東王右光早一光千音毎空下月花雨一電耳一二三点前花円車広右一岩空光車九店引王右週木一光草花毎角下考一雨一肉字光二子円近花円木光右一帰玉通車休手池王右西二一光足火角空下場歩雨一番車一二子点前花円家強右一魚空一車休考風王右前大一光村黒一空下肉来雨一聞四光二四黄光空円近光右一強玉通車休弟池王右長二一光大国角空下悪歩雨一毎出考光糸王一花円光形右一近休光車玉十一王右電竹一光男谷通空火手一雨一鳴糸光二糸高角花円社光右一計玉二車玉楽前王右肉土一光中火車空火二麦雨一用七光二字年矢花円西弓右一原犬一二玉弟院王右風竹一光虫下場空火近駅雨一理糸光二字点引花円通止下一古金通車金右通王右毎足一光町国毎空火矢毎雨一暗子光二耳高悪花円肉近右一後休二車金楽院王右来男一光天谷場空火通院雨一院糸一二七円二花円野工右一公玉一車金色場王右院木右一土火通空火毎毎雨一駅子一二七点毎花円院近右一交休一車空雨男下雨一田一光二下毎空花一肉雨右雨七一二車年近花王花記右一考姉光空空入千王雨花天一光日下毎空花車肉雨右下出光空車点肉花王三強右一高休一車空弓千右雨玉八一車日野通王花日町王右花字一二手円二花王車活右一合玉光車空色場王雨五川一光年貝通三花角鳴雨右九子一二手高一花王男形右一国休一車空妹光王雨耳立一二白貝光空花光長雨右空月光二十白前花王木才右一今空光車月手毎王雨女竹一光八学光空花色五雨右五手一二十高通花王引形右一細犬通車月活人王雨青入一光八国光空花前鳴雨右三小光二出王車花王角広右一作玉通車月考池王雨草立一光百黒一空花肉来雨右子四光二出黄悪花王近光右一止玉通車月弟池王雨町文一光文黒一空花悪来雨右耳四光二女王場花王光光右一矢金一車犬右東王雨白木一光木黒一空貝空悪雨右十糸光二女黄通王王矢画右一思矢一三犬楽毎王雨立村一光本谷光空貝足五右考人手一通小円前花王場記右一寺気通車犬色風王雨遠草一光名合毎空貝角鳴雨右青子一二小高一花王池才右一室玉二車犬妹場王雨会千一光立花二角貝光来雨右千子一二上雨悪花王東原右一弱休一車見手古王雨記虫一光力下光空貝場長雨右村字光二上点二花王風海右一週玉二車見考場王雨近千一光林国車空貝肉肉雨右中三一二森元近雨王悪才雨一書玉二車見弟場王雨古千一光六国車空貝悪肉雨右田三一二人王車町音一原右一場休一車五右光王雨黄虫一光引谷光空学空通雨右白字光二人高二花音空角右一心玉通車五楽場王雨作千一光雲火角空学二道雨右木三一二水年前花音人顔右一親九一車五弟東王雨社早一光園下一空学近鳴雨右林山光二水点一花音町光一光西空一通口右池王雨場千一光遠谷毎空学矢通雨右遠四光二正高一花音家強右一晴九一車口考肉王雨前千一光科国二空学肉通雨右会手一光生高矢花音近記右一船九一車口妹東王雨長草一光夏谷一空気右一九右角糸光二青雨悪花音黒形右一組気通車校日通王雨東草一光歌音毎空気千毎雨右顔子一二青店悪花音場強右一太休一車校考古王雨麦大一光画谷光空気引長雨右魚手一光夕高近花音前記右一台気通車校妹池王雨歩草一光回合毎空気考一花右近四考一石円一車音通会王一通金光光三右風空円一村雨一角下光二九一長花右光月行一川円悪車下車原王一電休光光三考社空円空赤雨一活音二二九考一空右矢字行一先円近二下二記花一東学右一山一院車二一円店一一一出二一円点一一一出悪",

"Twinkle Twinkle Little Star",
"右空一火本右光一一算光一円通一円車一音日一右三一一丸右車一音入一右三一一丸右車一音年一右三一一丸右二一電日一家一出一一町雨一一王光二一二悪花一花三右一雨王千車一二記王一九空通光右考光空一二八雨一花下場二右日五花一人山右一下王千二一通記王一糸九一光王雨花空一光先雨一犬花車二雨二長花一引車右一学円一車右角光王一青気二光下右悪空一通水雨一子火通二円二切花一近耳雨一玉雨二二雨一谷王一二休一光花行三空右空千雨一女花車二王光東花一社車考一見雨悪車雨光光王一引九一光学行一空右引夕雨一青火通光音光長花一池口考一三王千車円一記王一丸空通光九考光空右場日雨一草下二二下弟王花一風左考一糸王一車円光角王一元空一光玉考記空右毎田王一町音毎二火通切花右一耳右一車円一車王車古王一黄気通光月雨三空雨車石雨一百花角二花通太花右車十考一女円車車王場才王一寺学通光見雨三車雨角千雨一林音一二学右王花右二五考一水王空車音車家王一西空一光口右家空雨前二雨一科音二二気一院花右角五考一夕円毎車音場科王一池金右一左右光車二一円店一一一出二一円点一一一出悪",

"Ima, Sakihokoru Hanatachi yo (Arranged)",
"右空一火本一風一一算光一円通一円車一音日一右三一一丸九車一音入一右三一一丸一車一音年一右三一一丸休二一丸右一青一出一一園一光一才場空一手家下一学正光二右合角空一二星雨一学校光二右行近王一草羽一光火学角千右月白雨一女水光光音音空空一前切雨一三見一車円十近王一記六右光玉今通空右妹町王一二森一光花合千空右車寺右一小見一車王店近三一前立雨一三花毎空円月女雨一丸小右一休黄通空右通週雨一中見通二火行黒花一院羽右一車貝通車王手人王一黒生右一犬音千花雨木星右一名口光光貝店前花右二家右一水学通車音日遠王一切生音王一火弟車円近雨千一光二車一空王雨一王右通二一通花花一車雨右一音一毎車一通王王一糸右一光王一近空一矢雨雨一五一光二雨通男花一角右右一休一二車右通糸王一町一光光花一車空右空玉雨一女一二二王通空花一場火右一口一車車雨通花王一会円光光九一空空右矢花王一先一光二下光男花一風右右一糸一二車円場糸王一古一光光金光車空雨一玉雨一入一二二花光空花右三火右一女一車車王場花王一社円光光見光空空雨光王雨一雲右通二学光花花右家雨右一青一毎車音場王王一池右一光左光近空円一雨雨一活一光二九光男花右社右右一草一二車下場糸王車一王月光右一月光切夕高一三合場羽毎",

"Jesu, Joy of Man's Desiring",
"右空一火日光通一一算光一右毎一円車一音日一右三一一丸円車一音入一右三一一丸右車一音年一右三一一丸右二一走弟一引一出一一千王一一当光五一青院雨光花車一角右丸千学一村行右二花空二千右右矢空一上八一場音記角五一弟九円一三子円一円丸光学一原止右二空犬一千雨先三音一目二一場学火光三右家院雨光夕場一引下王空九一通丸王一山矢通人円画人音一近年一通玉下光二右分王雨光天場一引花円毎九右一弓王一手矢一人王歌毎音一矢虫一通犬下毎二雨家悪雨光力少一引学円近二右立原右二正南光人音行花下一台二一場左汽通五円右一円一角三雨一九間通学右時工右二草空一千下走三音一米日一場糸花車三円光東花一形十光角玉新千九右毎谷右光町休右光火走二音一泳文一場車貝一三王山九雨光合場一引月円通九雨青工右二百肉一人貝右東車右上年一場小記車五王弟一円一秋七一引見多通学雨光強王一羽市一人学歌風音右引町一通正下一通音歌一雨光雪色光引校王光九雨道谷右二画肉一人気考毎空二一円店一一一出二一円点一一一出悪",
];

var kind;
var maxCnt, cnt, tmp, i;
var btnNum;
var isPlaying;

const MAX_ROW = 15;

var sp = new SoundPlayerBase();

function scripts(){
	whenFlagClicked(function(){
		hide();
		kind = ORIGINAL;
		hideList(sampleSelectList);
	});
	whenIStartAsAClone(function(){
		if(kind == ORIGINAL){
			kind = GENERATOR;
			createCloneOf(CLONETARGET_MYSELF);
			kind = ORIGINAL;
		}
		if(kind == GENERATOR){
			
			maxCnt = lengthOf(sampleDataList) / 2;
			
			showList(sampleSelectList);
			gotoXY(0, 0);
			switchCostumeTo("sampleBknd");
			show();
			gotoFront();
			
			kind = BTN_CANCEL;
			createCloneOf(CLONETARGET_MYSELF);
			
			createLoadAndPlayBtn();
			
			if(maxCnt > MAX_ROW){
				kind = BTN_PREV;
				createCloneOf(CLONETARGET_MYSELF);
				kind = BTN_NEXT;
				createCloneOf(CLONETARGET_MYSELF);
			}
			
			sampleDataIndex = 0;
			broadcast(MSG_SAMPLE_INDEX_CHANGED);
			
			kind = GENERATOR;
		}else{
			if(kind == BTN_CANCEL){
				gotoXY(0, -160);
				switchCostumeTo("settingCancel");
			}
			if(kind == BTN_PLAY){
				isPlaying = -1;
				gotoXY(202, 148 - 20 * btnNum);
				switchCostumeTo("samplePlayBtnOff");
			}
			if(kind == BTN_LOAD){
				gotoXY(220, 148 - 20 * btnNum);
				switchCostumeTo("sampleLoadBtn");
			}
			if(kind == BTN_PREV){
				gotoXY(124, 168);
				switchCostumeTo("arrowLeft");
			}
			if(kind == BTN_NEXT){
				gotoXY(144, 168);
				switchCostumeTo("arrowRight");
			}
			
			show();
			gotoFront();
		}
	});
	
	whenThisSpriteClicked(function(){
		if(kind == BTN_CANCEL){
			broadcast(MSG_SAMPLE_CANCEL);
		}
		if(kind == BTN_PLAY){
			sp.stop();
			if(isPlaying == -1){
				switchCostumeTo("samplePlayBtnOn");
				tmp = maxCnt - btnNum;
				tmp = tmp * 2 - sampleDataIndex * 2;
				sp.play(sampleDataList[tmp]);
			}else{
				switchCostumeTo("samplePlayBtnOff");
			}
			isPlaying *= -1;
		}
		if(kind == BTN_LOAD){
			tmp = maxCnt - btnNum;
			tmp = tmp * 2 - sampleDataIndex * 2;
			selectedSampleData = sampleDataList[tmp];
			broadcast(MSG_LOAD_SAMPLE_DATA);
			broadcast(MSG_SAMPLE_CANCEL);
		}
		if(kind == BTN_PREV){
			if(sampleDataIndex > 0){
				sampleDataIndex -= MAX_ROW;
				broadcast(MSG_SAMPLE_INDEX_CHANGED);
			}
		}
		if(kind == BTN_NEXT){
			if(maxCnt - sampleDataIndex > MAX_ROW){
				sampleDataIndex += MAX_ROW;
				broadcast(MSG_SAMPLE_INDEX_CHANGED);
			}
		}
	});
	whenIReceive(MSG_SAMPLE_CANCEL, function(){
		if(kind == GENERATOR){
			hideList(sampleSelectList);
			sp.stop();
		}
		deleteThisClone();
	});
	whenIReceive(SOUNDPLAYER_PLAY_COMPLETE, function(){
		if(kind == BTN_PLAY){
			isPlaying = -1;
			switchCostumeTo("samplePlayBtnOff");
		}
	});
	whenIReceive(MSG_SAMPLE_INDEX_CHANGED, function(){
		if(kind == BTN_PREV){
			if(sampleDataIndex == 0){
				setEffectTo(EFFECT_GHOST, 50);
			}else{
				setEffectTo(EFFECT_GHOST, 0);
			}
		}
		if(kind == BTN_NEXT){
			if(maxCnt - sampleDataIndex <=  MAX_ROW){
				setEffectTo(EFFECT_GHOST, 50);
			}else{
				setEffectTo(EFFECT_GHOST, 0);
			}
		}
		if(kind == GENERATOR){
			updateList();
		}
		if(kind == BTN_PLAY || kind == BTN_LOAD){
			tmp = maxCnt - sampleDataIndex;
			if(tmp > btnNum){
				show();
			}else{
				hide();
			}
		}
	});
}

[ProcDef(fastmode="true")]
function createLoadAndPlayBtn(){
	btnNum = 0;
	cnt = MAX_ROW;
	repeat(MAX_ROW){
		kind = BTN_LOAD;
		createCloneOf(CLONETARGET_MYSELF);
		kind = BTN_PLAY;
		createCloneOf(CLONETARGET_MYSELF);
		btnNum++;
	}
}

[ProcDef(fastmode="true")]
function updateList(){
	deleteOf(LIST_DELETE_ALL, sampleSelectList);
	cnt = MAX_ROW;
	tmp = maxCnt - sampleDataIndex;
	if(cnt > tmp){ cnt = tmp; }
	i = maxCnt * 2 - 1 - sampleDataIndex * 2;
	repeat(cnt){
		tmp = i - 1;
		tmp /= 2;
		tmp += 1;
		addTo(join("No.", join(tmp, join("  ", sampleDataList[i]))) , sampleSelectList);
		i -= 2;
	}
}







