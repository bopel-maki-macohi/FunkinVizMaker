package fvm.scripting;

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
		var path:String = PathUtil.getPath(folder);

		var scripts:Array<String> = [for (file in FileUtil.readDirectoryRecursive(path)) file];

		for (s in scripts) if (s.endsWith(''.scriptFile())) add(new Script(s));
	}

	public function add(script:Script) scripts.push(script);

	public function remove(script:Script) scripts.remove(script);

	public function removeIndex(i:Int) remove(scripts[i]);

	public function call(fn:String, ?args:Array<Dynamic>) for (script in scripts) script.call(fn, args);

	public function set(vr:String, values:Dynamic) for (script in scripts) script.set(vr, values);

	public function get(vr:String):Dynamic
	{
		for (script in scripts) if (script.get(vr) != null) return script.get(vr);

		return null;
	}
}
