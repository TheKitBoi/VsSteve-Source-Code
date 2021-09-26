package;

import Controls.KeyboardScheme;
import flixel.input.gamepad.FlxGamepad;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import lime.system.System;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;
	var logoBl:FlxSprite;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'options', 'quit', 'credits', 'ouh'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.4.2" + nightly;
	public static var gameVer:String = "1.17";

	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		FlxG.mouse.visible = true;

		//var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menuBG"));
		//menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		//menuBG.x -= 800;
		//menuBG.y -= 400;
		//menuBG.updateHitbox();
		//menuBG.antialiasing = false;
		//menuBG.scale.set(1.3, 1.3);
		//add(menuBG);

		var minecraft:FlxSprite = new FlxSprite().loadGraphic(Paths.image("minecraf"));
		minecraft.setGraphicSize(Std.int(minecraft.width * 1.1));
		minecraft.updateHitbox();
		minecraft.screenCenter(X);
		minecraft.setPosition(minecraft.x, 150);
		minecraft.antialiasing = false;
		add(minecraft);

		var menuBG:FlxSprite = new FlxSprite();
		menuBG.frames = Paths.getSparrowAtlas('menuBG');
		menuBG.animation.addByPrefix('spin', 'Panorama', 12, true);
		menuBG.animation.play('spin');
		menuBG.y -= 500;
		menuBG.x -= 650;
		menuBG.scale.set(1.3, 1.3);
		menuBG.updateHitbox();
		menuBG.antialiasing = false;
		add(menuBG);


		camFollow = new FlxObject(0, 0, 0, 0);
		add(camFollow);

		menuItems = new FlxTypedGroup<FlxSprite>();
		

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		for (i in 0...optionShit.length)
		{
			var butos:FlxSprite = new FlxSprite(0, FlxG.height * 1.2);
			butos.ID = i;
			butos.frames = tex;
			butos.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			butos.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			butos.animation.play('idle');
			butos.antialiasing = false;
			butos.updateHitbox();
			butos.screenCenter(X);
			butos.scrollFactor.set();
			switch(i) 
			{
				case 0: //storymode
					butos.setPosition(butos.x, 250);
				case 1: //freeplay
					butos.setPosition(butos.x, 350);
				case 2: // options
					butos.setPosition(butos.x - 110, 500);
				case 3: //quit game
					butos.setPosition(butos.x + 110, 500);
				case 4: //credits?
					butos.setPosition(butos.x - 250, 500);
				case 5: //uoh?
					butos.setPosition(butos.x + 250, 500);
				
			}
			menuItems.add(butos);
		}

		add(menuItems);

		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " Minecraft / " + kadeEngineVer + " Steve Engine?" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	var canClick:Bool = true;
	var usingMouse:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		menuItems.forEach(function(spr:FlxSprite)
		{
			if(usingMouse)
			{
				if(!FlxG.mouse.overlaps(spr))
					spr.animation.play('idle');
			}

			if (FlxG.mouse.overlaps(spr))
			{
				if(canClick)
				{
					curSelected = spr.ID;
					usingMouse = true;
					spr.animation.play('selected');
				}

				if(FlxG.mouse.pressed && canClick)
				{
					selectSomething();
				}
			}
		});
			
			if (!selectedSomethin)
				{
					var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
				
					if (controls.BACK)
					{
						FlxG.switchState(new TitleState());
					}
				}
				
			super.update(elapsed);
			
	}

	function selectSomething()
	{
		if (optionShit[curSelected] == 'ouh')
			{
				FlxG.sound.play(Paths.sound('ouh'));
				FlxG.camera.shake(0.05, 0.05);
			}
			else
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				
				canClick = false;
	
				menuItems.forEach(function(spr:FlxSprite)
				{
					if (curSelected != spr.ID)
					{
						FlxG.camera.fade(FlxColor.BLACK, 0.7, false);
						FlxTween.tween(spr, {alpha: 0}, 1.3, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								spr.kill();
							}
						});
					}
					else
					{
						FlxG.camera.fade(FlxColor.BLACK, 0.7, false);
						new FlxTimer().start(1, function(tmr:FlxTimer)
							{
								goToState();
							});
					}
				});
			}
	}

	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story mode':
				FlxG.switchState(new StoryMenuState());
				trace("Story Menu Selected");
			case 'freeplay':
				FlxG.switchState(new FreeplayState());
				trace("Freeplay Menu Selected");

			case 'ouh':
				FlxG.camera.shake(0.05, 0.05);
				FlxG.sound.play(Paths.sound('ouh'));
				trace("WHAT THE FUCK HAPPENED");

			case 'options':
				FlxG.switchState(new OptionsMenu());

			case 'quit':
				System.exit(0);

			case 'credits':
				trace("Soon");
				System.exit(0);
		}
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}