package fvm.data.visualizer;

enum abstract VisualizerPropBopType(String) from String to String
{
	var none = 'none';
	var beat = 'beat';
	var step = 'step';
	var otherstep = 'otherstep';
	var otherbeat = 'otherbeat';
}
