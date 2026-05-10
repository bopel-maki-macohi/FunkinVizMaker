package fvm.audio;

import fvm.util.ScriptUtil;
import fvm.scripting.events.CancellableEvent;
import fvm.util.Core;
import flixel.FlxState;

class ConductorState extends FlxState
{
	public var conductor(get, never):Conductor;

	function get_conductor():Conductor return Conductor.instance;

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

	public function call(fn:String, ?args:Array<Dynamic>) ScriptUtil.callCore( fn, args);

	public function callEvent<T:CancellableEvent>(fn:String, event:T) call(fn, [event]);
}
