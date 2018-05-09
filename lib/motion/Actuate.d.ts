import motion_actuators_SimpleActuator from "./../motion/actuators/SimpleActuator";
import motion_easing_Expo from "./../motion/easing/Expo";
import haxe_ds_ObjectMap from "./../haxe/ds/ObjectMap";
import Type from "./../Type";
import motion__$Actuate_EffectsOptions from "./../motion/_Actuate/EffectsOptions";
import motion_actuators_MotionPathActuator from "./../motion/actuators/MotionPathActuator";
import Std from "./../Std";
import motion_actuators_IGenericActuator from "./../motion/actuators/IGenericActuator";
import Reflect from "./../Reflect";
import js_Boot from "./../js/Boot";
import motion__$Actuate_TweenTimer from "./../motion/_Actuate/TweenTimer";
import motion__$Actuate_TransformOptions from "./../motion/_Actuate/TransformOptions";
import HxOverrides from "./../HxOverrides";
import motion_actuators_MethodActuator from "./../motion/actuators/MethodActuator";

declare namespace motion {

export class Actuate {

	static defaultActuator:any;
	static defaultEase:any;
	static targetLibraries:any;
	static apply(target:any, properties:any, customActuator?:any):any;
	static effects(target:any, duration:any, overwrite?:any):any;
	static getLibrary(target:any, allowCreation?:any):any;
	static isActive():any;
	static motionPath(target:any, duration:any, properties:any, overwrite?:any):any;
	static pause(target:any):any;
	static pauseAll():any;
	static reset():any;
	static resume(target:any):any;
	static resumeAll():any;
	static stop(target:any, properties?:any, complete?:any, sendEvent?:any):any;
	static timer(duration:any, customActuator?:any):any;
	static transform(target:any, duration?:any, overwrite?:any):any;
	static tween(target:any, duration:any, properties:any, overwrite?:any, customActuator?:any):any;
	static unload(actuator:any):any;
	static update(target:any, duration:any, start?:any, end?:any, overwrite?:any):any;


}

}

export default motion.Actuate;