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

        if (Assets.exists(file))
            expr = Assets.getText(file);

        var ast = parser.parseString(expr, file);
        interp.execute(ast);
    }
}
