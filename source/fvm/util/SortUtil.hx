package fvm.util;

import flixel.util.FlxSort;
import flixel.FlxBasic;

class SortUtil
{
	/**
	 * Sort by the macro-added `zIndex` variable
	 * @param order Decides the sorting
	 */
	public static inline function byZIndex(order:Int = FlxSort.ASCENDING, a:FlxBasic, b:FlxBasic):Int
	{
		if (a == null || b == null)
			return 0;

		return FlxSort.byValues(order, a.zIndex, b.zIndex);
	}
}
