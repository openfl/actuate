import motion_actuators_SimpleActuator from "./../../motion/actuators/SimpleActuator";
import Reflect from "./../../Reflect";
import Std from "./../../Std";
import openfl_display_DisplayObject from "openfl/display/DisplayObject";
import openfl_geom_ColorTransform from "openfl/geom/ColorTransform";
import motion_actuators_PropertyDetails from "./../../motion/actuators/PropertyDetails";
import openfl_media_SoundTransform from "openfl/media/SoundTransform";

declare namespace motion.actuators {

export class TransformActuator extends motion_actuators_SimpleActuator {

	constructor(target:any, duration:any, properties:any);
	
	
	
	
	apply():any;
	initialize():any;
	initializeColor():any;
	initializeSound():any;
	update(currentTime:any):any;


}

}

export default motion.actuators.TransformActuator;