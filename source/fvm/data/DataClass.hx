package fvm.data;

import flixel.util.typeLimit.OneOfThree;

class DataClass<T>
{
	public var data:T;

	public function new(data:Dynamic)
	{
		init(data);
	}

	public function init(data:Dynamic)
	{
		this.data = null;

		if (this.data == null && Std.isOfType(data, String)) loadFromFile(data);
		if (this.data == null && Std.isOfType(data, DataClass)) loadFromData((cast data).data);
		if (this.data == null && Std.isOfType(data, Dynamic)) loadFromData(data);
	}

	public function loadFromData(data:T)
	{
		this.data = data;

		upgradeData();
	}

	public function loadFromFile(file:String)
	{
		upgradeData();
	}

	public function upgradeData() {}
}
