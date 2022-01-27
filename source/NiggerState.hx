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
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import io.newgrounds.NG;
import flixel.math.FlxMath;
import lime.app.Application;
using StringTools;



class NiggerState extends MusicBeatState
{
	

	override public function create()
		{
			super.create();
			
                   var niggernigger:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image("deleteyoursavelmao"));
                   add(niggernigger);
           
	
		}
	
		override public function update(elapsed:Float)
		{
			super.update(elapsed);
           
           
           
           
    
        
        }



}