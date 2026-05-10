package fvm;

import flixel.FlxSprite;
import fvm.audio.Conductor;
import fvm.player.PlayState;
import flixel.FlxG;
import flixel.FlxState;

/**
 * Lorem ipsum dolor sit amet
 */
class InitState extends FlxState
{
	/**
	 * Runs initalization functions
	 * and then boots you to `PlayState`
	 */
	override public function create()
	{
		super.create();

		Conductor.instance = new Conductor();

		FlxSprite.defaultAntialiasing = true;

		FlxG.switchState(() -> new PlayState());
	}
}
