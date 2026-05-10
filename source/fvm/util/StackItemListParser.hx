package fvm.util;

import haxe.CallStack.StackItem;

class StackItemListParser
{
	public static function parse(callStack:Array<StackItem>)
	{
		var list:String = '';

		for (item in callStack)
		{
			switch (item)
			{
				case FilePos(s, file, line, column):
					list += '${file}:${line}\n';

				default:
					list += '${item}\n';
			}
		}

		return list;
	}
}
