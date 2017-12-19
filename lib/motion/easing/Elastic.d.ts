import motion_easing_ElasticEaseIn from "./../../motion/easing/ElasticEaseIn";
import motion_easing_ElasticEaseInOut from "./../../motion/easing/ElasticEaseInOut";
import motion_easing_ElasticEaseOut from "./../../motion/easing/ElasticEaseOut";

declare namespace motion.easing {

export class Elastic {

	static easeIn:any;
	static easeInOut:any;
	static easeOut:any;
	static get_easeIn():any;
	static get_easeInOut():any;
	static get_easeOut():any;


}

}

export default motion.easing.Elastic;