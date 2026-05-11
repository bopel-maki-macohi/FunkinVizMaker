package fvm.menus;

import fvm.player.PlayState;
import flixel.FlxG;
import fvm.audio.ConductorState;

class VisualizerSelectMenu extends ConductorState
{
	override function create()
	{
		super.create();

		loadSong('test');
	}

	public function loadSong(song:String = 'test')
	{
		FlxG.switchState(() -> new PlayState(song));
	}
}
