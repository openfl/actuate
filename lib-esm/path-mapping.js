
"use strict"

var path = require('path');
// Get the absolute path to this directory
var dir = path.resolve(__dirname);

module.exports = function() {
  return {
    "motion/Actuate": path.join(dir, "motion/Actuate"),
    "motion/MotionPath": path.join(dir, "motion/MotionPath"),
    "motion/actuators": path.join(dir, "motion/actuators"),
    "motion/easing": path.join(dir, "motion/easing"),
  };
}