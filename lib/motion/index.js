module.exports = {
	actuators: require ("./actuators"),
	easing: require ("./easing"),
	Actuate: require ("./Actuate").default,
	MotionPath: require ("./MotionPath").default
}
module.exports.default = module.exports.Actuate;