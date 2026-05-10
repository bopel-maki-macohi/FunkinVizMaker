package fvm.data.visualizer;

import haxe.Json;
import lime.utils.Assets;

class VisualizerData extends DataClass<VisualizerRawData>
{
	public function new(songID:String)
	{
		var path:String = songID.getSongVizualizerPath('visualizer'.jsonFile());

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

		// upgrading shit here

		trace('Loaded $songID Visualizer data');
	}

	public var audioFiles(get, set):Array<String>;

	function get_audioFiles():Array<String> return data.audioFiles;

	function set_audioFiles(audioFiles:Array<String>):Array<String> return data.audioFiles = audioFiles;

	public var bpm(get, set):Float;

	function get_bpm():Float return data.bpm;

	function set_bpm(bpm:Float):Float return data.bpm = bpm;

	public var stage(get, set):VisualizerRawStageData;

	function get_stage():VisualizerRawStageData return data.stage;

	function set_stage(stage:VisualizerRawStageData):VisualizerRawStageData return data.stage = stage;

	public var props(get, set):Array<VisualizerRawPropData>;

	function get_props():Array<VisualizerRawPropData> return data.props;

	function set_props(props:Array<VisualizerRawPropData>):Array<VisualizerRawPropData> return data.props = props;

	public var events(get, set):Array<VisualizerRawEventData>;

	function get_events():Array<VisualizerRawEventData> return data.events;

	function set_events(events:Array<VisualizerRawEventData>):Array<VisualizerRawEventData> return data.events = events;
}
