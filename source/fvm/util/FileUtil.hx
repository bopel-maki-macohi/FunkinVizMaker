package fvm.util;

import haxe.io.Path;
import sys.FileSystem;

class FileUtil
{
	public static function readDirectory(dir:String):Array<String>
	{
		dir = Path.removeTrailingSlashes(dir);

		if (!FileSystem.exists(dir)) return [];

		var files = [
			for (file in FileSystem.readDirectory(dir))
				'$dir/$file'
		];

		// for (file in files)
			// trace(file);

		return files;
	}

	public static function readDirectoryRecursive(dir:String):Array<String>
	{
		dir = Path.removeTrailingSlashes(dir);

		if (!FileSystem.exists(dir)) return [];

		var files:Array<String> = [];

		for (file in readDirectory(dir))
		{
			if (FileSystem.isDirectory(file))
			{
				for (subfile in readDirectoryRecursive(file))
					files.push(subfile);
			}
			else files.push(file);
		}

		return files;
	}
}
