package states.stages;

import states.stages.objects.*;
import states.PlayState;
import shaders.*;
import shaders.WiggleEffect.WiggleEffectType;

class GrassN extends BaseStage
{
	var curShader:GlitchEffect;
	var wavy:FlxSprite;

	override function create()
	{
		var skybox:BGSprite = new BGSprite('bgs/GrassPlae/nightsky', -510, -890, 0, 0);
		skybox.updateHitbox();

		wavy = new FlxSprite(-600, -200).loadGraphic(Paths.image('bgs/GrassPlae/wavy thing'));
		wavy.antialiasing = true;
		wavy.scrollFactor.set(0.6, 0.6);
		wavy.active = true;

		var clouds:BGSprite = new BGSprite('bgs/GrassPlae/clouds', -428, -282, 0.5, 0.5);
		clouds.setGraphicSize(Std.int(1 * clouds.width));
		clouds.updateHitbox();

		var ground:BGSprite = new BGSprite('bgs/GrassPlae/GROUND', -757, -815, 1, 0.95);
		ground.setGraphicSize(Std.int(1.4 * ground.width));
		ground.updateHitbox();

		add(wavy);
		add(skybox);
		skybox.alpha = 0.6;
		add(clouds);
		remove(clouds);
		add(ground);

		ground.color = 0xFF878787;
		skybox.color = 0xFF878787;

		curShader = new GlitchEffect();
		curShader.waveAmplitude = 0.1;
		curShader.waveFrequency = 5;
		curShader.waveSpeed = 2;
		wavy.shader = curShader.shader;
	}
	
	override function createPost()
	{

	}

	override function update(elapsed:Float)
	{
		curShader.update(elapsed);
	}

	override function stepHit()
	{
		// Code here
	}
	override function beatHit()
	{
		// Code here
	}
	override function sectionHit()
	{
		// Code here
	}
}