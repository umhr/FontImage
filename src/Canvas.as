package  
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author umhr
	 */
	public class Canvas extends Sprite 
	{
		private var _drawCanvas:DrawCanvas = new DrawCanvas();
		private var _cameraManager:CameraManager = CameraManager.getInstance();
		public function Canvas() 
		{
			init();
		}
		private function init():void 
		{
            if (stage) onInit();
            else addEventListener(Event.ADDED_TO_STAGE, onInit);
        }
        
        private function onInit(event:Event = null):void 
        {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			addChild(_cameraManager);
			
			addChild(_drawCanvas);
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void 
		{
			if (!_cameraManager.activating) {
				return;
			}
			_drawCanvas.enter();
			_cameraManager.enter();
		}
	}
	
}