package fvm.util.macro;

import haxe.macro.Context;

class DefineMacro
{
	/**
	 * Receive every define going into the game
	 */
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
