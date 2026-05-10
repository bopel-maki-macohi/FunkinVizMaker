package fvm.util.macro;

import haxe.macro.Expr;
import haxe.macro.Context;

class DefineMacro
{
	/**
	 * Receive every define going into the game as a string array
	 */
	public static macro function getStrDefines():ExprOf<Array<String>> return macro $v{[for (define => value in Context.getDefines()) '$define=$value']};

	/**
	 * Receive every define going into the game as a map
	 */
	public static macro function getMapDefines():ExprOf<Map<String, Dynamic>> return macro $v{Context.getDefines()};

	public static macro function isDefined(define:String):Expr return macro $v{haxe.macro.Context.defined(define)};

	public static macro function defineValue(define:String):Expr return macro $v{haxe.macro.Context.definedValue(define)};
}
