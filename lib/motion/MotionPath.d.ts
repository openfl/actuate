import motion_BezierPath from "./../motion/BezierPath";
import motion_LinearPath from "./../motion/LinearPath";
import motion_RotationPath from "./../motion/RotationPath";
import motion_ComponentPath from "./../motion/ComponentPath";

declare namespace motion {

export class MotionPath {

	constructor();
	rotation:any;
	x:any;
	y:any;
	_rotation:any;
	_x:any;
	_y:any;
	bezier(x:any, y:any, controlX:any, controlY:any, strength?:any):any;
	line(x:any, y:any, strength?:any):any;
	get_rotation():any;
	get_x():any;
	get_y():any;


}

}

export default motion.MotionPath;