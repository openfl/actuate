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