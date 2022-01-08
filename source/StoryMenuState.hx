package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class StoryMenuState extends MusicBeatState
{
	var scoreText:FlxText;

	var weekData:Array<Dynamic> = [
		['Practice', 'Uoh', 'Craft Away', 'Suit Up', 'Whatever'],
		['Overseen', 'Mine', 'Iron Picks', 'Copper', 'Underrated', 'Tick Tock'],
		['Fast Travel', 'Gapple', 'Retired']
	];
	var curDifficulty:Int = 1;

	public static var weekUnlocked:Array<Bool> = [true, true, true];

	var weekCharacters:Array<Dynamic> = [
		['steve', 'bf', 'gf'],		
		['alex', 'bf', ''],
		['notch', 'bf', 'gf']
	];

	var weekNames:Array<String> = [
		"Crafting Bars",
		"Xp farms be like",
		"The Finale?"
	];

	var txtWeekTitle:FlxText;

	var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var upArrow:FlxSprite;
	var downArrow:FlxSprite;
	var diffs:FlxSprite;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Story Mode Menu", null);
		#end



		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menuBGSM")); // TIAGO THIS HERE INCASE yOUR FORGET LOL -- written by tiago

		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = false;
		menuBG.scale.set(1.3, 1.3);
		menuBG.y -= 50;
		add(menuBG);

		var b:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('blackSM'));
		b.scrollFactor.x = 0;
		b.scrollFactor.y = 0;
		b.updateHitbox();
		b.screenCenter();
		b.antialiasing = true;
		add(b);


		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}
				

		
		persistentUpdate = persistentDraw = true;
		
		scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);
		scoreText.y += 670;

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.y += 670;
		txtWeekTitle.screenCenter(X);

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("MinecraftRegular-Bmg3.otf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);
		
		
		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		var yellowBG:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 400, 0x00000000);

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		trace("Line 50");


		
		trace("Line 70");

		for (i in 0...weekData.length)
		{
			var weekThing:MenuItem = new MenuItem(0, yellowBG.y + yellowBG.height + 10, i);
			weekThing.y += ((weekThing.height + -40) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);

			weekThing.screenCenter(X);
			weekThing.antialiasing = true;
			// weekThing.updateHitbox();

			// Needs an offset thingie
			if (!weekUnlocked[i])
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = true;
				grpLocks.add(lock);
			}
		}

		trace("Line 96");

		grpWeekCharacters.add(new MenuCharacter(0, 100, 0.5, false));
		grpWeekCharacters.add(new MenuCharacter(450, 25, 0.9, true));
		grpWeekCharacters.add(new MenuCharacter(850, 100, 0.5, true));

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		trace("Line 124");

		leftArrow = new FlxSprite(grpWeekText.members[0].x + grpWeekText.members[0].width + 10, grpWeekText.members[0].y + 10);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		difficultySelectors.add(leftArrow);

		sprDifficulty = new FlxSprite(leftArrow.x + 130, leftArrow.y);
		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'NHARD');
		sprDifficulty.animation.addByPrefix('hardcore', 'HARDCORE');
		sprDifficulty.animation.addByPrefix('ultrahardcore', 'ULTRA HARDCORE');
		sprDifficulty.animation.play('normal');
		changeDifficulty();

		rightArrow = new FlxSprite(sprDifficulty.x + sprDifficulty.width + 50, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		difficultySelectors.add(rightArrow);
		
		difficultySelectors.add(sprDifficulty);
		
		diffs = new FlxSprite(0, 340);
		diffs.frames = Paths.getSparrowAtlas('Diffs');
		diffs.animation.addByPrefix('easy', 'Easy', 24);
		diffs.animation.addByPrefix('normal', 'Normal', 24);
		diffs.animation.addByPrefix('harrrd', 'Very yes very much hard', 24);
		diffs.animation.addByPrefix('hardcoreee', 'Hardcore', 24);
		diffs.animation.addByPrefix('Ultrahardcoreee', 'UltraHardcore', 24);
		diffs.animation.play('normal');
		add(diffs);
		
		upArrow = new FlxSprite(150, 320);
		upArrow.frames = Paths.getSparrowAtlas('Arrows');
		upArrow.animation.addByPrefix('idle', 'Up', 24, false);
		upArrow.animation.addByPrefix('press', "Up press", 24, false);
		upArrow.animation.play('idle');
		add(upArrow);
		
		downArrow = new FlxSprite(150, 440);
		downArrow.frames = Paths.getSparrowAtlas('Arrows');
		downArrow.animation.addByPrefix('idle', 'Down Press', 24, false);
		downArrow.animation.addByPrefix('press', "very much Down", 24, false);
		downArrow.animation.play('idle');
		add(downArrow);

		trace("Line 150");

		add(yellowBG);
		add(grpWeekCharacters);

		txtTracklist = new FlxText(FlxG.width * 0.05, yellowBG.x + yellowBG.height + 100, 0, "Tracks", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFFFFFFFF;
		txtTracklist.y += -480;
		add(txtTracklist);
		// add(rankText);
		add(scoreText);
		
		add(txtWeekTitle);

		updateText();

		trace("Line 165");

		super.create();
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		scoreText.text = "WEEK SCORE:" + lerpScore;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		// FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors.visible = weekUnlocked[curWeek];

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
		});

		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.RIGHT_P)
				{
					changeWeek(-1);
				}

				if (controls.LEFT_P)
				{
					changeWeek(1);
				}

				if (controls.RIGHT)
				{
					rightArrow.animation.play('press');					
				}
				else
					rightArrow.animation.play('idle');
				if (controls.LEFT)

					leftArrow.animation.play('press');		
				else
					leftArrow.animation.play('idle');
					
				if (controls.UP_P)
					{
					upArrow.animation.play('press'); 
					FlxG.sound.play(Paths.sound('scrollMenu'));
					}
				if (controls.DOWN_P)
					{
					downArrow.animation.play('press');
					FlxG.sound.play(Paths.sound('scrollMenu'));
					}
					
				if (controls.UP_P)
					changeDifficulty(1);
				if (controls.DOWN_P)
					changeDifficulty(-1);
			}

			if (controls.ACCEPT)
			{
				selectWeek();
			}
		}
		
		if (curDifficulty == 0){
		diffs.animation.play('normal');
		}	
		if (curDifficulty == 1){
		diffs.animation.play('harrrd');
		}
		if (curDifficulty == 2){
		diffs.animation.play('hardcoreee');
		}
		if (curDifficulty == 3){
			diffs.animation.play('Ultrahardcoreee');
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				grpWeekText.members[curWeek].startFlashing();
				grpWeekCharacters.members[1].animation.play('bfConfirm');
				stopspamming = true;
			}

			PlayState.storyPlaylist = weekData[curWeek];
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = "";

			switch (curDifficulty)
			{
				case 0:
					diffic = '-normal';
				case 3:
					diffic = '-ultrahardcore';
			}

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.storyWeek = curWeek;
			PlayState.campaignScore = 0;
			LoadingState.loadAndSwitchState(new PlayState(), true);
		}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 3;
		if (curDifficulty > 3)
			curDifficulty = 0;
			
		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('normal');
				sprDifficulty.offset.x = 30;
			case 1:
				sprDifficulty.animation.play('hard');
				sprDifficulty.offset.x = 20;
			case 2:
				sprDifficulty.animation.play('hardcore');
				sprDifficulty.offset.x = 20;
			case 3:
				sprDifficulty.animation.play('ultrahardcore');
				sprDifficulty.offset.x = 20;

		}

		sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		sprDifficulty.y = leftArrow.y - 15;
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end
		FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= weekData.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && weekUnlocked[curWeek])
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		FlxG.sound.play(Paths.sound('scrollMenu'));

		updateText();
	}

	function updateText()
	{
		grpWeekCharacters.members[0].setCharacter(weekCharacters[curWeek][0]);
		grpWeekCharacters.members[1].setCharacter(weekCharacters[curWeek][1]);
		grpWeekCharacters.members[2].setCharacter(weekCharacters[curWeek][2]);

		txtTracklist.text = "Tracks\n";
		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
			txtTracklist.text += "\n" + i;

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;

		txtTracklist.text += "\n";

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end
	}
}