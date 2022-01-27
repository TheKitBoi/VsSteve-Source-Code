package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;
class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;

	var stageSuffix:String = "";

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daBf:String = '';
		switch (PlayState.SONG.player1)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case'bf-v':
			    daBf = 'bf-v';
			case'bf-alt':
			    daBf='bf-alt';		
				
			case'bfzord':
			    daBf = 'bfzord';
			case'bfAndGF':
			    daBf = 'bfHoldingGF-DEAD';
			case'homoomor':
			    daBf = 'homoomor';
			default:
				daBf = 'bf';
		}

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		add(bf);

		var n = FlxG.random.int(1,25);	
     
	  switch (daBf)
	   {
        	case "bfzord"  : camFollow = new FlxObject(bf.getGraphicMidpoint().x+200, bf.getGraphicMidpoint().y+100, 1, 1); ///because offsets SUCK!
			
			default:
				camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		
		}
		Conductor.changeBPM(100);

		if(PlayState.SONG.player2 == "captain")
			{
				FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));			
				new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						FlxG.sound.play(Paths.sound('jeffGameover-'+n));		
				
				
						
					});
				
				
				
				
			
			}	
		else
		
			FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
			

		

		
		add(camFollow);
		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');
	}

	var startVibin:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new MainMenuState());
			else
				FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			if(PlayState.SONG.player2 == "captain")
			
				new FlxTimer().start(4, function(tmr:FlxTimer)
					{
						FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));					
					});
		
			 else	
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
			startVibin = true;
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		if (startVibin && !isEnding)
		{
			bf.playAnim('deathLoop', true);
		}
		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			PlayState.startTime = 0;
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
