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
	horizontalAlign="center"
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
			
			public var base:Object;
			public var disk:Object;
			public var disk_rotated:Object;
			public var needle:Object;

			public var lastX:Number;
			public var lastY:Number;
			
			public function onCreationComplete():void
			{
				base = createPiece("turntable_base.png");
				disk_rotated = createPiece("turntable_disk_01_rot_90.png");
				disk = createPiece("turntable_disk_01.png");
				needle = createPiece("turntable_needle.png");

				turntable.stage.addEventListener("keyDown", onKey);
				turntable.stage.addEventListener("enterFrame", onEnterFrame);
				turntable.addEventListener("removedFromStage", onCleanup);
				turntable.addEventListener("mouseDown", onMouseDown);
				turntable.addEventListener("mouseMove", onMouseMove);
				
				var loops:Array = [];
				loops.push({label:"Freestyle", data:"Idle"});
				loops.push({label:"Loop 01", data:"loop_01"});
				loops.push({label:"Loop 02", data:"loop_02"});
				loops.push({label:"Loop 03", data:"loop_03"});
				loopCombo.dataProvider = loops;
				loopCombo.focusEnabled = false;
				loopCombo.mouseFocusEnabled = false;
			}
			
			public function onCleanup(e:Object):void
			{
				turntable.stage.removeEventListener("keyDown", onKey);
				turntable.stage.removeEventListener("enterFrame", onEnterFrame);
			}
			
			public function createPiece(filename:String):void
			{
				piece = new textureImage();
				piece.basePath = basePath + "items/base/instruments/turntable/";
				piece.source = filename;
				piece.mouseEnabled = true;
				piece.buttonMode = true;
				piece.useHandCursor = true;
				piece.scaled = false;
				piece.percentWidth = 100;
				piece.percentHeight = 100;
				
				turntable.addChild(piece);
				
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
					play(disk, "scratch");
				else if (e.keyCode == 50)
					play(disk, "scratch");
				else if (e.keyCode == 51)
					play(disk, "scratch");
				else if (e.keyCode == 52)
					play(disk, "scratch");
			}
			
			public function onMouseDown(e:Object):void
			{ 
				if (hitTestPiece(disk))
					play(disk, "scratch");

				lastX = disk.mouseX;
				lastY = disk.mouseY;
			}

			public function onMouseMove(e:Object):void
			{
				if (!e.buttonDown)
					return;

				var dx:Number = lastX - disk.mouseX;
				var dy:Number = lastY - disk.mouseY;
				var distance:Number = Math.sqrt(dx * dx + dy * dy);

				if (distance < 30)
					return;

				play(disk, "scratch");

				lastX = disk.mouseX;
				lastY = disk.mouseY;
			}
			
			public function onEnterFrame(e:Object):void
			{ 
				// Don't update animation while using combo.
				if (loopCombo.dropdown && loopCombo.dropdown.visible)
					return;

				// Reset combo to idle if needed.
				if (!item.animation)
					loopCombo.selectedIndex = 0;
				else if (item.animation.indexOf("loop") != 0)
					loopCombo.selectedIndex = 0;
				else 
				{
					if (item.animation == "loop_01")
						loopCombo.selectedIndex = 1;
					else if (item.animation == "loop_02")
						loopCombo.selectedIndex = 2;
					else if (item.animation == "loop_03")
						loopCombo.selectedIndex = 3;

					if (disk.alpha == 1)
						tween(disk, 0.5, {alpha:0.0});
					else if (disk.alpha == 0)
						tween(disk, 0.5, {alpha:1.0});
				}
			}

			public function play(piece:Object, animation:String):void
			{
				if (!item || !item.canUse)
					return;
					
				// Cycle between animations.
				if (item.animation == animation + "_01")
					item.animation = animation + "_02"
				else if (item.animation == animation + "_02")
					item.animation = animation + "_03"
				else if (item.animation == animation + "_03")
					item.animation = animation + "_04"
				else
					item.animation = animation + "_01";

				// Set up a tween to give visual feedback.
				tween(piece, 0.25, {alpha:piece.alpha == 1 ? 0 : 1,
					onComplete:onPlayComplete, onCompleteParams:[piece, item.animation]});
			}
			
			public function onPlayComplete(piece:Object, animation:String):void
			{
				// Go back to normal state.
				tween(piece, 0.5, {alpha:piece.alpha == 1 ? 0 : 1,
					onComplete:onResetComplete, onCompleteParams:[piece, animation]});
			}
			
			public function onResetComplete(piece:Object, animation:String):void
			{
				// Back to idle animation.
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

	<mx:Spacer height="2" />

	<mx:Canvas width="218" height="140"
		horizontalScrollPolicy="off"
		verticalScrollPolicy="off">
		<mx:Canvas id="turntable" 
			horizontalScrollPolicy="off"
			verticalScrollPolicy="off"
			x="17" width="184" height="139" />
	</mx:Canvas>

	<mx:Spacer height="2" />

	<mx:ComboBox id="loopCombo" 
		rowCount="10" 
		percentWidth="100" 
		change="chooseLoop()" 
		toolTip="Play a loop, or go freestyle!"/>
	
</mx:MXML>;


hud.showDynamicUI(controlMXML, Hud.SELECTED_STATE, {
	item:entity, 
	basePath:Paths.libraryPath, 
	hitPoint:hitPoint, 
	hitOrigin:hitOrigin, 
	tween:TweenLite.to, 
	textureImage:TextureImage });