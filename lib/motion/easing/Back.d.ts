import IEasing from "./IEasing";


declare namespace motion.easing {
	
	
	export class Back {
		
		
		public static readonly easeIn:IEasing;
		public static readonly easeInOut:IEasing;
		public static readonly easeOut:IEasing;
		
		public static easeInWith (s:number):IEasing;
		public static easeInOutWith (s:number):IEasing;
		public static easeOutWith (s:number):IEasing;
		
		
	}
	
	
}


export default motion.easing.Back;