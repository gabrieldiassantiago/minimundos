import com.smallworlds.view.Hud;
import com.smallworlds.service.Paths;
import com.smallworlds.controls.TextureImage;
import com.gs.TweenLite;
import flash.geom.Point;

var hitPoint:Point = new Point();
var hitOrigin:Point = new Point();

var controlMXML:XML =
<mx:MXML
	xmlns:mx="http://www.adobe.com/2006/mxml"
	xmlns:controls="com.smallworlds.controls.*"
	creationComplete="onCreationComplete()"
	width="218" height="190">

	<mx:Script>
		<![CDATA[

			import com.smallworlds.entity.item.Item;

			public var item:Item;
			
			public var basePath:String;
			public var hitOrigin:Object;
			public var hitPoint:Object;
			public var tween:Function;
			public var textureImage:Class;
			
			public var kick:Object;
			public var snare:Object;
			public var hiHat:Object;
			public var tomLeft:Object;
			public var tomRight:Object;
			public var tomBottom:Object;
			public var crash:Object;
			public var ride:Object;
			
			public function onCreationComplete():void
			{
				kick = createPiece("drum_kick.png");
				snare = createPiece("drum_snare.png");
				hiHat = createPiece("drum_hi_hat.png");
				tomLeft = createPiece("drum_tom_left.png");
				tomRight = createPiece("drum_tom_right.png");
				tomBottom = createPiece("drum_tom_bottom.png");
				crash = createPiece("drum_crash.png");
				ride = createPiece("drum_ride.png");
				
				kit.stage.addEventListener("keyDown", onKey);
				kit.stage.addEventListener("enterFrame", onEnterFrame);
				kit.addEventListener("removedFromStage", onCleanup);
				kit.addEventListener("click", onClick);
				
				var loops:Array = [];
				loops.push({label:"Freestyle", data:"Idle"});
				loops.push({label:"Rock beat", data:"Loop_rock"});
				loops.push({label:"Groove beat", data:"Loop_groove"});
				loops.push({label:"Samba beat", data:"Loop_samba"});
				loopCombo.dataProvider = loops;
				loopCombo.focusEnabled = false;
				loopCombo.mouseFocusEnabled = false;
			}
			
			public function onCleanup(e:Object):void
			{
				kit.stage.removeEventListener("keyDown", onKey);
				kit.stage.removeEventListener("enterFrame", onEnterFrame);
			}
			
			public function createPiece(filename:String):void
			{
				piece = new textureImage();
				piece.basePath = basePath;
				piece.source = "items/base/instruments/drums/" + filename;
				piece.mouseEnabled = true;
				piece.buttonMode = true;
				piece.useHandCursor = true;
				piece.scaled = false;
				piece.percentWidth = 100;
				piece.percentHeight = 100;
				
				kit.addChild(piece);
				
				return piece;
			}
			
			public function hitTestPiece(piece:Object, animation:String):void
			{
				if (!piece.texture)
					return;
				if (!piece.texture.bitmap)
					return;
					
				hitPoint.x = piece.mouseX;
				hitPoint.y = piece.mouseY;
				
				return piece.texture.bitmap.hitTest(hitOrigin, 0, hitPoint);
			}
			
			public function onKey(e:Object):void
			{
				if (e.keyCode == 49)
					play(kick, "Kick");
				else if (e.keyCode == 50)
					play(snare, "Snare");
				else if (e.keyCode == 51)
					play(tomLeft, "TomLeft");
				else if (e.keyCode == 52)
					play(tomRight, "TomRight");
				else if (e.keyCode == 53)
					play(tomBottom, "TomBottom");
				else if (e.keyCode == 54)
					play(hiHat, "HiHat");
				else if (e.keyCode == 55)
					play(crash, "Crash");
				else if (e.keyCode == 56)
					play(ride, "Ride");
			}
			
			public function onClick(e:Object):void
			{ 
				if (hitTestPiece(ride))
					play(ride, "Ride");
				else if (hitTestPiece(crash))
					play(crash, "Crash");
				else if (hitTestPiece(tomLeft))
					play(tomLeft, "TomLeft");
				else if (hitTestPiece(tomRight))
					play(tomRight, "TomRight");
				else if (hitTestPiece(tomBottom))
					play(tomBottom, "TomBottom");
				else if (hitTestPiece(hiHat))
					play(hiHat, "HiHat");
				else if (hitTestPiece(snare))
					play(snare, "Snare");
				else if (hitTestPiece(kick))
					play(kick, "Kick");
			}
			
			public function onEnterFrame(e:Object):void
			{ 
				// Don't update animation while using combo.
				if (loopCombo.dropdown && loopCombo.dropdown.visible)
					return;
			
				// Reset combo to idle if needed.
				if (!item.animation)
					loopCombo.selectedIndex = 0;
				else if (item.animation.indexOf("Loop") != 0)
					loopCombo.selectedIndex = 0;
				else if (item.animation == "Loop_rock")
					loopCombo.selectedIndex = 1;
				else if (item.animation == "Loop_groove")
					loopCombo.selectedIndex = 2;
				else if (item.animation == "Loop_samba")
					loopCombo.selectedIndex = 3;
			}
			
			public function play(piece:Object, animation:String):void
			{
				if (!item || !item.canUse)
					return;
					
				// Cycle between animations.
				if (item.animation == animation + "_01")
					item.animation = animation + "_02"
				else
					item.animation = animation + "_01";
					
				// Set up a tween to give visual feedback.
				tween(piece, 0.1, {alpha :0.75, y:-2, scaleX:0.975,
					onComplete:onPlayComplete, onCompleteParams:[piece, item.animation]});
			}
			
			public function onPlayComplete(piece:Object, animation:String):void
			{
				tween(piece, 0.5, {alpha:1, y:0, scaleX:1, 
					onComplete:onResetComplete, onCompleteParams:[piece, animation]});
			}
			
			public function onResetComplete(piece:Object, animation:String):void
			{
				if (item.animation == animation)
					item.animation = "Idle";
			}
			
			public function chooseLoop():void
			{
				if (!item || !item.canUse)
					return;

				item.animation = loopCombo.selectedItem.data;
			}
			
				
		]]>
	</mx:Script>

	<mx:Canvas id="kit" width="218" height="160" />

	<mx:ComboBox id="loopCombo" 
		rowCount="10" 
		percentWidth="100" 
		change="chooseLoop()" 
		toolTip="Play a drum loop, or go freestyle!"/>
	
</mx:MXML>;


hud.showDynamicUI(controlMXML, Hud.SELECTED_STATE, {
	item:entity, 
	basePath:Paths.libraryPath, 
	hitPoint:hitPoint, 
	hitOrigin:hitOrigin, 
	tween:TweenLite.to, 
	textureImage:TextureImage });