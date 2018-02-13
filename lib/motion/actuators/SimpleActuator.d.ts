import motion_actuators_GenericActuator from "./../../motion/actuators/GenericActuator";
import Reflect from "./../../Reflect";
import motion_actuators_PropertyDetails from "./../../motion/actuators/PropertyDetails";
import Std from "./../../Std";
import openfl_display_DisplayObject from "openfl/display/DisplayObject";
import openfl_Lib from "openfl/Lib";

declare namespace motion.actuators {

export class SimpleActuator extends motion_actuators_GenericActuator {

	constructor(target:any, duration:any, properties:any);
	setField_openfl_geom_Transform(target:any, propertyName:any, value:any):any;
	setField_motion_actuators_TransformActuator_T(target:any, propertyName:any, value:any):any;
	setField_motion_actuators_MotionPathActuator_T(target:any, propertyName:any, value:any):any;
	setField_motion_actuators_SimpleActuator_T(target:any, propertyName:any, value:any):any;
	setField_openfl_display_DisplayObject(target:any, propertyName:any, value:any):any;
	timeOffset:any;
	active:any;
	cacheVisible:any;
	detailsLength:any;
	initialized:any;
	paused:any;
	pauseTime:any;
	propertyDetails:any;
	sendChange:any;
	setVisible:any;
	startTime:any;
	toggleVisible:any;
	autoVisible(value?:any):any;
	delay(duration:any):any;
	getField(target:any, propertyName:any):any;
	initialize():any;
	move():any;
	onUpdate(handler:any, parameters?:any):any;
	pause():any;
	resume():any;
	setProperty(details:any, value:any):any;
	stop(properties:any, complete:any, sendEvent:any):any;
	update(currentTime:any):any;
	static actuators:any;
	static actuatorsLength:any;
	static addedEvent:any;
	static stage_onEnterFrame(event:any):any;


}

}

export default motion.actuators.SimpleActuator;