package fvm.util;

import fvm.scripting.ScriptPack;

class Core
{
	public static var scriptPack:ScriptPack;

	public static function call(fn:String, ?args:Array<Dynamic>) scriptPack?.call(fn, args);
}
