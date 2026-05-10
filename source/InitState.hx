package;

import flixel.FlxSprite;
import fvm.audio.Conductor;
import fvm.player.PlayState;
import flixel.FlxG;
import flixel.FlxState;

class InitState extends FlxState
{
	override public function create()
	{
		super.create();

		Conductor.instance = new Conductor();

		FlxSprite.defaultAntialiasing = true;

		FlxG.switchState(() -> new PlayState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
