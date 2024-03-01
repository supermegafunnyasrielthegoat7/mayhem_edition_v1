package states;

import flixel.FlxSubState;

import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;

class PiracyState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"HEY. PIRACY IS NOT COOL MAN.\n
			I REKON YOU SHOULD CLOSE THIS.\n
			IT CAN BE A REAL PROBLEM DONT YOU REKON?\n
			...\n
			piracy isnt cool.",
			32);
		warnText.setFormat("Comic Sans MS Bold", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
