package nxColor;

/**
 * Class for representing HSV color and associated useful functions.
 * @author NxT
 */
class HSV
{
	/**
	 * Hue: 0-360
	 */
	public var H:Float;
	
	/**
	 * Saturation: 0-100
	 */
	public var S:Float;
	
	/**
	 * Value: 0-100
	 */
	public var V:Float;
	
	/**
	 * Create a new HSV color.
	 * @param	H	Hue, ranges from 0 to 360
	 * @param	S	Saturation, ranges from 0 to 100
	 * @param	V	Value, ranges from 0 to 100
	 */
	public function new(H:Float, S:Float, V:Float) 
	{
		this.H = H;
		this.S = S;
		this.V = V;
	}
	
	/**
	 * Convert this color to the RGB color space.
	 * @return	New RGB color.
	 */
	public function toRGB():RGB
	{
		var H:Float = this.H / 360;
		var S:Float = this.S / 100;
		var V:Float = this.V / 100;
		var R:Float;
		var G:Float;
		var B:Float;
		var hVar:Float, iVar:Float, var1:Float, var2:Float, var3:Float, rVar:Float, gVar:Float, bVar:Float;
		
		if (S == 0) 
		{
			R = V * 255;
			G = V * 255;
			B = V * 255;
		}
		else 
		{
			hVar = H * 6;
			iVar = Math.floor(hVar);
			var1 = V * (1 - S);
			var2 = V * (1 - S * (hVar - iVar));
			var3 = V * (1 - S * (1 - (hVar - iVar)));

			if (iVar == 0) { rVar = V; gVar = var3; bVar = var1; }
			else if (iVar == 1) { rVar = var2; gVar = V; bVar = var1; }
			else if (iVar == 2) { rVar = var1; gVar = V; bVar = var3; }
			else if (iVar == 3) { rVar = var1; gVar = var2; bVar = V; }
			else if (iVar == 4) { rVar = var3; gVar = var1; bVar = V; }
			else { rVar = V; gVar = var1; bVar = var2; };

			R = rVar * 255;
			G = gVar * 255;
			B = bVar * 255;
		}
		return new RGB(R, G, B);
	}

	/**
	 * Convert this color to the XYZ color space.
	 * @return	New XYZ color.
	 */
	public function toXYZ():XYZ
	{
		return this.toRGB().toXYZ();
	}
	
	/**
	 * Convert this color to the CIELch color space.
	 * @return	New CIELch color.
	 */
	public function toCIELch():CIELch
	{
		return this.toRGB().toCIELch();
	}
	
	/**
	 * Convert this color to the CIELab color space.
	 * @return	New CIELab color.
	 */
	public function toCIELab():CIELab
	{
		return this.toRGB().toCIELab();
	}
	
	/**
	 * Function which blends between two colors, including original and target.
	 * @param	n	Total number of steps.
	 * @param	target	Color to blend towards.
	 * @return	Array containing blend.
	 */
	public function blend(n:Int, target:HSV):Array<HSV>
	{
		n--;
		var a = new Array<HSV>();
		var DiffH = (1 / n) * (target.H - this.H);
		var DiffS = (1 / n) * (target.S - this.S);
		var DiffV = (1 / n) * (target.V - this.V);
		
		for (i in 0...n)
		{
			a.push(new HSV(this.H + (i * DiffH), this.S + (i * DiffS), this.V + (i * DiffV)));
		}
		a.push(target);
		
		return a;
	}
	
	/**
	 * Convert this color to a hex int.
	 * Useful for libraries like HaxeFlixel.
	 * @return	Int in the form 0xAARRGGBB.
	 */
	public function toNumber():Int
	{
		return this.toRGB().toNumber();
	}
	
	public function saturate(amount:Float):HSV
	{
		var x = this.S + amount;
		if (x > 100) { x = 100; }
		return new HSV(this.H, x, this.V);
	}
	
}