package game.runner;

import flambe.animation.Sine;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.asset.AssetPack;
import flambe.Entity;
import flambe.Component;

class PersonHead extends Component {
	public var sprite:Sprite;

	public function new(pack:AssetPack) {
		this.init(pack);
	}

	override function onAdded() {
		owner.addChild(this._root);
	}

	override function onRemoved() {
		owner.removeChild(this._root);
	}

	private function init(pack:AssetPack) {
		this._root = new Entity() //
			.add(sprite = new ImageSprite(pack.getTexture("runner/body/head")) //
				.setXY(0, -96) //
				.setAnchor(63, 148)); //
	}

	public function move(type:PersonMoveType, time:Float) {
		switch type {
			case Jump:
				sprite.rotation.behavior = new Sine(-40, -30, time * 2);
			case Crouch:
				sprite.rotation.behavior = new Sine(-34, -4, time / 2);
			case Walk:
				sprite.rotation.behavior = new Sine(-13, -4, time / 2);
			case Surf:
				sprite.rotation.behavior = new Sine(4, -4, time);
			case Idle:
				sprite.rotation.behavior = new Sine(4, -4, time);
		}
	}

	private var _root:Entity;
}
