package fvm.data.visualizer;

typedef VisualizerRawWaveformData =
{
	/**
	 * Should only be used
	 * when multiple audio files
	 */
	?audioFile:String,

	?visibleDurationSeconds:Float,

	// ?bgColor:String,
    ?rmsColor:String,

	?barSize:Int,
	?barPadding:Int,

	?width:Int,
	?height:Int,
}
