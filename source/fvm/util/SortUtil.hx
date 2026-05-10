package fvm.util;

import flixel.util.FlxSort;
import flixel.FlxBasic;

class SortUtil
{
	public static inline function byZIndex(order:Int = FlxSort.ASCENDING, a:FlxBasic, b:FlxBasic):Int
	{
		if (a == null || b == null)
			return 0;

		return FlxSort.byValues(order, a.zIndex, b.zIndex);
	}
}
