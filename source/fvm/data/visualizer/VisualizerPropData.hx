package fvm.data.visualizer;

import sys.io.File;
import sys.FileSystem;
import haxe.Json;

class VisualizerPropData extends DataClass<VisualizerRawPropData>
{
	override public function loadFromFile(prop:String)
	{
		var path:String = 'props/$prop'.jsonFile().getSharedPath();

		if (!FileSystem.exists(path)) throw 'Missing Prop Path: $path';

		var json:VisualizerRawPropData;

		try
		{
			json = Json.parse(File.getContent(path));
		}
		catch (e)
		{
			json = null;
			throw 'Visualizer Parsing Error: $e';
		}

		if (json == null) return;

		data = json;

		super.loadFromFile(prop);

		trace('Loaded ${prop} prop data');
	}

	var loop:Int = 0;

	override function init(data:Dynamic)
	{
		loop++;
		trace('loop $loop');

		super.init(data);
	}

	override function upgradeData()
	{
		super.upgradeData();

		if (data.base != null)
		{
			var path = 'props/${data.base}'.getSharedPath().jsonFile();

			if (FileSystem.exists(path)) init(new VisualizerPropData(data.base));
		}
	}
}
