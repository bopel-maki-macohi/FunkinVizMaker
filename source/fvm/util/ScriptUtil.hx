package fvm.util;

import fvm.scripting.events.CancellableEvent;
import fvm.scripting.ScriptPack;

class ScriptUtil
{
	public static function call(scriptPacks:Array<ScriptPack>, fn:String, ?args:Array<Dynamic>)
	{
		for (pack in scriptPacks) pack.call(fn, args);
		Core.call(fn, args);
	}

	public static function callEvent<T:CancellableEvent>(scriptPacks:Array<ScriptPack>, fn:String, event:T) call(scriptPacks, fn, [event]);
}
