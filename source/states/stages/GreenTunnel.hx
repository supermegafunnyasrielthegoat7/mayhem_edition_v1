package states.stages;

import states.stages.objects.*;
import states.PlayState;
import shaders.*;
import shaders.WiggleEffect.WiggleEffectType;

class GreenTunnel extends BaseStage
{
	public var Tunnel:FlxSprite;
	public var BG:FlxSprite;
	var weird:FlxSprite;

	override function create()
	{
		BG = new FlxSprite(-1000, -700).loadGraphic(Paths.image('bgs/geen_tunnel/tunnelGreenBG'));
		BG.setGraphicSize(Std.int(BG.width * 1.15));
		BG.updateHitbox();
		BG.active = true;
		BG.visible = true;
		add(BG);

		Tunnel = new FlxSprite(-1000, -700).loadGraphic(Paths.image('bgs/geen_tunnel/tunnelGreen'));
		Tunnel.setGraphicSize(Std.int(Tunnel.width * 1.15));
		Tunnel.updateHitbox();
		Tunnel.active = true;
		Tunnel.visible = true;
		add(Tunnel);

		var platform:BGSprite = new BGSprite('bgs/geen_tunnel/platform1', -1376, -678, 1, 1); // this is my version of the code lmao
		platform.setGraphicSize(Std.int(platform.width * 1.2));
		platform.updateHitbox();
		add(platform); // ok what you gotta do
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
		if (Tunnel != null){
			Tunnel.angle += elapsed * 3.5;
		}
	}
}