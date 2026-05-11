package fvm.graphics;

import fvm.data.visualizer.VisualizerPropBopType;
import fvm.data.visualizer.VisualizerPropData;

interface IVizProp
{
	public var data:VisualizerPropData;
	public var bopType:VisualizerPropBopType;

	public var songID:String;
	public var id:String;

	public var loaded:Bool;
}
