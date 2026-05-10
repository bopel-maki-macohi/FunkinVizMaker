import fvm.util.PathUtil;

function onCreate()
{
	trace('hello world');

    trace(PathUtil.audioFile('nonexistant-audio'));
    trace(PathUtil.getPath('nonexistant-path'));
    PathUtil.getPropAsset('nonexistant.asset', 'nonexistant-prop');
    PathUtil.getPropAsset('nonexistant-asset', 'nonexistant-prop', 'nonexistant-song-id');
    trace(PathUtil.getSharedPath('nonexistant-shared-path'));
    trace(PathUtil.getSongVizualizerPath('nonexistant-song-id', 'nonexistant-visualizer-asset'));
    trace(PathUtil.getSparrowAtlas('nonexistant-sparrow-asset'));
    trace(PathUtil.getVisualizersPath('nonexistant-visualizer-path'));
    trace(PathUtil.imageFile('nonexistant-image'));
    trace(PathUtil.jsonFile('nonexistant-json'));
    trace(PathUtil.xmlFile('nonexistant-xml'));
}
