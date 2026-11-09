class DUCalculator extends DataUnit {
	
	private function set_operand1(a:int):void { this.operand1 = a; this.iao(DUCalculator.ID_DP_OPERAND1); }
	private function get_operand1():int { return this.operand1;}
	private var operand1:int
	
	private function set_operand2(a:int):void { this.operand2 = a; this.iao(DUCalculator.ID_DP_OPERAND2); }
	private function get_operand2():int { return this.operand2;}
	private var operand2:int
	
	private function set_memory(a:int):void { this.memory = a; this.iao(DUCalculator.ID_DP_MEMORY); }
	private function get_memory():int { return this.memory;}
	private var memory:int

	private function set_result(a:int):void { this.result = a; this.iao(DUCalculator.ID_DP_RESULT); }
	private function get_result():int { return this.result;}
	private var result:int
	
	
	public static const ID_OPERATION_ADDITION:uint = 1
	public static const ID_OPERATION_SUBSTRUCTION:uint = 2
	public static const ID_OPERATION_MULTIPLICATION:uint = 3
	public static const ID_OPERATION_DIVISION:uint = 4
	
	public static const ID_OPERATION_NONE:uint = 0
	
	private function set_mathOperationID(a:int):void { this.mathOperationID = a; this.iao(DUCalculator.ID_DP_MATH_OPERATION_ID); }
	private function get_mathOperationID():int { return this.mathOperationID;}
	private var mathOperationID:uint
	
	public override function reset():void {
		this.operand1 = 0
		this.operand2 = 0
		this.result = 0
		this.operationID = DUCalculator.ID_OPERATION_NONE
	}
	
	
	public static const UID:String = "20261022212140_DUCalculator"
	
	//{ ============================ inform about data update ============================
	
	/**
	 * data part
	 */
	public static const ID_DP_OPERAND1:String = UID + "ID_DP_OPERAND1"
	public static const ID_DP_OPERAND2:String = UID + "ID_DP_OPERAND2"
	public static const ID_DP_MEMORY:String = UID + "ID_DP_MEMORY"
	public static const ID_DP_RESULT:String = UID + "ID_DP_RESULT"
	public static const ID_DP_MATH_OPERATION_ID:String = UID + "ID_DP_MATH_OPERATION_ID"
	
	//} ============================ inform about data update ============================
	
	
	
}