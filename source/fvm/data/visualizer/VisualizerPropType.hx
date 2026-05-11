package fvm.data.visualizer;

enum abstract VisualizerPropType(String) from String to String
{
	var waveform = 'waveform';

	var still = 'still';
	var bopperSparrow = 'bopperSparrow';

	public function animated() return [bopperSparrow].contains(this);

	public function vizSpriteProp() return [still, bopperSparrow].contains(this);
}
