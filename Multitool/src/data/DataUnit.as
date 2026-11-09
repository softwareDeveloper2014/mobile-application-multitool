class DataUnit {
	
	public function reset():void {
		
	}
	
	/**
     * inform about data update
     * @param dpid data part id
     */
    protected function iao(dpid:uint):void {
		if (!this._dopEll) return;
		
		for each (var listener:Function in this._dopEll) {
			this.listener(dpid);
		}
	}
		
	/**
     * listener list: operation performed on a data part
     */
    private var dopEll:Array = []
	
	
}

// Agents Framework
/**
     * data part updated
     * @param el function (dpid) //@param dpid data part id;
     */
    /*
	addNotificationReceiver(el) {
        this._dopEll.push(el);
    }
	
	notify(event:Event) +
	addNotificationReceiver +
	*/
	
	