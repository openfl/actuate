import motion_actuators_SimpleActuator from "./../../motion/actuators/SimpleActuator";
import Reflect from "./../../Reflect";
import motion_actuators_PropertyDetails from "./../../motion/actuators/PropertyDetails";

declare namespace motion.actuators {

export class MethodActuator extends motion_actuators_SimpleActuator {

	constructor(target:any, duration:any, properties:any);
	currentParameters:any;
	
	apply():any;
	complete(sendEvent?:any):any;
	initialize():any;
	update(currentTime:any):any;


}

}

export default motion.actuators.MethodActuator;