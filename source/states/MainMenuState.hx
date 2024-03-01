package states;

import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;
import shaders.*; // :)

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.7.2h'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public static var curCharSel:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	var bg:FlxSprite;
	var idiotshader:GlitchEffect;
	var selector:FlxSprite;

	var optionShit:Array<String> = [
		//'story_mode',
		'freeplay',
	//	#if MODS_ALLOWED 'mods', #end
	//	#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'credits',
	//	#if !switch 'donate', #end
		'options'
	];

	var charShit:Array<String> = [
		'Tyler',
		'Sonic dead',
		'Cinder'
	];

	var magenta:FlxSprite;
	var currentChar:FlxSprite;
	var camFollow:FlxObject;

	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		bg = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/mainmenuBack'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scrollFactor.set(0, 0);
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);
		idiotshader = new GlitchEffect();
		idiotshader.waveAmplitude = 0.1;
		idiotshader.waveFrequency = 5;
		idiotshader.waveSpeed = 2;
		bg.shader = idiotshader.shader;

		var roof:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('bgs/b/theawsomeroof'));
		roof.antialiasing = ClientPrefs.data.antialiasing;
		roof.y = 110;
		roof.scrollFactor.set(0, 0);
		roof.setGraphicSize(Std.int(roof.width * 0.60));
		roof.updateHitbox();
		add(roof);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/mainmenuBack'));
		magenta.antialiasing = ClientPrefs.data.antialiasing;
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.color = 0xFFfd719b;
		add(magenta);

		currentChar = new FlxSprite(700, 140).loadGraphic(Paths.image('mainmenu/' + (charShit[curCharSel])));
		currentChar.scrollFactor.set(0, yScroll);
		currentChar.setGraphicSize(Std.int(currentChar.width * 0.15));
		currentChar.updateHitbox();
		add(currentChar);

		var curoffset:Float = 100;
		var menuItem:FlxSprite;
		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		selector = new FlxSprite(-66, 0);
		selector.frames = Paths.getSparrowAtlas('mainmenu/cusor'); // opps i mispelt it whatever
		selector.animation.addByPrefix('swag', 'idleing', 16, true);
		selector.animation.play('swag');
		selector.antialiasing = ClientPrefs.data.antialiasing;
		selector.scrollFactor.set(0, 0);
		selector.visible = true;
		selector.setGraphicSize(Std.int(selector.width * 1.1));
		selector.updateHitbox();
		add(selector);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			if (optionShit.length == 3){
				menuItem = new FlxSprite(curoffset, 80 + (i * 199));
			} else {
				menuItem = new FlxSprite(curoffset, (i * 140) + offset);
			}
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 6)
				scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.updateHitbox();
		}

		var psychVer:FlxText = new FlxText(12, FlxG.height - 44, 0, "Mayhem Edition V1 " + "(PE v" + psychEngineVersion + ")", 12);
		psychVer.scrollFactor.set();
		psychVer.setFormat("Comic Sans MS Bold", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(psychVer);
		var fnfVer:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		fnfVer.scrollFactor.set();
		fnfVer.setFormat("Comic Sans MS Bold", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(fnfVer);
		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		// Unlocks "Freaky on a Friday Night" achievement if it's a Friday and between 18:00 PM and 23:59 PM
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
			Achievements.unlock('friday_night_play');

		#if MODS_ALLOWED
		Achievements.reloadList();
		#end
		#end

		super.create();

		FlxG.camera.follow(camFollow, null, 0.15);
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		//cool code
		idiotshader.update(elapsed);

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
				changeItem(-1);

			if (controls.UI_DOWN_P)
				changeItem(1);

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;

					FlxTween.tween(currentChar, {alpha: 0}, 0.4, {
						ease: FlxEase.quadOut,
						onComplete: function(twn:FlxTween)
						{
							currentChar.kill();
						}
					});

					FlxTween.tween(selector, {alpha: 0}, 0.4, {
						ease: FlxEase.quadOut,
						onComplete: function(twn:FlxTween)
						{
							currentChar.kill();
						}
					});

					FlxTween.tween(FlxG.camera, {zoom:1.35}, 1.45, {ease: FlxEase.expoIn});

					FlxFlicker.flicker(menuItems.members[curSelected], 1, 0.06, false, false, function(flick:FlxFlicker)
					{
						switch (optionShit[curSelected])
						{
							case 'story_mode':
								MusicBeatState.switchState(new StoryMenuState());
							case 'freeplay':
								MusicBeatState.switchState(new FreeplayState());

							#if MODS_ALLOWED
							case 'mods':
								MusicBeatState.switchState(new ModsMenuState());
							#end

							#if ACHIEVEMENTS_ALLOWED
							case 'awards':
								MusicBeatState.switchState(new AchievementsMenuState());
							#end

							case 'credits':
								MusicBeatState.switchState(new CreditsState());
							case 'options':
								MusicBeatState.switchState(new OptionsState());
								OptionsState.onPlayState = false;
								if (PlayState.SONG != null)
								{
									PlayState.SONG.arrowSkin = null;
									PlayState.SONG.splashSkin = null;
									PlayState.stageUI = 'normal';
								}
						}
					});

					for (i in 0...menuItems.members.length)
					{
						if (i == curSelected)
							continue;
						FlxTween.tween(menuItems.members[i], {alpha: 0}, 0.4, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								menuItems.members[i].kill();
							}
						});
					}
				}
			}
			#if desktop
			if (controls.justPressed('debug_1'))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));
		menuItems.members[curSelected].animation.play('idle');
		menuItems.members[curSelected].updateHitbox();

		curSelected += huh;
		curCharSel += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		if (curCharSel >= charShit.length)
			curCharSel = 0;
		if (curCharSel < 0)
			curCharSel = charShit.length - 1;

		menuItems.members[curSelected].animation.play('selected');
		menuItems.members[curSelected].centerOffsets();

		camFollow.setPosition(menuItems.members[curSelected].getGraphicMidpoint().x,
			menuItems.members[curSelected].getGraphicMidpoint().y - (menuItems.length > 4 ? menuItems.length * 8 : 0));
		
		currentChar.loadGraphic(Paths.image('mainmenu/' + (charShit[curCharSel]))); // fixes some shit
		selector.y = menuItems.members[curSelected].y - 348;
	}
}
