package game.score;

import flambe.display.TextSprite;
import flambe.display.Font;
import flambe.display.Sprite;
import flambe.animation.Sine;
import flambe.animation.Ease;
import game.cafe.CafeGame;
import flambe.System;
import flambe.display.ImageSprite;
import flambe.display.FillSprite;
import flambe.asset.AssetPack;
import flambe.Entity;
import flambe.Component;

class ScoreGame extends Component {
	public function new(pack:AssetPack, width:Float, height:Float) {
		this.init(pack, width, height);
	}

	override function onAdded() {
		owner.addChild(this._root);
	}

	override function onRemoved() {
		owner.removeChild(this._root);
	}

	private function init(pack:AssetPack, width:Float, height:Float) {
		Audio.stop_();
		Audio.playSound_("sfx/win");
		var score = System.root.get(OverallScore);
		var font = new Font(pack, "testfont");
		score.tally();

		var x = width / 2;
		var scoreTop:Sprite;
		var scoreBottom:Sprite;
		var cloud1:Sprite;
		var cloud2:Sprite;
		var cloud3:Sprite;
		var cloud4:Sprite;
		var cloud5:Sprite;
		var cloud6:Sprite;
		this._root = new Entity() //
			.add(new FillSprite(0xacdde5, width, height)) //
			.addChild(new Entity().add(cloud1 = new ImageSprite(pack.getTexture("cloud")) //
				.setScale(0.9) //
				.setXY(10, 280) //
				.centerAnchor()))
			.addChild(new Entity().add(cloud2 = new ImageSprite(pack.getTexture("cloud")) //
				.setScale(0.7) //
				.setXY(1800, 180) //
				.centerAnchor()))
			.addChild(new Entity().add(cloud3 = new ImageSprite(pack.getTexture("cloud")) //
				.setScale(1) //
				.setXY(400, 780) //
				.centerAnchor()))
			.addChild(new Entity().add(cloud4 = new ImageSprite(pack.getTexture("cloud")) //
				.setScale(0.6) //
				.setXY(1220, 80) //
				.centerAnchor()))
			.addChild(new Entity().add(cloud5 = new ImageSprite(pack.getTexture("cloud")) //
				.setScale(0.7) //
				.setXY(1000, 280) //
				.centerAnchor()))
			.addChild(new Entity().add(cloud6 = new ImageSprite(pack.getTexture("cloud")) //
				.setScale(0.8) //
				.setXY(1800, 880) //
				.centerAnchor()))
			.addChild(new Entity() //
				.add(new ImageSprite(pack.getTexture("score/scoreBottomBubble")) //
					.centerAnchor() //
					.setXY(x, 476)) //
				.addChild(new Entity() //
					.add(new TextSprite(font, score.currentScore).setScale(3.5) //
						.setXY(70, 0)))) //
			.addChild(new Entity() //
				.add(scoreBottom = new ImageSprite(pack.getTexture("score/scoreBottom")) //
					.centerAnchor() //
					.setXY(x, 356))) //
			.addChild(new Entity() //
				.add(new ImageSprite(pack.getTexture("score/scoreTopBubble")) //
					.centerAnchor() //
					.setXY(x, 923)) //
				.addChild(new Entity() //
					.add(new TextSprite(font, score.bestScore) //
						.setXY(54, -4) //
						.setScale(2.75)))) //
			.addChild(new Entity() //
				.add(scoreTop = new ImageSprite(pack.getTexture("score/scoreTop")) //
					.centerAnchor() //
					.setXY(x, 853))) //
			.add(_homeButton = new Button(pack, "homeButton", width - 121, 90)); //

		scoreTop.y.animateTo(753, 0.75, Ease.backOut);
		scoreTop.rotation.behavior = new Sine(-5, 5, 4);
		scoreTop.scaleX.behavior = new Sine(0.9, 1, 4);
		scoreTop.scaleY.behavior = new Sine(0.9, 1, 4);

		scoreBottom.y.animateTo(256, 0.5, Ease.backOut);
		scoreBottom.rotation.behavior = new Sine(5, -5, 4);
		scoreBottom.scaleX.behavior = new Sine(1, 0.9, 4);
		scoreBottom.scaleY.behavior = new Sine(1, 0.9, 4);

		cloud1.anchorX.behavior = new Sine(-40, 40, 4);
		cloud1.anchorY.behavior = new Sine(-20, 20, 8);
		cloud2.anchorX.behavior = new Sine(-40, 40, 4);
		cloud2.anchorY.behavior = new Sine(-20, 20, 8);
		cloud3.anchorX.behavior = new Sine(-40, 40, 4);
		cloud3.anchorY.behavior = new Sine(-20, 20, 8);
		cloud4.anchorX.behavior = new Sine(-40, 40, 4);
		cloud4.anchorY.behavior = new Sine(-20, 20, 8);
		cloud5.anchorX.behavior = new Sine(-40, 40, 4);
		cloud5.anchorY.behavior = new Sine(-20, 20, 8);
		cloud6.anchorX.behavior = new Sine(-40, 40, 4);
		cloud6.anchorY.behavior = new Sine(-20, 20, 8);

		_homeButton.click.connect(() -> {
			this.dispose();
			Audio.playSound_("click");
			System.root.get(DrinkPercent).reset();
			System.root.add(new CafeGame(pack, width, height));
		}).once();
	}

	private var _root:Entity;
	private var _homeButton:Button;
}
