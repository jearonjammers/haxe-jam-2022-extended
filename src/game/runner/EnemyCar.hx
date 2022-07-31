package game.runner;

import flambe.display.FillSprite;
import flambe.math.Rectangle;
import flambe.animation.Sine;
import flambe.display.Sprite;
import flambe.display.ImageSprite;
import flambe.asset.AssetPack;
import flambe.Entity;

class EnemyCar extends Enemy {
	public function new(pack:AssetPack, index:Int, x:Float, y:Float) {
		_x = x;
		_y = y;
		this.init(pack, index);
	}

	override function onAdded() {
		owner.addChild(this._root);
	}

	override function onRemoved() {
		owner.removeChild(this._root);
	}

	override function onUpdate(dt:Float) {
		this._root.get(Sprite).x._ -= 500 * dt;
		_elapsed += dt;
		if (_elapsed > 3) {
			this.owner.dispose();
		}
	}

	override public function hits(x:Float, y:Float):Bool {
		return _rect1.contains(x + _x - 30, y + _y) || _rect2.contains(x + _x - 30, y + _y);
	}

	private function init(pack:AssetPack, index:Int) {
		Audio.playSound_("sfx/runner/car");
		var car = new ImageSprite(pack.getTexture("runner/car/car"));
		var carEye = new ImageSprite(pack.getTexture("runner/car/carEye"));
		var carStar = new ImageSprite(pack.getTexture("runner/car/carStar"));
		var carWheel1 = new ImageSprite(pack.getTexture("runner/car/carWheel"));
		var carWheel2 = new ImageSprite(pack.getTexture("runner/car/carWheel"));
		this._root = new Entity() //
			.add(new Sprite().setAnchor(0, 30).setXY(_x, _y)) //
			.addChild(new Entity().add(car //
				.setAnchor(226, 220).setXY(0, 0))) //
			.addChild(new Entity().add(carEye //
				.setXY(-80, -94).setAnchor(34, 92))) //
			.addChild(new Entity().add(carStar //
				.setXY(25, -58) //
				.centerAnchor())) //
			.addChild(new Entity().add(carWheel1 //
				.setXY(-95, 0) //
				.centerAnchor())) //
			.addChild(new Entity().add(carWheel2 //
				.setXY(139, 0) //
				.centerAnchor())); //
		// .addChild(new Entity().add(new FillSprite(0xff0000, _rect2.width, _rect2.height).setXY(_rect2.x, _rect2.y).setAlpha(0.5))) //
		// .addChild(new Entity().add(new FillSprite(0xff0000, _rect1.width, _rect1.height).setXY(_rect1.x, _rect1.y).setAlpha(0.5))); //

		var time = 0.25;
		car.anchorY.behavior = new Sine(220, 210, time);
		car.rotation.behavior = new Sine(-3, 0, time);
		carEye.anchorY.behavior = new Sine(92, 82, time);
		carStar.anchorY.behavior = new Sine(34, 24, time);

		if (index == 0) {
			this._root.addChild(new Entity().add(new ImageSprite(pack.getTexture("runner/instructJump")).setXY(-220, -470)));
		}
	}

	private var _x:Float;
	private var _y:Float;
	private var _root:Entity;
	private var _elapsed = 0.0;

	public var _rect1:Rectangle = new Rectangle(-80, -170, 220, 80); // top
	public var _rect2:Rectangle = new Rectangle(-190, -90, 420, 100); // bottom
}
