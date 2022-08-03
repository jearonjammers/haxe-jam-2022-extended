package game.runner;

import flambe.display.Sprite;
import flambe.Entity;
import flambe.Component;

class Enemy extends Component {
	public function hits(x1:Float, y1:Float, x2:Float, y2:Float):Bool {
		return Sprite.hitTest(this._hittable, x1, y1) != null || Sprite.hitTest(this._hittable, x2, y2) != null;
	}

	private var _hittable:Entity;
	private var _other:Entity;
}
