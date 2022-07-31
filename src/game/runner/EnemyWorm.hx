package game.runner;

import flambe.display.FillSprite;
import flambe.System;
import flambe.animation.Sine;
import flambe.math.Rectangle;
import flambe.display.Sprite;
import flambe.display.ImageSprite;
import flambe.asset.AssetPack;
import flambe.Entity;

class EnemyWorm extends Enemy {
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
		_elapsed += dt;
		if (_elapsed > 7) {
			this.owner.dispose();
		}
	}

	override public function hits(x:Float, y:Float, width:Float, height:Float):Bool {
		return Sprite.hitTest(this._root, x, y) != null;
	}

	private function init(pack:AssetPack, index:Int) {
		Audio.playSound_("sfx/runner/worm");
		var anchorX = 77;
		var anchorY = 230;
		var tex = pack.getTexture("runner/worm/worm");
		this._root = new Entity() //
			.addChild(_hittable = new Entity().add(new Sprite().setXY(_x, _y)) //
				.addChild(new Entity().add(new ImageSprite(pack.getTexture("runner/worm/wormHole")) //
					.centerAnchor())) //
				.addChild(new Entity() //
					.add(_clip = new Sprite()) //
					.addChild(new Entity().add(_worm = new ImageSprite(pack.getTexture("runner/worm/worm")) //
						.setXY(0, 20) //
						.setAnchor(anchorX, anchorY)))) //
				.addChild(new Entity().add(new ImageSprite(pack.getTexture("runner/worm/wormHoleClip")) //
					.setAnchor(128.5, -11)))) //
			.addChild(_instructions = new Entity().add(new Sprite().setXY(_x, _y))); //

		_clip.scissor = new Rectangle(-(anchorX + PADDING), -(anchorY + PADDING), tex.width + PADDING * 2, (tex.height + PADDING) - CLIP_LENGTH);

		// _worm.y.behavior = new Sine(0, 300, 2);
		_worm.rotation.behavior = new Sine(-15, 15, 1);

		if (index == 0) {
			// _instructions.addChild(new Entity().add(new ImageSprite(pack.getTexture("runner/instructJump")).setXY(-220, -470)));
		}
	}

	private var _x:Float;
	private var _y:Float;
	private var _root:Entity;
	private var _clip:Sprite;
	private var _worm:Sprite;
	private var _elapsed = 0.0;

	private static inline var PADDING = 60;
	private static inline var CLIP_LENGTH = 30;
}
