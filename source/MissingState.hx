package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;

using StringTools;

class MissingState  extends MusicBeatState
{
    public var huh:Bool;
	
    public function new(freeplay:Bool) 
        {
            super();
            huh =freeplay;
            
        }
   
   
   
   
    override function create()
	{
        super.create();
        var missingfilesbro:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image("missing"));
            add(missingfilesbro);
           
    }

   

    override function update(elapsed) 
    {
        super.update(elapsed);
       
       
           if(huh == true)
           { if(FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.ENTER)
             FlxG.switchState(new FreeplayState());}
           else 
            {if(FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.ENTER)
             FlxG.switchState(new MainMenuState());}
    
    }

}