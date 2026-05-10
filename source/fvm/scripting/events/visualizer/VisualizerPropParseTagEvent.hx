package fvm.scripting.events.visualizer;

import fvm.graphics.VizProp;

class VisualizerPropParseTagEvent extends CancellableEvent
{
	public var props:VizProp;
	
	public var tag:String;
}
