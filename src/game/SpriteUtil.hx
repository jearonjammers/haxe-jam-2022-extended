package game;

import flambe.display.Sprite;
import flambe.math.Point;

class SpriteUtil {
	public static function localXY(sprite:Sprite, viewX:Float, viewY:Float):Point {
		var mat = sprite.getViewMatrix();
		if (!mat.inverseTransform(viewX, viewY, SPRITE_SCRATCH)) {
			SPRITE_SCRATCH.set(0, 0);
		}
		return SPRITE_SCRATCH;
	}

	public static function viewXY(sprite:Sprite, viewX:Float, viewY:Float):Point {
		sprite.getViewMatrix().transform(0, 0, SPRITE_SCRATCH);
		return SPRITE_SCRATCH;
	}

	private static var SPRITE_SCRATCH:Point = new Point();
}
