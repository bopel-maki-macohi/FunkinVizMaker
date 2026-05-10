package fvm.graphics;

import haxe.io.Path;
import fvm.data.visualizer.VisualizerRawPropData;

class VizProp extends VizSprite
{
	public var data:VisualizerRawPropData;

	public var assetPath:String;

	override public function new(data:VisualizerRawPropData, ?assetPath:String)
	{
		super();

		this.data = data;
		this.assetPath = assetPath;

		parseData();
	}

	public function parseData()
	{
		if (assetPath == null)
			return;

		switch data.type
		{
			case still:
				loadGraphic(assetPath);
			case bopperSparrow:
				if (data.anims == null)
					return;

				frames = Path.withoutExtension(assetPath).getSparrowAtlas();

				for (anim in data.anims)
				{
					animation.addByPrefix(anim.name, anim.prefix, 24, false);
					animation.play(anim.name);
				}

				if (data.defaultAnim != null)
					animation.play(data.defaultAnim);
		}
	}
}
