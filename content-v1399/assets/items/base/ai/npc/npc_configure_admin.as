import com.smallworlds.view.Hud;
import com.smallworlds.entity.item.ai.npc.NPCItem;

// Debug Trace.
printf("NPC: configure.");

// Get the npc item.	
var item:NPCItem = entity as NPCItem;

// Default configuration for npc.
var configDefault:XML = <ai></ai>;


// XML configuration UI.
var configUI:XML = 
<mx:MXML 
	xmlns:mx="http://www.adobe.com/2006/mxml"
	width="400" height="290" 
	title="CONFIGURE NPC"
	creationComplete="this.init()" >

	<mx:Script>
		<![CDATA[
		
		public var ai:XML;

		/* Post creation initialization. */	
		public function init():void
		{
			// Get the ai configuration section.
			ai = item.getConfigSection("ai");
			
			// Use default config xml if not initialized yet.
			if (ai == null) 
				ai = configDefault;
			
			aiBotId.text = ai.@botId;
			aiClone.selected = ai.@clone != "false";
			aiLink.selected = ai.@clone == "false";
		}
		
		/* Save and exit. */
		public function save():void
		{
			// Store the pandora bot id.
			ai.@botId = aiBotId.text;
			
			// Store ID of the current avatar.
			if (item.avatar)
				ai.@avatarId = item.avatar.avatarId;
				
			// Store cloning status.
			ai.@clone = aiClone.selected;
				
			item.setConfigSection(ai);
			hud.hudState = Hud.NORMAL_STATE;
		}
		
		/* Cancel and exit. */
		public function cancel():void
		{
			hud.hudState = Hud.NORMAL_STATE;
		}
		
		]]>
	</mx:Script>
	
	<mx:Canvas width="100%" height="100%" >
		
		<mx:Form width="100%" top="40" bottom="40" labelWidth="130">
			<mx:FormItem label="Pandora chatbot id">
				<mx:TextInput id="aiBotId" width="150" />
			</mx:FormItem>
			<mx:FormItem label="Cloning" layout="vertical" verticalGap="0">
				<mx:Label text="When this item is cloned or sold:" />
				<mx:RadioButton id="aiClone" groupName="clone" label="Clone the NPC too" />
				<mx:RadioButton id="aiLink" groupName="clone" label="Keep the existing NPC" />
			</mx:FormItem>
		</mx:Form>

		<mx:HBox width="100%" height="24" 
			horizontalGap="8" 
			horizontalAlign="right" 
			bottom="12" 
			right="15" 
			verticalAlign="middle">
			<mx:SWButton id="btnCancel" 
				label="CANCEL" 
				width="100" height="24" 
				click="cancel()" 
				styleName="dynamicUIButtonOrange" 
				toolTip="Cancels configuration changes."/>
			<mx:SWButton id="btnSave" 
				label="SAVE" 
				width="100" height="24" 
				click="save()" 
				styleName="dynamicUIButtonOrange" 
				toolTip="Saves your configuration changes."/>
		</mx:HBox>
	</mx:Canvas>
</mx:MXML>
		
	
// Show the configuration UI if the user has admin rights.
if (item && item.canConfigure)
	hud.showDynamicUI(configUI, Hud.CONFIG_STATE, 
	{
		item:item, 
		hud:hud, 
		configDefault:configDefault
	});