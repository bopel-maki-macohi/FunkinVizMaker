package fvm.scripting.events;

import flixel.util.FlxDestroyUtil.IFlxDestroyable;

@:autoBuild(fvm.util.macro.EventMacro.build())
class CancellableEvent implements IFlxDestroyable
{
	/**
	 * Additional data if used in scripts
	 */
	public var data:Dynamic = {};

	@:dox(hide) public var cancelled(default, null):Bool = false;
	@:dox(hide) public var __continueCalls(default, null):Bool = true;

	/**
	 * Prevents default action from occurring.
	 * @param c Whenever the scripts following this one should be called or not. (Defaults to `true`)
	 */
	public function preventDefault(c:Bool = false)
	{
		cancelled = true;
		__continueCalls = c;
	}

	@:dox(hide)
	public function cancel(c:Bool = true)
	{
		preventDefault(c);
	}

	public function new() {}

	public function recycleBase()
	{
		data = {};
		cancelled = false;
		__continueCalls = true;
	}

	public function destroy() {}

	/**
	 * Returns a string representation of the event, in this format:
	 * `[CancellableEvent]`
	 * `[CancellableEvent (Cancelled)]`
	 * @return String
	 */
	public function toString():String
	{
		var fields = Reflect.fields(this);
		var claName = Type.getClassName(Type.getClass(this)).split(".");
		var rep = '[${claName[claName.length - 1]}${cancelled ? " (Cancelled)" : ""}]';
		return rep;
	}
}
