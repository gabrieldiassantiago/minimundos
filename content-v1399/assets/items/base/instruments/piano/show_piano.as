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
			public var note_d:Object;
			public var note_e:Object;
			public var note_f:Object;
			public var note_g:Object;
			public var note_a:Object;
			public var note_b:Object;
			public var note_c_hi:Object;
			public var note_c_sharp:Object;
			public var note_d_sharp:Object;
			public var note_f_sharp:Object;
			public var note_g_sharp:Object;
			public var note_a_sharp:Object;
			public var body:Object;
			
			
			public function onCreationComplete():void
			{
				body = createPiece("piano_body.png");
				note_c = createPiece("piano_note_c.png");
				note_d = createPiece("piano_note_d.png");
				note_e = createPiece("piano_note_e.png");
				note_f = createPiece("piano_note_f.png");
				note_g = createPiece("piano_note_g.png");
				note_a = createPiece("piano_note_a.png");
				note_b = createPiece("piano_note_b.png");
				note_c_hi = createPiece("piano_note_c_hi.png");
				note_c_sharp = createPiece("piano_note_c_sharp.png");
				note_d_sharp = createPiece("piano_note_d_sharp.png");
				note_f_sharp = createPiece("piano_note_f_sharp.png");
				note_g_sharp = createPiece("piano_note_g_sharp.png");
				note_a_sharp = createPiece("piano_note_a_sharp.png");
				
				piano.stage.addEventListener("keyDown", onKey);
				piano.stage.addEventListener("enterFrame", onEnterFrame);
				piano.addEventListener("removedFromStage", onCleanup);
				piano.addEventListener("click", onClick);
				
				var loops:Array = [];
				loops.push({label:"Freestyle", data:"Idle"});
				loops.push({label:"Romantic tune", data:"Loop_romantic"});
				loops.push({label:"Groove tune", data:"Loop_groove"});
				loops.push({label:"Samba tune", data:"Loop_samba"});
				loopCombo.dataProvider = loops;
				loopCombo.focusEnabled = false;
				loopCombo.mouseFocusEnabled = false;
			}
			
			public function onCleanup(e:Object):void
			{
				piano.stage.removeEventListener("keyDown", onKey);
				piano.stage.removeEventListener("enterFrame", onEnterFrame);
			}
			
			public function createPiece(filename:String):void
			{
				piece = new textureImage();
				piece.basePath = basePath;
				piece.source = "items/base/instruments/piano/" + filename;
				piece.mouseEnabled = true;
				piece.buttonMode = true;
				piece.useHandCursor = true;
				piece.scaled = false;
				piece.percentWidth = 100;
				piece.percentHeight = 100;
				
				piano.addChild(piece);
				
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
				if (e.keyCode == 87)
					play(note_c_sharp, "C_Sharp");
				else if (e.keyCode == 69)
					play(note_d_sharp, "D_Sharp");
				else if (e.keyCode == 84)
					play(note_f_sharp, "F_Sharp");
				else if (e.keyCode == 89)
					play(note_g_sharp, "G_Sharp");
				else if (e.keyCode == 85)
					play(note_a_sharp, "A_Sharp");
				else if (e.keyCode == 65)
					play(note_c, "C");
				else if (e.keyCode == 83)
					play(note_d, "D");
				else if (e.keyCode == 68)
					play(note_e, "E");
				else if (e.keyCode == 70)
					play(note_f, "F");
				else if (e.keyCode == 71)
					play(note_g, "G");
				else if (e.keyCode == 72)
					play(note_a, "A");
				else if (e.keyCode == 74)
					play(note_b, "B");
				else if (e.keyCode == 75)
					play(note_c_hi, "C1");
			}
			
			public function onClick(e:Object):void
			{ 
				if (hitTestPiece(note_c_sharp))
					play(note_c_sharp, "C_Sharp");
				else if (hitTestPiece(note_d_sharp))
					play(note_d_sharp, "D_Sharp");
				else if (hitTestPiece(note_f_sharp))
					play(note_f_sharp, "F_Sharp");
				else if (hitTestPiece(note_g_sharp))
					play(note_g_sharp, "G_Sharp");
				else if (hitTestPiece(note_a_sharp))
					play(note_a_sharp, "A_Sharp");
				else if (hitTestPiece(note_c))
					play(note_c, "C");
				else if (hitTestPiece(note_d))
					play(note_d, "D");
				else if (hitTestPiece(note_e))
					play(note_e, "E");
				else if (hitTestPiece(note_f))
					play(note_f, "F");
				else if (hitTestPiece(note_g))
					play(note_g, "G");
				else if (hitTestPiece(note_a))
					play(note_a, "A");
				else if (hitTestPiece(note_b))
					play(note_b, "B");
				else if (hitTestPiece(note_c_hi))
					play(note_c_hi, "C1");
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
				else if (item.animation == "Loop_romantic")
					loopCombo.selectedIndex = 1;
				else if (item.animation == "Loop_groove")
					loopCombo.selectedIndex = 2;
				else if (item.animation == "Loop_samba")
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

	<mx:Canvas id="piano" width="220" height="130" 
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