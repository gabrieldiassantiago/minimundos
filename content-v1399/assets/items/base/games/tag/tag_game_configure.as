import com.smallworlds.view.Hud;
import com.smallworlds.entity.item.Item;

// Debug Trace.
printf("Game: configure.");

// Get the widget item.	
var item:Item = entity as Item;

// XML configuration UI.
var configUI:XML = 
<mx:MXML 
	xmlns:mx="http://www.adobe.com/2006/mxml" 
	width="500" height="350" 
	title="CONFIGURE TAG GAME"
	creationComplete="this.init()" >

	<mx:Script>
		<![CDATA[
		
		import com.smallworlds.widget.WidgetEvent;
		import com.smallworlds.widget.IWidget;
		import com.smallworlds.widget.IWidgetService;
		
		public var game:XML;
		
		/* Post creation initialization. */	
		public function init():void
		{
            game = item.getConfigSection("game");
			if (game.@name != undefined)
				gameName.text = game.@name;
			gameMinPlayers.value = game.@minPlayers;
			gameMaxPlayers.value = game.@maxPlayers;
			gameDuration.value = game.@duration / 60;
			gameScoreToWin.value = game.@scoreToWin;
		}
		
		/* Save and exit. */
		public function save():void
		{
			game.@name = gameName.text;
			game.@type = "TagGame";
			game.@minPlayers = gameMinPlayers.value;
			game.@maxPlayers = gameMaxPlayers.value;
			game.@duration = gameDuration.value * 60;
			game.@scoreToWin = gameScoreToWin.value;
			item.setConfigSection(game);
			
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
		<mx:Form id="configHolder" width="100%" top="40" >
			<mx:FormItem label="Game name">
				<mx:TextInput id="gameName" width="150" />
			</mx:FormItem>
			<mx:FormItem label="Min players">
				<mx:NumericStepper id="gameMinPlayers" minimum="2" maximum="30"
					toolTip="The minimum number of players in this game." />
			</mx:FormItem>
			<mx:FormItem label="Max players">
				<mx:NumericStepper id="gameMaxPlayers" minimum="2" maximum="30"
					toolTip="The maximum number of players in this game." />
			</mx:FormItem>
			<mx:FormItem label="Round duration">
				<mx:HBox>
					<mx:NumericStepper id="gameDuration" minimum="1" maximum="60"
						toolTip="The duration of a single round, in minutes." />
					<mx:Label text="minutes" />
				</mx:HBox>
			</mx:FormItem>
			<mx:FormItem label="Score to win">
				<mx:HBox>
					<mx:NumericStepper id="gameScoreToWin" minimum="1" maximum="100"
						toolTip="The number of points a team must score to win the game." />
					<mx:Label text="points" />
				</mx:HBox>
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
				click="this.cancel()" 
				styleName="dynamicUIButtonOrange" 
				toolTip="Cancels configuration changes."/>
			<mx:SWButton id="btnCancel" 
				label="SAVE" 
				width="100" height="24" 
				click="this.save()" 
				styleName="dynamicUIButtonOrange" 
				toolTip="Saves your configuration changes."/>
		</mx:HBox>
	</mx:Canvas>
</mx:MXML>
		
	
// Show the configuration UI if the user has admin rights.
if (item && item.canConfigure)
	hud.showDynamicUI(configUI, Hud.CONFIG_STATE, {item:item, hud:hud});