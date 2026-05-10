package fvm.audio;

import flixel.util.FlxSignal;

class Conductor
{
	public static var instance:Conductor;

	public function new()
	{
		reset();
	}

	public var bpm:Float = 150.0;

	public function setBPM(bpm:Float)
	{
		stepOffset = step;
		songPositionOffset = songPosition;

		this.bpm = bpm;
	}

	public var songPosition:Float = 0;

	public var beat:Int = 0;
	public var step:Int = 0;

	public var crochet(get, never):Float;

	function get_crochet():Float
		return 60 / bpm * 1000;

	public var quaver(get, never):Float;

	function get_quaver():Float
		return crochet / 4;

	public var stepOffset:Int = 0;
	public var songPositionOffset:Float = 0;

	public var stepHit:FlxTypedSignal<Int->Void> = new FlxTypedSignal<Int->Void>();
	public var beatHit:FlxTypedSignal<Int->Void> = new FlxTypedSignal<Int->Void>();

	public function update()
	{
		final lastStep:Int = step;
		final lastBeat:Int = beat;

		step = stepOffset + Math.floor((songPosition - songPositionOffset) / quaver);
		beat = Math.floor(step / 4);

		if (lastStep != step)
			stepHit.dispatch(step);
		if (lastBeat != beat)
			beatHit.dispatch(beat);
	}

	public function reset(bpm:Float = 0)
	{
		this.bpm = bpm;

		songPosition = 0;
		step = 0;
		beat = 0;

		stepOffset = 0;
		songPositionOffset = 0;
	}
}
