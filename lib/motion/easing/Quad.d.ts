import motion_easing_QuadEaseIn from "./../../motion/easing/QuadEaseIn";
import motion_easing_QuadEaseInOut from "./../../motion/easing/QuadEaseInOut";
import motion_easing_QuadEaseOut from "./../../motion/easing/QuadEaseOut";

declare namespace motion.easing {

export class Quad {

	static easeIn:any;
	static easeInOut:any;
	static easeOut:any;
	static get_easeIn():any;
	static get_easeInOut():any;
	static get_easeOut():any;


}

}

export default motion.easing.Quad;