package simple_calculator {

    import flash.display.Sprite;
	import flash.display.DisplayObject;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import flash.events.Event;

	
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import flash.desktop.NativeApplication;
	
	
	
	
	[SWF(width="540", height="1200", frameRate="60", backgroundColor="#ffffff")]
    public dynamic class Multitool extends Sprite {
		
		[Embed(source="../../res/MultitoolUILib.swf", symbol="MultitoolUILib")]
		private var uiLib:Class;
		private var uiLibInstance:DisplayObject;
		
		private static const PRODUCTION_MODE:Boolean = Boolean(1)
		
    	public function Multitool() {
			if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			if (Multitool.PRODUCTION_MODE) {
				stage.scaleMode = StageScaleMode.SHOW_ALL;
				stage.align = StageAlign.TOP_LEFT;
			} else {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			
            this.applicationLocale = new LTextEnglish()
			this.uiLibInstance = new uiLib()
			addChild(this.uiLibInstance)
    		this.calculatorView = new VCCalculator(this.uiLibInstance, this.applicationLocale, this.el_calculatorView);
			this.addChild(this.calculatorView)
    	    if (this.stage) this.el_onAddedToStage() else this.addEventListener(Event.ADDED_TO_STAGE, el_onAddedToStage);
    	}

        private function startApplication():void {
			this.applicationOperationMode = Multitool.ID_AOM_CALC
            this.calculatorView.prepare();
            this.calculatorMemory = new CalculatorMemory();
            this.calculator = new Calculator(calculatorMemory, this.er_calculator, this.calculatorView);
		}

    	/**
    	* event listener
    	*/
    	private function el_calculatorView(eventSN:uint):void {
    		switch (eventSN) {
				
				case VCCalculator.ID_E_SWITCH_MODE:
					this.applicationOperationMode = (this.applicationOperationMode === Multitool.ID_AOM_CALC) ? Multitool.ID_AOM_COORD : Multitool.ID_AOM_CALC
					this.view_refreshDisplay()
					break;
				
				case VCCalculator.ID_E_DISPLAY_DEVELOPER_ID:
					this.calculatorView.displayDeveloperID()
					break;
				
    		    /**
               	 * action digit entered
               	*/
               	case VCCalculator.ID_E_DE_D_1:
               	    this.calculator.addDigit(1);
               	    break;
               	case VCCalculator.ID_E_DE_D_2:
               	    this.calculator.addDigit(2);
               	    break;
               	case VCCalculator.ID_E_DE_D_3:
               	    this.calculator.addDigit(3);
               	    break;
               	case VCCalculator.ID_E_DE_D_4:
               	    this.calculator.addDigit(4);
               	    break;
               	case VCCalculator.ID_E_DE_D_5:
               	    this.calculator.addDigit(5);
               	    break;
               	case VCCalculator.ID_E_DE_D_6:
               	    this.calculator.addDigit(6);
               	    break;
               	case VCCalculator.ID_E_DE_D_7:
               	    this.calculator.addDigit(7);
               	    break;
               	case VCCalculator.ID_E_DE_D_8:
               	    this.calculator.addDigit(8);
               	    break;
               	case VCCalculator.ID_E_DE_D_9:
               	    this.calculator.addDigit(9);
               	    break;
               	case VCCalculator.ID_E_DE_D_0:
               	    this.calculator.addDigit(0);
               	    break;

					
               	case VCCalculator.ID_E_MO_P:
					this.calculator.storeResultIntoMemory();
					break;
					
               	case VCCalculator.ID_E_MO_G:
					this.calculator.loadResultFromMemory();
					break;
					
               	case VCCalculator.ID_E_AO_A:
					if (this.calculator.operand1 !== 0) {
						this.calculatorView.set_operationSN(VCCalculator.ID_E_AO_A);
						this.calculator.s_currentOperandSN(Calculator.ID_OPERAND_2); t('Calculator.ID_OP_A: ' + Calculator.ID_OP_A);
						this.calculator.s_currentOperationSN(Calculator.ID_OP_A);
					}
					break
					
               	case VCCalculator.ID_E_AO_S:
               		if (this.calculator.operand1 !== 0) {
						this.calculatorView.set_operationSN(VCCalculator.ID_E_AO_S);
						this.calculator.s_currentOperandSN(Calculator.ID_OPERAND_2);
						this.calculator.s_currentOperationSN(Calculator.ID_OP_S);
					}
               		break
				
				case VCCalculator.ID_E_AO_M:
               		if (this.calculator.operand1 !== 0) {
						this.calculatorView.set_operationSN(VCCalculator.ID_E_AO_M);
						this.calculator.s_currentOperandSN(Calculator.ID_OPERAND_2);
						this.calculator.s_currentOperationSN(Calculator.ID_OP_M);
						
					}
               		break
				
				case VCCalculator.ID_E_AO_D:
					if (this.calculator.operand1 !== 0) {
						this.calculatorView.set_operationSN(VCCalculator.ID_E_AO_D);
						this.calculator.s_currentOperandSN(Calculator.ID_OPERAND_2);
						this.calculator.s_currentOperationSN(Calculator.ID_OP_D);
					}
					break
				
				
               	case VCCalculator.ID_E_RESET:
					this.calculator.reset();
					break;
 
				case VCCalculator.ID_E_PERFORM:
					if (this.calculator.operand1 === 0 || this.calculator.operand2 === 0) break;
					if (this.calculator.perform()) {
						this.calculatorView.set_resultValue(this.calculator.g_result())
						this.calculatorView.refreshDisplay()
					}
				
			}
			
            this.calculatorView.refreshDisplay()
    	}
		
		/**
    	* event receiver
    	*/
    	private function er_calculator(eventID:uint):void {t('er_calculator: ' + eventID);
			switch (eventID) {
				case Calculator.ID_E_RESET:
					this.calculatorView.reset()
					break
			}
		}

        private function el_onAddedToStage(e:Event = null):void {
            this.startApplication();
        }

		//{ ===== VIEW =====
		private function view_refreshDisplay():void {
			switch (this.applicationOperationMode) {
				case Multitool.ID_AOM_CALC:
					this.ct5.text = this.applicationLocale.T_UIE_T_M_CALC;
					break;
				case Multitool.ID_AOM_COORD:
					this.ct5.text = this.applicationLocale.T_UIE_T_M_COORD;
					break;
			}
		}

		//} ===== VIEW =====
		

		private var calculator:Calculator;
        private var calculatorMemory:CalculatorMemory
        private var calculatorView:VCCalculator;
        private var applicationLocale:LTextEnglish;
		
		private var applicationOperationMode:uint;
		
		/**
		 * application operation mode calculator
		 */
		public static const ID_AOM_CALC:uint = 1;
		/**
		 * coordinates
		 */
		public static const ID_AOM_COORD:uint = 2;
	}
}



import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

class Calculator {

	/**
	 * 
	 * @param	memory
	 * @param	er event receiver
	 * @param	calculatorView
	 */
	public function Calculator (memory:CalculatorMemory, er:Function, calculatorView:VCCalculator):void {
		this.memory = memory;
		this.calculatorView = calculatorView;
		this.er = er
		this.reset()
	}
	
	/**
	 * @return operation succeed
	 */
	public function perform():Boolean {t('perform:'+this.currentOperationSN)
		switch (this.currentOperationSN) {
			case Calculator.ID_OP_A: return this.add()
			case Calculator.ID_OP_S: return this.substract()
			case Calculator.ID_OP_M: return this.multiple()
			case Calculator.ID_OP_D: return this.devide()
		}
	}
	
	/**
	 * @return operation succeed
	 */
	public function add():Boolean {
		if (this.operand1 === 0 || this.operand2 === 0) return
		this.result = this.operand1 + this.operand2;
		this.operationPerformed = true;
		return true;
	}
	public function substract():Boolean {
		if (this.operand1 === 0 || this.operand2 === 0) return
		this.result = this.operand1 - this.operand2;
		this.operationPerformed = true;
		return true;
	}

	
	public function multiple():Boolean {
		if (this.operand1 === 0 || this.operand2 === 0) return
		this.result = this.operand1 * this.operand2;
		this.operationPerformed = true;
		return true;
	}
	
	public function devide():Boolean {
		if (this.operand1 === 0 || this.operand2 === 0) return
		this.result = this.operand1 / this.operand2;
		this.operationPerformed = true;
		return true;
	}

	public function addDigit(v:Number):void {
		
		if (this.operationPerformed) this.afterOperationPerformed()
		
	    switch (this.currentOperandSN) {
	        case Calculator.ID_OPERAND_1:
				if (this.operand1 === 0) this.operand1 = 0
	            this.operand1 = Number(this.operand1 + "" + v);
	            this.calculatorView.set_operand1Value(this.operand1)
	            break
	        case Calculator.ID_OPERAND_2:
				if (this.operand2 === 0) this.operand2 = 0
	            this.operand2 = Number(this.operand2 + "" + v);
				this.calculatorView.set_operand2Value(this.operand2)
	            break
	    }
		
    }
	
	private function afterOperationPerformed():void {
		this.reset()
		this.operationPerformed = false
		this.calculatorView.reset()
		this.calculatorView.refreshDisplay()
	}

		
	/**
	 * @return operation performed
	 */
	public function storeResultIntoMemory():Boolean {
		if (this.result === 0) this.memory.store(this.operand1);
		if (this.result !== 0) this.memory.store(this.result);
		this.calculatorView.set_memoryOccupied(true)
		return true
	}
	
	public function loadResultFromMemory():void {
		
		if (this.operationPerformed) this.afterOperationPerformed()
		
		switch (this.currentOperandSN) {
	        case Calculator.ID_OPERAND_1:
				this.operand1 = this.memory.read()
				this.calculatorView.set_operand1Value(this.operand1)
	            break
	        case Calculator.ID_OPERAND_2:
				this.operand2 = this.memory.read()
				this.calculatorView.set_operand2Value(this.operand2)
	            break
	    }
	}
	
	public function reset():void {
		this.result = 0;
		this.operand1 = 0;
		this.operand2 = 0;
		this.calculatorView.refreshMemoryIndicatorState(false)
		this.calculatorView.reset()
		this.currentOperandSN = Calculator.ID_OPERAND_1
		this.er(Calculator.ID_E_RESET)
	}
	
	public function g_result():Number {
    	if (this.result === 0) this.result = 0
		return this.result;
    }

	
	public static const ID_OPERAND_1:uint = 0
	public static const ID_OPERAND_2:uint = 1

	
	public var operand1:Number;
	public var operand2:Number;
	
	
	private var operationPerformed:Boolean;
	
	/**
	 * @param v ID_OPERAND_1 ID_OPERAND_2
	 */
	public function s_currentOperandSN(v:uint):void {
		this.currentOperandSN = v
		t('s_currentOperandSN=' + this.currentOperandSN)
	}
		
    /**
     *
     */
	private var currentOperandSN:uint;
	

	/**
	 * @param v ID_OP_A ID_OP_S ID_OP_M ID_OP_D
	 */
	public function s_currentOperationSN(v:uint):void {t('s_currentOperationSN: ' + v);
		this.currentOperationSN = v
	}
	
	/**
	 * operation add
	 */
	public static const ID_OP_A:uint = 1
	public static const ID_OP_S:uint = 2
	public static const ID_OP_M:uint = 3
	public static const ID_OP_D:uint = 4
	
	private var currentOperationSN:uint;

	
	private var result:Number;
	
	private var memory:CalculatorMemory = null;
	
	private var calculatorView:VCCalculator = null;
	
	public static const ID_E_RESET:uint = 1;
	
	private var er:Function = null;
	
}




class DegreeTool {

	/**
	 * 
	 * @param	memory
	 * @param	er event receiver
	 * @param	calculatorView
	 */
	public function DegreeTool (er:Function, degreeToolView:MovieClip):void {
		this.degreeToolView = degreeToolView;
		this.er = er
	}
	
	public function addDigit(v:Number):void {
		
	    switch (this.currentAxisID) {
	        case DegreeTool.ID_AXIS_X:
				this.x = Number(this.x+ "" + v);
	            break
	        case DegreeTool.ID_AXIS_Y:
				this.y = Number(this.y+ "" + v);
	            break
	    }
		
    }
		
	public function reset():void {
		this.x = 0;
		this.y = 0;
	}
		
	public static const ID_AXIS_X:uint = 1
	public static const ID_AXIS_Y:uint = 2

	
	public var x:int = 0;
	public var y:int = 0;
	
	/**
	 * @param v ID_OPERAND_1 ID_OPERAND_2
	 */
	public function s_currentAxisID(v:uint):void {
		this.currentOperandSN = v
		t('s_currentOperandSN=' + this.currentOperandSN)
	}
		
    /**
     *
     */
	private var currentAxisID:uint;
	
	
	private var degreeToolView:MovieClip = null;
	
	private var er:Function = null;
	
}


class CalculatorMemory {
	
	public function store(number:Number):void {
		this.number1 = number;
	}
	
	public function read():Number {
		return this.number1;
	}
	
	
	private var number1:Number = 0;
}


dynamic class VCCalculator extends flash.display.Sprite {
	
	
	/**
	 * @param el event listener ex: function(actionSN:uint):void
	*/
	public function VCCalculator(uiLib:DisplayObject, lText:Locale, el:Function):void {
		this.ui = uiLib;
		this.el = el;
		this.lText = lText;
	}
	
	public function refreshMemoryIndicatorState(a:Boolean):void {
		this.ui.i1.visible = a
	}
	
	///{ START ---------------------------------------------------

	/**
	 * @returns operation succeed
	*/
	public function prepare():Boolean {
		this.ui.ip1.visible = false
		this.setUIElementsLocale()

        for (var i1:uint = 0; i1 < this.ui.numChildren; i1 += 1) {
            var do_:DisplayObject = this.ui.getChildAt(i1);
            if (!(do_ is DisplayObjectContainer)) continue;

            for (var i2:uint = 0; i2 < do_.numChildren; i2 += 1) {
                if (!(do_.getChildAt(i2) is InteractiveObject)) continue;
                do_.getChildAt(i2).mouseEnabled = false;
            }
        }

	    this.ui.addEventListener(MouseEvent.MOUSE_DOWN, this.el_mouseDown);
		return true;
	}
	
	private function el_mouseDown(e:Event):void {
		
		switch (e.target.name) {
		
			case "b1"://digit 1
				this.el(VCCalculator.ID_E_DE_D_1)
				break;

			case "b2"://digit 2
				this.el(VCCalculator.ID_E_DE_D_2)
				break;

			case "b3"://digit 3
				this.el(VCCalculator.ID_E_DE_D_3)
				break;

			case "b4"://digit 4
				this.el(VCCalculator.ID_E_DE_D_4)
				break;

			case "b5"://digit 5
				this.el(VCCalculator.ID_E_DE_D_5)
				break;

			case "b6"://digit 6
				this.el(VCCalculator.ID_E_DE_D_6)
				break;

			case "b7"://digit 7
				this.el(VCCalculator.ID_E_DE_D_7)
				break;

			case "b8"://digit 8
				this.el(VCCalculator.ID_E_DE_D_8)
				break;

			case "b9"://digit 9
				this.el(VCCalculator.ID_E_DE_D_9)
				break;

			case "b10"://digit 10
				this.el(VCCalculator.ID_E_DE_D_0)
				break;


			case "b13"://memory put
				this.el(VCCalculator.ID_E_MO_P)
				break;

			case "b14"://memory get
				this.el(VCCalculator.ID_E_MO_G)
				break;
				

			case "b11"://reset
				this.reset()
				this.el(VCCalculator.ID_E_RESET)
				break;

			case "b12"://perform
				this.operationPerformed = true
				this.el(VCCalculator.ID_E_PERFORM)
				break;
				

			case "b17"://operation addition
				this.el(VCCalculator.ID_E_AO_A)
				break;

			case "b18"://operation substraction
				this.el(VCCalculator.ID_E_AO_S)
				break;
				
			case "b15"://operation multiplication
				this.el(VCCalculator.ID_E_AO_M)
				break;

			case "b16"://operation division
				this.el(VCCalculator.ID_E_AO_D)
				break;
			
			case "b1000"://operation switch mode
				this.el(VCCalculator.ID_E_SWITCH_MODE)
				break;
				
			case "b10000"://display developer ID
				this.el(VCCalculator.ID_E_DISPLAY_DEVELOPER_ID)
				break;
		}

	}

	private var el:Function = null;

	
	/**
	 * event - action digit entered
	*/
	public static const ID_E_DE_D_1:uint = 1;
	public static const ID_E_DE_D_2:uint = 2;
	public static const ID_E_DE_D_3:uint = 3;
	public static const ID_E_DE_D_4:uint = 4;
	public static const ID_E_DE_D_5:uint = 5;
	public static const ID_E_DE_D_6:uint = 6;
	public static const ID_E_DE_D_7:uint = 7;
	public static const ID_E_DE_D_8:uint = 8;
	public static const ID_E_DE_D_9:uint = 9;
	public static const ID_E_DE_D_0:uint = 10;

	/**
	 * event - action arithmethic operation addition
	*/
	public static const ID_E_AO_A:uint = 101;
	public static const ID_E_AO_S:uint = 102;
	public static const ID_E_AO_M:uint = 103;
	public static const ID_E_AO_D:uint = 104;
	
	
	/**
	 * event - action memory operation put
	*/
	public static const ID_E_MO_P:uint = 201;
	public static const ID_E_MO_G:uint = 202;
	
	
	/**
	 * event - action reset
	*/
	public static const ID_E_RESET:uint = 301;

	/**
	 * event - action perform
	*/
	public static const ID_E_PERFORM:uint = 302;
	
	/**
	 * event - action switch mode
	*/
	public static const ID_E_SWITCH_MODE:uint = 401;
	
	/**
	 * event - action display developer ID
	*/
	public static const ID_E_DISPLAY_DEVELOPER_ID:uint = 1001;
	

	///} END ---------------------------------------------------




	///} END ---------------------------------------------------

	public function set_operand1Value(a:Number):void {
	    this.operand1 = a
		this.refreshDisplay()
	}
	public function set_operand2Value(a:Number):void {
	    this.operand2 = a
		this.refreshDisplay()
	}
	public function set_resultValue(a:Number):void {
	    this.result = a
		this.refreshDisplay()
	}
	public function set_memoryOccupied(v:Boolean):void {
		this.memoryOccupied = v
	}
	
	/**
	 * ID_E_AO_A / ID_E_AO_S / ID_E_AO_M / ID_E_AO_D
	 */
	public function set_operationSN(a:uint):void {
		this.operationSpecified = true
	    this.operationSN = a
		this.refreshDisplay()
	}
	public function reset():void {
		this.operationSpecified = false
		this.operationPerformed = false
		this.operand1 = ""
		this.operand2 = ""
		this.result = ""
	}

	public function refreshDisplay():void {
		this.ui.ct1.text = this.operand1
		this.ui.ct2.text = this.operand2
		this.ui.ct4.text = this.result
		this.refreshMemoryIndicatorState(this.memoryOccupied)
		if (this.operationSpecified) {
			switch (this.operationSN) {
				case VCCalculator.ID_E_AO_A: this.ui.ct3.text = " + "; break;
				case VCCalculator.ID_E_AO_S: this.ui.ct3.text = " - "; break;
				case VCCalculator.ID_E_AO_M: this.ui.ct3.text = " * "; break;
				case VCCalculator.ID_E_AO_D: this.ui.ct3.text = " / "; break;
			}
		} else {
			this.ui.ct3.text = "";
		}
    }
	public function displayDeveloperID():void {
		this.ui.ip1.visible = !this.ui.ip1.visible 
	}

	private var operand1:String = "";
	private var operand2:String = "";
	private var result:String = "";

	private var operationSN:uint;
	private static const SN_OPERATION_ADDITION:uint = 0;
	private static const SN_OPERATION_SUBSTRUCTION:uint = 1;
	private static const SN_OPERATION_MULTIPLICATION:uint = 2;
	private static const SN_OPERATION_DIVISION:uint = 3;
	private var operationSpecified:Boolean;
	private var operationPerformed:Boolean;

	private var memoryOccupied:Boolean;


	///{ END ---------------------------------------------------

	
	

	
	
	///} START -------------------------------------------------

	///} END -------------------------------------------------
	

    ///{ -----------------------------------------------------
    private function setUIElementsLocale():void {
        this.ui.b1.ct1.text = this.lText.T_UIE_B_D_1
        this.ui.b2.ct1.text = this.lText.T_UIE_B_D_2
        this.ui.b3.ct1.text = this.lText.T_UIE_B_D_3
        this.ui.b4.ct1.text = this.lText.T_UIE_B_D_4
        this.ui.b5.ct1.text = this.lText.T_UIE_B_D_5
        this.ui.b6.ct1.text = this.lText.T_UIE_B_D_6
        this.ui.b7.ct1.text = this.lText.T_UIE_B_D_7
        this.ui.b8.ct1.text = this.lText.T_UIE_B_D_8
        this.ui.b9.ct1.text = this.lText.T_UIE_B_D_9
        this.ui.b10.ct1.text = this.lText.T_UIE_B_D_0

        this.ui.b13.ct1.text = this.lText.T_UIE_B_O_MP
        this.ui.b14.ct1.text = this.lText.T_UIE_B_O_MG

        this.ui.b12.ct1.text = this.lText.T_UIE_B_O_P
        this.ui.b11.ct1.text = this.lText.T_UIE_B_O_R

        this.ui.b17.ct1.text = this.lText.T_UIE_B_O_A
        this.ui.b18.ct1.text = this.lText.T_UIE_B_O_S
        this.ui.b15.ct1.text = this.lText.T_UIE_B_O_M
        this.ui.b16.ct1.text = this.lText.T_UIE_B_O_D
		
        this.ui.b1000.ct1.text = this.lText.T_UIE_B_O_SM
		
        this.ui.b10000.ct1.text = this.lText.T_UIE_B_O_DEVELOPER

    }
    ///] -----------------------------------------------------

	private var ui:DisplayObject
	private var lText:Locale
}


class Locale {

    	/**
         * text for the user interface element
        */
        public var T_UIE_B_D_1:String
        public var T_UIE_B_D_2:String
        public var T_UIE_B_D_3:String
        public var T_UIE_B_D_4:String
        public var T_UIE_B_D_5:String
        public var T_UIE_B_D_6:String
        public var T_UIE_B_D_7:String
        public var T_UIE_B_D_8:String
        public var T_UIE_B_D_9:String
        public var T_UIE_B_D_0:String

        /**
         * operation addition
        */
        public var T_UIE_B_O_S:String
        public var T_UIE_B_O_M:String
        public var T_UIE_B_O_D:String
        public var T_UIE_B_O_A:String


        /**
         * operation put memory
        */
        public var T_UIE_B_O_MP:String
        public var T_UIE_B_O_MG:String


        /**
         * operation reset
        */
        public var T_UIE_B_O_R:String
        /**
         * operation perform
        */
        public var T_UIE_B_O_P:String
		
        /**
         * operation switch mode
        */
        public var T_UIE_B_O_SM:String
		
        public var T_UIE_B_O_DEVELOPER:String

        /**
         * mode calc
        */
        public var T_UIE_T_M_CALC:String
        /**
         * mode coordinates
        */
        public var T_UIE_T_M_COORD:String
}

class LTextEnglish extends Locale {

    public function LTextEnglish() {
        /**
   	     * text for the user interface element
   	    */
   	    this.T_UIE_B_D_1 = "1"
   	    this.T_UIE_B_D_2 = "2"
   	    this.T_UIE_B_D_3 = "3"
   	    this.T_UIE_B_D_4 = "4"
   	    this.T_UIE_B_D_2 = "2"
   	    this.T_UIE_B_D_6 = "6"
   	    this.T_UIE_B_D_7 = "7"
   	    this.T_UIE_B_D_5 = "5"
   	    this.T_UIE_B_D_8 = "8"
   	    this.T_UIE_B_D_9 = "9"
   	    this.T_UIE_B_D_0 = "0"
   	    /**
   	     * operation addition
   	    */
   	    this.T_UIE_B_O_A = "+"
   	    this.T_UIE_B_O_S = "-"
   	    this.T_UIE_B_O_M = "*"
   	    this.T_UIE_B_O_D = "/"
   	    /**
   	     * operation put into memory
   	    */
   	    this.T_UIE_B_O_MP = "Mw"
   	    this.T_UIE_B_O_MG = "Mr"
   	    /**
   	     * operation reset
   	    */
   	    this.T_UIE_B_O_R = "R"
   	    /**
         * operation perform
        */
        this.T_UIE_B_O_P = "="
   	    /**
         * set mode
        */
        this.T_UIE_B_O_SM = "MODE"
        this.T_UIE_B_O_DEVELOPER = "DEVELOPER ID"
		
        /**
         * mode calc
        */
        this.T_UIE_T_M_CALC = "CALC"
        /**
         * mode coordinates
        */
        this.T_UIE_T_M_COORD = "COORD"
    }
}

//{ ==================================== SERVICE

    
function t(text:String):void {
	trace(text);
}

//} ==================================== SERVICE
