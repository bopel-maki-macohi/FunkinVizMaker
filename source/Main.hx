package;

import fvm.util.macro.DefineMacro;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		final defines = DefineMacro.getDefines();
		for (define in defines)
			trace(define);

		addChild(new FlxGame(0, 0, InitState));
	}
}
