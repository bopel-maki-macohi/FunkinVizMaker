package fvm.scripting;

import fvm.scripting.events.CancellableEvent;
import fvm.util.FileUtil;
import lime.utils.Assets;

using StringTools;

class ScriptPack
{
	public var scripts:Array<Script> = [];

	public var id(default, null):String;

	public function new(id:String)
	{
		this.id = id;
	}

	public function load(folder:String)
	{
		var path:String = (!folder.startsWith(''.getPath())) ? PathUtil.getPath(folder) : folder;

		for (s in FileUtil.readDirectoryRecursive(path))
		{
			if (s.endsWith(''.scriptFile()))
			{
				// trace(s);
				add(new Script(s));
			}
		}
	}

	public function add(script:Script) scripts.push(script);

	public function remove(script:Script) scripts.remove(script);

	public function removeIndex(i:Int) remove(scripts[i]);

	public function call(fn:String, ?args:Array<Dynamic>)
	{
		var proceed:Bool = true;

		for (script in scripts)
		{
			for (arg in args)
			{
				if (Std.isOfType(arg, CancellableEvent))
				{
					var event = cast(arg, CancellableEvent);
					if (event.cancelled && !event.__continueCalls)
					{
						proceed = false;
						trace(event);
					}
				}
			}

			if (proceed)
			{
				// trace('${script.file} $fn');
				script.call(fn, args);
			}
		}
	}

	public function set(vr:String, values:Dynamic) for (script in scripts) script.set(vr, values);

	public function get(vr:String):Dynamic
	{
		for (script in scripts) if (script.get(vr) != null) return script.get(vr);

		return null;
	}
}
