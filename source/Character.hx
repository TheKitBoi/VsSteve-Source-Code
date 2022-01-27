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

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		if(FlxG.save.data.antialiasing)
			{
				antialiasing = true;
			}

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_assets','shared',true);
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

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('gfChristmas','shared',true);
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

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('gfCar','shared',true);
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('gfPixel','shared',true);
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('DADDY_DEAREST','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'spooky':
				tex = Paths.getSparrowAtlas('spooky_kids_assets','shared',true);
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');
			case 'mom':
				tex = Paths.getSparrowAtlas('Mom_Assets','shared',true);
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');

			case 'mom-car':
				tex = Paths.getSparrowAtlas('momCar','shared',true);
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'monster':
				tex = Paths.getSparrowAtlas('Monster_Assets','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				loadOffsetFile(curCharacter);
				playAnim('idle');
			case 'monster-christmas':
				tex = Paths.getSparrowAtlas('monsterChristmas','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				loadOffsetFile(curCharacter);
				playAnim('idle');
			case 'pico':
				tex = Paths.getSparrowAtlas('Pico_FNF_assetss','shared',true);
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;

			case 'bf':
				var tex = Paths.getSparrowAtlas('BOYFRIEND','shared',true);
				frames = tex;

				trace(tex.frames.length);

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

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, false);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;

			case 'bf-christmas':
				var tex = Paths.getSparrowAtlas('bfChristmas','shared',true);
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

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;
			case 'bf-car':
				var tex = Paths.getSparrowAtlas('bfCar','shared',true);
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

				loadOffsetFile(curCharacter);
				playAnim('idle');

				flipX = true;
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('bfPixel','shared',true);
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				loadOffsetFile(curCharacter);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('bfPixelsDEAD','shared',true);
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, false);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				loadOffsetFile(curCharacter);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'senpai':
				frames = Paths.getSparrowAtlas('senpai','shared',true);
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry':
				frames = Paths.getSparrowAtlas('senpai','shared',true);
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				loadOffsetFile(curCharacter);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit':
				frames = Paths.getPackerAtlas('spirit','shared',true);
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				loadOffsetFile(curCharacter);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;

			case 'parents-christmas':
				frames = Paths.getSparrowAtlas('mom_dad_christmas_assets','shared',true);
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			////vvvvvv  V-cast-code vvvvvv//////
			case 'gf-v':
				// V GF CODE
				tex = Paths.getSparrowAtlas('characters/GF-v');
				frames = tex;
				animation.addByPrefix('cheer', 'gf_hey', 24, false);			
				animation.addByIndices('danceLeft', 'gf', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'gf', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				loadOffsetFile(curCharacter);
				playAnim('danceRight');
			   
			case 'bf-v':
				
				var tex = Paths.getSparrowAtlas('characters/BoyFriend-v', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'bf_idle', 24, false);
				animation.addByPrefix('singUP', 'bf_up0', 24, false);
				animation.addByPrefix('singLEFT', 'bf_left0', 24, false);
				animation.addByPrefix('singRIGHT', 'bf_right0', 24, false);
				animation.addByPrefix('singDOWN', 'bf_down0', 24, false);
				animation.addByPrefix('singUPmiss', 'bf_up_miss0', 24, false);
				animation.addByPrefix('singLEFTmiss', 'bf_left_miss0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'bf_right_miss0', 24, false);
				animation.addByPrefix('singDOWNmiss', 'bf_down_miss0', 24, false);
				

				animation.addByPrefix('firstDeath', 'bf_dead_1', 24, false);
				animation.addByPrefix('deathLoop', "bf_dead_2", 24, true);
				animation.addByPrefix('deathConfirm', "bf_dead_3", 24, false);

				
				 
				loadOffsetFile(curCharacter);
				
			   
				playAnim('idle');

				flipX = true;
			case 'v-calm':
				// V not sperging  ANIMATION  CODE
				tex = Paths.getSparrowAtlas('characters/v-calm', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'v_idle', 24,false);
				animation.addByPrefix('singUP', 'v_up', 24,false);
				animation.addByPrefix('singRIGHT', 'v_right', 24,false);
				animation.addByPrefix('singDOWN', 'v_down', 24,false);
				animation.addByPrefix('singLEFT', 'v_left', 24,false);

				loadOffsetFile(curCharacter);
				playAnim('idle');
			case 'v-mic':
				// V beep booping  CODE
				tex = Paths.getSparrowAtlas('characters/v-mic', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'vMic_idle', 24,false);
				animation.addByPrefix('singUP', 'vMic_up', 24,false);
				animation.addByPrefix('singRIGHT', 'vMic_right', 24,false);
				animation.addByPrefix('singDOWN', 'vMic_down', 24,false);
				animation.addByPrefix('singLEFT', 'vMic_left', 24,false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			
			
			case 'v-rage':
				// V SEGGSY  ANIMATION  CODE
				tex = Paths.getSparrowAtlas('characters/v-rage', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'vrage_idle', 24,false);
				animation.addByPrefix('singUP', 'vrage_up', 24,false);
				animation.addByPrefix('singRIGHT', 'vrage_right', 24,false);
				animation.addByPrefix('singDOWN', 'vrage_down', 24,false);
				animation.addByPrefix('singLEFT', 'vrage_left', 24,false);
				///
				animation.addByPrefix('singRIGHT-alt', 'vrage_pun', 24);////row row 
				animation.addByPrefix('singDOWN-alt', 'vrage_down', 24,false);
				animation.addByPrefix('singUP-alt', 'vrage_up', 24,false);
				animation.addByPrefix('singLEFT-alt', 'vrage_left', 24,false);
				///
				//animation.addByPrefix('FFFFu', 'vrage_ffff', 24,false);				
				//animation.addByPrefix('stomp', 'vrage_stomp', 24);///punch is better
				
				loadOffsetFile(curCharacter);
				
				addOffset('singDOWN-alt');
				addOffset('singUP-alt');
				addOffset('singRIGHT-alt');

				playAnim('idle');
			
			case 'bf-alt':
					////2.5D boyfriend assets///
					var tex = Paths.getSparrowAtlas('characters/bfalt', 'shared');
					frames = tex;
	
					//trace(tex.frames.length);
	
					animation.addByPrefix('idle', 'bf_idle', 24, false);
					animation.addByPrefix('singUP', 'bf_up0', 24, false);
					animation.addByPrefix('singLEFT', 'bf_left0', 24, false);
					animation.addByPrefix('singRIGHT', 'bf_right0', 24, false);
					animation.addByPrefix('singDOWN', 'bf_down0', 24, false);
					animation.addByPrefix('singUPmiss', 'bf_up_miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'bf_left_miss', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'bf_right_miss', 24, false);
					animation.addByPrefix('singDOWNmiss', 'bf_down_miss', 24, false);					
					
					animation.addByPrefix('firstDeath', "bf_dead_1", 24, false);
					animation.addByPrefix('deathLoop', "bf_dead_2", 24, true);
					animation.addByPrefix('deathConfirm',"bf_dead_3", 24,false);
			
					
					loadOffsetFile(curCharacter);	
					playAnim('idle');
					flipX = true;
				case 'cancer':
					// cancer  ANIMATION  CODE
					tex = Paths.getSparrowAtlas('characters/cancer', 'shared');
					frames = tex;
					animation.addByPrefix('idle', 'cancer_idle', 24,false);
					animation.addByPrefix('singUP', 'cancer_up', 24,false);
					animation.addByPrefix('singRIGHT', 'cancer_right', 24,false);
					animation.addByPrefix('singDOWN', 'cancer_down', 24,false);
					animation.addByPrefix('singLEFT', 'cancer_left', 24,false);
					scale.set(0.92,0.92);
					loadOffsetFile(curCharacter);
	
					playAnim('idle');
					case 'bf-cyber':
						// fotor bf 
						tex = Paths.getSparrowAtlas('characters/bf-cyber', 'shared');
						frames = tex;
	
						//trace(tex.frames.length);
		
						animation.addByPrefix('idle', 'cbf_idle', 24, false);
						animation.addByPrefix('singUP', 'cbf_up0', 24, false);
						animation.addByPrefix('singLEFT', 'cbf_left0', 24, false);
						animation.addByPrefix('singRIGHT', 'cbf_right0', 24, false);
						animation.addByPrefix('singDOWN', 'cbf_down0', 24, false);
						animation.addByPrefix('singUPmiss', 'cbf_up_miss', 24, false);
						animation.addByPrefix('singLEFTmiss', 'cbf_left_miss', 24, false);
						animation.addByPrefix('singRIGHTmiss', 'cbf_right_miss', 24, false);
						animation.addByPrefix('singDOWNmiss', 'cbf_down_miss', 24, false);					
						
						animation.addByPrefix('firstDeath', "cbf_dead_1", 24, false);
						animation.addByPrefix('deathLoop', "cbf_dead_2", 24, true);
						animation.addByPrefix('deathConfirm',"cbf_dead_3", 24,false);
						loadOffsetFile(curCharacter);
						playAnim('idle');
						flipX = true;
					case 'zord':
						// gaint  ANIMATION  CODE
						tex = Paths.getSparrowAtlas('characters/zord', 'shared');
						frames = tex;
						animation.addByPrefix('idle', 'zord_idle', 24,false);
						
						animation.addByPrefix('singUP', 'zord_up', 24,false);
						animation.addByPrefix('singRIGHT', 'zord_right', 24,false);
						animation.addByPrefix('singDOWN', 'zord_down', 24,false);
						animation.addByPrefix('singLEFT', 'zord_left', 24,false);
						
						animation.addByPrefix('singRIGHT-alt', 'zord_altright', 24,false);
						animation.addByPrefix('singDOWN-alt', 'zord_altdown', 24,false);
						animation.addByPrefix('singUP-alt', 'zord_altup', 24,false);
						animation.addByPrefix('singLEFT-alt', 'zord_altleft', 24,false);
						
						//animation.addByIndices('danceLeft', 'zord_idle', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14], "", 24, false);
						//animation.addByIndices('danceRight', 'zord_idle', [15,16,17,18,19,20,21,22,23,24,25,26,27,28,29], "", 24, false);
						
						loadOffsetFile(curCharacter);
		
						playAnim('idle');
					case 'bfzord':
					////tinybf code///
					var tex = Paths.getSparrowAtlas('characters/bfzord', 'shared');
					frames = tex;

					//trace(tex.frames.length);

					animation.addByPrefix('idle', 'rebf_idle', 24, false);
					animation.addByPrefix('singUP', 'rebf_up', 24, false);
					animation.addByPrefix('singLEFT', 'rebf_left', 24, false);
					animation.addByPrefix('singRIGHT', 'rebf_right', 24, false);
					animation.addByPrefix('singDOWN', 'rebf_down', 24, false);
					animation.addByPrefix('singUPmiss', 'miss_rebf_up', 24, false);
					animation.addByPrefix('singLEFTmiss', 'miss_rebf_left', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'miss_rebf_right', 24, false);
					animation.addByPrefix('singDOWNmiss', 'miss_rebf_down', 24, false);					
					animation.addByPrefix('firstDeath', "bf_dead_1", 24, false);
					animation.addByPrefix('deathLoop', "bf_dead_2", 24, true);
					animation.addByPrefix('deathConfirm',"bf_dead_3", 24,false);
					flipX=true;
					loadOffsetFile(curCharacter);	
					playAnim('idle');

					case 'zordhand':
						///is brokers :-(
						
						var tex = Paths.getSparrowAtlas('characters/zordhand', 'shared');
						frames = tex;
						
						animation.addByPrefix('idle', 'handidle' ,24,false);
						animation.addByPrefix('singUP', 'handup' ,24,false);
						animation.addByPrefix('singDOWN', 'handdown' ,24,false);
						animation.addByPrefix('singLEFT', 'handleft' ,24,false);
						animation.addByPrefix('singRIGHT', 'handright' ,24,false);
						
						playAnim('idle');
						loadOffsetFile(curCharacter);	
						
					case 'vbfdeadbasic':
						frames = Paths.getSparrowAtlas('characters/vbfdeadbasic','shared',true);
						animation.addByPrefix('singUP', "bf_dead_1", 24, false);
						animation.addByPrefix('firstDeath', "bf_dead_1", 24, false);
						animation.addByPrefix('deathLoop', "bf_dead_2", 24, false);
						animation.addByPrefix('deathConfirm', "bf_dead_3", 24, false);
						animation.play('firstDeath');
		
						loadOffsetFile(curCharacter);
						playAnim('firstDeath');
					
						
						flipX = true;
	
	
						//////////////////////////////////////////
		                ///week 7kekekekekekek////
						case 'captain':
						///is brokers :-(
						
						var tex = Paths.getSparrowAtlas('characters/captain', 'shared');
						frames = tex;
						
						animation.addByPrefix('idle', 'Tankman Idle Dance instance' ,24,false);
						animation.addByPrefix('singUP', 'Tankman UP note instance' ,24,false);
						animation.addByPrefix('singDOWN', 'Tankman DOWN note instance' ,24,false);
						animation.addByPrefix('singLEFT', 'Tankman Right Note instance' ,24,false);
						animation.addByPrefix('singRIGHT', 'Tankman Note Left instance' ,24,false);//reversed momment
						animation.addByPrefix('UGH', 'TANKMAN UGH instance' ,24,false);
						animation.addByPrefix('GOOD', 'PRETTY GOOD tankman instance' ,24,false);
						animation.addByPrefix('singDOWN-alt', 'PRETTY GOOD tankman instance' ,24,false);
						flipX=true;
						playAnim('idle');
						loadOffsetFile(curCharacter);	
						case 'bfAndGF':
							var tex = Paths.getSparrowAtlas('characters/bfAndGF','shared');
							frames = tex;
			
							animation.addByPrefix('idle', 'BF idle dance w gf', 24, false);
							animation.addByPrefix('singUP', "BF NOTE UP0", 24, false);
							animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
							animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
							animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
							animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
							animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
							animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
							animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				
			
							loadOffsetFile(curCharacter);
			
							playAnim('idle');
			
							flipX = true;
						case 'bfHoldingGF-DEAD':
							frames = Paths.getSparrowAtlas('characters/bfHoldingGF-DEAD','shared');
							animation.addByPrefix('singUP', "BF Dies with GF", 24, false);
							animation.addByPrefix('firstDeath', "BF Dies with GF", 24, false);
							animation.addByPrefix('deathLoop', "BF Dead with GF Loop", 24, false);
							animation.addByPrefix('deathConfirm', "RETRY confirm holding gf", 24, false);
							animation.play('firstDeath');

							loadOffsetFile(curCharacter);
							playAnim('firstDeath');
							flipX = true;
						case 'gfTankman':
							// GIRLFRIEND AT GUN POINT CODE
							tex = Paths.getSparrowAtlas('gfTankman','shared',true);
							frames = tex;
							animation.addByIndices('sad', 'GF Crying at Gunpoint', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
							animation.addByIndices('danceLeft', 'GF Dancing at Gunpoint', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
							animation.addByIndices('danceRight', 'GF Dancing at Gunpoint', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
							
			
							loadOffsetFile(curCharacter);
			
							playAnim('danceRight');
						case 'picoSpeaker':
							// GIRLFRIEND?????????????? CODE
							tex = Paths.getSparrowAtlas('characters/picoSpeaker','shared');
							frames = tex;
						
							animation.addByPrefix('idle', "Pico shoot 1", 24, false);
						
						
						//	animation.addByIndices('idle', 'Pico shoot 1', [5, 6, 7, 8, 9, 10, 11, 12,13,14,15,16,17,18,19,20,21,22,23,24], "", 24, false);
							animation.addByPrefix('singRIGHT', "Pico shoot 2", 24, false);
							animation.addByPrefix('singLEFT', "Pico shoot 3", 24, false);
						
			
							loadOffsetFile(curCharacter);
			
							playAnim('idle');
		
							case 'homoomor':
								var tex = Paths.getSparrowAtlas('characters/homoomor','shared');
								frames = tex;
				
								animation.addByPrefix('idle', 'homoor_idle', 24, false);
								animation.addByPrefix('singUP', "homoor_up", 24, false);
								animation.addByPrefix('singLEFT', 'homoor_right', 24, false);
								animation.addByPrefix('singRIGHT', 'homoor_left', 24, false);
								animation.addByPrefix('singDOWN', 'homoor_down', 24, false);
								animation.addByPrefix('singUPmiss', 'miss_homoor_up', 24, false);
								animation.addByPrefix('singLEFTmiss', 'miss_homoor_left', 24, false);
								animation.addByPrefix('singRIGHTmiss', 'miss_homoor_right', 24, false);
								animation.addByPrefix('singDOWNmiss', 'miss_homoor_down', 24, false);
								animation.addByPrefix('firstDeath', "homoor_dead_1", 24, false);
								animation.addByPrefix('deathLoop', "homoor_dead_2", 24, true);
								animation.addByPrefix('deathConfirm',"homoor_dead_3", 24,false);
								loadOffsetFile(curCharacter);
				
							
				
								playAnim('idle');
				
								flipX = true;
							case 'sneed':
								var tex = Paths.getSparrowAtlas('characters/sneed','shared');
								frames = tex;
				
								animation.addByPrefix('idle', 'sneeds_idle', 24, false);
								animation.addByPrefix('singUP', "sneeds_up", 24, false);
								animation.addByPrefix('singLEFT', 'sneeds_left', 24, false);
								animation.addByPrefix('singRIGHT', 'sneeds_right', 24, false);
								animation.addByPrefix('singDOWN', 'sneeds_down', 24, false);
								animation.addByPrefix('singUP-alt', "sneeds_up", 24, false);
								animation.addByPrefix('singLEFT-alt', 'sneeds_left', 24, false);
								animation.addByPrefix('singRIGHT-alt', 'sneeds_right', 24, false);
								animation.addByPrefix('singDOWN-alt', 'sneeds_down', 24, false);							
								loadOffsetFile(curCharacter);
				
								playAnim('idle');
					
							case 'bsneed':
								var tex = Paths.getSparrowAtlas('characters/bsneed','shared');
								frames = tex;
				
								animation.addByPrefix('idle', 'bsneed_idle', 24, false);
								animation.addByPrefix('singUP', "bsneed_up", 24, false);
								animation.addByPrefix('singLEFT', 'bsneed_left', 24, false);
								animation.addByPrefix('singRIGHT', 'bsneed_right', 24, false);
								animation.addByPrefix('singDOWN', 'bsneed_down', 24, false);					
								loadOffsetFile(curCharacter);
				
								playAnim('idle');	
							case 'chuck':
									var tex = Paths.getSparrowAtlas('characters/chuck','shared');
									frames = tex;
					
									animation.addByPrefix('idle', 'chuckie_idle', 24, false);
								
									animation.addByPrefix('singUP-alt', "chuckie_up", 24, false);
									animation.addByPrefix('singLEFT-alt', 'chuckie_left', 24, false);
									animation.addByPrefix('singRIGHT-alt', 'chuckie_right', 24, false);
									animation.addByPrefix('singDOWN-alt', 'chuckie_down', 24, false);							
									loadOffsetFile(curCharacter);
					
									playAnim('idle');
	
	
	
	
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

	public function loadOffsetFile(character:String, library:String = 'shared')
	{
		var offset:Array<String> = CoolUtil.coolTextFile(Paths.txt('images/characters/' + character + "Offsets", library));

		for (i in 0...offset.length)
		{
			var data:Array<String> = offset[i].split(' ');
			addOffset(data[0], Std.parseInt(data[1]), Std.parseInt(data[2]));
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
				trace('dance');
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
	public function dance(forced:Bool = false)
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-christmas' | 'gf-car' | 'gf-pixel'| 'gf-v'|'gfTankman':
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
				//case 'zord':
				//	danced = !danced;

				//if (danced)
				//		playAnim('danceRight');
				//	else
				//		playAnim('danceLeft');
				
				
				
				default:
					playAnim('idle', forced);
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
	       switch(AnimName)
		   {
				case 'singLEFT' :danced = true;
				case 'singRIGHT' :danced = false;			 
				case 'singUP'|'singDOWN' :danced = !danced;
		
			}
           	
	
		
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
