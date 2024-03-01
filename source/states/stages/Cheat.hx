package states.stages;

import states.stages.objects.*;
import states.PlayState;
import shaders.*;
import shaders.WiggleEffect.WiggleEffectType;

class Cheat extends BaseStage
{
	var curShader:GlitchEffect;
	var wavy:FlxSprite;

	var cheaterPlatform:FlxSprite = new FlxSprite(-275, 750).loadGraphic(Paths.image('bgs/redPlatform')); 
	var weird:FlxSprite;

	override function create()
	{
		wavy = new FlxSprite(-600, -200).loadGraphic(Paths.image('bgs/cheater'));
		wavy.antialiasing = true;
		wavy.scrollFactor.set(0.6, 0.6);
		wavy.active = true;

		cheaterPlatform.loadGraphic(Paths.image('bgs/cheaterPlatform'));
		cheaterPlatform.setGraphicSize(Std.int(cheaterPlatform.width * 0.85));
		cheaterPlatform.updateHitbox();
		cheaterPlatform.antialiasing = true;
		cheaterPlatform.scrollFactor.set(1.0, 1.0);
		cheaterPlatform.active = true;

		add(wavy);
		add(cheaterPlatform);

		curShader = new GlitchEffect();
		curShader.waveAmplitude = 0.1;
		curShader.waveFrequency = 7;
		curShader.waveSpeed = 3;
		wavy.shader = curShader.shader;
	}

	override function createPost()
	{
		weird = new FlxSprite(-120, -120).makeGraphic(Std.int(FlxG.width * 100), Std.int(FlxG.height * 150), FlxColor.BLACK);
		weird.alpha = 0.4;
		weird.setGraphicSize(Std.int(weird.width * 1.4));
		weird.updateHitbox();
		weird.screenCenter();
		weird.scrollFactor.set();
		add(weird);
	}

	override function update(elapsed:Float)
	{
		curShader.update(elapsed);
	}
}