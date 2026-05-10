package fvm.data.visualizer;

typedef VisualizerRawPropData =
{
	type:VisualizerPropType,
	asset:String,
	
	?defaultAnim:String,
    ?anims:Array<VisualizerRawAnimationData>,
}
