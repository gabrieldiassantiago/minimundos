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
	width="220" height="170">

	<mx:Script>
		<![CDATA[

			import com.smallworlds.entity.item.Item;

			public var item:Item;
			
			public var basePath:String;
			public var hitOrigin:Object;
			public var hitPoint:Object;
			public var tween:Function;
			public var textureImage:Class;
			
			public var note_c:Object;
			public var note_c_sharp:Object;
			public var note_d:Object;
			public var note_d_sharp:Object;
			public var note_e:Object;
			public var note_f:Object;
			public var note_f_sharp:Object;
			public var note_g:Object;
			public var note_g_sharp:Object;
			public var note_a:Object;
			public var note_a_sharp:Object;
			public var note_b:Object;
			public var note_c1:Object;
			public var note_c1_sharp:Object;
			public var note_d1:Object;
			public var note_d1_sharp:Object;
			public var note_e1:Object;
			public var note_f1:Object;
			public var note_f1_sharp:Object;
			public var note_g1:Object;
			public var note_g1_sharp:Object;
			public var note_a1:Object;
			public var note_a1_sharp:Object;
			public var note_b1:Object;
			public var body:Object;
			
			
			public function onCreationComplete():void
			{
				body = createPiece("grand_piano_body.png", 0);
				body.percentWidth = 100;
				
				note_c = createPiece("grand_piano_note_c.png", 0);
				note_d = createPiece("grand_piano_note_d.png", 0);
				note_e = createPiece("grand_piano_note_e.png", 0);
				note_f = createPiece("grand_piano_note_f.png", 0);
				note_g = createPiece("grand_piano_note_g.png", 0);
				note_a = createPiece("grand_piano_note_a.png", 0);
				note_b = createPiece("grand_piano_note_b.png", 0);
				note_c_sharp = createPiece("grand_piano_note_c_sharp.png", 0);
				note_d_sharp = createPiece("grand_piano_note_d_sharp.png", 0);
				note_f_sharp = createPiece("grand_piano_note_f_sharp.png", 0);
				note_g_sharp = createPiece("grand_piano_note_g_sharp.png", 0);
				note_a_sharp = createPiece("grand_piano_note_a_sharp.png", 0);
				note_c1 = createPiece("grand_piano_note_c1.png", 110);
				note_d1 = createPiece("grand_piano_note_d1.png", 110);
				note_e1 = createPiece("grand_piano_note_e1.png", 110);
				note_f1 = createPiece("grand_piano_note_f1.png", 110);
				note_g1 = createPiece("grand_piano_note_g1.png", 110);
				note_a1 = createPiece("grand_piano_note_a1.png", 110);
				note_b1 = createPiece("grand_piano_note_b1.png", 110);
				note_c1_sharp = createPiece("grand_piano_note_c1_sharp.png", 110);
				note_d1_sharp = createPiece("grand_piano_note_d1_sharp.png", 110);
				note_f1_sharp = createPiece("grand_piano_note_f1_sharp.png", 110);
				note_g1_sharp = createPiece("grand_piano_note_g1_sharp.png", 110);
				note_a1_sharp = createPiece("grand_piano_note_a1_sharp.png", 110);
				
				piano.stage.addEventListener("keyDown", onKey);
				piano.stage.addEventListener("enterFrame", onEnterFrame);
				piano.addEventListener("removedFromStage", onCleanup);
				piano.addEventListener("click", onClick);
				
				var loops:Array = [];
				loops.push({label:"Freestyle", data:"Idle"});
				loops.push({label:"Blues", data:"Loop_blues"});
				loops.push({label:"Jazz", data:"Loop_jazz"});
				loops.push({label:"Bossa Nova", data:"Loop_bossa"});
				loopCombo.dataProvider = loops;
				loopCombo.focusEnabled = false;
				loopCombo.mouseFocusEnabled = false;
			}
			
			public function onCleanup(e:Object):void
			{
				piano.stage.removeEventListener("keyDown", onKey);
				piano.stage.removeEventListener("enterFrame", onEnterFrame);
			}
			
			public function createPiece(filename:String, x:int):void
			{
				piece = new textureImage();
				piece.basePath = basePath;
				piece.source = "items/base/instruments/piano/" + filename;
				piece.mouseEnabled = true;
				piece.buttonMode = true;
				piece.useHandCursor = true;
				piece.scaled = false;
				piece.x = x;
				piece.width = 110;
				piece.percentHeight = 100;
				
				piano.addChild(piece);
				
				return piece;
			}
			
			public function hitTest(x:Number, y:Number, ox:Number, oy:Number, ow:Number, oh:Number):void
			{
				if (x < ox || x > (ox + ow))
					return false;
				else if (y < oy || y > (oy + oh))
					return false;
				else
					return true;
			}
			
			public function onKey(e:Object):void
			{
				if (e.keyCode == 49)
					play(note_c_sharp, "C_Sharp");
				else if (e.keyCode == 50)
					play(note_d_sharp, "D_Sharp");
				else if (e.keyCode == 52)
					play(note_f_sharp, "F_Sharp");
				else if (e.keyCode == 53)
					play(note_g_sharp, "G_Sharp");
				else if (e.keyCode == 54)
					play(note_a_sharp, "A_Sharp");
				else if (e.keyCode == 9)
					play(note_c, "C");
				else if (e.keyCode == 81)
					play(note_d, "D");
				else if (e.keyCode == 87)
					play(note_e, "E");
				else if (e.keyCode == 69)
					play(note_f, "F");
				else if (e.keyCode == 82)
					play(note_g, "G");
				else if (e.keyCode == 84)
					play(note_a, "A");
				else if (e.keyCode == 89)
					play(note_b, "B");
				else if (e.keyCode == 56)
					play(note_c1_sharp, "C1_Sharp");
				else if (e.keyCode == 57)
					play(note_d1_sharp, "D1_Sharp");
				else if (e.keyCode == 189)
					play(note_f1_sharp, "F1_Sharp");
				else if (e.keyCode == 187)
					play(note_g1_sharp, "G1_Sharp");
				else if (e.keyCode == 8)
					play(note_a1_sharp, "A1_Sharp");
				else if (e.keyCode == 85)
					play(note_c1, "C1");
				else if (e.keyCode == 73)
					play(note_d1, "D1");
				else if (e.keyCode == 79)
					play(note_e1, "E1");
				else if (e.keyCode == 80)
					play(note_f1, "F1");
				else if (e.keyCode == 219)
					play(note_g1, "G1");
				else if (e.keyCode == 221)
					play(note_a1, "A1");
				else if (e.keyCode == 220)
					play(note_b1, "B1");
			}
			
			public function onClick(e:Object):void
			{ 
				var x:Number = piano.mouseX;
				var y:Number = piano.mouseY;
				
				if (hitTest(x, y, 14, 55, 14, 45))
					play(note_c_sharp, "C_Sharp");
				else if (hitTest(x, y, 28, 55, 14, 45))
					play(note_d_sharp, "D_Sharp");
				else if (hitTest(x, y, 59, 55, 14, 45))
					play(note_f_sharp, "F_Sharp");
				else if (hitTest(x, y, 74, 55, 14, 45))
					play(note_g_sharp, "G_Sharp");
				else if (hitTest(x, y, 89, 55, 14, 45))
					play(note_a_sharp, "A_Sharp");
				else if (hitTest(x, y, 118, 55, 14, 45))
					play(note_c1_sharp, "C1_Sharp");
				else if (hitTest(x, y, 132, 55, 14, 45))
					play(note_d1_sharp, "D1_Sharp");
				else if (hitTest(x, y, 163, 55, 14, 45))
					play(note_f1_sharp, "F1_Sharp");
				else if (hitTest(x, y, 178, 55, 14, 45))
					play(note_g1_sharp, "G1_Sharp");
				else if (hitTest(x, y, 192, 55, 14, 45))
					play(note_a1_sharp, "A1_Sharp");
				else if (hitTest(x, y, 5, 55, 15, 75))
					play(note_c, "C");
				else if (hitTest(x, y, 20, 55, 15, 75))
					play(note_d, "D");
				else if (hitTest(x, y, 35, 55, 15, 75))
					play(note_e, "E");
				else if (hitTest(x, y, 50, 55, 15, 75))
					play(note_f, "F");
				else if (hitTest(x, y, 65, 55, 15, 75))
					play(note_g, "G");
				else if (hitTest(x, y, 80, 55, 15, 75))
					play(note_a, "A");
				else if (hitTest(x, y, 95, 55, 15, 75))
					play(note_b, "B");
				else if (hitTest(x, y, 110, 55, 15, 75))
					play(note_c1, "C1");
				else if (hitTest(x, y, 125, 55, 15, 75))
					play(note_d1, "D1");
				else if (hitTest(x, y, 140, 55, 15, 75))
					play(note_e1, "E1");
				else if (hitTest(x, y, 155, 55, 15, 75))
					play(note_f1, "F1");
				else if (hitTest(x, y, 170, 55, 15, 75))
					play(note_g1, "G1");
				else if (hitTest(x, y, 185, 55, 15, 75))
					play(note_a1, "A1");
				else if (hitTest(x, y, 200, 55, 15, 75))
					play(note_b1, "B1");
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
				else if (item.animation == "Loop_blues")
					loopCombo.selectedIndex = 1;
				else if (item.animation == "Loop_jazz")
					loopCombo.selectedIndex = 2;
				else if (item.animation == "Loop_bossa")
					loopCombo.selectedIndex = 3;
			}
			
			public function play(piece:Object, animation:String):void
			{
				// Cycle between animations.
				if (item.animation == animation + "_01")
					item.animation = animation + "_02"
				else
					item.animation = animation + "_01";
					
				// Set up a tween to give visual feedback.
				tween(piece, 0.1, {alpha :0.75,
					onComplete:onPlayComplete, onCompleteParams:[piece, item.animation]});
			}
			
			public function onPlayComplete(piece:Object, animation:String):void
			{
				tween(piece, 1.0, {alpha:1,
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

	<mx:Canvas id="piano" width="220" height="132" 
		horizontalCenter="0" />

	<mx:Spacer height="2" />
	
	<mx:ComboBox id="loopCombo" 
		rowCount="10" 
		percentWidth="100" 
		change="chooseLoop()" 
		toolTip="Play a built-in tune, or go freestyle!"/>
	
</mx:MXML>;


hud.showDynamicUI(controlMXML, Hud.SELECTED_STATE, {
	item:entity, 
	basePath:Paths.libraryPath, 
	hitPoint:hitPoint, 
	hitOrigin:hitOrigin, 
	tween:TweenLite.to, 
	textureImage:TextureImage });