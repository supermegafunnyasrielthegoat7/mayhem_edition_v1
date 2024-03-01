package states.stages;

import states.stages.objects.*;
import states.PlayState;
import shaders.*;
import shaders.WiggleEffect.WiggleEffectType;

class ThreedFaked extends BaseStage
{
	var curShader:WiggleEffect;
	var wavy:FlxSprite;
	var idiot:Bool = false;

	var weird:FlxSprite;

	override function create()
	{
		wavy = new FlxSprite(-600, -200).loadGraphic(Paths.image('bgs/3dShited'));
		wavy.antialiasing = true;
		wavy.setGraphicSize(Std.int(wavy.width * 1.4));
		wavy.scrollFactor.set(0.4, 0.4);
		wavy.active = true;

		switch(songName){
			case 'psychosis':
				idiot = true;
				wavy.loadGraphic(Paths.image('bgs/foxybg'));
		}

		add(wavy);

		curShader = new WiggleEffect();
		curShader.effectType = FLAG;
		if (idiot){
			curShader.waveFrequency = 102;
		} else {
			curShader.waveFrequency = 5;
		}
		curShader.waveAmplitude = 0.1;
		curShader.waveSpeed = 2;
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