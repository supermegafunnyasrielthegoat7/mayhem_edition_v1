package states.stages;

import states.stages.objects.*;

class Grass extends BaseStage
{
	//... this fucking sucks

	override function create()
	{
		var skybox:BGSprite = new BGSprite('bgs/GrassPlae/sky', -510, -890, 0, 0);
		skybox.updateHitbox();
		add(skybox);

		var clouds:BGSprite = new BGSprite('bgs/GrassPlae/clouds', -428, -282, 0.5, 0.5);
		clouds.setGraphicSize(Std.int(1 * clouds.width));
		clouds.updateHitbox();
		add(clouds);

		var ground:BGSprite = new BGSprite('bgs/GrassPlae/GROUND', -757, -815, 1, 0.95);
		ground.setGraphicSize(Std.int(1.4 * ground.width));
		ground.updateHitbox();
		add(ground);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
	}

	override function update(elapsed:Float)
	{
		// Code here
	}

	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
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