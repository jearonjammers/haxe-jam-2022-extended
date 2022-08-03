package game;

import flambe.sound.Playback;
import flambe.System;
import flambe.sound.Sound;
import flambe.sound.Mixer;
import flambe.Component;
import flambe.asset.AssetPack;
import flambe.Entity;

class Audio extends Component {
	private static var _hasAudio = false;

	public static function make(pack:AssetPack):Void {
		if (!_hasAudio) {
			System.root.add(new Audio(pack));
			_hasAudio = true;
		}
	}

	public static function playTitle_():Void {
		System.root.get(Audio).playTitle();
	}

	public static function playMain_():Void {
		System.root.get(Audio).playMain();
	}

	public static function playChug_():Void {
		System.root.get(Audio).playChug();
	}

	public static function playSplash_():Void {
		System.root.get(Audio).playSplash();
	}

	public static function stop_():Void {
		System.root.get(Audio).stop();
	}

	public static function stopMixer_():Void {
		System.root.get(Audio).stopMixer();
	}

	public static function stopDrink_():Void {
		System.root.get(Audio).stopDrink();
	}

	public static function playSound_(name:String):Void {
		System.root.get(Audio).playSound(name);
	}

	public function new(pack:AssetPack) {
		_pack = pack;
		this.init();
	}

	override public function onAdded() {
		this.owner.addChild(this._root);
	}

	private function init() {
		_madeSounds = new Map<String, Sound>();
		this._root = new Entity();
		this._root.add(_mixer = new Mixer());
	}

	public function playTitle():Void {
		this.stop();
		_bg = _pack.getSound("sfx/title").loop();
	}

	public function playMain():Void {
		this.stop();
		_bg = _pack.getSound("sfx/main").loop();
	}

	public function stop():Void {
		if (_bg != null) {
			_bg.dispose();
			_bg = null;
		}
	}

	public function stopDrink():Void {
		if (_drink != null) {
			_drink.dispose();
			_drink = null;
		}
	}

	public function stopMixer():Void {
		_mixer.stopAll();
	}

	public function playChug():Void {
		this.stopDrink();
		_drink = _pack.getSound("sfx/cafe/chug").loop();
	}

	public function playSplash():Void {
		this.stopDrink();
		_drink = _pack.getSound("sfx/cafe/bottleSplash").loop();
	}

	public function playSound(name:String):Void {
		if (!_madeSounds.exists(name)) {
			var packSound = _pack.getSound(name);
			var mixerSound = this._mixer.createSound(packSound, 1);
			_madeSounds.set(name, mixerSound);
		}
		_madeSounds.get(name).play();
	}

	private var _root:Entity;
	private var _pack:AssetPack;
	private var _mixer:Mixer;
	private var _bg:Playback;
	private var _drink:Playback;
	private var _madeSounds:Map<String, Sound>;
}
