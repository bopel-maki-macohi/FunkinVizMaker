function parsePropTag(prop, tag)
{
	trace(tag);

	if (tag.toLowerCase() == 'center') prop.screenCenter();
	if (tag.toLowerCase() == 'screencenter') prop.screenCenter();
}
