package game.runner;

import flambe.display.FillSprite;
import flambe.animation.Sine;
import flambe.math.Rectangle;
import flambe.display.Sprite;
import flambe.display.ImageSprite;
import flambe.asset.AssetPack;
import flambe.Entity;

class EnemyBird extends Enemy {
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
		this._hittable.get(Sprite).x._ -= 400 * dt;
		this._instructions.get(Sprite).x._ -= 400 * dt;
		_elapsed += dt;
		if (_elapsed > 4) {
			this.owner.dispose();
		}
	}

	

	private function init(pack:AssetPack, index:Int) {
		Audio.playSound_("sfx/runner/bird");
		var anchorSprite = new Sprite();
		var birdFeet = new ImageSprite(pack.getTexture("runner/bird/birdFeet"));
		var birdBody = new ImageSprite(pack.getTexture("runner/bird/birdBody"));
		var birdWing = new ImageSprite(pack.getTexture("runner/bird/birdWing"));
		var birdHat = new ImageSprite(pack.getTexture("runner/bird/birdHat"));
		this._root = new Entity() //
			.addChild(_hittable = new Entity().add(new Sprite().setXY(_x, _y)) //
				.addChild(new Entity().add(anchorSprite = new Sprite()) //
					.addChild(new Entity().add(birdFeet //
						.setAnchor(8, 12).setXY(50, 50))) //
					.addChild(new Entity().add(birdBody //
						.setAnchor(266, 266))) //
					.addChild(new Entity().add(birdWing //
						.setXY(-18, 25) //
						.setAnchor(50, 22)))
					.addChild(new Entity().add(birdHat //
						.setXY(-30, -135) //
						.setAnchor(47, 230))))) //
			.addChild(_instructions = new Entity().add(new Sprite().setXY(_x, _y))); //

		birdFeet.rotation.behavior = new Sine(-15, 15, 0.5);
		anchorSprite.rotation.behavior = new Sine(-5, 5);
		birdHat.rotation.behavior = new Sine(30, -10, 5);
		birdWing.rotation.behavior = new Sine(30, -20, 0.5);

		if (index == 0) {
			// _instructions.addChild(new Entity().add(new ImageSprite(pack.getTexture("runner/instructCrouch")).setXY(-220, 100)));
		}
	}

	private var _x:Float;
	private var _y:Float;
	private var _root:Entity;
	private var _elapsed = 0.0;
}
