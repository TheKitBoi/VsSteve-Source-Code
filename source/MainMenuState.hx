package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import Controls.KeyboardScheme;
import sys.FileSystem;
import sys.io.File;
import flixel.FlxObject;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.effects.FlxFlicker;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import io.newgrounds.NG;
import flixel.math.FlxMath;
import lime.app.Application;


using StringTools;

class MainMenuState extends MusicBeatState
{
	
	public static var nightly:String = "";
	public static var kadeEngineVer:String = "1.6.1" + nightly;
	public static var gameVer:String = "0.2.7.1";
      
	////weeks 
    var weekData:Array<Dynamic> = [
		['Tutorial'],
		['Bopeebo', 'Fresh', 'Dadbattle'],
		['Spookeez', 'South', "Monster"],
		['Pico', 'Philly', "Blammed"],
		['Satin-Panties', "High", "Milf"],
		['Cocoa', 'Eggnog', 'Winter-Horrorland'],
		['Senpai', 'Roses', 'Thorns'],
		['ugh', 'guns', 'stress'],		
		['vidyagaems','sage','harmony'],
	    ['infinigger'],
		['nogames']
	];
	var music:FlxSound;
	///non buttons
	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/menu'));
	///button side images 
    var portsB:FlxSprite = new FlxSprite();
    ///button sprites
	var freeplayB:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/freeplay'));   
	var optionsB:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/options')); 
	var comicsB:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/comics')); 
	var week1B:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/week1'));
	var week2B:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/week2'));
	var week3B:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/week3'));
	var week4B:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/week4'));
	var week5B:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/week5'));
	var week6B:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/week6'));
	var week7B:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/week7'));
	var vB:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/v'));
	var gdB:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/GD'));
	var bonusButton:FlxSprite = new FlxSprite();
	
	
	var freeplay:Bool=true;
	var options:Bool=false;
	var comics:Bool; 
	var week1:Bool=false;
	var week2:Bool=false;
	var week3:Bool=false;
	var week4:Bool=false;
	var week5:Bool=false;
	var week6:Bool=false;
	var week7:Bool=false;
	var bonus:Bool=false;
	var v:Bool=false;
	var gd:Bool=false;
	var diffs:FlxSprite = new FlxSprite();
	var diffic:String="";
    public static var showcat:Bool=false;
	var note:FlxSprite = new FlxSprite(900,415).loadGraphic(Paths.image('Menu/mainmenu/NOTE'));
	var score:FlxText;
	var intendedScore:Int;
	var CD:Int=1;
	var debug2:Bool = false;
	var missing:Bool;
	var debug:Bool = false;
	var _noGames:FlxSprite = new FlxSprite();
	var sneedcat:FlxSprite = new FlxSprite();
	var noGames:Bool;
	var header:Headers;	  
	var baseX:Int=279;
	var otherX:Int=468;
	var newX:Int;
	var newOtherX:Int;
	
	
	override public function create()
		{
			super.create();
			newX=baseX+15;
			newOtherX=otherX+15;	
			#if debug
			debug = true;
			debug2=true;
			
			#end
			var lefunnycat = Paths.getSparrowAtlas('Menu/mainmenu/bonus/cat');
			sneedcat.frames=lefunnycat;
			sneedcat.animation.addByPrefix('danceyellowboidance',"cat", 60);
			sneedcat.animation.play('danceyellowboidance');
			sneedcat.setPosition(600,400);
			FlxG.save.data.nogames=true;///unlocked from the get go 
			var bBonus = Paths.getSparrowAtlas('Menu/mainmenu/bonus/bonus');
			bonusButton.frames=bBonus;
			bonusButton.animation.addByPrefix('idle',"Bonus-idle", 24);
			bonusButton.animation.addByPrefix('selected',"Bonus-selected", 24);//they are reversed??? what the fuck
			bonusButton.animation.play('idle');
			bonusButton.setPosition(500,175);
			
			var zzz = Paths.getSparrowAtlas('Menu/mainmenu/bonus/zord');
			_noGames.frames=zzz;
			_noGames.animation.addByPrefix('idle',"bonusZord0", 24);
			_noGames.animation.addByPrefix('selected',"bonusZord selected", 24);
			_noGames.animation.play('idle');
			_noGames.setPosition(-15,95);
			
			if (!FlxG.sound.music.playing) FlxG.sound.playMusic(Paths.music('breakfast'));
				
				
			score = new FlxText(FlxG.width * 0.2, "");
			score.setFormat(Paths.font("vcr.ttf"), 25, FlxColor.BLUE, RIGHT);
			score.setPosition(355,621);
			
			var diff = Paths.getSparrowAtlas('Menu/diff/diff');
					diffs.frames = diff;
					diffs.animation.addByPrefix('easy',"de", 24, false);
					diffs.animation.addByPrefix('normal',"dn", 24, false);
					diffs.animation.addByPrefix('hard',"dh", 24, false);
					diffs.scale.set(0.6,0.6);
					diffs.setPosition(800,609);
							
			
			
			var images = Paths.getSparrowAtlas('Menu/mainmenu/side2');
					portsB.frames = images;
					portsB.animation.addByPrefix('week1',"w1", 24, false);
					portsB.animation.addByPrefix('week2',"w2", 24, false);
					portsB.animation.addByPrefix('week3',"w3", 24, false);
					portsB.animation.addByPrefix('week4',"w4", 24, false);
					portsB.animation.addByPrefix('week5',"w5", 24, false);
					portsB.animation.addByPrefix('week6',"w6", 24, false);
					portsB.animation.addByPrefix('v',"wv", 24, false);
					portsB.animation.addByPrefix('gd',"gd", 24, false);
					portsB.animation.addByPrefix('options',"op", 24, false);
					portsB.animation.addByPrefix('freeplay',"fp", 24, false);
					portsB.animation.addByPrefix('comics',"co", 24, false);
					portsB.animation.addByPrefix('week7',"w7", 24, false);
					
					
					portsB.setPosition(575,400);
					
		
			week1B.y = vB.y= 307;
			week2B.y = gdB.y = week1B.y+35;
			week3B.y = week2B.y+35;
			week4B.y =freeplayB.y= week3B.y+35;
			week5B.y = optionsB.y= week4B.y+35;
			week6B.y = comicsB.y = week5B.y+35;
			week7B.y =week6B.y +35;
			bonusButton.scale.set(0.7,0.7);
			_noGames.scale.set(0.7,0.7);
			note.scale.set(0.55,0.55);

			add(bg);
			add(note);	
			add(week1B);
			add(week2B);
			add(week3B);
			add(week4B);
			add(week5B);
			add(week6B);
			add(week7B);
			add(vB);
			add(gdB);
			add(freeplayB);
			add(optionsB);
			add(comicsB);
			add(diffs);
			add(portsB);
			add(score);
	
			var n = FlxG.random.int(1, 5);
			if(n==5)
				add(sneedcat);
			
			if(debug||FlxG.save.data.nogames)
				add(_noGames);	


			if(debug||FlxG.save.data.unlockBonus)
				add(bonusButton);			
			
		
		
                
		

			diffs.animation.play('normal');			
		
			var red:FlxSprite = new FlxSprite(475,29).loadGraphic(Paths.image('Menu/headers/main'));
			header = new Headers(475, 32);
			add(header);
			add(red);
		}
	






		override public function update(elapsed:Float)
		{
			super.update(elapsed);
			
			if(FlxG.keys.justPressed.V)
				openSubState(new ThankSubstate());
		
			if(FlxG.keys.justPressed.NUMPADFOUR)
				remove(note);
			if(FlxG.keys.justPressed.NUMPADSEVEN)
				add(note);
			
			
			if(FlxG.keys.justPressed.ESCAPE)
				FlxG.switchState(new TitleState());
			
			
			if (FlxG.keys.justPressed.N) 
				{diffs.animation.play('normal');diffic="";CD=1;}
			else if (FlxG.keys.justPressed.E) 
				{diffs.animation.play('easy');diffic="-easy";CD=0;}
			else if (FlxG.keys.justPressed.H) 
				{diffs.animation.play('hard');diffic="-hard";CD=2;}
		
			
		
		
			if (week1 == false)
				week1B.x = baseX;
			if (week2 == false)
				week2B.x = baseX;
			if (week3 == false)
				week3B.x = baseX;
			if (week4 == false)
				week4B.x = baseX;
			if (week5 == false)
				week5B.x = baseX;
			if (week6 == false)
				week6B.x = baseX;
			if (week7 == false)
				week7B.x = baseX;
			if (v == false)
				vB.x =otherX;
			if (gd == false)
				gdB.x =otherX;
			if (freeplay== false)
				freeplayB.x =otherX;
			
			if (options == false)
				optionsB.x =otherX;
			if (comics == false)
				comicsB.x = otherX;
		    if (bonus == true)
				bonusButton.animation.play('selected');
			else
				bonusButton.animation.play('idle');
			if (noGames == true)
				_noGames.animation.play('selected');
			else
				_noGames.animation.play('idle');
				
			
			if (freeplay== true)
				{
					portsB.setPosition(630,80);portsB.scale.set(0.35,0.35);portsB.animation.play('freeplay');freeplayB.x = newOtherX;
	
					score.text = "N/a";
					if (FlxG.keys.justPressed.DOWN){freeplay= false; options = true;}
					if (FlxG.keys.justPressed.UP){freeplay= false;	gd = true;}
					if (FlxG.keys.justPressed.LEFT){freeplay= false;week4 = true;}
					if (FlxG.keys.justPressed.RIGHT){freeplay= false;week4 = true;}
						
                 	if(FlxG.keys.justPressed.ENTER) {FlxG.switchState(new FreeplayState());FlxG.sound.music.stop();};						
				}	
			else if (options == true)
				{
					portsB.setPosition(640,80);portsB.scale.set(0.3,0.3);portsB.animation.play('options');optionsB.x = newOtherX;
					score.text = "N/a";
					if (FlxG.keys.justPressed.DOWN){options = false;comics = true;}
					if (FlxG.keys.justPressed.UP){freeplay = true;options = false;}
					if (FlxG.keys.justPressed.LEFT){ options = false;	week5 = true;}
					if (FlxG.keys.justPressed.RIGHT){ options = false;	week5 = true;}
					if(FlxG.keys.justPressed.ENTER)FlxG.switchState(new OptionsMenu());					
				}
			else if (comics == true)
				{
					portsB.setPosition(635,80);portsB.scale.set(0.3,0.3);portsB.animation.play('comics');comicsB.x = newOtherX;
					score.text = "N/a";
					
					if (FlxG.keys.justPressed.DOWN){comics = false;v = true;}									
					if (FlxG.keys.justPressed.UP){comics = false;options = true;}
					if (FlxG.keys.justPressed.LEFT){comics = false;week6 = true;}
					if (FlxG.keys.justPressed.RIGHT){comics = false;week6 = true;}				
					if(FlxG.keys.justPressed.ENTER)					
							FlxG.openURL('https://imgur.com/a/ce8YEtV');								
				}
			else if (week1 == true)
				{
					portsB.setPosition(650,80);portsB.scale.set(0.35,0.35);portsB.animation.play('week1');week1B.x = newX;				
					scoreText(1);					
					if (FlxG.keys.justPressed.DOWN){week1 = false;week2 = true;}
					if (FlxG.keys.justPressed.UP){ week1 = false;week7 = true;}
					if (FlxG.keys.justPressed.LEFT)				
						
					{
						if(debug2||FlxG.save.data.nogames){week1 = false; noGames = true;}
						else if(debug||FlxG.save.data.unlockBonus){week1 = false; bonus = true;}
						else {week1 = false;v = true;}
					}
						
					
					if (FlxG.keys.justPressed.RIGHT){week1 = false;	v = true;}					
					if(FlxG.keys.justPressed.ENTER)
						if(sys.FileSystem.exists('assets/missingW1.txt')) FlxG.switchState(new MissingState(false)); //stupid way to check on the weeks,freeplay has a system						
						else weekselected(1);
				}
			else if (week2 == true)
				{
					portsB.setPosition(630,100);portsB.scale.set(0.4,0.4);portsB.animation.play('week2');week2B.x = newX;
					scoreText(2);
					if (FlxG.keys.justPressed.DOWN){week2 = false ; week3 = true;}
					if (FlxG.keys.justPressed.UP){week2 = false; week1 = true;}
					if (FlxG.keys.justPressed.LEFT)	{ week2 = false;gd = true;}
					if (FlxG.keys.justPressed.RIGHT){week2 = false; gd = true;}
					if(FlxG.keys.justPressed.ENTER)						
						if(sys.FileSystem.exists('assets/missingW2.txt'))FlxG.switchState(new MissingState(false));
						else weekselected(2);			
				}
			else if (week3 == true)
				{		
					portsB.setPosition(755,270);portsB.scale.set(1,1);portsB.animation.play('week3');week3B.x = newX;
					scoreText(3);
					if (FlxG.keys.justPressed.DOWN){ week3 = false;week4 = true;}
					if (FlxG.keys.justPressed.UP){week3 = false;week2 = true;}
					if (FlxG.keys.justPressed.LEFT){freeplay = true;week3 = false;}
					if (FlxG.keys.justPressed.RIGHT){freeplay = true;week3 = false;}
					if(FlxG.keys.justPressed.ENTER)					
						if(sys.FileSystem.exists('assets/missingW3.txt'))FlxG.switchState(new MissingState(false));
						else 	weekselected(3);							
				}
			else if (week4 == true)
				{
					portsB.setPosition(735,150);portsB.scale.set(0.7,0.7);portsB.animation.play('week4');week4B.x = newX;
					scoreText(4);
					if (FlxG.keys.justPressed.DOWN){week4 = false;week5 = true;}
					if (FlxG.keys.justPressed.UP){ week4 = false;week3 = true;}
					if (FlxG.keys.justPressed.LEFT){freeplay = true;week4 = false;}
					if (FlxG.keys.justPressed.RIGHT){ freeplay = true;week4 = false;}
					if(FlxG.keys.justPressed.ENTER)
						if(sys.FileSystem.exists('assets/missingW4.txt'))
							FlxG.switchState(new MissingState(false));
						else  weekselected(4);												
				}
			else if (week5 == true)
				{
					portsB.setPosition(595,75);portsB.scale.set(0.25,0.25);portsB.animation.play('week5');week5B.x = newX;
					scoreText(5);
					if (FlxG.keys.justPressed.DOWN){week5 = false; week6 = true;}
					if (FlxG.keys.justPressed.UP){week5 = false; week4 = true;}
					if (FlxG.keys.justPressed.LEFT){week5 = false;options = true;	}
					if (FlxG.keys.justPressed.RIGHT){ week5 = false;options = true;	}
					if(FlxG.keys.justPressed.ENTER)
						if(sys.FileSystem.exists('assets/missingW5.txt'))
							FlxG.switchState(new MissingState(false));
						else weekselected(5);										
				}
			else if (week6 == true)
				{					
					portsB.setPosition(670,160);portsB.scale.set(0.6,0.6);portsB.animation.play('week6');week6B.x = newX;
					scoreText(6);
					if (FlxG.keys.justPressed.DOWN){ week6 = false;	week7 = true;	}
					if (FlxG.keys.justPressed.UP){ week6 = false;	week5 = true;}
					if (FlxG.keys.justPressed.LEFT){ week6 = false;comics = true;}
					if (FlxG.keys.justPressed.RIGHT){week6 = false;comics = true;}
					if(FlxG.keys.justPressed.ENTER)					
						if(sys.FileSystem.exists('assets/missingW6.txt'))
								FlxG.switchState(new MissingState(false));
							else 	weekselected(6);							
				}
			else if (week7 == true)
				{						
					portsB.setPosition(670,160);portsB.animation.play('week7');week7B.x = newX;portsB.scale.set(0.6,0.6);
					scoreText(7);
					if (FlxG.keys.justPressed.DOWN){ week7 = false;week1 = true;}
					if (FlxG.keys.justPressed.UP){ week7 = false;week6 = true;}
					if (FlxG.keys.justPressed.LEFT){ week7 = false;comics = true;}
					if (FlxG.keys.justPressed.RIGHT){ week7 = false;comics = true;}
					if(FlxG.keys.justPressed.ENTER)
						if(sys.FileSystem.exists('assets/missingW7.txt'))
							FlxG.switchState(new MissingState(false));
						else 
							weekselected(7);							
				}
			else if (v == true)
				{ 
					portsB.setPosition(690,150);portsB.scale.set(0.55,0.55);portsB.animation.play('v');vB.x = newOtherX;
			        scoreText(8);
					if (FlxG.keys.justPressed.DOWN){ v = false;gd = true;}
					if (FlxG.keys.justPressed.UP){ v = false;comics = true;}
					if (FlxG.keys.justPressed.LEFT){v = false;week1 = true;}
					if (FlxG.keys.justPressed.RIGHT)				
						if(debug||FlxG.save.data.unlockBonus){v = false;bonus = true;}							
						 else {v = false;week1 = true;}								
					
					if(FlxG.keys.justPressed.ENTER)	weekselected(8);
										
				}
			else if (gd == true)
				{
					portsB.setPosition(645,40);portsB.scale.set(0.25,0.25);portsB.animation.play('gd');gdB.x = newOtherX;
	
					if (FlxG.keys.justPressed.DOWN) { freeplay = true; gd = false;}
					if (FlxG.keys.justPressed.UP)   {gd = false; v = true;}
					if (FlxG.keys.justPressed.LEFT)	{gd = false; week1 = true;}
					if (FlxG.keys.justPressed.RIGHT){gd = false;week1 = true;}
					
					if(FlxG.keys.justPressed.ENTER){ trace('no GD HA');}						
				}
				else if (bonus == true)
					{
						scoreText(9);			
						if (FlxG.keys.justPressed.LEFT) {bonus = false; v = true;}
						if (FlxG.keys.justPressed.ENTER) {weekselected(9);}						
					}
				
				else if (noGames == true)
					{				
						scoreText(10);						
						if (FlxG.keys.justPressed.RIGHT) {noGames = false; week1 = true;}
						if(FlxG.keys.justPressed.ENTER) {weekselected(10);}						
					}
	
		
			}
		
		public function weekselected(i:Int):Void
			{
				if(bonus == true && (CD == 1|| CD == 0 )||noGames == true && (CD == 1|| CD == 0 ))
				FlxG.switchState(new Urafaggot());
				else
				{					
							FlxG.sound.music.stop();// bits of the music kept playing even after switching to video state  					
							PlayState.storyPlaylist = weekData[i];
							PlayState.isStoryMode = true;
							PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
							PlayState.sicks = 0;
							PlayState.bads = 0;
							PlayState.shits = 0;
							PlayState.goods = 0;
							PlayState.campaignMisses = 0;
							PlayState.storyWeek = i;
							PlayState.campaignScore = 0;
							PlayState.storyDifficulty = CD;																			
							if(v==true){LoadingState.loadAndSwitchState(new VideoState("assets/videos/v_intro.webm", new PlayState()));}
							else if (bonus== true ){LoadingState.loadAndSwitchState(new VideoState("assets/videos/cancer_intro.webm", new PlayState()));}
                            else if (week7== true ){LoadingState.loadAndSwitchState(new VideoState("assets/videos/ugh.webm", new PlayState()));}
							else{LoadingState.loadAndSwitchState(new PlayState(), true);}					
			    }
		}
		public function scoreText(a:Int):Void
			{
				intendedScore = Highscore.getWeekScore(a, CD);
				intendedScore = Math.floor(intendedScore);
				score.text = "" + intendedScore;
			}




}