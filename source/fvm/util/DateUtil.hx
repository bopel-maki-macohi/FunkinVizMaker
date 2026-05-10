package fvm.util;

class DateUtil
{
	public static function generateCurrentFileTimestamp():String return generateFileTimestamp(Date.now());

	public static function generateFileTimestamp(date:Date):String
	{
		return '${date.getFullYear()}-${date.getMonth()}-${date.getDate()} ${Math.round(date.getTime() / 1000)}';
	}
}
