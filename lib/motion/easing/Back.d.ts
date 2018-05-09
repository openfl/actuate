import motion_easing_BackEaseIn from "./../../motion/easing/BackEaseIn";
import motion_easing_BackEaseInOut from "./../../motion/easing/BackEaseInOut";
import motion_easing_BackEaseOut from "./../../motion/easing/BackEaseOut";

declare namespace motion.easing {

export class Back {

	static easeIn:any;
	static easeInOut:any;
	static easeOut:any;
	static get_easeIn():any;
	static get_easeInOut():any;
	static get_easeOut():any;


}

}

export default motion.easing.Back;