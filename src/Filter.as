package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	/**
	 * ブラーフィルターをかけて返します。
	 * ...
	 * @author umhr
	 */
	public class Filter 
	{
		private var _filerBitmap:Bitmap;
		private var _tempBitmapData:BitmapData;
		public function Filter(width:int, height:int) 
		{
			init(width, height);
		}
		
		private function init(width:int, height:int):void 
		{
			_filerBitmap = new Bitmap(new BitmapData(width, height));
			_filerBitmap.filters = [new BlurFilter(2, 2)];
			
			_tempBitmapData = new BitmapData(_filerBitmap.width, _filerBitmap.height)
		}
		
		/**
		 * ブラーフィルターをかけて返します。
		 * @param	bitmapData
		 * @return
		 */
		public function blurFilter(bitmapData:BitmapData):BitmapData {
			_filerBitmap.bitmapData = bitmapData;
			_tempBitmapData.draw(_filerBitmap);
			return _tempBitmapData;
		}
	}

}