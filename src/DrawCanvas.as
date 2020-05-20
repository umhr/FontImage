package  
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author umhr
	 */
	public class DrawCanvas extends Sprite 
	{
		private var _bitmap:Bitmap;
		private var _colorBitmapCollector:ColorBitmapCollector = new ColorBitmapCollector();
		//private const FADE:ColorTransform = new ColorTransform(1, 1, 1, 1, 1, 1, 1);
		private var _filter:Filter;
		public function DrawCanvas() 
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
			
			_bitmap = new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight,true,0x0));
			addChild(_bitmap);
			
			_filter = new Filter(stage.stageWidth, stage.stageHeight);
			
		}
		public function enter():void {
			// ブラーをかける
			_bitmap.bitmapData = _filter.blurFilter(_bitmap.bitmapData);
			
			for (var i:int = 0; i < 100; i++) 
			{
				draw(_bitmap.bitmapData);
			}
		}
		
		private function draw(targetBitmapData:BitmapData):void {
			var tx:int = Math.random() * stage.stageWidth;
			var ty:int = Math.random() * stage.stageHeight;
			var rgb:uint = CameraManager.getInstance().getPixel(tx, ty);
			var bitmap:Bitmap = _colorBitmapCollector.getNearBitmap(rgb);
			
			targetBitmapData.draw(bitmap, new Matrix(1, 0, 0, 1, tx - bitmap.width * 0.5, ty - bitmap.height * 0.5));
			
		}
		
	}
	
}