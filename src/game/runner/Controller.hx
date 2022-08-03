package game.runner;

import flambe.math.Point;
import flambe.input.PointerEvent;
import flambe.util.Value;
import flambe.input.KeyboardEvent;
import flambe.System;
import flambe.Disposer;
import flambe.Entity;
import flambe.Component;

using game.SpriteUtil;

class Controller extends Component {
	public var state:Value<ControlState>;

	public function new() {
		this.state = new Value(ControlState.Idle);
		this.init();
	}

	override function onAdded() {
		owner.addChild(this._root);
	}

	override function onRemoved() {
		owner.removeChild(this._root);
		_disposer.dispose();
	}

	override function onUpdate(dt:Float) {
		if (_isDown) {
			var dist = _down.distanceTo(System.pointer.x, System.pointer.y);
			if (dist > 50) {
				var angleDeg = Math.atan2(_down.y - System.pointer.y, _down.x - System.pointer.x) * 180 / Math.PI;
				var normDeg = MathUtil.normDegrees(angleDeg);
				if (isUp(normDeg)) {
					this.state._ = Up;
				}
				else if(isDown(normDeg)) {
					this.state._ = Down;
				}
				else if(isRight(normDeg)) {
					this.state._ = Right;
				}
				this._isDown = false;
			}
		}
	}

	private static inline function isUp(deg:Float):Bool {
		return (deg > 40 && deg < 140);
	}

	private static inline function isDown(deg:Float):Bool {
		return (deg > 220 && deg < 320);
	}

	private static inline function isRight(deg:Float):Bool {
		return (deg > 130 && deg < 230);
	}

	private function onkeyUp(e:KeyboardEvent):Void {
		this.state._ = Idle;
	}

	private function onkeyDown(e:KeyboardEvent):Void {
		switch e.key {
			case Up:
				this.state._ = Up;
			case Down:
				this.state._ = Down;
			case Right:
				this.state._ = Right;
			case Space:
				this.state._ = Space;
			case _:
		}
	}

	private function onPointerUp(e:PointerEvent):Void {
		this.state._ = Idle;
		_isDown = false;
	}

	private function onPointerDown(e:PointerEvent):Void {
		if (this.state._ != Space) {
			this.state._ = Space;
			_down.x = e.viewX;
			_down.y = e.viewY;
			_isDown = true;
		}
	}

	private function onPointerMove(e:PointerEvent):Void {
		this._viewX = e.viewX;
		this._viewY = e.viewY;
	}

	private function init() {
		this._root = new Entity();
		_disposer = new Disposer();
		_disposer.add(System.keyboard.down.connect(onkeyDown));
		_disposer.add(System.keyboard.up.connect(onkeyUp));
		_disposer.add(System.pointer.down.connect(onPointerDown));
		_disposer.add(System.pointer.up.connect(onPointerUp));
		_disposer.add(System.pointer.move.connect(onPointerMove));
	}

	private var _root:Entity;
	private var _disposer:Disposer;
	private var _downElapsed:Float = 0.0;
	private var _viewX:Float = 0.0;
	private var _viewY:Float = 0.0;
	private var _down = new Point();
	private var _isDown:Bool = false;
}
