function parsePropTag(prop, tag)
{
	switch (tag.toLowercase())
	{
		case 'center', 'screencenter':
			prop.screenCenter();
	}
}
