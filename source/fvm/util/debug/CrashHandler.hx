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
		if (FlxG.signals.postUpdate.has(errorKeybind)) return;

		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);

		FlxG.signals.postUpdate.add(errorKeybind);

		#if hl
		trace('Crash handler does not work :D');
		#else
		trace('Init crash handler');
		#end
	}

	public static var CRASH_KEY:FlxKey = F1;

	static function errorKeybind()
	{
		if (FlxG.keys.anyJustPressed([CRASH_KEY])) throw 'Crash via ${CRASH_KEY.toString()}';
	}

	public static var CRASH_DIRECTORY:String =
		#if debug
		'../../../../dump/crash';
		#else
		'crash';
		#end

	static function onUncaughtError(event:UncaughtErrorEvent)
	{
		var path:String = '$CRASH_DIRECTORY/Crash Log ${DateUtil.generateCurrentFileTimestamp()}.log';
		final spacing:String = '--------------------------------\n';

		if (!FileSystem.exists(CRASH_DIRECTORY)) FileSystem.createDirectory(CRASH_DIRECTORY);

		var UE:String = '';

		try
		{
			UE = 'Uncaught Error: ${Std.string(event?.error) ?? 'Unknown'}';
		}
		catch (e)
		{
			UE = 'Uncaught Error: Unknown ($e)';
		}

		var errorMessage:String = '$UE\n\n';

		errorMessage += 'Exception Stack:\n';
		errorMessage += StackItemListParser.parse(CallStack.exceptionStack(true));

		// errorMessage += '\nCall Stack:\n';
		// errorMessage += StackItemListParser.parse(CallStack.callStack());

		errorMessage += '\n$spacing\n';

		errorMessage += 'Version: ${Application.current.meta.get('version')}\n\n';

		if (FlxG?.state != null)
		{
			errorMessage += 'Current State: ${Type.getClassName(Type.getClass(FlxG?.state))?.replace('.', '/') + '.hx' ?? 'None (how tf)'}\n';
			if (FlxG?.state?.subState != null)
				errorMessage += ' - Current Substate: ${Type.getClassName(Type.getClass(FlxG?.state?.subState))?.replace('.', '/') + '.hx' ?? 'None'}\n';
		}

		errorMessage += '\n$spacing\n';

		errorMessage += 'Crash log saved to "$path"\n';
		errorMessage += 'Please report to the github: https://github.com/bopel-maki-macohi/FunkinVizMaker/issues';

		File.saveContent(path, errorMessage);
		Application.current.window.alert(errorMessage, UE);

		Sys.println(errorMessage);

		Sys.sleep(2);

		Sys.exit(0);
	}
}
