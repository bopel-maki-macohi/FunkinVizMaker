package fvm.scripting.events.visualizer;

import fvm.graphics.VizSpriteProp;

class VisualizerPropParseTagEvent extends CancellableEvent
{
	public var prop:VizSpriteProp;

	public var tag:String;
}
