package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class FakeMoot  extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas("Backbros/fakemoot",'V');
		animation.addByIndices('danceLeft', 'fakemoot', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], "", 24, false);
		animation.addByIndices('danceRight', 'fakemoot', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], "", 24, false);
		animation.play('danceLeft');
		antialiasing = true;
	}

	var danceDir:Bool = false;

	public function dance():Void
	{
		danceDir = !danceDir;

		if (danceDir)
			animation.play('danceRight', true);
		else
			animation.play('danceLeft', true);
	}
}
