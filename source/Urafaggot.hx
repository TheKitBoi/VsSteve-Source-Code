package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;

class Urafaggot extends MusicBeatState
{
        
     override public function create():Void
    {
        super.create();
    
        var faggot:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('Menu/ph/bg'));
		add(faggot);
        var text = new FlxSprite(31,488);
        text.frames = Paths.getSparrowAtlas('Menu/ph/hard');
        text.animation.addByPrefix('text','hard',24,true);
        text.antialiasing = true;
        text.animation.play('text');
        add(text);
   
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        if (FlxG.keys.justPressed.ESCAPE)
			{
				FlxG.switchState(new MainMenuState());
			}
    }
    
}