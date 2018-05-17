const path = require ("path");

module.exports = {
	entry: "./lib/motion/index.js",
	devtool: "source-map",
	output: {
		path: path.resolve (__dirname, "dist"),
		library: 'motion',
		libraryTarget: 'umd'
	},
	externals: [
		function (context, request, callback) {
			if (/^openfl\//.test (request)) {
				return callback (null, {
					amd: request,
					root: request.split ("/"),
					commonjs: request,
					commonjs2: request
				});
			}
			callback ();
		}
	]
};