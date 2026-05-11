package fvm.data.visualizer;

typedef VisualizerRawWaveformData =
{
	/**
	 * Should only be used
	 * when multiple audio files
	 */
	?audioFile:String,

	?visibleDurationSeconds:Float,

	?bgColor:String,

	?barSize:Int,
	?barSizePadding:Int,
}
