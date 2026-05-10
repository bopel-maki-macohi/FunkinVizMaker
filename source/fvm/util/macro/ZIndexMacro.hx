package fvm.util.macro;

import haxe.macro.Context;
import haxe.macro.Expr;

/**
 * A macro class for implementing z-ordering features.
 * 
 * Yoinked from [WTF-Engine](https://github.com/VirtuGuy/WTF-Engine)
 */
class ZIndexMacro
{
	public static macro function buildFlxBasic():Array<Field>
	{
		var fields = Context.getBuildFields();
		var has:Bool = false;

		for (field in fields)
		{
			if (field.name != 'zIndex') continue;
			has = true;
		}

		if (!has)
		{
			fields.push({
				name: 'zIndex',
				access: [APublic],
				kind: FieldType.FVar(macro :Int, macro $v{0}),
				pos: Context.currentPos()
			});
		}

		return fields;
	}

	public static macro function buildFlxGroup():Array<Field>
	{
		var fields = Context.getBuildFields();
		var has:Bool = false;

		for (field in fields)
		{
			if (field.name != 'refresh') continue;
			has = true;
		}

		if (!has)
		{
			fields.push({
				name: 'refresh',
				access: [APublic],
				kind: FieldType.FFun({
					args: [],
					expr: macro
					{sort(fvm.util.SortUtil.byZIndex);}
				}),
				pos: Context.currentPos()
			});
		}

		return fields;
	}
}
