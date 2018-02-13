const webpack = require ("webpack");
const merge = require ("webpack-merge");
const common = require ("./webpack.common.js");
const package = require ("./package.json");

var banner = "/*!\n"
 + " * Actuate v" + package.version + "\n"
 + " * https://github.com/jgranick/actuate\n"
 + " * \n"
 + " * Copyright Joshua Granick\n"
 + " * Released under the MIT license\n"
 + " */\n"
 + "if (typeof window != 'undefined') { this['openfl.display.Sprite'] = window['openfl.display.Sprite']; this['openfl.events.Event'] = window['openfl.events.Event']; this['openfl.geom.ColorTransform'] = window['openfl.display.ColorTransform']; this['openfl.media.SoundTransform'] = window['openfl.media.SoundTransform']; this['openfl.Lib'] = window.openfl.Lib; }";

module.exports = merge (common, {
	output: {
		filename: "actuate.js"
	},
	plugins: [
		new webpack.BannerPlugin ({
			banner: banner,
			raw: true,
			entryOnly: true
		})
	]
});