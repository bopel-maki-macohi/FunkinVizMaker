package fvm.graphics;

import fvm.data.visualizer.VisualizerPropBopType;
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

	public var bopType:VisualizerPropBopType;

	public var bopAnim:String;

	public function parseData()
	{
		if (loaded)
			return;

		if (data == null)
			return;

		if (assetPath == null)
			return;

		this.bopType = beat;
		if (data.bopType != null)
			this.bopType = data.bopType;

		switch (data.type)
		{
			case still:
				this.bopType = none;

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

				if (data.bopAnim == null)
					data.bopAnim = animation.getNameList()[0];

				bopAnim = data.bopAnim;
				dance();

				loaded = true;
		}

		if (loaded)
			parseGeneralData();
	}

	public function parseGeneralData() {}

	public function dance()
	{
		animation.play(bopAnim);
	}
}
