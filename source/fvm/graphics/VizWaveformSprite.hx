package fvm.graphics;

import fvm.player.PlayState;
import flixel.sound.FlxSound;
import fvm.util.VizPropHelper;
import fvm.data.visualizer.VisualizerPropBopType;
import fvm.data.visualizer.VisualizerPropData;
import flixel.util.FlxColor;
import flixel.addons.display.waveform.FlxWaveform;

class VizWaveformSprite extends FlxWaveform implements IVizProp
{
	public var data:VisualizerPropData;
	public var bopType:VisualizerPropBopType = none;

	public var songID:String;
	public var id:String;

	public var loaded:Bool = false;

	override public function new(data:Dynamic, propNum:Int, ?songID:String)
	{
		super(0, 0, 120, 120);

		this.data = new VisualizerPropData(data);

		this.songID = songID;

		this.id = '$propNum';

		parseData();
	}

	public function parseData()
	{
		if (loaded) return;
		if (data.data == null) return;

		if (data.data.type != waveform)
		{
			trace('${this.getClassName()} : Waveforms only');
			return;
		}

		if (data.data.waveform != null)
		{
			var waveformData = data.data.waveform;

			if (PlayState.instance?.visualizer?.data?.audioFiles != null
				&& waveformData.audioFile != null) loadDataFromFlxSound(new FlxSound()
					.loadEmbedded(songID.getSongVizualizerPath('song/${waveformData.audioFile}'.audioFile())));
		}

		if (loaded) VizPropHelper.parseGeneralData(this, data.data);
	}
}
