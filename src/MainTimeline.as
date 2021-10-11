package
{
	import flash.display.MovieClip;
	import flash.external.ExternalInterface;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public dynamic class MainTimeline extends MovieClip
	{
		// All the various input IDs this UI listens for, such as "IE UIAccept"
		public var events:Array;
		//A unique id for this UI.
		public var anchorId:String = "";
		public var alignment:String = "none";
		//fixed, fitVertical, fitHorizontal, fit, fill, fillVFit
		public var layout:String = "fillVFit";
		//center, top, topleft, etc
		public var anchorPos:String = "topleft";
		public var anchorTPos:String = "topleft";
		public var anchorTarget:String = "screen";
		public var uiScaling:Number = 1;
		//Set to whatever your stage resolution is. This is used to set uiScaling when the screen changes
		public var screenWidth:Number = 0;
		public var screenHeight:Number = 0;
		public const designResolution:Point = new Point(1920,1080);

		public var curTooltip:String = "";
	  	public var hasTooltip:Boolean = false;
		
		public function MainTimeline()
		{
			super();
			//The array of inputs to listen for. Must be separate entries like "IE UIAccept".
			this.events = new Array(); //new Array("IE UIAccept", "IE UICancel");
			//This function will be called when frame 0 happens, so this is typically like an "init" function.
			addFrameScript(0, this.frame1);
		}

		private function frame1() : void
		{
			
		}
		
		// When the game initializes this UI
		public function onEventInit() : void
		{
			ExternalInterface.call("registeranchorId", this.anchorId);
			//Determines how to anchor this UI to the screen.
			//The default values up top of fillVFit and topleft will make this UI stretch to always fit the screen size.
			ExternalInterface.call("setAnchor", this.anchorPos, this.anchorTarget, this.anchorTPos);
		}

		// When the UI is resized
		public function onEventResize() : void
		{
			ExternalInterface.call("setPosition", this.anchorPos, this.anchorTarget, this.anchorPos);
		}

		// When the screen resolution changes
		public function onEventResolution(w:Number, h:Number) : void
		{
			if(this.screenWidth != w || this.screenHeight != h)
			{
				ExternalInterface.call("setPosition", this.anchorPos, this.anchorTarget, this.anchorPos);
				this.screenWidth = w;
				this.screenHeight = h;
				this.uiScaling = h / this.designResolution.y;
			}
		}

		//When an input is released
		public function onEventUp(index:Number) : Boolean
		{
			//If isHandled is true, other UIs won't see this event.
			var isHandled:Boolean = false;
			/*
			switch(this.events[index])
			{
				case "IE UIAccept":
					isHandled = true;
					break;
				case "IE UICancel":
					isHandled = true;
					break;
			}
			*/
			return isHandled;
		}
		
		//When an input is pressed
		public function onEventDown(index:Number) : Boolean
		{
			//If isHandled is true, other UIs won't see this event. Use that to "consume" an input, like listening for UICancel to close/hide your UI.
			var isHandled:Boolean = false;
			/*
			switch(this.events[index])
			{
				case "IE UIAccept":
					isHandled = true;
					break;
				case "IE UICancel":
					isHandled = true;
					break;
			}
			*/
			return isHandled;
		}
	}
}