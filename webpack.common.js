const path = require ("path");

module.exports = {
	entry: "./lib/motion/index.js",
	devtool: "source-map",
	output: {
		path: path.resolve (__dirname, "dist"),
		library: 'motion',
		libraryTarget: 'umd'
	},
	resolve: {
		alias: {
			"openfl": path.resolve (__dirname, "node_modules/openfl/lib/openfl")
		}
	},
	externals: {
		"openfl/display/DisplayObject": "openfl.display.DisplayObject",
		"openfl/display/Sprite": "openfl.display.Sprite",
		"openfl/events/Event": "openfl.events.Event",
		"openfl/geom/ColorTransform": "openfl.geom.ColorTransform",
		"openfl/media/SoundTransform": "openfl.media.SoundTransform",
		"openfl/Lib": "openfl.Lib"
	}
};