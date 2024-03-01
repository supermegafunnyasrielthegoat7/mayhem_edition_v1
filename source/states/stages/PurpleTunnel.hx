package states.stages;

import states.stages.objects.*;
import states.PlayState;
import shaders.*;
import shaders.WiggleEffect.WiggleEffectType;

class PurpleTunnel extends BaseStage
{
	public var Tunnel:FlxSprite;
	public var BG:FlxSprite;
	public var weird:FlxSprite;

	override function create()
	{
		BG = new FlxSprite(-1000, -700).loadGraphic(Paths.image('bgs/purple_tunnel/bg'));
		BG.setGraphicSize(Std.int(BG.width * 1.15));
		BG.updateHitbox();
		BG.active = true;
		BG.visible = true;
		add(BG);

		Tunnel = new FlxSprite(-1000, -700).loadGraphic(Paths.image('bgs/purple_tunnel/tunnel'));
		Tunnel.setGraphicSize(Std.int(Tunnel.width * 1.15));
		Tunnel.updateHitbox();
		Tunnel.active = true;
		Tunnel.visible = true;
		add(Tunnel);

		var platform:BGSprite = new BGSprite('bgs/purple_tunnel/platform', -1376, -678, 1, 1); // this is my version of the code lmao
		platform.setGraphicSize(Std.int(platform.width * 1.2));
		platform.updateHitbox();
		add(platform); // ok what you gotta do
	}

	override function createPost()
	{
	}

	override function update(elapsed:Float)
	{
		if (Tunnel != null){
			Tunnel.angle += elapsed * 3.5;
		}
	}
}