package;

#if sys
import smTools.SMFile;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import openfl.Assets;
import flixel.FlxObject;

#if windows
import Discord.DiscordClient;
#end

#if cpp
import sys.thread.Thread;
#end

using StringTools;

class TitleState extends MusicBeatState
{
	static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;

	var curWacky:Array<String> = [];
	var camFollow:FlxObject; ///for da zoom
	var wackyImage:FlxSprite;

	override public function create():Void
	{
		#if polymod
		polymod.Polymod.init({modRoot: "mods", dirs: ['introMod']});
		#end
		
		#if sys
		if (!sys.FileSystem.exists(Sys.getCwd() + "/assets/replays"))
			sys.FileSystem.createDirectory(Sys.getCwd() + "/assets/replays");
		#end

		@:privateAccess
		{
			trace("Loaded " + openfl.Assets.getLibrary("default").assetsLoaded + " assets (DEFAULT)");
		}
		
		#if !cpp

		FlxG.save.bind('funkin', 'ninjamuffin99');

		PlayerSettings.init();

		KadeEngineData.initSave();
		
		#end

				
		Highscore.load();


		curWacky = FlxG.random.getObject(getIntroTextShit());

		trace('hello');

		// DEBUG BULLSHIT

		super.create();

		// NGio.noLogin(APIStuff.API);

		#if ng
		var ng:NGio = new NGio(APIStuff.API, APIStuff.EncKey);
		trace('NEWGROUNDS LOL');
		#end

		#if FREEPLAY
		FlxG.switchState(new FreeplayState());
		#elseif CHARTING
		FlxG.switchState(new ChartingState());
		#else
		#if !cpp
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			startIntro();
		});
		#else
		startIntro();
		#end
		#end
	}

	var bigman:FlxSprite;
	var pressENTER:FlxSprite;
	//var demoetxt:FlxText;

	function startIntro()
	{
		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

		add(bg);

		bigman = new FlxSprite(0, 0);
		bigman.frames = Paths.getSparrowAtlas('Menu/bigguy');
		bigman.antialiasing = true;
		bigman.animation.addByPrefix('lookan', 'biggiy', 24);
		bigman.animation.play('lookan');
		bigman.updateHitbox();
		add(bigman);
		
		pressENTER = new FlxSprite(600,60);
		pressENTER.frames = Paths.getSparrowAtlas('Menu/press');
		pressENTER.animation.addByPrefix('idle', "b1", 24);
		pressENTER.animation.addByPrefix('press', "b2", 24);
		pressENTER.antialiasing = true;
		pressENTER.animation.play('idle');
		pressENTER.updateHitbox();
		
		add(pressENTER);
	
		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		credTextShit = new Alphabet(0, 0, "ninjamuffin99\nPhantomArcade\nkawaisprite\nevilsk8er", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('funkg'));
		add(ngSpr);
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(X);
		if(FlxG.save.data.antialiasing)
			{
				ngSpr.antialiasing = true;
			}

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		FlxG.mouse.visible = false;

		if (initialized)
			skipIntro();
		else {
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));

			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('freakyMenu'));
			// FlxG.sound.list.add(music);
			FlxG.sound.playMusic(Paths.music('intro'));
			Conductor.changeBPM(215);//big for accuracy
			initialized = true;
		}

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('data/introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		var pressedEnter:Bool = controls.ACCEPT;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		if (pressedEnter && !transitioning && skippedIntro)
		{
			#if !switch
			NGio.unlockMedal(60960);

			// If it's Friday according to da clock
			if (Date.now().getDay() == 5)
				NGio.unlockMedal(61034);
			#end

			camFollow = new FlxObject(1015, 330, 1, 1);
			if (FlxG.save.data.flashing)
				pressENTER.animation.play('press');
			
			FlxG.camera.follow(camFollow, null, 1);
			FlxTween.tween(FlxG.camera, {zoom: 5}, 0.9, {ease: FlxEase.expoIn});
			
			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			transitioning = true;
	

			new FlxTimer().start(0.9, function(tmr:FlxTimer)
				{
					FlxG.sound.music.stop();
					if(FlxG.save.data.slurs)
						FlxG.switchState(new NiggerState());
					else
					FlxG.switchState(new MainMenuState());
					
				});
		}

		if (pressedEnter && !skippedIntro && initialized)
		{
			skipIntro();
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			money.y += (i * 60) + 200;
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String)
	{
		var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
		coolText.screenCenter(X);
		coolText.y += (textGroup.length * 60) + 200;
		credGroup.add(coolText);
		textGroup.add(coolText);
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	override function beatHit()
	{
		super.beatHit();

		bigman.animation.play('lookan');
			
			FlxG.log.add(curBeat);
			FlxG.watch.addQuick("beatShit", curBeat);
			switch (curBeat)
			{
				case 3 : createCoolText(['special thanks', 'to']);						
				case 4 : addMoreText('Three Angled Blue');				
				case 17 : deleteCoolText();		
				case 18 : createCoolText(['From the degenerates', 'at']);					        
				case 19 :ngSpr.visible = true;		
				case 26 : deleteCoolText();		
						  ngSpr.visible = false;	    
				case 27 : createCoolText([curWacky[0]]);	
				case 28 : addMoreText(curWacky[1]);
				case 31 : deleteCoolText();	
				case 32 : createCoolText(['Friday']);		
				case 33 : addMoreText('night');
				case 34 : addMoreText('fankan');
				case 36: deleteCoolText();	
				case 38: skipIntro();
					 ///that was a mess lol
					
			}
	}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)  ///hmmm optimize da game ? nooo tween da logo -kade
			{
				remove(ngSpr);
	
				FlxG.camera.flash(FlxColor.WHITE, 4);
				remove(credGroup);
				skippedIntro = true;
			}
	}
}
