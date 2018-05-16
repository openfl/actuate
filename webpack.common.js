const path = require ("path");

module.exports = {
	entry: "./lib/motion/index.js",
	devtool: "source-map",
	output: {
		path: path.resolve (__dirname, "dist"),
		library: 'motion',
		libraryTarget: 'umd'
	},
	externals: {
		"openfl/display/DisplayObject": {
			amd: 'openfl/display/DisplayObject',
			root: [ 'openfl', 'display', 'DisplayObject' ],
			commonjs: 'openfl/display/DisplayObject',
			commonjs2: 'openfl/display/DisplayObject'
		},
		"openfl/display/Sprite": {
			amd: 'openfl/display/Sprite',
			root: [ 'openfl', 'display', 'Sprite' ],
			commonjs: 'openfl/display/Sprite',
			commonjs2: 'openfl/display/Sprite'
		},
		"openfl/events/Event": {
			amd: 'openfl/events/Event',
			root: [ 'openfl', 'events', 'Event' ],
			commonjs: 'openfl/events/Event',
			commonjs2: 'openfl/events/Event'
		},
		"openfl/geom/ColorTransform": {
			amd: 'openfl/geom/ColorTransform',
			root: [ 'openfl', 'geom', 'ColorTransform' ],
			commonjs: 'openfl/geom/ColorTransform',
			commonjs2: 'openfl/geom/ColorTransform'
		},
		"openfl/media/SoundTransform": {
			amd: 'openfl/media/SoundTransform',
			root: [ 'openfl', 'media', 'SoundTransform' ],
			commonjs: 'openfl/media/SoundTransform',
			commonjs2: 'openfl/media/SoundTransform'
		},
		"openfl/Lib": {
			amd: 'openfl/Lib',
			root: [ 'openfl', 'Lib' ],
			commonjs: 'openfl/Lib',
			commonjs2: 'openfl/Lib'
		}
	}
};