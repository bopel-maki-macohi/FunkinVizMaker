function parsePropTag(e)
{
	if (e.tag.toLowerCase() == 'center') e.prop.screenCenter();
	if (e.tag.toLowerCase() == 'screencenter') e.prop.screenCenter();
}
