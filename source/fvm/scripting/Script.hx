package fvm.scripting;

import lime.utils.Assets;
import hscript.Parser;
import hscript.Interp;

class Script
{
	public var interp:Interp;
	public var parser:Parser;

	public function new(file:String)
	{
		interp = new Interp();
		parser = new Parser();

		var expr = 'throw "$file does not exist"';

		if (Assets.exists(file)) expr = Assets.getText(file);

		var ast = parser.parseString(expr, file);
		interp.execute(ast);

        call('onCreate');
	}

	/**
	 * Calls a method on the script
	 * @param fun       The name of the method you wanna call.
	 * @param args      The arguments that the method needs.
	 */
	public function call(fun:String, ?args:Array<Dynamic>):Dynamic
	{
		if (interp == null)
		{
			trace("Functions cannot be called.");
			return null;
		}

		if (args == null) args = [];

		// fun-ny
		var ny:Dynamic = interp.variables.get(fun); // function signature
		var isFunction:Bool = false;
		try
		{
			isFunction = ny != null && Reflect.isFunction(ny);
			if (!isFunction) throw 'Tried to call a non-function, for "$fun"';
			// throw "Variable not found or not callable, for \"" + fun + "\"";

			final ret = Reflect.callMethod(null, ny, args);
			return ret;
		}
		catch (e) {}
		// @formatter:on
		return null;
	}
}
