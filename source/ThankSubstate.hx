package;

import flixel.input.gamepad.FlxGamepad;
import openfl.Lib;
#if windows
import llua.Lua;
#end
import Controls.Control;
import flixel.FlxG;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxObject;


import flixel.util.FlxTimer;
import Controls.KeyboardScheme;

class ThankSubstate extends MusicBeatSubstate
{


        override public function create():Void 
        {
            super.create();
            var bg:FlxSprite = new FlxSprite(0,0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
            bg.alpha = 0;
            bg.scrollFactor.set();
            add(bg);
             
         
            FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
            
            var thanu:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/thank'));
            thanu.screenCenter();
            thanu.alpha = 0;
            thanu.scrollFactor.set();
            add(thanu);
           
            FlxTween.tween(thanu, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
        
        
        }
   
    
    override function update(elapsed:Float)
        {
            
            if(FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.ENTER)
                           {    
                            
                                close();

                            }
                
                       
            
           
        }



}