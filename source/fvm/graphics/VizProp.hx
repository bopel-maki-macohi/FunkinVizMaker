package fvm.graphics;

import flixel.util.typeLimit.OneOfThree;
import flixel.util.typeLimit.OneOfTwo;
import fvm.data.visualizer.VisualizerPropData;
import sys.FileSystem;
import fvm.scripting.events.visualizer.VisualizerPropEvent;
import fvm.util.ScriptUtil;
import fvm.util.Core;
import fvm.scripting.events.visualizer.VisualizerPropParseTagEvent;
import fvm.scripting.EventManager;
import fvm.scripting.ScriptPack;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import animate.FlxAnimateFrames;
import fvm.data.visualizer.VisualizerPropBopType;
import haxe.io.Path;
import fvm.data.visualizer.VisualizerRawPropData;

class VizProp extends VizSprite
{
	public var data:VisualizerPropData;

	public var songID:String;

	public var id:String;

	override public function new(data:Dynamic, propNum:Int, ?songID:String)
	{
		super();

		this.data = new VisualizerPropData(data);

		this.songID = songID;

		this.id = '$propNum';

		parseData();
	}

	public var loaded:Bool = false;

	public var bopType:VisualizerPropBopType;

	public var bopAnim:String;

	public function parseData()
	{
		if (loaded) return;
		if (data.data == null) return;

		this.bopType = beat;

		if (data.data.bopType != null) this.bopType = data.data.bopType;

		if (data.data.id != null) this.id = data.data.id;

		var assetPath:String = data.data.asset.imageFile().getPropAsset(id, songID);

		switch (data.data.type)
		{
			case still:
				if (assetPath == null) return;

				this.bopType = none;

				loadGraphic(assetPath);
				loaded = true;

			case bopperSparrow:
				if (assetPath == null) return;
				if (data.data.anims == null) return;

				var frameList:Array<FlxAtlasFrames> = [Path.withoutExtension(assetPath).getSparrowAtlas()];

				for (anim in data.data.anims)
				{
					if (anim.altAsset != null)
					{
						var altAssetPath:String = anim.altAsset.imageFile().getPropAsset(id, songID);
						var altAtlas = Path.withoutExtension(altAssetPath).getSparrowAtlas();

						if (altAtlas == null) return;

						frameList.push(altAtlas);
					}
				}

				frames = FlxAnimateFrames.combineAtlas(frameList);

				for (anim in data.data.anims)
				{
					if (anim.name == null) continue;
					if (anim.prefix == null) continue;

					animation.addByPrefix(anim.name, anim.prefix, 24, false);
					animation.play(anim.name);
				}

				if (animation.getNameList().length == 0) return;

				this.animated = true;

				if (data.data.bopAnim == null) data.data.bopAnim = animation.getNameList()[0];

				bopAnim = data.data.bopAnim;
				dance();

				loaded = true;
		}

		if (loaded) parseGeneralData();
	}

	public function parseGeneralData()
	{
		if (data.data == null) return;

		if (data.data.tags != null)
		{
			for (tag in data.data.tags)
			{
				switch (tag.toLowerCase())
				{
					// case 'center', 'screencenter':
					// screenCenter();
				}

				ScriptUtil.callCoreEvent('parsePropTag', EventManager.get(VisualizerPropParseTagEvent).recycle(this, tag));
			}
		}

		alpha = data?.data?.alpha ?? 1;

		if (data.data?.position != null)
		{
			x += data?.data?.position[0] ?? 0;
			y += data?.data?.position[1] ?? 0;
		}

		if (data.data?.scale != null)
		{
			scale.x = data?.data?.scale[0] ?? 1;
			scale.y = data?.data?.scale[1] ?? 1;
		}

		if (data.data?.scrollFactor != null)
		{
			scrollFactor.x = data?.data?.scrollFactor[0] ?? 1;
			scrollFactor.y = data?.data?.scrollFactor[1] ?? 1;
		}

		flipX = data?.data?.flipX ?? false;
		flipY = data?.data?.flipY ?? false;

		if (data.data?.layer != null) zIndex = data?.data?.layer;

		antialiasing = data?.data?.antialiasing ?? true;
		// trace(zIndex);
	}

	/**
	 * The purpose of this is to prevent
	 * `dance()` from running.
	 */
	public var animated:Bool = false;

	public function dance()
	{
		if (!animated) return;
		if (bopType == none) return;

		animation.play(bopAnim);
		ScriptUtil.callCoreEvent('dance', EventManager.get(VisualizerPropEvent).recycle(this));
	}
}
