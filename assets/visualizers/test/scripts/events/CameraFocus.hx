import fvm.player.PlayState;

function onEvent(e)
{
	if (e.id != 'cameraFocus') return;

	var props = PlayState.instance.props;
	var camFollow = PlayState.instance.camFollow;

	if (props.propExists(e.value))
	{
		var prop = props.getProp(e.value);

		camFollow.setPosition(prop.getGraphicMidpoint().x, prop.getGraphicMidpoint().y);
	}

	e.cancel(false);
}
