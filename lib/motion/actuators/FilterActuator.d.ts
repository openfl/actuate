import motion_actuators_SimpleActuator from "./../../motion/actuators/SimpleActuator";
import Reflect from "./../../Reflect";
import motion_actuators_PropertyDetails from "./../../motion/actuators/PropertyDetails";
import Std from "./../../Std";
import Type from "./../../Type";

declare namespace motion.actuators {

export class FilterActuator extends motion_actuators_SimpleActuator {

	constructor(target:any, duration:any, properties:any);
	
	filterClass:any;
	filterIndex:any;
	apply():any;
	initialize():any;
	setFilter():any;
	update(currentTime:any):any;


}

}

export default motion.actuators.FilterActuator;