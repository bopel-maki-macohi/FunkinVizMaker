package fvm.util.debug;

import lime.app.Application;
import sys.io.File;
import haxe.CallStack;
import sys.FileSystem;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import openfl.events.UncaughtErrorEvent;
import openfl.Lib;

using StringTools;

class CrashHandler
{
	public static function init()
	{
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);

		trace('Init crash handler');
	}

	static function onUncaughtError(event:UncaughtErrorEvent)
	{
		trace('Error');
	}
}
