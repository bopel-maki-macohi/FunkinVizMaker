package fvm.player;

import flixel.sound.FlxSound;
import fvm.data.visualizer.VisualizerData;
import flixel.sound.FlxSoundGroup;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var songID:String = 'test';
	public var songVisualizerData:VisualizerData;

	public var audioFiles:FlxSoundGroup;

	override function create()
	{
		super.create();

		songVisualizerData = new VisualizerData(songID);

		audioFiles = new FlxSoundGroup();

		for (file in songVisualizerData.audioFiles)
		{
			audioFiles.add(new FlxSound().loadEmbedded('assets/visualizers/$songID/song/$file.ogg'));
		}
	}
}
