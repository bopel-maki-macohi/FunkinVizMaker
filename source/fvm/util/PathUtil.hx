package fvm.util;

import lime.utils.Assets;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class PathUtil
{
	public static inline function getPath(path:String):String return 'assets/$path';

	public static inline function getCorePath(path:String):String return getPath('core/$path');

	public static inline function getSharedPath(path:String):String return getPath('shared/$path');

	public static inline function getVisualizersPath(path:String):String return getPath('visualizers/$path');

	public static inline function getSongVizualizerPath(songID:String, path:String):String return getVisualizersPath('$songID/$path');

	public static inline function jsonFile(path:String):String return '$path.json';

	public static inline function audioFile(path:String):String return '$path.ogg';

	public static inline function imageFile(path:String):String return '$path.png';

	public static inline function xmlFile(path:String):String return '$path.xml';

	public static inline function getSparrowAtlas(rawPath:String):FlxAtlasFrames return FlxAtlasFrames.fromSparrow(rawPath.imageFile(), rawPath.xmlFile());

	public static function getPropAsset(rawPath:String, id:String, ?songID:String):String
	{
		var assetPath:String = null;

		final localPath = songID.getSongVizualizerPath('props/${rawPath}');
		final altLocalPath = songID.getSongVizualizerPath('props/$id/${rawPath}');

		final sharedPath = rawPath.getSharedPath();
		final altSharedPath = '$id/$rawPath'.getSharedPath();

		function checkForPath(path:String, pathType:String)
		{
			var log = '$id : NPAP($pathType, $path)';

			#if WHATS_NPAP
			log = log.replace('NPAP', 'No Prop Asset Path');
			#end

			if (Assets.exists(path) && assetPath == null)
				assetPath = path;
			else if (assetPath == null)
				trace(log);
		}

		checkForPath(localPath, 'local');
		checkForPath(sharedPath, 'shared');
		checkForPath(altLocalPath, 'local-alt');
		checkForPath(altSharedPath, 'shared-alt');

		return assetPath;
	}
}
