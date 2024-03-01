package states.unstableexported;

import states.stages.objects.*;
import shaders.*;

class BHOUSE extends BaseStage
{
	var whatEffect:GlitchEffect;
	var redSky:FlxSprite;

	override function create()
	{
		var bg:BGSprite = new BGSprite('bgs/sky_night', -1000, -160, 0.2, 0.2);
		add(bg);

		redSky = new FlxSprite(0,0).loadGraphic(Paths.image('bgs/b/shid'));
		redSky.setGraphicSize(Std.int(redSky.width * 1.0));
		redSky.antialiasing = true;
		redSky.scrollFactor.set(0.6, 0.6);
		redSky.visible = false;
		add(redSky);
		whatEffect = new GlitchEffect();
		whatEffect.waveAmplitude = 0.1;
		whatEffect.waveFrequency = 32;
		whatEffect.waveSpeed = 100;
		redSky.shader = whatEffect.shader;

		var platform:BGSprite = new BGSprite('bgs/b/theawsomeroof', -585, 88, 1, 1);
		platform.setGraphicSize(Std.int(platform.width * 1));
		platform.updateHitbox();
		add(platform);

		platform.color = 0xFF878787;		
	}
	
	override function createPost()
	{
		
	}

	override function update(elapsed:Float)
	{
		whatEffect.update(elapsed);
	}
}