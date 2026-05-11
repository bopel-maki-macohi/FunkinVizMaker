package fvm.player;

import flixel.math.FlxMath;
import fvm.graphics.VizWaveformSprite;
import fvm.menus.VisualizerSelectMenu;
import fvm.util.ScriptUtil;
import fvm.scripting.events.visualizer.VisualizerEventCallEvent;
import fvm.scripting.EventManager;
import fvm.scripting.ScriptPack;
import flixel.FlxObject;
import fvm.data.visualizer.VisualizerRawEventEventData;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxCamera;
import fvm.graphics.VizPropGroup;
import fvm.audio.ConductorState;
import fvm.audio.AudioGroup;
import fvm.data.visualizer.VisualizerData;

class PlayState extends ConductorState
{
	public var song:String = 'test';
	public var visualizer:VisualizerData;

	public var audioFiles:AudioGroup;

	public var props:VizPropGroup;

	public var camGame:FlxCamera;
	public var camFollow:FlxObject;

	public var eventTimers:Array<FlxTimer> = [];

	public static var instance:PlayState;

	public function new(song:String = 'test')
	{
		super();

		this.song = song;
	}

	override function create()
	{
		super.create();

		instance = null;
		instance = this;

		camGame = new FlxCamera();
		FlxG.cameras.add(camGame, false);

		camFollow = new FlxObject();
		add(camFollow);

		camFollow.screenCenter();

		visualizer = new VisualizerData(song);

		audioFiles = new AudioGroup();
		audioFiles.loadFiles([
			for (file in visualizer.data?.audioFiles) song.getSongVizualizerPath('song/$file'.audioFile())
		]);
		audioFiles.play();
		audioFiles.sounds[0].onComplete = onSongEnd;

		conductor.setBPM(visualizer.data.bpm);

		props = new VizPropGroup();
		add(props);

		props.loadProps(song, visualizer.data.props);

		props.camera = camGame;

		camGame.zoom = visualizer?.data?.stage?.zoom ?? 1.0;

		for (event in visualizer.data.events)
		{
			var timer = new FlxTimer();
			timer.start(event.time / 1000, t ->
			{
				parseEvent(event.event);

				eventTimers.remove(t);
			});

			eventTimers.push(timer);
		}

		camGame.follow(camFollow, LOCKON, visualizer?.data?.stage?.camSpeed ?? 0.04);
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

		for (sprite in props.getWaveformProps())
		{
			var waveform = cast(sprite, VizWaveformSprite);
			@:privateAccess
			if (waveform != null) waveform.waveformTime = audioFiles?.getSoundBasedOnID(waveform.soundID)?._channel?.position ?? conductor.songPosition;
		}
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
		callEvent('onEvent', EventManager.get(VisualizerEventCallEvent).recycle(event.id, event.value));
	}

	public function onSongEnd()
	{
		FlxG.switchState(() -> new VisualizerSelectMenu());
	}
}
