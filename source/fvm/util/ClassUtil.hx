package fvm.util;

class ClassUtil
{
	public static function getClassName<T>(cls:T)
	{
		var mc = Type.getClassName(Type.getClass(cls)).split(".");
		return mc[mc.length - 1];
	}
}
