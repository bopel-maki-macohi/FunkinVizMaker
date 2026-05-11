package fvm.graphics;

import flixel.FlxG;
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

	public var soundID:String = '';

	override public function new(data:Dynamic, propNum:Int, ?songID:String)
	{
		super(0, 0, FlxG.width, Std.int(FlxG.height / 4));

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

		antialiasing = false;

		if (data.data.waveform != null)
		{
			var waveformData = data.data.waveform;

			if (PlayState.instance?.visualizer?.data?.audioFiles != null)
			{
				if (waveformData.audioFile != null) soundID = 'song/${waveformData?.audioFile}';
			}
			else
			{
				soundID = PlayState.instance.audioFiles.soundKeys[0];
				soundID = soundID.split('/')[soundID.split('/').length - 1];

				loadDataFromFlxSound(PlayState.instance?.audioFiles?.sounds[0]);
			}

			if (soundID != null) loadDataFromFlxSound(new FlxSound().loadEmbedded(songID.getSongVizualizerPath('$soundID'.audioFile())));

			waveformDuration = (waveformData?.visibleDurationSeconds ?? 5) * 1000;

			// if (waveformData?.bgColor != null) waveformBgColor = FlxColor.fromString(waveformData.bgColor);

			waveformBarSize = waveformData?.barSize ?? 1;
			waveformBarPadding = waveformData?.barPadding ?? 0;

			color = FlxColor.BLUE;
			waveformRMSColor = FlxColor.WHITE;
			if (waveformData?.rmsColor != null) waveformRMSColor = FlxColor.fromString(waveformData.rmsColor);

			waveformDrawRMS = true;

			waveformWidth = waveformData?.width ?? FlxG.width;
			waveformHeight = waveformData?.height ?? Std.int(FlxG.height / 2);

			loaded = waveformBuffer != null;
		}

		if (loaded) VizPropHelper.parseGeneralData(this, data.data);
	}
}
