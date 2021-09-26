package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';
	public var holdTimer:Float = 0;
	public var iconColor:String = "FF82d4f5";
	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				iconColor = 'FFB03060';
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('characters/gfChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('characters/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('characters/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'no-gf':
				tex = Paths.getSparrowAtlas('characters/no-gf');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('pre-attack', 'bf pre attack', 24, false);
				animation.addByPrefix('attack', 'boyfriend attack', 24 , false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset("pre-attack", 0, -32);
				addOffset("attack", 177, 275);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf-christmas':
				var tex = Paths.getSparrowAtlas('characters/bfChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');

				flipX = true;
			case 'bf-car':
				var tex = Paths.getSparrowAtlas('characters/bfCar');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');

				flipX = true;
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('characters/bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;

			case 'bfminecraft':
				frames = Paths.getSparrowAtlas('characters/bfMinecraft');
				animation.addByPrefix('idle', 'bfMinecraft Idle', 24, false);
				animation.addByPrefix('singUP', 'bfMinecraft up note', 24, false);
				animation.addByPrefix('singLEFT', 'bfMinecraft left note', 24, false);
				animation.addByPrefix('singRIGHT', 'bfMinecraft right note', 24, false);
				animation.addByPrefix('singDOWN', 'bfMinecraft down note', 24, false);
				animation.addByPrefix('singUPmiss', 'bfMinecraft up miss', 24, false);
				animation.addByPrefix('singLEFTmiss', 'bfMinecraft left miss', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'bfMinecraft right miss', 24, false);
				animation.addByPrefix('singDOWNmiss', 'bfMinecraft down miss', 24, false);
				animation.addByPrefix('shield', 'bfMinecraft shield', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");
				addOffset("shield");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			
			case 'bfeyes':
				frames = Paths.getSparrowAtlas('characters/bfeyes');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'senpai':
				iconColor = 'FF2B5480';
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'tiago':
				iconColor = 'FF800080';
				frames = Paths.getSparrowAtlas('characters/Tiago');
				animation.addByPrefix('idle', 'Tiago Idle', 24, false);
				animation.addByPrefix('singUP', 'Tiago UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Tiago LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Tiago RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Tiago DOWN NOTE', 24, false);
			
				addOffset('idle', -3, -3);
				addOffset("singUP", -18, 14);
				addOffset("singRIGHT", -4, -21);
				addOffset("singLEFT", 19, -5);
				addOffset("singDOWN", 12, -12);
			
				playAnim('idle');
		
				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'tiagoswag':
				iconColor = 'FF800080';
				frames = Paths.getSparrowAtlas('characters/TiagoSwag');
				animation.addByPrefix('idle', 'TiagoSwag Idle', 24, false);
				animation.addByPrefix('singUP', 'TiagoSwag UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'TiagoSwag LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'TiagoSwag RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'TiagoSwag DOWN NOTE', 24, false);
		
				addOffset('idle', -3, -3);
				addOffset("singUP", -18, 14);
				addOffset("singRIGHT", -4, -21);
				addOffset("singLEFT", 19, -5);
				addOffset("singDOWN", 12, -12);
		
				playAnim('idle');
		
				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'senpai-angry':
				iconColor = 'FF264B73';
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'steve-armor':
				iconColor = 'FF224367';
				frames = Paths.getSparrowAtlas('characters/SteveArmor');
				animation.addByPrefix('idle', 'Steve Armor Idle', 24, false);
				animation.addByPrefix('singUP', 'Steve Armor UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Steve Armor LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Steve Armor RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Steve Armor DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'tuxsteve':
				iconColor = 'FF2B5480';
				frames = Paths.getSparrowAtlas('characters/tuxsteve');
				animation.addByPrefix('idle', 'tuxsteve Idle', 24, false);
				animation.addByPrefix('singUP', 'tuxsteve up', 24, false);
				animation.addByPrefix('singLEFT', 'tuxsteve left', 24, false);
				animation.addByPrefix('singRIGHT', 'tuxsteve right', 24, false);
				animation.addByPrefix('singDOWN', 'tuxsteve down', 24, false);

				addOffset('idle', -250, -260);
				addOffset("singUP", -247, -256);
				addOffset("singRIGHT", -249, -254);
				addOffset("singLEFT", -244, -259);
				addOffset("singDOWN", -256, -260);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'stevehorse':
				iconColor = 'FF2B5480';
				frames = Paths.getSparrowAtlas('characters/steveHorse');
				animation.addByPrefix('idle', 'steveHorse idle', 24, false);
				animation.addByPrefix('singUP', 'steveHorse up', 24, false);
				animation.addByPrefix('singLEFT', 'steveHorse left', 24, false);
				animation.addByPrefix('singRIGHT', 'steveHorse right', 24, false);
				animation.addByPrefix('singDOWN', 'steveHorse down', 24, false);

				addOffset('idle', -250, -260);
				addOffset("singUP", -247, -256);
				addOffset("singRIGHT", -249, -254);
				addOffset("singLEFT", -244, -259);
				addOffset("singDOWN", -256, -260);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
				
			case 'tuxsteveuoh':
				iconColor = 'FF2B5480';
				frames = Paths.getSparrowAtlas('characters/tuxsteveuoh');
				animation.addByPrefix('idle', 'tux steve Idle', 24, false);
				animation.addByPrefix('singUP', 'tux steve UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'tux steve LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'tux steve RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'tux steve DOWN NOTE', 24, false);
	
				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');
	
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
	
				antialiasing = false;

			case 'stevefnm':
				iconColor = 'FF2B5480';
				frames = Paths.getSparrowAtlas('characters/stevefnm');
				animation.addByPrefix('idle', 'stevefnm Idle', 24, false);
				animation.addByPrefix('singUP', 'stevefnm up', 24, false);
				animation.addByPrefix('singLEFT', 'stevefnm left', 24, false);
				animation.addByPrefix('singRIGHT', 'stevefnm right', 24, false);
				animation.addByPrefix('singDOWN', 'stevefnm down', 24, false);


				addOffset('idle', -250, -260);
				addOffset("singUP", -260, -260);
				addOffset("singRIGHT", -252, -260);
				addOffset("singLEFT", -250, -260);
				addOffset("singDOWN", -248, -267);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'stevematt':
				iconColor = 'FF2B5480';
				frames = Paths.getSparrowAtlas('characters/stevematt');
				animation.addByPrefix('idle', 'steve Idle', 24, false);
				animation.addByPrefix('singUP', 'steve UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'steve LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'steve RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'steve DOWN NOTE', 24, false);
	
				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');
	
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
	
				antialiasing = false;

			case 'stevelucky':
				iconColor = 'FF2B5480';
				frames = Paths.getSparrowAtlas('characters/stevelucky');
				animation.addByPrefix('idle', 'steve Idle', 24, false);
				animation.addByPrefix('singUP', 'steve UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'steve LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'steve RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'steve DOWN NOTE', 24, false);
	
				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');
	
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
	
				antialiasing = false;

			case 'alex':
				iconColor = 'FF9AFF9A';
				frames = Paths.getSparrowAtlas('characters/alex');
				animation.addByPrefix('idle', 'alex Idle', 24, false);
				animation.addByPrefix('singUP', 'alex UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'alex LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'alex RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'alex DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'alexchill':
				iconColor = 'FF9AFF9A';
				frames = Paths.getSparrowAtlas('characters/alexchill');
				animation.addByPrefix('idle', 'alex Idle', 24, false);
				animation.addByPrefix('singUP', 'alex UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'alex LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'alex RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'alex DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'alexsunday':
				iconColor = 'FF9AFF9A';
				frames = Paths.getSparrowAtlas('characters/alexsunday');
				animation.addByPrefix('idle', 'alexsunday idle', 24, false);
				animation.addByPrefix('singUP', 'alexsunday up normal', 24, false);
				animation.addByPrefix('singLEFT', 'alexsunday left normal', 24, false);
				animation.addByPrefix('singRIGHT', 'alexsunday right normal', 24, false);
				animation.addByPrefix('singDOWN', 'alexsunday down normal', 24, false);

				animation.addByPrefix('singUP-alt', 'alexsunday upguitar', 24, false);

				animation.addByPrefix('singDOWN-alt', 'alexsunday downguitar', 24, false);
				animation.addByPrefix('singLEFT-alt', 'alexsunday leftguitar', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'alexsunday rightguitar', 24, false);

				addOffset('idle', -250, -260);
				addOffset("singUP", -260, -260);
				addOffset("singRIGHT", -252, -260);
				addOffset("singLEFT", -250, -260);
				addOffset("singDOWN", -248, -267);
				addOffset("singUP-alt", -262, -260);
				addOffset("singRIGHT-alt", -249, -261);
				addOffset("singLEFT-alt", -250, -265);
				addOffset("singDOWN-alt", -250, -257);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'smollalex':
				iconColor = 'FF9AFF9A';
				frames = Paths.getSparrowAtlas('characters/smollalex');
				animation.addByPrefix('idle', 'smollalex idle', 24, false);
				animation.addByPrefix('singUP', 'smollalex up', 24, false);
				animation.addByPrefix('singLEFT', 'smollalex left', 24, false);
				animation.addByPrefix('singRIGHT', 'smollalex right', 24, false);
				animation.addByPrefix('singDOWN', 'smollalex down', 24, false);

				addOffset('idle', -250, -260);
				addOffset("singUP", -260, -260);
				addOffset("singRIGHT", -252, -260);
				addOffset("singLEFT", -250, -260);
				addOffset("singDOWN", -248, -267);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'notch':
				iconColor = 'FFd7711a';
				frames = Paths.getSparrowAtlas('characters/Notch');
				animation.addByPrefix('idle', 'Notch Idle', 24, false);
				animation.addByPrefix('singUP', 'Notch upNormal', 24, false);
				animation.addByPrefix('singLEFT', 'Notch left', 24, false);
				animation.addByPrefix('singRIGHT', 'Notch right', 24, false);
				animation.addByPrefix('singDOWN', 'Notch downNormal', 24, false);

				animation.addByPrefix('singUP-alt', 'Notch upGapple', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Notch downGapple', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Notch left', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Notch right', 24, false);

				addOffset('idle', -250, -260);
				addOffset("singUP", -260, -260);
				addOffset("singRIGHT", -252, -260);
				addOffset("singLEFT", -250, -260);
				addOffset("singDOWN", -248, -267);
				addOffset("singUP-alt", -262, -260);
				addOffset("singRIGHT-alt", -249, -261);
				addOffset("singLEFT-alt", -250, -265);
				addOffset("singDOWN-alt", -250, -257);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'endless':
				iconColor = 'FF2B5480';
				frames = Paths.getSparrowAtlas('characters/endless');
				animation.addByPrefix('idle', 'endless idle', 24, false);
				animation.addByPrefix('singUP', 'endless up', 24, false);
				animation.addByPrefix('singLEFT', 'endless left', 24, false);
				animation.addByPrefix('singRIGHT', 'endless right', 24, false);
				animation.addByPrefix('singDOWN', 'endless down', 24, false);

				addOffset('idle', -250, -260);
				addOffset("singUP", -260, -260);
				addOffset("singRIGHT", -252, -260);
				addOffset("singLEFT", -250, -260);
				addOffset("singDOWN", -248, -267);

				playAnim('idle');

				setGraphicSize(Std.int(width * 0.85));
				updateHitbox();

			case 'alexpickaxe':
				iconColor = 'FF9AFF9A';
				frames = Paths.getSparrowAtlas('characters/alexpickaxe');
				animation.addByPrefix('idle', 'alex Idle', 24, false);
				animation.addByPrefix('singUP', 'alex UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'alex LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'alex RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'alex DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'alexpickaxemad':
				iconColor = 'FF9AFF9A';
				frames = Paths.getSparrowAtlas('characters/alexpickaxemad');
				animation.addByPrefix('idle', 'alex Idle', 24, false);
				animation.addByPrefix('singUP', 'alex UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'alex LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'alex RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'alex DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'herobrine':
				iconColor = 'FF112133 ';
				frames = Paths.getSparrowAtlas('characters/herobrine');
				animation.addByPrefix('idle', 'herobrine Idle', 24, false);
				animation.addByPrefix('singUP', 'herobrine UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'herobrine LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'herobrine RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'herobrine DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit':
				frames = Paths.getPackerAtlas('characters/spirit');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;
				

			case 'gabo':
				iconColor = 'FF8FD8D4';
				frames = Paths.getSparrowAtlas('characters/gabo');
				animation.addByPrefix('idle', 'gabo Idle', 24, false);
				animation.addByPrefix('singUP', 'gabo UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'gabo LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'gabo RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'gabo DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'jeb':
				iconColor = 'FFFFFFFF';
				frames = Paths.getSparrowAtlas('jeb/jeb', 'shared');
				animation.addByPrefix('idle', 'jeb idle', 24, false);
				animation.addByPrefix('singUP', 'jeb up', 24, false);
				animation.addByPrefix('singLEFT', 'jeb left', 24, false);
				animation.addByPrefix('singRIGHT', 'jeb right', 24, false);
				animation.addByPrefix('singDOWN', 'jeb down', 24, false);
	
				addOffset('idle', -250, -260);
				addOffset("singUP", -260, -260);
				addOffset("singRIGHT", -252, -260);
				addOffset("singLEFT", -250, -260);
				addOffset("singDOWN", -248, -267);
	
				playAnim('idle');
	
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
	
				antialiasing = false;
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
