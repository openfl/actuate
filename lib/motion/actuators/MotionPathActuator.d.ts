import motion_actuators_SimpleActuator from "./../../motion/actuators/SimpleActuator";
import Reflect from "./../../Reflect";
import js_Boot from "./../../js/Boot";
import motion_IComponentPath from "./../../motion/IComponentPath";
import motion_actuators_PropertyPathDetails from "./../../motion/actuators/PropertyPathDetails";

declare namespace motion.actuators {

export class MotionPathActuator extends motion_actuators_SimpleActuator {

	constructor(target:any, duration:any, properties:any);
	apply():any;
	initialize():any;
	update(currentTime:any):any;


}

}

export default motion.actuators.MotionPathActuator;