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
		openfl: {
			commonjs: 'openfl',
			commonjs2: 'openfl',
			amd: 'openfl',
			root: 'openfl'
		}
	}
};