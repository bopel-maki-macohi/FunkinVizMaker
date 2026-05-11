package fvm.data.visualizer;

enum abstract VisualizerPropType(String) from String to String
{
	var still = 'still';

	var waveform = 'waveform';

	var bopperSparrow = 'bopperSparrow';

	public function animated() return this == bopperSparrow;
}
