import flash.display.DisplayObject
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip

class CalculatorView class VCCalculator1 extends flash.display.MovieClip {
	
	/**
	 * @param ui
	 * @param el event listener ex: function(actionSN:uint):void
	*/
	public function VCCalculator1(ui:DisplayObject, lText:Locale, el:Function):void {
		this.ui = ui;
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
				this.el(VCCalculator1.ID_E_DE_D_1)
				break;

			case "b2"://digit 2
				this.el(VCCalculator1.ID_E_DE_D_2)
				break;

			case "b3"://digit 3
				this.el(VCCalculator1.ID_E_DE_D_3)
				break;

			case "b4"://digit 4
				this.el(VCCalculator1.ID_E_DE_D_4)
				break;

			case "b5"://digit 5
				this.el(VCCalculator1.ID_E_DE_D_5)
				break;

			case "b6"://digit 6
				this.el(VCCalculator1.ID_E_DE_D_6)
				break;

			case "b7"://digit 7
				this.el(VCCalculator1.ID_E_DE_D_7)
				break;

			case "b8"://digit 8
				this.el(VCCalculator1.ID_E_DE_D_8)
				break;

			case "b9"://digit 9
				this.el(VCCalculator1.ID_E_DE_D_9)
				break;

			case "b10"://digit 10
				this.el(VCCalculator1.ID_E_DE_D_0)
				break;


			case "b13"://memory put
				this.el(VCCalculator1.ID_E_MO_P)
				break;

			case "b14"://memory get
				this.el(VCCalculator1.ID_E_MO_G)
				break;
				

			case "b11"://reset
				this.reset()
				this.el(VCCalculator1.ID_E_RESET)
				break;

			case "b12"://perform
				this.el(VCCalculator1.ID_E_PERFORM)
				this.operationPerformed = true
				break;
				

			case "b17"://operation addition
				this.el(VCCalculator1.ID_E_AO_A)
				break;

			case "b18"://operation substraction
				this.el(VCCalculator1.ID_E_AO_S)
				break;
				
			case "b15"://operation multiplication
				this.el(VCCalculator1.ID_E_AO_M)
				break;

			case "b16"://operation division
				this.el(VCCalculator1.ID_E_AO_D)
				break;
		}

	}

	private var el:Function = null;

	
	/**
	 * action digit entered
	*/
	public static const ID_E_DE_D_1:uint = 0;
	public static const ID_E_DE_D_2:uint = 1;
	public static const ID_E_DE_D_3:uint = 2;
	public static const ID_E_DE_D_4:uint = 3;
	public static const ID_E_DE_D_5:uint = 4;
	public static const ID_E_DE_D_6:uint = 5;
	public static const ID_E_DE_D_7:uint = 6;
	public static const ID_E_DE_D_8:uint = 7;
	public static const ID_E_DE_D_9:uint = 8;
	public static const ID_E_DE_D_0:uint = 9;

	/**
	 * action arithmethic operation addition
	*/
	public static const ID_E_AO_A:uint = 100;
	public static const ID_E_AO_S:uint = 101;
	public static const ID_E_AO_M:uint = 102;
	public static const ID_E_AO_D:uint = 103;
	
	
	/**
	 * action memory operation put
	*/
	public static const ID_E_MO_P:uint = 200;
	public static const ID_E_MO_G:uint = 201;
	
	
	/**
	 * action reset
	*/
	public static const ID_E_RESET:uint = 301;

	/**
	 * action perform
	*/
	public static const ID_E_PERFORM:uint = 302;
	

	///} END ---------------------------------------------------




	///} END ---------------------------------------------------

	public function set_operand1Value(a:int):void {
	    this.operand1 = a
		this.refreshDisplay()
	}
	public function set_operand2Value(a:int):void {
	    this.operand2 = a
		this.refreshDisplay()
	}
	/**
	 * ID_E_AO_A / ID_E_AO_S / ID_E_AO_M / ID_E_AO_D
	 */
	public function set_operationSN(a:uint):void {
		this.operationSpecified = true
	    this.operationSN = a
		this.refreshDisplay()
	}
	public function reset() {
		this.operationSpecified = false
	}

	public function refreshDisplay():void {
		this.ui.ct1.text = this.operand1
		if (this.operationSpecified) {
			switch (this.operationSN) {
				case VCCalculator1.ID_E_AO_A: this.ui.ct1.text = this.ui.ct1.text + " + "; break;
				case VCCalculator1.ID_E_AO_S: this.ui.ct1.text = this.ui.ct1.text + " - "; break;
				case VCCalculator1.ID_E_AO_M: this.ui.ct1.text = this.ui.ct1.text + " + "; break;
				case VCCalculator1.ID_E_AO_D: this.ui.ct1.text = this.ui.ct1.text + " / "; break;
			}
	
			this.ui.ct1.text = this.ui.ct1.text + "" + this.operand2
		
			if (this.operationPerformed) this.ui.ct1.text = this.ui.ct1.text + "" + this.result
		}
		
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

	/**
	 * user interface element
	*/
	public static const SN_UIE_B_D_1:uint = 0;
	public static const SN_UIE_B_D_2:uint = 1;
	public static const SN_UIE_B_D_3:uint = 2;
	public static const SN_UIE_B_D_4:uint = 3;
	public static const SN_UIE_B_D_5:uint = 4;
	public static const SN_UIE_B_D_6:uint = 5;
	public static const SN_UIE_B_D_7:uint = 6;
	public static const SN_UIE_B_D_8:uint = 7;
	public static const SN_UIE_B_D_9:uint = 8;
	public static const SN_UIE_B_D_0:uint = 9;

	/**
	 * operation addition
	*/
	public static const SN_UIE_B_O_A:uint = 100;
	public static const SN_UIE_B_O_S:uint = 101;
	public static const SN_UIE_B_O_M:uint = 102;
	public static const SN_UIE_B_O_D:uint = 103;
	
	
	/**
	 * operation put memory
	*/
	public static const SN_UIE_B_O_MP:uint = 200;
	public static const SN_UIE_B_O_MG:uint = 201;
	
	
	/**
	 * operation reset
	*/
	public static const SN_UIE_B_OR:uint = 301;
	
	///} END -------------------------------------------------
	

    ///{ -----------------------------------------------------
    private function setUIElementsLocale() {
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

    }
    ///] -----------------------------------------------------

	private var ui:MovieClip
	private var lText:Locale
}
