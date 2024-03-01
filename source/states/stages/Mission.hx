package states.stages;

import states.stages.objects.*;
import states.PlayState;
import shaders.*;
import shaders.WiggleEffect.WiggleEffectType;

class Mission extends BaseStage
{
	var curShader:WiggleEffect;
	var wavy:FlxSprite;

	var weird:FlxSprite;

	override function create()
	{
		wavy = new FlxSprite(-600, -200).loadGraphic(Paths.image('bgs/omission/back'));
		wavy.antialiasing = true;
		wavy.scrollFactor.set(0.6, 0.6);
		wavy.active = true;

		var hills:FlxSprite = new FlxSprite(-300, 110).loadGraphic(Paths.image('bgs/omission/BgHills'));
		hills.antialiasing = true;
		hills.scrollFactor.set(0.5, 0.5);
		hills.active = true;

		var farm:FlxSprite = new FlxSprite(150, 200).loadGraphic(Paths.image('bgs/omission/GoofFarmHouse'));
		farm.antialiasing = true;
		farm.scrollFactor.set(0.65, 0.65);
		farm.active = true;

		var foreground:FlxSprite = new FlxSprite(-400, 600).loadGraphic(Paths.image('bgs/omission/Ground'));
		foreground.antialiasing = true;
		foreground.scrollFactor.set(1, 1);
		foreground.active = true;

		var cornSet:FlxSprite = new FlxSprite(-350, 325).loadGraphic(Paths.image('bgs/omission/TheCorn'));
		cornSet.antialiasing = true;
		cornSet.scrollFactor.set(1, 1);
		cornSet.active = true;

		var cornSet2:FlxSprite = new FlxSprite(1050, 325).loadGraphic(Paths.image('bgs/omission/TheCorn'));
		cornSet2.antialiasing = true;
		cornSet2.scrollFactor.set(1, 1);
		cornSet2.active = true;

		var fence:FlxSprite = new FlxSprite(-350, 450).loadGraphic(Paths.image('bgs/omission/Crazy Ass Fences'));
		fence.antialiasing = true;
		fence.scrollFactor.set(0.98, 0.98);
		fence.active = true;

		add(wavy);
		add(hills);
		add(farm);
		add(foreground);
		add(cornSet);
		add(cornSet2);
		add(fence);

		curShader = new WiggleEffect();
		curShader.effectType = WiggleEffectType.FLAG;
		curShader.waveAmplitude = 0.1;
		curShader.waveFrequency = 101;
		curShader.waveSpeed = 1.2;
		wavy.shader = curShader.shader;
	}

	override function createPost()
	{
		weird = new FlxSprite(-120, -120).makeGraphic(Std.int(FlxG.width * 100), Std.int(FlxG.height * 150), FlxColor.BLACK);
		weird.alpha = 0.2;
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