

declare namespace motion.actuators {

export class IGenericActuator {

	
	autoVisible(value?:any):any;
	delay(duration:any):any;
	ease(easing:any):any;
	onComplete(handler:any, parameters?:any):any;
	onRepeat(handler:any, parameters?:any):any;
	onUpdate(handler:any, parameters?:any):any;
	reflect(value?:any):any;
	repeat(times?:any):any;
	reverse(value?:any):any;
	smartRotation(value?:any):any;
	snapping(value?:any):any;
	onPause(handler:any, parameters?:any):any;
	onResume(handler:any, parameters?:any):any;
	apply():any;
	move():any;
	pause():any;
	resume():any;
	stop(properties:any, complete:any, sendEvent:any):any;


}

}

export default motion.actuators.IGenericActuator;