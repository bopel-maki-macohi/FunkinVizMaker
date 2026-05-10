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

	/**
	 * Returns a field from the script.
	 * @param field 	The field that needs to be looked for.
	 */
	public function get(field:String):Dynamic
	{
		if (interp == null) trace('Variables cannot be get');

		return interp != null ? interp.variables.get(field) : false;
	}

	/**
	 * Sets a new field to the script
	 * @param name          The name of your new field, scripts will be able to use the field with the name given.
	 * @param value         The value for your new field.
	 * @param allowOverride If set to true, when setting the new field, we will ignore any previously set fields of the same name.
	 */
	public function set(name:String, value:Dynamic, allowOverride:Bool = true):Void
	{
		if (interp == null || interp.variables == null)
		{
			trace('Variables cannot be set');
			return;
		}

		if (allowOverride || !interp.variables.exists(name)) interp.variables.set(name, value);
	}

	/**
	 * Checks the existance of a field or method within your script.
	 * @param field 		The field to check if exists.
	 */
	public function exists(field:String):Bool
	{
		return (interp != null) ? interp.variables.exists(field) : false;
	}

	/**
	 * Destroys the current instance of this script
	 * along with its parser,.
	 *
	 * **WARNING**: this action CANNOT be undone.
	**/
	public function destroy():Void
	{
		interp = null;
		parser = null;
	}
}
