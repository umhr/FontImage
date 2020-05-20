package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * rgbに対応したbitmapを保持します。
	 * ...
	 * @author umhr
	 */
	public class ColorBitmapCollector 
	{
		
		private var _textSampleList:Vector.<Bitmap>;
		private var _rgbSeparatList:Vector.<Vector.<int>>;
		private var _indexFromRGBList:Vector.<int>;
		public function ColorBitmapCollector() 
		{
			init();
		}
		
		private function init():void 
		{
			// 色名、色番号に対応した画像を用意しておく
			var textField:TextField = new TextField();
			textField.defaultTextFormat = new TextFormat("_明朝", 18);
			textField.autoSize = "left";
			
			_textSampleList = new Vector.<Bitmap>();
			
			var japaneseColors:JapaneseColors = new JapaneseColors();
			
			var n:int = japaneseColors.colorNameList.length;
			_rgbSeparatList = new Vector.<Vector.<int>>(n, true);
			for (var i:int = 0; i < n; i++) 
			{
				textField.text = japaneseColors.colorNameList[i];
				textField.textColor = japaneseColors.textColorList[i];
				var bitmap:Bitmap = new Bitmap(new BitmapData(textField.textWidth, textField.textHeight + 3, true, 0x0));
				bitmap.bitmapData.draw(textField);
				_textSampleList.push(bitmap);
				_rgbSeparatList[i] = rgbSeparater(japaneseColors.textColorList[i]);
			}
			
			// 色(rgb)に対応した近似色のindexを保持しておくための処理
			_indexFromRGBList = new Vector.<int>(0xFFFFFF + 1, true);
			n = 0xFFFFFF + 1;
			for (i = 0; i < n; i++) 
			{
				_indexFromRGBList[i] = -1;
			}
		}
		
		/**
		 * 引数rgbに近似色のbitmapを返します。
		 * @param	rgb
		 * @return
		 */
		public function getNearBitmap(rgb:int):Bitmap {
			return _textSampleList[indexFromRGB(rgb)];
		}
		
		/**
		 * 色と色の距離を求める。相対的な値が欲しいだけなので、平方根は求めない。
		 * http://www40.atwiki.jp/spellbound/pages/293.html
		 * @param	rgbList
		 * @param	array
		 * @return
		 */
		private function getColotDistance(rgbList:Vector.<int>, array:Vector.<int>):Number 
		{
			var r:int = rgbList[0] - array[0];
			var g:int = rgbList[1] - array[1];
			var b:int = rgbList[2] - array[2];
			return r * r + g * g + b * b;
		}
		
		/**
		 * 色を分解して返す。
		 * @param	rgb
		 * @return
		 */
		private function rgbSeparater(rgb:int):Vector.<int> {
			return Vector.<int>([rgb >> 16 & 0xFF, rgb >> 8 & 0xFF, rgb & 0xFF]);
		}
		
		private var count:int = 0;
		private function indexFromRGB(rgb:int):int {
			var index:int = _indexFromRGBList[rgb];
			
			// 以前に近似色を探索し、該当indexを保持していればその値を返す。
			if ( -1 < index) {
				return index;
			}
			
			//　以前に近似色を探していない場合の処理。
			
			
			var rgbList:Vector.<int> = rgbSeparater(rgb);
			
			// すべての色と比較
			var n:int = _rgbSeparatList.length;
			var distanceList:Array = new Array(n);
			for (var i:int = 0; i < n; i++) 
			{
				distanceList[i] = getColotDistance(rgbList, _rgbSeparatList[i]);
			}
			
			// 一番近い距離の色を求める。
			index = distanceList.sort(Array.NUMERIC | Array.RETURNINDEXEDARRAY)[0];
			
			_indexFromRGBList[rgb] = index;
			
			count ++;
			if (count%1000 == 0) {
				trace("取得済みindex数:" + count);
			}
			
			return index;
		}
	}

}