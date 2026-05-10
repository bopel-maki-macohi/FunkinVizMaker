function parsePropTag(prop, tag)
{
	if (tag.toLowerCase() == 'center') prop.screenCenter();
	if (tag.toLowerCase() == 'screencenter') prop.screenCenter();

    trace(prop);
}
