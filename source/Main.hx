package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		for (arg in Sys.args())
		{
			trace(arg);
		}

		addChild(new FlxGame(0, 0, InitState));
	}
}
