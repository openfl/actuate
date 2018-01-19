const webpack = require ("webpack");
const merge = require ("webpack-merge");
const UglifyJSPlugin = require ("uglifyjs-webpack-plugin");
const common = require ("./webpack.common.js");
const package = require ("./package.json");

var banner = "/*! Actuate v" + package.version + " | MIT (c) Joshua Granick | https://github.com/jgranick/actuate */\n"
 + "if (typeof window != 'undefined') { this['openfl.display.Sprite'] = window['openfl.display.Sprite']; this['openfl.events.Event'] = window['openfl.events.Event']; this['openfl.geom.ColorTransform'] = window['openfl.display.ColorTransform']; this['openfl.media.SoundTransform'] = window['openfl.media.SoundTransform']; this['openfl.Lib'] = window.openfl.Lib; }";

module.exports = merge (common, {
	output: {
		filename: "actuate.min.js"
	},
	plugins: [
		new UglifyJSPlugin ({
			sourceMap: true,
			uglifyOptions: {
				// warnings: true
			}
		}),
		new webpack.BannerPlugin ({
			banner: banner,
			raw: true,
			entryOnly: true
		}),
		new webpack.DefinePlugin ({
			"process.env.NODE_ENV": JSON.stringify ("production")
		})
	]
});