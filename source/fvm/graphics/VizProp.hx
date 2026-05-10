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

	public function parseGeneralData()
	{
		if (data == null)
			return;

		if (data.tags != null)
		{
			for (tag in data.tags)
			{
				switch (tag.toLowerCase())
				{
					case 'center', 'screencenter':
						screenCenter();
				}
			}
		}

		alpha = data?.alpha ?? 1;

		if (data.position != null)
		{
			x += data?.position[0] ?? 0;
			y += data?.position[1] ?? 0;
		}
		
		if (data.scale != null)
		{
			scale.x = data?.scale[0] ?? 1;
			scale.y = data?.scale[1] ?? 1;
		}

		if (data.scrollFactor != null)
		{
			scrollFactor.x = data?.scrollFactor[0] ?? 1;
			scrollFactor.y = data?.scrollFactor[1] ?? 1;
		}
	}

	public function dance()
	{
		animation.play(bopAnim);
	}
}
