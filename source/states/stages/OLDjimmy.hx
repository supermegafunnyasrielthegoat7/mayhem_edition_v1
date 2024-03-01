package states.stages;

import states.stages.objects.*;
import states.PlayState;
import shaders.*;
import shaders.WiggleEffect.WiggleEffectType;

class OLDjimmy extends BaseStage
{
	var wavyShader:WiggleEffect;
	var wavybg:FlxSprite;

	var weird:FlxSprite;

	override function create()
	{
		wavybg = new FlxSprite(-600, -300).loadGraphic(Paths.image('bgs/jimmy/Wavy'));
		wavybg.scrollFactor.set(0.6, 0.6);
		wavybg.antialiasing = true;
		wavybg.active = true;

		var bg:BGSprite = new BGSprite('bgs/jimmy/davehouseback', -600, -200, 0.2, 0.2);
		bg.alpha = 0.7;

		var davehousefloor:BGSprite = new BGSprite('bgs/jimmy/davehousefloor', -425, 625, 1.0, 1.0);
		davehousefloor.setGraphicSize(Std.int(davehousefloor.width * 1.3));
		davehousefloor.updateHitbox();

		add(wavybg);
		add(bg);
		add(davehousefloor);

		wavyShader = new WiggleEffect();
		wavyShader.effectType = HEAT_WAVE_HORIZONTAL;
		wavyShader.waveAmplitude = 0.1;
		wavyShader.waveFrequency = 5;
		wavyShader.waveSpeed = 2;
		wavybg.shader = wavyShader.shader;
	}

	override function createPost()
	{
	}

	override function update(elapsed:Float)
	{
		wavyShader.update(elapsed);
	}
}