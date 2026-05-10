package fvm.data.visualizer;

typedef VisualizerRawData =
{
	/**
	 * TODO: make optional & when unincluded it looks for
	 * `assets/shared/songs/{songID}.ogg` or `assets/visualizers/${songID}/song.ogg`
	 */
	audioFiles:Array<String>,

	bpm:Float,
}
