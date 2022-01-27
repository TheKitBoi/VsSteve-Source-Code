package;

import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.Lib;
import Controls.Control;
import lime.app.Application;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxObject;
import flixel.tweens.FlxEase;

class OptionsMenu extends MusicBeatState
{
	 
	
	
	var dumbTexts:FlxTypedGroup<FlxText>;
	
	
	
	var options:Array<String> =
	[  	"Key bindings.",
	    "Full Screen.",
		"Offset.",
		"Scroll type.",
		"Scroll speed.",
		"Ghost tapping.",
		"Show FPS.",
		"Song position.",
		"Safe frames.",
		"Accuracy type.",
		"Restart pressing R.",
		"FPS Cap.",
		"Hide slurs.",
		"Cache.",
		"Customize Hud.",
		"Charter grid.",
		"Sneedify."
	
	];	
	public static var acceptInput:Bool = true;
	var header:Headers;
   	var selected:Int = 0;
  	var baseX:Int=60;
  	var baseY:Int=242;
	public var disc:FlxText;
   override public function create():Void
    {
        super.create();
		
		if (!FlxG.sound.music.playing)
			{
				FlxG.sound.playMusic(Paths.music('breakfast'));
			}
		
		var bg:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('Menu/options/bg'));
		
		var bg2:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('Menu/options/bg2'));
	

		dumbTexts = new FlxTypedGroup<FlxText>();
		
		disc = new FlxText("This is a test text lol");
		disc.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(82, 41, 26));
		disc.setPosition(380,629);
		
		var prup:FlxSprite = new FlxSprite(475,29).loadGraphic(Paths.image('Menu/headers/ops'));
		header = new Headers(475, 32);
		
	
		//layering		
		add(bg2);
		add(dumbTexts);	
		add(bg);
		add(disc);
		add(header);
		add(prup);
	
		daOptions();
		text();		
	}

	function text()
		{									
			for (n in 0...options.length)
					{																					 
						var space=(n == selected)? "  " : "";													
						var ops:FlxText = new FlxText();		
						ops.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
						ops.y=baseY+n*32;						
						ops.text=space + options[n];													
						ops.x=baseX;		
						dumbTexts.add(ops);		  
					}
		    
		}		
	function fuckYou()
		{
			dumbTexts.forEach(function(ops:FlxText)
			{
				ops.kill();
				dumbTexts.remove(ops);
			});
		}
	function change(n:Int)
		{			
			selected += n;			
			if (selected > options.length-1)
				selected = 0;
			if (selected < 0)			 		
				selected = options.length-1;			
			if(selected<13)
				baseY=242;
			
			if(selected>=13&&FlxG.keys.justPressed.UP)
				baseY+=30;
			if(selected>=13&&FlxG.keys.justPressed.DOWN)
				baseY-=30;
		    if(selected==options.length-1)
				baseY=117;
		
		
	



		}	
    
	
	
	
	
	function daOptions()
		{
			var curSelect:String = options[selected];
			switch(curSelect)
			{
				
				case "Sneedify.": 
					if (FlxG.keys.justPressed.ENTER)
					FlxG.save.data.sneed=!FlxG.save.data.sneed;
					
					FlxG.save.data.sneed ? disc.text="Sneed Engine"  : disc.text="Kade Engine";	
				case "Full Screen.": 
					if (FlxG.keys.justPressed.ENTER)
					FlxG.fullscreen = !FlxG.fullscreen;
					
					FlxG.fullscreen ? disc.text="Full Screen is ON"  : disc.text="Full Screen is OFF";	
				
				
				
				case "Key bindings.": 
					if (FlxG.keys.justPressed.ENTER)
					openSubState(new KeyBindMenu());							
					disc.text="Change input keys.";					
				case "Offset.":
					if (FlxG.keys.justPressed.RIGHT)
						FlxG.save.data.offset += 0.1;
					if (FlxG.keys.justPressed.LEFT)
						FlxG.save.data.offset -= 0.1;
					if (FlxG.keys.justPressed.R)
						FlxG.save.data.offset = 0;
					disc.text="Input offset : "+ HelperFunctions.truncateFloat(FlxG.save.data.offset,2) + '- Press R to reset';
				case "Scroll type.":
					FlxG.save.data.downscroll ? disc.text="Scroll type : Down" : disc.text="Scroll type : UP";	
					if (FlxG.keys.justPressed.ENTER)
						FlxG.save.data.downscroll = !FlxG.save.data.downscroll;	
				case "Scroll speed.":
					
					if (FlxG.keys.justPressed.LEFT)
						{
							FlxG.save.data.scrollSpeed -= 0.1;						
							if (FlxG.save.data.scrollSpeed < 1)
								FlxG.save.data.scrollSpeed = 1;											
							if (FlxG.save.data.scrollSpeed > 4)
								FlxG.save.data.scrollSpeed = 4;											
						}
					if (FlxG.keys.justPressed.RIGHT)
						{
							FlxG.save.data.scrollSpeed += 0.1;			
							if (FlxG.save.data.scrollSpeed < 1)
								FlxG.save.data.scrollSpeed = 1;								
							if (FlxG.save.data.scrollSpeed > 4)
								FlxG.save.data.scrollSpeed = 4;							
						}
						disc.text="Scroll speed : " + HelperFunctions.truncateFloat(FlxG.save.data.scrollSpeed,1);	
				case "Ghost tapping.":
					if (FlxG.keys.justPressed.ENTER)												
						FlxG.save.data.ghost = !FlxG.save.data.ghost;
					FlxG.save.data.ghost ? disc.text="Safe input in empty sections : ON" : disc.text="Safe input in empty sections : OFF";																		
				case "Show FPS.":
					if (FlxG.keys.justPressed.ENTER)
						{
							FlxG.save.data.fps = !FlxG.save.data.fps;
							(cast (Lib.current.getChildAt(0), Main)).toggleFPS(FlxG.save.data.fps);								
						}
						!FlxG.save.data.fps ? disc.text="Display FPS counter : OFF" : disc.text="Display FPS counter : ON";	
				case "Song position.":
					if (FlxG.keys.justPressed.ENTER)											
							FlxG.save.data.songPosition = !FlxG.save.data.songPosition;
					!FlxG.save.data.songPosition ? disc.text="Bar showing the length of the song : OFF" :disc.text="Bar showing the length of the song : ON ";								
				case "Safe frames.":
					if (FlxG.keys.justPressed.LEFT)
						{	
							Conductor.safeFrames -= 1;
							FlxG.save.data.frames = Conductor.safeFrames;								
							Conductor.recalculateTimings();										
						}
					if (FlxG.keys.justPressed.RIGHT)
						{								
							Conductor.safeFrames += 1;
							FlxG.save.data.frames = Conductor.safeFrames;								
							Conductor.recalculateTimings();									
						}
						disc.text = "Ratings:" + Conductor.safeFrames +
							"|SK:" + HelperFunctions.truncateFloat(45 * Conductor.timeScale, 0) +
							"ms|GD:" + HelperFunctions.truncateFloat(90 * Conductor.timeScale, 0) +
							"ms|BD:" + HelperFunctions.truncateFloat(135 * Conductor.timeScale, 0) + 
							"ms|ST:" + HelperFunctions.truncateFloat(166 * Conductor.timeScale, 0) +
							"ms|All:" + HelperFunctions.truncateFloat(Conductor.safeZoneOffset,0)+"ms";
				case "Accuracy type.":											
					if (FlxG.keys.justPressed.ENTER)												
							FlxG.save.data.accuracyMod = FlxG.save.data.accuracyMod == 1 ? 0 : 1;															
						FlxG.save.data.accuracyMod == 0 ?  disc.text="Accurate" : disc.text="Complex";
				case "Restart pressing R.":						
					if (FlxG.keys.justPressed.ENTER)												
							FlxG.save.data.resetButton = !FlxG.save.data.resetButton;
					!FlxG.save.data.resetButton ? disc.text="R as a restart button : ON" : disc.text="R as a restart button : OFF";		
				case "FPS Cap.":
					if (FlxG.keys.justPressed.LEFT)
							{	
								if (FlxG.save.data.fpsCap > 290)
									FlxG.save.data.fpsCap = 290;
								else if (FlxG.save.data.fpsCap < 60)
									FlxG.save.data.fpsCap = Application.current.window.displayMode.refreshRate;
								else
									FlxG.save.data.fpsCap = FlxG.save.data.fpsCap - 10;
								(cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
							}
						if (FlxG.keys.justPressed.RIGHT)
							{								
								if (FlxG.save.data.fpsCap >= 290)
									{
										FlxG.save.data.fpsCap = 290;
										(cast (Lib.current.getChildAt(0), Main)).setFPSCap(290);
									}
								else
										FlxG.save.data.fpsCap = FlxG.save.data.fpsCap + 10;					
							}
							disc.text="FPS CAP: " + FlxG.save.data.fpsCap + (FlxG.save.data.fpsCap == Application.current.window.displayMode.refreshRate ? "Hz" : "");
				case "Hide slurs.":
					if (FlxG.keys.justPressed.ENTER)												
							FlxG.save.data.slurs = !FlxG.save.data.slurs;
					FlxG.save.data.slurs ?  disc.text="Hide slurs : ON" : disc.text="Hide slurs : OFF";		
				case "Cache.":
					if (FlxG.keys.justPressed.ENTER)												
							FlxG.save.data.cacheImages  = !FlxG.save.data.cacheImages;												
					FlxG.save.data.cacheImages ?  disc.text="Cache Characters : ON" : disc.text="Cache Characters : OFF";		
				case "Customize Hud.":
					if (FlxG.keys.justPressed.ENTER)												
							FlxG.switchState(new GameplayCustomizeState());
					disc.text="Change the placement of some HUD elements" ;				
				case "Charter grid.":
					if (FlxG.keys.justPressed.ENTER)											
							FlxG.save.data.editor = !FlxG.save.data.editor;
					FlxG.save.data.editor ?  disc.text="Charter grid : ON" : disc.text="Charter grid : OFF";		
			}
			FlxG.save.flush();


		}


	override public function update(elapsed:Float)
	{
		super.update(elapsed);		
		if (acceptInput)
			{	#if debug
				if (FlxG.keys.justPressed.K)
					FlxG.save.data.botplay = !FlxG.save.data.botplay;
                #end
		               
				if (FlxG.keys.justPressed.ESCAPE)						
					if	(FlxG.save.data.slurs) //  fugg :DDDD
						FlxG.switchState(new NiggerState());
					else
					FlxG.switchState(new MainMenuState());
					
		
                if (FlxG.keys.justPressed.UP)
							{		
								fuckYou();
								change(-1);														
								text();
								
							}

							if (FlxG.keys.justPressed.DOWN)
							{
								fuckYou();
								change(1);				
								text();
								
							}							
							
							daOptions();
							
							FlxG.save.flush();
								
			}

	}
}
