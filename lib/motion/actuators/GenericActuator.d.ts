import motion_actuators_IGenericActuator from "./../../motion/actuators/IGenericActuator";
import Reflect from "./../../Reflect";
import motion_Actuate from "./../../motion/Actuate";

declare namespace motion.actuators {

export class GenericActuator {

	constructor(target:any, duration:any, properties:any);
	duration:any;
	id:any;
	
	target:any;
	_autoVisible:any;
	_delay:any;
	_ease:any;
	
	_onCompleteParams:any;
	
	_onRepeatParams:any;
	
	_onUpdateParams:any;
	
	_onResumeParams:any;
	
	_onPauseParams:any;
	_reflect:any;
	_repeat:any;
	_reverse:any;
	_smartRotation:any;
	_snapping:any;
	special:any;
	apply():any;
	autoVisible(value?:any):any;
	callMethod(method:any, params?:any):any;
	change():any;
	complete(sendEvent?:any):any;
	delay(duration:any):any;
	ease(easing:any):any;
	move():any;
	onComplete(handler:any, parameters?:any):any;
	onRepeat(handler:any, parameters?:any):any;
	onUpdate(handler:any, parameters?:any):any;
	onPause(handler:any, parameters?:any):any;
	onResume(handler:any, parameters?:any):any;
	pause():any;
	reflect(value?:any):any;
	repeat(times?:any):any;
	resume():any;
	reverse(value?:any):any;
	smartRotation(value?:any):any;
	snapping(value?:any):any;
	stop(properties:any, complete:any, sendEvent:any):any;


}

}

export default motion.actuators.GenericActuator;