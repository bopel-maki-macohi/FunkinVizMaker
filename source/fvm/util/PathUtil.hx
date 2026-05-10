package fvm.util;

import flixel.graphics.frames.FlxAtlasFrames;

class PathUtil
{
	public static inline function getPath(path:String):String
		return 'assets/$path';

	public static inline function getCorePath(path:String):String
		return getPath('core/$path');

	public static inline function getSharedPath(path:String):String
		return getPath('shared/$path');

	public static inline function getVisualizersPath(path:String):String
		return getPath('visualizers/$path');

	public static inline function getSongVizualizerPath(songID:String, path:String):String
		return getVisualizersPath('$songID/$path');

	public static inline function jsonFile(path:String):String
		return '$path.json';

	public static inline function audioFile(path:String):String
		return '$path.ogg';

	public static inline function imageFile(path:String):String
		return '$path.png';

	public static inline function xmlFile(path:String):String
		return '$path.xml';

	public static inline function getSparrowAtlas(rawPath:String):FlxAtlasFrames
		return FlxAtlasFrames.fromSparrow(rawPath.imageFile(), rawPath.xmlFile());
}
