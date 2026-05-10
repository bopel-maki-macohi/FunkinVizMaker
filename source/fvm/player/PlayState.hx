package fvm.player;

import fvm.graphics.VizPropGroup;
import haxe.io.Path;
import lime.utils.Assets;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import fvm.audio.ConductorState;
import fvm.audio.Conductor;
import fvm.audio.AudioGroup;
import flixel.sound.FlxSound;
import fvm.data.visualizer.VisualizerData;
import flixel.FlxState;

class PlayState extends ConductorState
{
	public var songID:String = 'test';
	public var songVisualizerData:VisualizerData;

	public var audioFiles:AudioGroup;

	public var props:VizPropGroup;

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

		props = new VizPropGroup();
		add(props);

		props.loadProps(songID, songVisualizerData.props);

		refresh();
	}

	/**
	 * TODO: Make this open a pause state
	 */
	override function onFocusLost()
	{
		super.onFocusLost();

		audioFiles.pause();
	}

	override function onFocus()
	{
		super.onFocus();

		audioFiles.resume();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		conductor.songPosition += elapsed * 1000;
		conductor.update();
	}

	override function beatHit(beat:Int)
	{
		super.beatHit(beat);

		props.onBeatHit(beat);

		// trace('beat: $beat');
	}

	override function stepHit(step:Int)
	{
		super.stepHit(step);

		props.onStepHit(step);
	}
}
