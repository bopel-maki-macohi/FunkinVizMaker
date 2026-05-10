package fvm.player;

import flixel.FlxObject;
import fvm.data.visualizer.VisualizerRawEventEventData;
import fvm.data.visualizer.VisualizerRawEventData;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxCamera;
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
	public var visualizer:VisualizerData;

	public var audioFiles:AudioGroup;

	public var props:VizPropGroup;

	public var camGame:FlxCamera;
	public var camFollow:FlxObject;

	public var eventTimers:Array<FlxTimer> = [];

	override function create()
	{
		super.create();

		camGame = new FlxCamera();
		FlxG.cameras.add(camGame);

		camFollow = new FlxObject();
		add(camFollow);

		camFollow.screenCenter();

		visualizer = new VisualizerData(songID);

		audioFiles = new AudioGroup();
		audioFiles.loadFiles([
			for (file in visualizer.audioFiles)
				songID.getSongVizualizerPath('song/$file'.audioFile())
		]);
		audioFiles.play();

		conductor.setBPM(visualizer.bpm);

		props = new VizPropGroup();
		add(props);

		props.loadProps(songID, visualizer.props);

		camGame.zoom = visualizer?.stage?.zoom ?? 1.0;

		for (event in visualizer.events)
		{
			var timer = new FlxTimer();
			timer.start(event.time / 1000, t ->
			{
				trace(event);

				parseEvent(event.event);

				eventTimers.remove(t);
			});

			eventTimers.push(timer);
		}

		camGame.follow(camFollow, LOCKON, visualizer?.stage?.camSpeed ?? 0.04);
		camGame.focusOn(camFollow.getPosition());

		refresh();
	}

	/**
	 * TODO: Make this open a pause state
	 */
	override public function onFocusLost()
	{
		super.onFocusLost();

		audioFiles.pause();
	}

	override public function onFocus()
	{
		super.onFocus();

		audioFiles.resume();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		audioFiles.update(elapsed);

		conductor.songPosition += elapsed * 1000;
		conductor.update();
	}

	override public function beatHit(beat:Int)
	{
		super.beatHit(beat);

		props.onBeatHit(beat);

		// trace('beat: $beat');
	}

	override public function stepHit(step:Int)
	{
		super.stepHit(step);

		audioFiles.resyncCheck();

		props.onStepHit(step);
	}

	public function parseEvent(event:VisualizerRawEventEventData)
	{
		switch (event.id)
		{
			case 'cameraFocus':
				if (props.propExists(event.value))
				{
					var prop = props.getProp(event.value);

					camFollow.setPosition(prop.getGraphicMidpoint().x, prop.getGraphicMidpoint().y);
				}
		}
	}
}
