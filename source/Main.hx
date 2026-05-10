package;

import fvm.util.macro.DefineMacro;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, fvm.InitState));
	}
}
