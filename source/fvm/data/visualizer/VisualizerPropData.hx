package fvm.data.visualizer;

import sys.io.File;
import sys.FileSystem;
import haxe.Json;

class VisualizerPropData extends DataClass<VisualizerRawPropData>
{
	override public function loadFromFile(prop:String)
	{
		var path:String = 'props/$prop'.jsonFile().getSharedPath();

		if (!FileSystem.exists(path)) throw 'Missing Prop Path: $path';

		var json:VisualizerRawPropData;

		try
		{
			json = Json.parse(File.getContent(path));
		}
		catch (e)
		{
			json = null;
			throw 'Visualizer Parsing Error: $e';
		}

		if (json == null) return;

		data = json;

		super.loadFromFile(prop);

		trace('Loaded ${prop} prop data');
	}

	var loop:Int = 0;

	override function init(data:Dynamic)
	{
		loop++;
		trace('loop $loop');

		super.init(data);
	}

	override function upgradeData()
	{
		if (data.base != null)
		{
			var path = 'props/${data.base}'.getSharedPath().jsonFile();

			if (FileSystem.exists(path))
			{
				var mergedData = new VisualizerPropData(data.base);
				var mergedRawData = mergedData.data;

				data.base = null;

				var ogAsset = data.asset;

				if (data?.baseOptions?.remove != null)
				{
					if (data.baseOptions.remove?.anims != null) //
						for (anim in data.baseOptions.remove.anims) //
							for (a in mergedRawData.anims) if (a.name == anim) mergedRawData.anims.remove(a);
					
					if (data.baseOptions.remove.xPos) mergedRawData.position[0] = 0;
					if (data.baseOptions.remove.yPos) mergedRawData.position[0] = 0;
				}

				var replaceFields = Reflect.fields(mergedRawData);
				replaceFields.remove('position');
				replaceFields.remove('scale');
				replaceFields.remove('scrollFactor');
				replaceFields.remove('anims');
				replaceFields.remove('tags');

				function mergeFloatArrayField(field:String)
				{
					var oldFA:Array<Float> = Reflect.field(data, field);
					var newFA:Array<Float> = Reflect.field(mergedRawData, field);

					if (oldFA != null && newFA != null)
					{
						if (oldFA.length > 0 && newFA.length > 0)
						{
							oldFA[0] += newFA[0] ?? 0;

							if (oldFA.length > 1 && newFA.length > 1) oldFA[1] += newFA[1] ?? 0;
						}
					}
					else if (oldFA == null && newFA != null) replaceFields.push(field);
					else if (oldFA != null && newFA == null) {};
				}

				mergeFloatArrayField('position');
				mergeFloatArrayField('scale');
				mergeFloatArrayField('scrollFactor');

				if (mergedRawData.tags != null) //
					for (tag in mergedRawData.tags) if (!data.tags.contains(tag)) data.tags.push(tag);

				if (!mergedRawData.type.animated()) data.anims = [];
				if (mergedRawData.type.animated() && mergedRawData.anims.length > 0)
				{
					if (data.type.animated()) //
						for (newanim in mergedRawData.anims)
						{
							for (anim in data.anims)
							{
								if (newanim.name == anim.name)
								{
									anim.altAsset = newanim.altAsset;
									anim.prefix = newanim.prefix;
									mergedRawData.anims.remove(newanim);
								}
							}
						}

					if (data.type.animated()) for (anim in data.anims) //
						if (data.asset != ogAsset && anim.altAsset != ogAsset) data.anims.remove(anim);

					for (anim in mergedRawData.anims) //
						data.anims.push(anim);
				}

				for (field in replaceFields) Reflect.setField(this.data, field, Reflect.field(mergedRawData, field));

				init(data);

				return;
			}
		}

		if (data.anims != null) for (anim in data.anims)
		{
			if (anim.prefix == null && data.type == bopperSparrow) data.anims.remove(anim);
		}
	}
}
