package;

import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxSort;
import lime.app.Application;
import openfl.utils.Future;
import openfl.media.Sound;
import flixel.system.FlxSound;
#if sys
import smTools.SMFile;
import sys.FileSystem;
import sys.io.File;
#end
import Song.SwagSong;
import flash.text.TextField;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroupIterator;

import flixel.util.FlxTimer;
import io.newgrounds.NG;
import flixel.FlxState;
import flixel.animation.FlxBaseAnimation;

import sys.FileSystem;
import sys.io.File;
using StringTools;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];
	
	var curSelected:Int = 0;
	var camFollow:FlxObject;

	public var curDifficulty:Int=1;
	
    var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/freeplay/menublue'));
	private var iconArray:Array<HealthIcon> = [];
	public var port:FlxSprite = new FlxSprite();
	public var diffs:FlxSprite = new FlxSprite();
	public var yotsuba:FlxSprite = new FlxSprite();
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;
	public var diffictext:String;
	var scoreText:FlxText;
	
	var header:Headers;
	  
	var selectedSong:FlxText;
	var debug:Bool;
	
	override function create()
	{
		super.create();
	    #if debug
		debug = true;
		#end
		
		
		var initSonglist = CoolUtil.coolTextFile(Paths.txt('data/freeplaySonglist'));			
		for (i in 0...initSonglist.length)
			{
				var data:Array<String> = initSonglist[i].split(':');
				songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
			}
			if(sys.FileSystem.exists('assets/Sneed'))
				songs.push(new SongMetadata("sneed", Std.parseInt("10"), "sneed")); ///aaa
			
			
			if(debug||FlxG.save.data.unlockBonus)
				songs.push(new SongMetadata("infinigger", Std.parseInt("11"), "cancer")); ///aaa
			


			scoreText = new FlxText("", 32);
			scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.BLUE, RIGHT);
			scoreText.setPosition(765,311);
			
			selectedSong = new FlxText("", 32);
			selectedSong.setFormat(Paths.font("score.ttf"), 32, FlxColor.fromRGB(17, 103, 7));
			selectedSong.setPosition(267,320);
			selectedSong.alignment = FlxTextAlign.CENTER;
			
			
					
			var ports = Paths.getSparrowAtlas('Menu/freeplay/ports');
					port.frames = ports;
					port.animation.addByPrefix('tutorial',"week0port", 24, false);
					port.animation.addByPrefix('week1',"week1port", 24, false);
					port.animation.addByPrefix('week2',"week2port", 24, false);
					port.animation.addByPrefix('week3',"week3port", 24, false);
					port.animation.addByPrefix('week4',"week4port", 24, false);
					port.animation.addByPrefix('week5',"week5port", 24, false);
					port.animation.addByPrefix('week6',"week6port0", 24, false);
					port.animation.addByPrefix('v',"weekvport", 24, false);
					port.animation.addByPrefix('week6alt',"week6port3", 24, false);
					port.animation.addByPrefix('week5alt',"week5portalt", 24, false);
					port.animation.addByPrefix('cancer',"weekcanport", 24, false);
					port.animation.addByPrefix('week2alt',"weekmonport", 24, false);
					port.animation.addByPrefix('week7',"weektank", 24, false);
					port.animation.addByPrefix('zord',"weekzord", 24, false);
					port.animation.addByPrefix('sneed',"weeksneed", 24, false);
					port.antialiasing = true;
					port.scale.set(0.67,0.67);
					port.setPosition(562,383);
					
			var diff = Paths.getSparrowAtlas('Menu/diff/diff_blue');
					diffs.frames = diff;
					diffs.animation.addByPrefix('easy',"be", 24, false);
					diffs.animation.addByPrefix('normal',"bn", 24, false);
					diffs.animation.addByPrefix('hard',"bh", 24, false);
					diffs.animation.addByPrefix('vside',"bv", 24, false);
					diffs.animation.play('normal');
					diffs.scale.set(0.8,0.8);
					diffs.setPosition(750,335);
					diffs.antialiasing = true;
			
			var yo = Paths.getSparrowAtlas('Menu/freeplay/Yotsu');
				yotsuba.frames = yo;
				yotsuba.animation.addByPrefix('easy',"Ye", 24, false);
				yotsuba.animation.addByPrefix('normal',"Yn", 24, false);
				yotsuba.animation.addByPrefix('hard',"yh", 24, false);
				yotsuba.animation.addByPrefix('vside',"Yv", 24, false);
				yotsuba.animation.play('normal');
				yotsuba.scale.set(0.68,0.68);
				yotsuba.setPosition(240,370);
				yotsuba.antialiasing = true;
				
				bg.screenCenter();
				bg.antialiasing = true;
				
				
				add(bg);
				add(port);
                add(diffs);	
				add(scoreText);
			    add(yotsuba);
			    add(selectedSong);
				changeItem(0);
				changeDiff(1);
			
				diffictext='';
				var blue:FlxSprite = new FlxSprite(475,29).loadGraphic(Paths.image('Menu/headers/free'));
				header = new Headers(475, 32);
				add(header);
				add(blue);
			}

	var selectedSomethin:Bool = false;
	override function update(elapsed:Float)
	{	
		if (!selectedSomethin)
		{
			if (FlxG.keys.justPressed.E){changeDiff(0);diffictext='-easy';}
			if (FlxG.keys.justPressed.N){changeDiff(1);diffictext='';}
			if (FlxG.keys.justPressed.H){changeDiff(2);diffictext='-hard';}
			//if (FlxG.keys.justPressed.V){changeDiff(3);diffictext='-v';}
		
			if (FlxG.keys.justPressed.LEFT)
			{			
				changeItem(-1);
				changeDiff(curDifficulty);
			}

			if (FlxG.keys.justPressed.RIGHT)
			{				
				changeItem(1);
				changeDiff(curDifficulty);
			}
			
		
			
			if (FlxG.keys.justPressed.ESCAPE)
			{
				  
				
				FlxG.switchState(new MainMenuState());
			}

			if (FlxG.keys.justPressed.ENTER)
			{
				var songFormat = StringTools.replace(songs[curSelected].songName, " ", "-");
				switch (songFormat) {
					case 'Dad-Battle': songFormat = 'Dadbattle';
					case 'Philly-Nice': songFormat = 'Philly';
		            case 'Sage':songFormat= 'sage';
					case 'Vidyagaems':songFormat= 'vidyagaems';
					case 'Harmony':songFormat= 'harmony';		
				}
						
				var songcheck = StringTools.replace(songs[curSelected].songName, " ", "-"); ////UUNNNHGGGGGG
				switch (songcheck) {
					case 'Dad-Battle': songcheck = 'dadbattle';
					case 'Philly-Nice': songcheck = 'philly';
					case 'Satin-Panties': songcheck = 'satin-panties';
					case 'Winter-Horrorland': songcheck = 'winter-horrorland';
					case 'Tutorial': songcheck = 'tutorial';
					case 'Bopeebo': songcheck = 'bopeebo';
					case 'Fresh': songcheck = 'fresh';
					case 'Spookeez': songcheck = 'spookeez';
					case 'South': songcheck = 'south';
					case 'Monster': songcheck = 'monster';
					case 'Pico': songcheck = 'pico';
					case 'Blammed': songcheck = 'blammed';
					case 'High': songcheck = 'high';
					case 'Milf': songcheck = 'milf';
					case 'Cocoa': songcheck = 'cocoa';
					case 'Eggnog': songcheck = 'eggnog';
					case 'Senpai': songcheck = 'senpai';
					case 'Roses': songcheck = 'roses';
					case 'Thorns': songcheck = 'thorns';
					case 'Sage':songcheck= 'sage';
					case 'Vidyagaems':songcheck= 'vidyagaems';
					case 'Harmony':songcheck= 'harmony';	
				}
				
			
				
				if(sys.FileSystem.exists('assets/data/'+ songcheck +'/'+ songcheck + diffictext + '.json'))
					{
						var poop:String = Highscore.formatSong(songFormat, curDifficulty);		
						PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName);	
						PlayState.isSM = false;
						PlayState.isStoryMode = false;
						PlayState.storyDifficulty = curDifficulty;
						PlayState.storyWeek = songs[curSelected].week;
						LoadingState.loadAndSwitchState(new PlayState());}
				else
					{FlxG.switchState(new MissingState(true));}
            }
        }
    }

	public function addSong(songName:String, weekNum:Int, songCharacter:String)
		{
			songs.push(new SongMetadata(songName, weekNum, songCharacter));
		}
	
	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>)
		{
			if (songCharacters == null)
				songCharacters = ['dad'];
	
			var num:Int = 0;
			for (song in songs)
			{
				addSong(song, weekNum, songCharacters[num]);
	
				if (songCharacters.length != 1)
					num++;
			}
		}
	
		function changeItem(change:Int = 0)
		{	
			//selectedSong.setPosition(275,320);			
			//FlxTween.tween(selectedSong, { x: 267, y: 320 }, 0.4);
			
			curSelected += change;
			if (curSelected < 0)
				curSelected = songs.length - 1;
			if (curSelected >= songs.length)
				curSelected = 0;
			FlxG.sound.playMusic(Paths.inst(songs[curSelected].songName));	
			FlxG.sound.play(Paths.sound('scrollMenu'),false);
			
           trace(songs[curSelected].songCharacter);

			switch(songs[curSelected].songCharacter)
			{           
							
				case "gf" : port.animation.play('tutorial');
				case 'dad': port.animation.play('week1');
				case 'spooky' : port.animation.play('week2');
				case 'monster' : port.animation.play('week2alt');
				case "pico" : port.animation.play('week3');
				case "mom" : port.animation.play('week4');
				case "parents-christmas" : port.animation.play('week5');
			 	case "monster-christmas" : port.animation.play('week5alt');
				case "senpai" : port.animation.play('week6');
				case "spirit" : port.animation.play('week6alt');
				case "captain" : port.animation.play('week7');				
				case "v-calm" : port.animation.play('v');
				case "zord" : port.animation.play('zord');
				case "cancer" : port.animation.play('cancer');
				case "sneed" : port.animation.play('sneed');										
			}
		/*	switch(songs[curSelected].songCharacter)
			{           
							
				case "Tutorial" : port.animation.play('tutorial');
				case 'Bopeebo'|'Fresh'|"Dad Battle": port.animation.play('week1');
				case 'Spookeez'|'South' : port.animation.play('week2');
				case 'Monster' : port.animation.play('week2alt');
				case "Philly Nice"|"pico"|"blammed" : port.animation.play('week3');
				case "milf"|"satine panites"|"high" : port.animation.play('week4');
				case "eggnog"|"Cocoa:parents-" : port.animation.play('week5');
				case "winter hororrland" : port.animation.play('week5alt');
				case "roses"|"senpai" : port.animation.play('week6');
				case "throns" : port.animation.play('week6alt');
				case "stress"|"ugh"|"guns" : port.animation.play('week7');				
				case "vidyagames"|"sage"|"harmony" : port.animation.play('v');
				case "nogames" : port.animation.play('zord');
				case "infinigger" : port.animation.play('cancer');
														
			}*/
			var songHighscore = StringTools.replace(songs[curSelected].songName, " ", "-");
			switch (songHighscore) {
				case 'Dad-Battle': songHighscore = 'Dadbattle';
				case 'Philly-Nice': songHighscore = 'Philly';
				case 'Sage':songHighscore= 'sage';
				case 'Vidyagaems':songHighscore= 'vidyagaems';
				case 'Harmony':songHighscore= 'harmony';
			}		
			
			intendedScore = Highscore.getScore(songHighscore, curDifficulty);			
			
			selectedSong.text=""+ songs[curSelected].songName;
			
		}
		
		function changeDiff(D:Int)
			{
				curDifficulty = D;		
				switch(D)
				{
					case 0 :diffs.animation.play('easy'); yotsuba.animation.play('easy');
					case 1 :diffs.animation.play('normal'); yotsuba.animation.play('normal');
					case 2 :diffs.animation.play('hard'); yotsuba.animation.play('hard');
					case 3 :diffs.animation.play('vside'); yotsuba.animation.play('vside');
				}			
				
				var songHighscore = StringTools.replace(songs[curSelected].songName, " ", "-");
				switch (songHighscore) 
				{
					case 'Dad-Battle': songHighscore = 'Dadbattle';
					case 'Philly-Nice': songHighscore = 'Philly';
					case 'Sage':songHighscore= 'sage';
					case 'Vidyagaems':songHighscore= 'vidyagaems';
					case 'Harmony':songHighscore= 'harmony';
				
				}
				intendedScore = Highscore.getScore(songHighscore, curDifficulty);					
			
				scoreText.text = "" + intendedScore;
			}	
			



}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	#if sys
	public var sm:SMFile;
	public var path:String;
	#end
	public var songCharacter:String = "";

	public var diffs = [];

	#if sys
	public function new(song:String, week:Int, songCharacter:String, ?sm:SMFile = null, ?path:String = "")
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.sm = sm;
		this.path = path;
	}
	#else
	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
	#end
}
