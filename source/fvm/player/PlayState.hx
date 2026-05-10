package fvm.player;

import fvm.audio.Conductor;
import fvm.audio.AudioGroup;
import flixel.sound.FlxSound;
import fvm.data.visualizer.VisualizerData;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var songID:String = 'test';
	public var songVisualizerData:VisualizerData;

	public var audioFiles:AudioGroup;

	public var conductor(get, never):Conductor;

	function get_conductor():Conductor
		return Conductor.instance;

	override function create()
	{
		super.create();

		songVisualizerData = new VisualizerData(songID);

		audioFiles = new AudioGroup();
		audioFiles.loadFiles([
			for (file in songVisualizerData.audioFiles)
				songID.getSongVizualizerPath('song/$file'.audioFile())
		]);
		audioFiles.play();

		conductor.setBPM(songVisualizerData.bpm);

		conductor.beatHit.add(beat ->
		{
			trace('beat');
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		conductor.songPosition += elapsed * 1000;
		conductor.update();
	}
}
