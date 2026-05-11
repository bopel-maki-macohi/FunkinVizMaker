package fvm.data.visualizer;

import haxe.Json;
import lime.utils.Assets;

// @:build(fvm.util.macro.DataClassMacro.build())
class VisualizerData extends DataClass<VisualizerRawData>
{
	override function loadFromFile(file:String)
	{
		super.loadFromFile(file);

		var path:String = file.getSongVizualizerPath('visualizer'.jsonFile());

		if (!Assets.exists(path)) throw 'Missing Visualizer Path: $path';

		var json:VisualizerRawData;

		try
		{
			json = Json.parse(Assets.getText(path));
		}
		catch (e)
		{
			json = null;
			throw 'Visualizer Parsing Error: $e';
		}

		if (json == null) return;

		data = json;

		super.loadFromFile(file);

		trace('Loaded "$file" Visualizer data');
	}
}
