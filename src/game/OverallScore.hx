package game;

import flambe.util.Value;
import flambe.Component;

class OverallScore extends Component {
	public var scoreFirst:Value<Int>;
	public var scoreSecond:Value<Int>;
	public var currentScore(get, null):String;
	public var bestScore(get, null):String;

	public function new() {
		this.init();
	}

	public function resetFirst():Void {
		this.scoreFirst._ = 0;
	}

	public function resetSecond():Void {
		this.scoreSecond._ = 0;
	}

	public function tally():Void {
		var s = this.scoreFirst._ + this.scoreSecond._;
		if (s > this._bestScore) {
			this._bestScore = s;
		}
	}

	private function get_currentScore():String {
		return formatScore(this.scoreFirst._ + this.scoreSecond._);
	}

	private function get_bestScore():String {
		return formatScore(this._bestScore);
	}

	private function formatScore(score:Int):String {
		if (score < 10) {
			return "00" + score;
		} else if (score < 100) {
			return "0" + score;
		} else {
			return "" + score;
		}
	}

	private function init() {
		this.scoreFirst = new Value(0);
		this.scoreSecond = new Value(0);
	}

	private var _bestScore:Int = 0;
}
