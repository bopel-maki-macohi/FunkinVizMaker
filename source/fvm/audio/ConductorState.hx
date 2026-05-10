package fvm.audio;

import flixel.FlxState;

class ConductorState extends FlxState
{
	public var conductor(get, never):Conductor;

	function get_conductor():Conductor
		return Conductor.instance;

	public function new()
	{
		super();

		conductor.beatHit.add(beatHit);
		conductor.stepHit.add(stepHit);
	}

	override function destroy()
	{
		conductor.beatHit.remove(beatHit);
		conductor.stepHit.remove(stepHit);

		super.destroy();
	}

	public function beatHit(beat:Int) {}

	public function stepHit(step:Int) {}
}
