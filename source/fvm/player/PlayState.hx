package fvm.player;

import fvm.audio.AudioGroup;
import flixel.sound.FlxSound;
import fvm.data.visualizer.VisualizerData;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var songID:String = 'test';
	public var songVisualizerData:VisualizerData;

	public var audioFiles:AudioGroup;

	override function create()
	{
		super.create();

		songVisualizerData = new VisualizerData(songID);

		audioFiles = new AudioGroup();
		audioFiles.loadFiles([
			for (file in songVisualizerData.audioFiles) songID.getSongVizualizerPath('songs/$file'.audioFile())
		]);
        audioFiles.play();
	}
}
