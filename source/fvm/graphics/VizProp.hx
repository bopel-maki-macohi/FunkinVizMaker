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

	public var loaded:Bool = false;

	public function parseData()
	{
		if (assetPath == null)
			return;

		switch (data.type)
		{
			case still:
				loadGraphic(assetPath);
				loaded = true;

			case bopperSparrow:
				if (data.anims == null)
					return;

				frames = Path.withoutExtension(assetPath).getSparrowAtlas();

				for (anim in data.anims)
				{
					if (anim.name == null)
						continue;
					if (anim.prefix == null)
						continue;

					animation.addByPrefix(anim.name, anim.prefix, 24, false);
					animation.play(anim.name);
				}

				if (animation.getNameList().length == 0)
					return;

				if (data.bopAnim != null)
					animation.play(data.bopAnim);

				loaded = true;
		}
	}
}
