import com.smallworlds.view.Hud;
import com.smallworlds.service.ServiceManager;
import com.smallworlds.permissions.UserPermissions;

var controlMXML:XML =
<mx:MXML
	xmlns:mx="http://www.adobe.com/2006/mxml"
	xmlns:base="com.smallworlds.widget.controls.*"
	layout="vertical"
	creationComplete="onCreationComplete()" 
	width="100%" 
	height="194">

	<mx:Script>
		<![CDATA[

			import com.smallworlds.entity.item.Item;

			public var item:Item;
			
			public function onCreationComplete():void
			{
				// Tell controller about the spawn point.
				controller.spawn = item;
				
				// Create the first row of actions.
				var row = controller.actions.row(0);
				row.add("items/base/consumables/emotes/emote_01_smile_item.xml");
				row.add("items/base/consumables/emotes/emote_05_sad_item.xml");
				row.add("items/base/consumables/emotes/emote_02_laugh_item.xml");
				row.add("items/base/consumables/emotes/emote_06_cheer_item.xml");
				row.add("items/base/consumables/emotes/emote_04_angry_item.xml");
				row.add("items/base/consumables/emotes/emote_03_whistle_item.xml");

				// Create the second row of actions.
				var row = controller.actions.row(1);
				row.add("items/base/ai/npc/npcemo_01_hug_item.xml");
				row.add("items/base/ai/npc/npcemo_02_kiss_item.xml");
				row.add("items/base/ai/npc/npcemo_03_poke_item.xml");
				row.add("items/base/ai/npc/npcemo_04_slap_item.xml");
				row.add("items/base/consumables/emotes/emote_07_clap_item.xml");
				row.add("items/base/consumables/emotes/emote_12_dance1_item.xml");
			}
				
		]]>
	</mx:Script>

	<base:NPCControlPanel id="controller" percentWidth="100" />
	
</mx:MXML>;

// Update the desired panel height if user can debug NPCs.
var permissions = ServiceManager.instance.userService.user.permissions;
if (UserPermissions.guiDebugAccess(permissions))
	controlMXML.@height = 240;

// Display the panel UI.
hud.showDynamicUI(controlMXML, Hud.SELECTED_STATE, {item:entity});