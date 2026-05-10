package fvm.util.macro;

import haxe.macro.Expr.ExprOf;
import haxe.macro.Context;

class DefineMacro
{
	public static macro function getDefines():ExprOf<Array<String>>
	{
		var defines:Array<String> = [];

		for (define => value in Context.getDefines())
		{
			defines.push('$define=$value');
		}

		return macro $v{defines};
	}
}
