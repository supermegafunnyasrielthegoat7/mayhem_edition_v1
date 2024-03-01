package states.stages;

import states.stages.objects.*;
import states.PlayState;
import shaders.*;
import shaders.WiggleEffect.WiggleEffectType;

class FloatFunny extends BaseStage
{
	var wavyShader:GlitchEffect;
	var gdShader:GlitchEffect;
	var wavybg:FlxSprite;
	var wavygeometry:FlxSprite;

	var weird:FlxSprite;

	override function create()
	{
		wavybg = new FlxSprite(-600, -300).loadGraphic(Paths.image('bgs/random/galaxyBG'));
		wavybg.scrollFactor.set(0.9, 0.9);
		wavybg.active = true;

		wavygeometry = new FlxSprite(-500, -200).loadGraphic(Paths.image('bgs/random/linesBG'));
		wavygeometry.scrollFactor.set(0.9, 0.9);
		wavygeometry.setGraphicSize(Std.int(wavygeometry.width * 1.1));
		wavygeometry.updateHitbox();
		wavygeometry.active = true;

		add(wavybg);
		add(wavygeometry);

		wavyShader = new GlitchEffect();
		wavyShader.waveAmplitude = 0.1;
		wavyShader.waveFrequency = 7; //2,7
		wavyShader.waveSpeed = 2;
		wavybg.shader = wavyShader.shader;

		gdShader = new GlitchEffect();
		gdShader.waveAmplitude = 0.1;
		gdShader.waveFrequency = 2; //2,2
		gdShader.waveSpeed = 2;
		wavygeometry.shader = gdShader.shader;
	}

	override function createPost()
	{
	}

	override function update(elapsed:Float)
	{
		wavyShader.update(elapsed);
		gdShader.update(elapsed);
	}
}