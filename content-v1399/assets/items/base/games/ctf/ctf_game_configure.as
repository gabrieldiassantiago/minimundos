import com.smallworlds.view.Hud;
import com.smallworlds.entity.item.Item;

// Debug Trace.
printf("Game: configure.");

// Get the widget item.	
var item:Item = entity as Item;

// Default configuration for game.
var configDefault:XML =
<game type="CaptureTheFlagGame" 
	name="Capture the Flag"
	theme="sciFi"
	minPlayers="2" 
	maxPlayers="8" 
	duration="600" 
	durationCountdown="5" 
	durationEnd="5" 
	pointsToWin="3" 
	pointsOnPickup="0"
	pointsOnSave="0"
	pointsOnCapture="1"
	pointsOnShoot="0"
	pointsOnShot="0"
	mustHoldOwnFlags="true">
	<teams>
		<team id="A" name="Team A" color="800000">
			<flags>
				<flag id="A" name="Flag A" holdId="1559"/>
			</flags>
		</team>
		<team id="B" name="Team B" color="000090">
			<flags>
				<flag id="B" name="Flag B" holdId="1560"/>
			</flags>
		</team>
	</teams>
</game>;

// Set of available themes.
var themes:XML = 
<themes>
	<theme label="SciFi" data="sciFi"/>
	<theme label="Wooden" data="wooden"/>
	<theme label="Futuristic" data="future"/>
</themes>;

// Set of available camera angles.
var angles:XML = 
<angles>
	<angle label="Default" data=""/>
	<angle label="45" data="45"/>
	<angle label="135" data="135"/>
	<angle label="225" data="225"/>
	<angle label="315" data="315"/>
</angles>;


// XML configuration UI.
var configUI:XML = 
<mx:MXML 
	xmlns:mx="http://www.adobe.com/2006/mxml"
	width="700" height="390" 
	title="CONFIGURE CAPTURE THE FLAG GAME"
	creationComplete="this.init()" >

	<mx:Script>
		<![CDATA[
		
		import com.smallworlds.widget.WidgetEvent;
		import com.smallworlds.widget.IWidget;
		import com.smallworlds.widget.IWidgetService;
		import com.smallworlds.entity.space.Space;
		import mx.controls.dataGridClasses.DataGridColumn;
		
		public var game:XML;

		public function selectPage(i:int):void
		{
			buttonGame.selected = (i == 0);
			buttonLevels.selected = (i == 1);
			buttonTimes.selected = (i == 2);
			buttonScore.selected = (i == 3);
			buttonActions.selected = (i == 4);
			buttonShooting.selected = (i == 5);
			buttonTeamA.selected = (i == 6);
			buttonTeamB.selected = (i == 7);
			buttonRules.selected = (i == 8);
			buttonTweaks.selected = (i == 9);
			pages.selectedIndex = i;
		}
		
		/* Post creation initialization. */	
		public function init():void
		{
			// Get the game configuration section.
			game = item.getConfigSection("game");
			
			// Use default config xml if not initialized yet.
			if (game == null) 
				game = configDefault;
			
			gameName.text = game.@name;
			gameId.text = game.@gameId;
			gameMinPlayers.value = game.@minPlayers;
			gameMaxPlayers.value = game.@maxPlayers;
			gameEntryFeeCurrency.currency = game.@entryFeeCurrency;
			gameEntryFeeAmount.value = game.@entryFeeAmount;
			gameTheme.dataProvider = themes.theme;
			for each (var t in themes.theme)
				if (t.@data == game.@theme)
					{ gameTheme.selectedItem = t; break; }
					
			if (game.playerLevelRanges.length() > 0)
			{
				if (game.playerLevelRanges[0].range.(@type == "1").length() > 0)
				{
					var artistXPLevelRange:XML = game.playerLevelRanges[0].range.(@type == "1")[0];
					artistXPLevelMin.value = artistXPLevelRange.@low;
					artistXPLevelMax.value = artistXPLevelRange.@high;
				}
				if (game.playerLevelRanges[0].range.(@type == "2").length() > 0)
				{
					var explorerXPLevelRange:XML = game.playerLevelRanges[0].range.(@type == "2")[0];
					explorerXPLevelMin.value = explorerXPLevelRange.@low;
					explorerXPLevelMax.value = explorerXPLevelRange.@high;
				}
				if (game.playerLevelRanges[0].range.(@type == "3").length() > 0)
				{
					var gamerXPLevelRange:XML = game.playerLevelRanges[0].range.(@type == "3")[0];
					gamerXPLevelMin.value = gamerXPLevelRange.@low;
					gamerXPLevelMax.value = gamerXPLevelRange.@high;
				}
				if (game.playerLevelRanges[0].range.(@type == "4").length() > 0)
				{
					var socialXPLevelRange:XML = game.playerLevelRanges[0].range.(@type == "4")[0];
					socialXPLevelMin.value = socialXPLevelRange.@low;
					socialXPLevelMax.value = socialXPLevelRange.@high;
				}
				if (game.playerLevelRanges[0].range.(@type == "5").length() > 0)
				{
					var arenaXPLevelRange:XML = game.playerLevelRanges[0].range.(@type == "5")[0];
					arenaXPLevelMin.value = arenaXPLevelRange.@low;
					arenaXPLevelMax.value = arenaXPLevelRange.@high;
				}
				if (game.playerLevelRanges[0].range.(@type == "6").length() > 0)
				{
					var farmerXPLevelRange:XML = game.playerLevelRanges[0].range.(@type == "6")[0];
					farmerXPLevelMin.value = farmerXPLevelRange.@low;
					farmerXPLevelMax.value = farmerXPLevelRange.@high;
				}
				if (game.playerLevelRanges[0].range.(@type == "cp").length() > 0)
				{
					var playerCPLevelRange:XML = game.playerLevelRanges[0].range.(@type == "cp")[0];
					playerCPLevelMin.value = playerCPLevelRange.@low;
					playerCPLevelMax.value = playerCPLevelRange.@high;
				}
			}

			gameDuration.value = game.@duration;
			gameDurationCountdown.value = game.@durationCountdown;
			gameDurationEnd.value = game.@durationEnd;
			gameDurationJoinWhilePlaying.value = game.@durationJoinWhilePlaying;
					
			pointsToWin.value = game.@pointsToWin;
			pointsOnPickup.value = game.@pointsOnPickup;
			pointsOnSave.value = game.@pointsOnSave;
			pointsOnCapture.value = game.@pointsOnCapture;
			pointsOnShoot.value = game.@pointsOnShoot;
			pointsOnShot.value = game.@pointsOnShot;
			mustHoldOwnFlags.selected = (game.@mustHoldOwnFlags == "true");

			gameRestrictedActionTags.text = game.@restrictedActionTags;
			gameRequiredActionTags.text = game.@requiredActionTags;
			gameRestrictedModelNames.text = game.@restrictedModelNames;
			gameRequiredModelNames.text = game.@requiredModelNames;

			if (game.itemLevelRanges.length() > 0)
			{
				if (game.itemLevelRanges[0].range.(@type == "1").length() > 0)
				{
					var itemXPLevelRange:XML = game.itemLevelRanges[0].range.(@type == "1")[0];
					itemXPLevelMin.value = itemXPLevelRange.@low;
					itemXPLevelMax.value = itemXPLevelRange.@high;
				}
				if (game.itemLevelRanges[0].range.(@type == "cp").length() > 0)
				{
					var itemCPLevelRange:XML = game.itemLevelRanges[0].range.(@type == "cp")[0];
					itemCPLevelMin.value = itemCPLevelRange.@low;
					itemCPLevelMax.value = itemCPLevelRange.@high;
				}
			}
			
			if (game.attribLevelRanges.length() > 0)
			{
				if (game.attribLevelRanges[0].range.length() > 0)
				{
					var attribLevelRange:XML = game.attribLevelRanges[0].range[0];
					attribLevelMin.value = attribLevelRange.@low;
					attribLevelMax.value = attribLevelRange.@high;
				}
			}
			
			if (game.attribSecondaryLevelRanges.length() > 0)
			{
				if (game.attribSecondaryLevelRanges[0].range.length() > 0)
				{
					var attribSecondaryLevelRange:XML = game.attribSecondaryLevelRanges[0].range[0];
					attribSecondaryLevelMin.value = attribSecondaryLevelRange.@low;
					attribSecondaryLevelMax.value = attribSecondaryLevelRange.@high;
				}
			}
			
			gameFriendlyFire.selected = game.@friendlyFire == "true";
			playerCanBeShot.selected = (game.@playerCanBeShot == "true");
			playerCanBeKilled.selected = (game.@playerCanBeKilled == "true");
			playerKillAttribute.text = game.@playerKillAttribute;
			playerKillValue.value = game.@playerKillValue;
			gameAttributeBarProperty.text = game.@attributeBarProperty;
			gameAttributeBarLow.value = game.@attributeBarLow;
			gameAttributeBarHigh.value = game.@attributeBarHigh;

			var teamFlagColumns:Array = [new DataGridColumn(), new DataGridColumn(), new DataGridColumn(), new DataGridColumn(), new DataGridColumn(), new DataGridColumn(), new DataGridColumn()];
			teamFlagColumns[0].dataField = "@id"; 
			teamFlagColumns[0].headerText = "ID";
			teamFlagColumns[1].dataField = "@name"; 
			teamFlagColumns[1].headerText = "Name";
			teamFlagColumns[2].dataField = "@holdId"; 
			teamFlagColumns[2].headerText = "Held Model ID";
			teamFlagColumns[3].dataField = "@capturesMax"; 
			teamFlagColumns[3].headerText = "Max. captures";
			teamFlagColumns[4].dataField = "@holdersMax"; 
			teamFlagColumns[4].headerText = "Max. holders";
			teamFlagColumns[5].dataField = "@requiredFlagId"; 
			teamFlagColumns[5].headerText = "Required Flag ID";
			teamFlagColumns[6].dataField = "@pointsOnCapture"; 
			teamFlagColumns[6].headerText = "Points on capture";
			
			var teamA:XML = game.teams[0].team[0];
			teamAId.text = teamA.@id;
			teamAName.text = teamA.@name;
			teamAColor.selectedColor = uint(teamA.@color);
			teamAUniformId.text = teamA.@uniformId;
			teamAShootIds.text = teamA.@shootIds;
			teamAShootTags.text = teamA.@shootTags;
			teamAFlags.columns = teamFlagColumns;
			teamAFlags.dataProvider = game.teams[0].team[0].flags[0].flag;
			teamAFlagCount.value = teamAFlags.dataProvider.length;
			teamAAngle.dataProvider = angles.angle;
			for each (var a in angles.angle)
				if (a.@data == teamA.@angle)
					{ teamAAngle.selectedItem = a; break; }
			
			var teamB:XML = game.teams[0].team[1];
			teamBId.text = teamB.@id;
			teamBName.text = teamB.@name;
			teamBColor.selectedColor = uint(teamB.@color)
			teamBUniformId.text = teamB.@uniformId;
			teamBShootIds.text = teamB.@shootIds;
			teamBShootTags.text = teamB.@shootTags;
			teamBFlags.columns = teamFlagColumns;
			teamBFlags.dataProvider = game.teams[0].team[1].flags[0].flag;
			teamBFlagCount.value = teamBFlags.dataProvider.length;
			teamBAngle.dataProvider = angles.angle;
			for each (var a in angles.angle)
				if (a.@data == teamB.@angle)
					{ teamBAngle.selectedItem = a; break; }
					
			if (game.rules.length() > 0)
				rules.htmlText = game.rules[0].text();
				
			rules.setStyle("borderSkin", null);
			
			// Set up target tolerance.
			if (game.hasOwnProperty("@targetToleranceMin"))
			{
				gameTargetToleranceMin.value = game.@targetToleranceMin;
				gameTargetToleranceMax.value = game.@targetToleranceMax;
			}
			else if (game.hasOwnProperty("@targetTolerance"))
			{
				gameTargetToleranceMin.value = game.@targetTolerance;
				gameTargetToleranceMax.value = game.@targetTolerance;
			}
			else
			{
				gameTargetToleranceMin.value = 50;
				gameTargetToleranceMax.value = 50;
			}

			// Set up target click tolerance.
			if (game.hasOwnProperty("@targetClickToleranceMin"))
			{
				gameTargetClickToleranceMin.value = game.@targetClickToleranceMin;
				gameTargetClickToleranceMax.value = game.@targetClickToleranceMax;
			}
			else if (game.hasOwnProperty("@targetClickTolerance"))
			{
				gameTargetClickToleranceMin.value = game.@targetClickTolerance;
				gameTargetClickToleranceMax.value = game.@targetClickTolerance;
			}
			else
			{
				gameTargetClickToleranceMin.value = 40;
				gameTargetClickToleranceMax.value = 40;
			}
			
			// Set up target pan tolerance.
			if (game.hasOwnProperty("@targetPanToleranceMin"))
			{
				gameTargetPanToleranceMin.value = game.@targetPanToleranceMin;
				gameTargetPanToleranceMax.value = game.@targetPanToleranceMax;
			}
			else if (game.hasOwnProperty("@targetPanTolerance"))
			{
				gameTargetPanToleranceMin.value = game.@targetPanTolerance;
				gameTargetPanToleranceMax.value = game.@targetPanTolerance;
			}
			else
			{
				gameTargetPanToleranceMin.value = 40;
				gameTargetPanToleranceMax.value = 40;
			}
			
			gameLimitCamera.selected = game.hasOwnProperty("@limitCamera") ? (game.@limitCamera == "true") : true;
			gameDamageScale.value = game.hasOwnProperty("@damageScale") ? game.@damageScale : 1;
			gameDurationScale.value = game.hasOwnProperty("@durationScale") ? game.@durationScale : 1;
			gameSpeedScale.value = game.hasOwnProperty("@speedScale") ? game.@speedScale : 1;
			gameRangeScale.value = game.hasOwnProperty("@rangeScale") ? game.@rangeScale : 1;
			gameCPBonusCap.value = game.hasOwnProperty("@cpBonusCap") ? game.@cpBonusCap : -1;
					
			// Start on the game page.
			selectPage(0);
		}
		
		/* Save and exit. */
		public function save():void
		{
			game.@name = gameName.text;
			if (gameId.text != "")
				game.@gameId = gameId.text;
			else
				delete game.@gameId;
				
			game.@theme = gameTheme.selectedItem.@data;
			game.@type = "CaptureTheFlagGame";
			game.@minPlayers = gameMinPlayers.value;
			game.@maxPlayers = gameMaxPlayers.value;
			game.@entryFeeCurrency = gameEntryFeeCurrency.currency;
			game.@entryFeeAmount = gameEntryFeeAmount.value;
			game.@challengeAvatarId = Space.instance.avatar.avatarId;
			
			var playerLevelRanges:XML = <playerLevelRanges/>, r:XML;
			if (artistXPLevelMin.value != 0 || artistXPLevelMax.value != 0)
			{
				r = <range type="1"/>;  
				r.@low = artistXPLevelMin.value; 
				r.@high = artistXPLevelMax.value; 
				playerLevelRanges.appendChild(r);
			}
			if (explorerXPLevelMin.value != 0 || explorerXPLevelMax.value != 0)
			{
				r = <range type="2"/>;  
				r.@low = explorerXPLevelMin.value; 
				r.@high = explorerXPLevelMax.value; 
				playerLevelRanges.appendChild(r);
			}
			if (gamerXPLevelMin.value != 0 || gamerXPLevelMax.value != 0)
			{
				r = <range type="3"/>;  
				r.@low = gamerXPLevelMin.value; 
				r.@high = gamerXPLevelMax.value; 
				playerLevelRanges.appendChild(r);
			}
			if (socialXPLevelMin.value != 0 || socialXPLevelMax.value != 0)
			{
				r = <range type="4"/>;  
				r.@low = socialXPLevelMin.value; 
				r.@high = socialXPLevelMax.value; 
				playerLevelRanges.appendChild(r);
			}
			if (arenaXPLevelMin.value != 0 || arenaXPLevelMax.value != 0)
			{
				r = <range type="5"/>;  
				r.@low = arenaXPLevelMin.value; 
				r.@high = arenaXPLevelMax.value; 
				playerLevelRanges.appendChild(r);
			}
			if (farmerXPLevelMin.value != 0 || farmerXPLevelMax.value != 0)
			{
				r = <range type="6"/>;  
				r.@low = farmerXPLevelMin.value; 
				r.@high = farmerXPLevelMax.value; 
				playerLevelRanges.appendChild(r);
			}
			if (playerCPLevelMin.value != 0 || playerCPLevelMax.value != 0)
			{
				r = <range type="cp"/>; 
				r.@low = playerCPLevelMin.value; 
				r.@high = playerCPLevelMax.value; 
				playerLevelRanges.appendChild(r);
			}
				
			if (game.playerLevelRanges.length() > 0)
				game.replace("playerLevelRanges", playerLevelRanges);
			else
				game.appendChild(playerLevelRanges);
			
			game.@duration = gameDuration.value;
			game.@durationCountdown = gameDurationCountdown.value;
			game.@durationEnd = gameDurationEnd.value;
			game.@durationJoinWhilePlaying = gameDurationJoinWhilePlaying.value;
			
			game.@pointsToWin = pointsToWin.value;
			game.@pointsOnPickup = pointsOnPickup.value;
			game.@pointsOnSave = pointsOnSave.value;
			game.@pointsOnCapture = pointsOnCapture.value;
			game.@pointsOnShoot = pointsOnShoot.value;
			game.@pointsOnShot = pointsOnShot.value;
			game.@mustHoldOwnFlags = mustHoldOwnFlags.selected;

			game.@restrictedActionTags = gameRestrictedActionTags.text;
			game.@requiredActionTags = gameRequiredActionTags.text;
			game.@restrictedModelNames = gameRestrictedModelNames.text;
			game.@requiredModelNames = gameRequiredModelNames.text;
			
			var xplo:int = itemXPLevelMin.value;
			var xphi:int = itemXPLevelMax.value;
			var cplo:int = itemCPLevelMin.value;
			var cphi:int = itemCPLevelMax.value;
			var itemLevelRanges:XML = <itemLevelRanges/>, r:XML;
			
			if (xplo != 0 || xphi != 0)
			{
				r = <range type="1"/>;  r.@low = xplo; r.@high = xphi; itemLevelRanges.appendChild(r);
				r = <range type="2"/>;  r.@low = xplo; r.@high = xphi; itemLevelRanges.appendChild(r);
				r = <range type="3"/>;  r.@low = xplo; r.@high = xphi; itemLevelRanges.appendChild(r);
				r = <range type="4"/>;  r.@low = xplo; r.@high = xphi; itemLevelRanges.appendChild(r);
				r = <range type="5"/>;  r.@low = xplo; r.@high = xphi; itemLevelRanges.appendChild(r);
				r = <range type="6"/>;  r.@low = xplo; r.@high = xphi; itemLevelRanges.appendChild(r);
			}
			if (cplo != 0 || cphi != 0)
			{
				r = <range type="cp"/>; r.@low = cplo; r.@high = cphi; itemLevelRanges.appendChild(r);
			}
			if (game.itemLevelRanges.length() > 0)
				game.replace("itemLevelRanges", itemLevelRanges);
			else
				game.appendChild(itemLevelRanges);

			var alo:int = attribLevelMin.value;
			var ahi:int = attribLevelMax.value;
			var attribLevelRanges:XML = <attribLevelRanges/>, r:XML;
			if (alo != 0 || ahi != 0)
			{
				r = <range type="arcane"/>;  r.@low = alo; r.@high = ahi; attribLevelRanges.appendChild(r);
				r = <range type="fire"/>;  r.@low = alo; r.@high = ahi; attribLevelRanges.appendChild(r);
				r = <range type="frost"/>;  r.@low = alo; r.@high = ahi; attribLevelRanges.appendChild(r);
				r = <range type="shadow"/>;  r.@low = alo; r.@high = ahi; attribLevelRanges.appendChild(r);
				r = <range type="nature"/>;  r.@low = alo; r.@high = ahi; attribLevelRanges.appendChild(r);
			}
			if (game.attribLevelRanges.length() > 0)
				game.replace("attribLevelRanges", attribLevelRanges);
			else
				game.appendChild(attribLevelRanges);
				
			var alo:int = attribSecondaryLevelMin.value;
			var ahi:int = attribSecondaryLevelMax.value;
			var attribSecondaryLevelRanges:XML = <attribSecondaryLevelRanges/>, r:XML;
			if (alo != 0 || ahi != 0)
			{
				r = <range type="health"/>;  r.@low = alo; r.@high = ahi; attribSecondaryLevelRanges.appendChild(r);
				r = <range type="speed"/>;  r.@low = alo; r.@high = ahi; attribSecondaryLevelRanges.appendChild(r);
			}
			if (game.attribSecondaryLevelRanges.length() > 0)
				game.replace("attribSecondaryLevelRanges", attribSecondaryLevelRanges);
			else
				game.appendChild(attribSecondaryLevelRanges);
				
			game.@friendlyFire = gameFriendlyFire.selected ? "true" : "false";
			game.@playerCanBeShot = playerCanBeShot.selected ? "true" : "false";
			game.@playerCanBeKilled = playerCanBeKilled.selected ? "true" : "false";
			game.@playerKillAttribute = playerKillAttribute.text;
			game.@playerKillValue = playerKillValue.value;
			game.@attributeBarProperty = gameAttributeBarProperty.text;
			game.@attributeBarLow = gameAttributeBarLow.value;
			game.@attributeBarHigh = gameAttributeBarHigh.value;
			
			var teamA:XML = game.teams[0].team[0];
			teamA.@id = teamAId.text;
			teamA.@name = teamAName.text;
			teamA.@color = "0x" + Number(teamAColor.selectedColor).toString(16);
			teamA.@uniformId = teamAUniformId.text;
			teamA.@shootIds = teamAShootIds.text;
			teamA.@shootTags = teamAShootTags.text;
			teamA.@angle = teamAAngle.selectedItem.@data;

			var teamB:XML = game.teams[0].team[1];
			teamB.@id = teamBId.text;
			teamB.@name = teamBName.text;
			teamB.@color = "0x" + Number(teamBColor.selectedColor).toString(16);
			teamB.@uniformId = teamBUniformId.text;
			teamB.@shootIds = teamBShootIds.text;
			teamB.@shootTags = teamBShootTags.text;
			teamB.@angle = teamBAngle.selectedItem.@data;
			
			if (game.rules.length() == 0)
				game.appendChild(<rules/>);
			game.rules[0].setChildren(rules.htmlText);
			
			game.@targetToleranceMin = gameTargetToleranceMin.value;
			game.@targetToleranceMax = gameTargetToleranceMax.value;
			game.@targetClickToleranceMin = gameTargetClickToleranceMin.value;
			game.@targetClickToleranceMax = gameTargetClickToleranceMax.value;
			game.@targetPanToleranceMin = gameTargetPanToleranceMin.value;
			game.@targetPanToleranceMax = gameTargetPanToleranceMax.value;
			game.@limitCamera = gameLimitCamera.selected;
			game.@damageScale = gameDamageScale.value;
			game.@durationScale = gameDurationScale.value;
			game.@speedScale = gameSpeedScale.value;
			game.@rangeScale = gameRangeScale.value;
			if (gameCPBonusCap.value >= 0)
				game.@cpBonusCap = gameCPBonusCap.value;
			else
				delete game.@cpBonusCap;
			
			item.setConfigSection(game);
			
			hud.hudState = Hud.NORMAL_STATE;
		}
		
		/* Cancel and exit. */
		public function cancel():void
		{
			hud.hudState = Hud.NORMAL_STATE;
		}
		
		private function onTeamAFlagCountChange():void
			{ resizeTeamFlags(teamAFlags, game.teams[0].team[0].flags[0], teamAFlagCount.value); }
		
		private function onTeamBFlagCountChange():void
			{ resizeTeamFlags(teamBFlags, game.teams[0].team[1].flags[0], teamBFlagCount.value); }
			
		private function resizeTeamFlags(grid:Object, flags:XML, size:int):void
		{
			printf("Resizing flags to: " + size);
			var n:int = flags.flag.length();
			var result:XML = <flags/>;
			for (var i:int = 0; i<size; i++)
				result.appendChild((i < n) ? flags.flag[i] : <flag id="Flag" name="Flag"/>);
			
			flags.flag = result.flag;
			grid.dataProvider = flags.flag;
		}
		
		
		]]>
	</mx:Script>
	
	<mx:Canvas width="100%" height="100%" >
		
		<mx:VBox verticalGap="4" top="40" left="20">
			<mx:SWButton id="buttonGame"
				styleName="genericInsetButton" height="24" label="General" 
				toggle="true" toggleableWithMouse="false"
				toolTip="View general game settings" 
				click="this.selectPage(0)" />
			<mx:SWButton id="buttonLevels"
				styleName="genericInsetButton" height="24" label="Levels" 
				toggle="true" toggleableWithMouse="false"
				toolTip="View game level restriction settings" 
				click="this.selectPage(1)" />
			<mx:SWButton id="buttonTimes"
				styleName="genericInsetButton" height="24" label="Timing" 
				toggle="true" toggleableWithMouse="false"
				toolTip="View game timing settings" 
				click="this.selectPage(2)" />
			<mx:SWButton id="buttonScore"
				styleName="genericInsetButton" height="24" label="Scoring" 
				toggle="true" toggleableWithMouse="false"
				toolTip="View game scoring settings" 
				click="this.selectPage(3)" />
			<mx:SWButton id="buttonActions"
				styleName="genericInsetButton" height="24" label="Items" 
				toggle="true" toggleableWithMouse="false"
				toolTip="View game settings for item actions" 
				click="this.selectPage(4)" />
			<mx:SWButton id="buttonShooting"
				styleName="genericInsetButton" height="24" label="Shooting" 
				toggle="true" toggleableWithMouse="false"
				toolTip="View shooting settings" 
				click="this.selectPage(5)" />
			<mx:SWButton id="buttonTeamA"
				styleName="genericInsetButton" height="24" label="Team A" 
				toggle="true" toggleableWithMouse="false"
				toolTip="View Team A settings" 
				click="this.selectPage(6)" />
			<mx:SWButton id="buttonTeamB"
				styleName="genericInsetButton" height="24" label="Team B" 
				toggle="true" toggleableWithMouse="false"
				toolTip="View Team B settings" 
				click="this.selectPage(7)" />
			<mx:SWButton id="buttonRules"
				styleName="genericInsetButton" height="24" label="Rules" 
				toggle="true" toggleableWithMouse="false"
				toolTip="Game rules description" 
				click="this.selectPage(8)" />
			<mx:SWButton id="buttonTweaks"
				styleName="genericInsetButton" height="24" label="Tweaks" 
				toggle="true" toggleableWithMouse="false"
				toolTip="Game tweaks" 
				click="this.selectPage(9)" />
		</mx:VBox>
		
		<mx:Canvas width="585" top="40" left="100" bottom="50" 
			styleName="inWorldDockPanelBackground" />
			
		<mx:ViewStack id="pages" width="600" top="35" left="95" bottom="40" creationPolicy="all">
			
			<mx:Form width="100%" height="100%" >
				<mx:Label fontWeight="bold" text="General Game Settings" />
				<mx:FormItem label="Game name" width="350">
					<mx:TextInput id="gameName" width="100%" />
				</mx:FormItem>
				<mx:FormItem label="Game ID (Optional)" width="350">
					<mx:TextInput id="gameId" width="100%" />
				</mx:FormItem>
				<mx:FormItem label="Theme" width="350">
					<mx:ComboBox id="gameTheme" width="100%" labelField="@label"/>
				</mx:FormItem>
				<mx:FormItem label="Number of players" direction="horizontal" width="350">
					<mx:NumericStepper id="gameMinPlayers" minimum="2" maximum="30" width="100%"
						toolTip="The minimum number of players in this game." />
					<mx:Label text="to"/>
					<mx:NumericStepper id="gameMaxPlayers" minimum="2" maximum="30" width="100%"
						toolTip="The maximum number of players in this game." />
				</mx:FormItem>
				<mx:FormItem label="Entry fee" direction="horizontal" verticalAlign="middle" width="350">
					<mx:CurrencySelector id="gameEntryFeeCurrency"/>
					<mx:NumericStepper id="gameEntryFeeAmount" minimum="0" maximum="99999"
						width="100%"
						toolTip="Entry fee for this game." />
				</mx:FormItem>
			</mx:Form>
			
			<mx:Form width="100%" height="100%">
				<mx:Label fontWeight="bold" text="Level Restriction Settings" />
				<mx:FormItem label="Artist level range" direction="horizontal" width="350">
					<mx:NumericStepper id="artistXPLevelMin" minimum="0" maximum="1000" width="100%" />
					<mx:Label text="to"/>
					<mx:NumericStepper id="artistXPLevelMax" minimum="0" maximum="1000" width="100%" />
				</mx:FormItem>
				<mx:FormItem label="Explorer level range" direction="horizontal" width="350">
					<mx:NumericStepper id="explorerXPLevelMin" minimum="0" maximum="1000" width="100%" />
					<mx:Label text="to"/>
					<mx:NumericStepper id="explorerXPLevelMax" minimum="0" maximum="1000" width="100%" />
				</mx:FormItem>
				<mx:FormItem label="Gamer level range" direction="horizontal" width="350">
					<mx:NumericStepper id="gamerXPLevelMin" minimum="0" maximum="1000" width="100%" />
					<mx:Label text="to"/>
					<mx:NumericStepper id="gamerXPLevelMax" minimum="0" maximum="1000" width="100%" />
				</mx:FormItem>
				<mx:FormItem label="Social level range" direction="horizontal" width="350">
					<mx:NumericStepper id="socialXPLevelMin" minimum="0" maximum="1000" width="100%" />
					<mx:Label text="to"/>
					<mx:NumericStepper id="socialXPLevelMax" minimum="0" maximum="1000" width="100%" />
				</mx:FormItem>
				<mx:FormItem label="Arena level range" direction="horizontal" width="350">
					<mx:NumericStepper id="arenaXPLevelMin" minimum="0" maximum="1000" width="100%" />
					<mx:Label text="to"/>
					<mx:NumericStepper id="arenaXPLevelMax" minimum="0" maximum="1000" width="100%" />
				</mx:FormItem>
				<mx:FormItem label="Farmer level range" direction="horizontal" width="350">
					<mx:NumericStepper id="farmerXPLevelMin" minimum="0" maximum="1000" width="100%" />
					<mx:Label text="to"/>
					<mx:NumericStepper id="farmerXPLevelMax" minimum="0" maximum="1000" width="100%" />
				</mx:FormItem>
				<mx:FormItem label="CP level range" direction="horizontal" width="350">
					<mx:NumericStepper id="playerCPLevelMin" minimum="0" maximum="1000" width="100%" />
					<mx:Label text="to"/>
					<mx:NumericStepper id="playerCPLevelMax" minimum="0" maximum="1000" width="100%" />
				</mx:FormItem>
			</mx:Form>
			
			<mx:Form width="100%" height="100%">
				<mx:Label fontWeight="bold" text="Timing Settings" />
				<mx:FormItem label="Countdown" direction="horizontal">
					<mx:NumericStepper id="gameDurationCountdown" minimum="1" maximum="60" width="150"
						toolTip="The duration of the game countdown phase, in seconds." />
					<mx:Label text="seconds" />
				</mx:FormItem>
				<mx:FormItem label="Round duration" direction="horizontal">
					<mx:NumericStepper id="gameDuration" minimum="0" maximum="86400" width="150"
						toolTip="The duration of a single round, in seconds." />
					<mx:Label text="seconds" />
				</mx:FormItem>
				<mx:FormItem label="Join window" direction="horizontal">
					<mx:NumericStepper id="gameDurationJoinWhilePlaying" minimum="0" maximum="86400" width="150"
						toolTip="The time window during which players are allowed to join an round in progress." />
					<mx:Label text="seconds" />
				</mx:FormItem>
				<mx:FormItem label="Game Over" direction="horizontal">
					<mx:NumericStepper id="gameDurationEnd" minimum="1" maximum="60" width="150"
						toolTip="The duration of the game-over phase, in seconds." />
					<mx:Label text="seconds" />
				</mx:FormItem>
			</mx:Form>

			<mx:Form width="100%" height="100%">
				<mx:Label fontWeight="bold" text="Scoring Settings" />
				<mx:FormItem label="Score to win" direction="horizontal">
					<mx:NumericStepper id="pointsToWin" minimum="1" maximum="100" width="150"
						toolTip="The number of points a team must score to win the game." />
					<mx:Label text="points" />
				</mx:FormItem>
				<mx:FormItem label="Flag pickup" direction="horizontal">
					<mx:NumericStepper id="pointsOnPickup" minimum="-1000" maximum="1000" width="150"
						toolTip="Points awarded to team (and player) for picking up the flag." />
					<mx:Label text="points" />
				</mx:FormItem>
				<mx:FormItem label="Flag saved" direction="horizontal">
					<mx:NumericStepper id="pointsOnSave" minimum="-1000" maximum="1000" width="150"
						toolTip="Points awarded to team (and player) for saving the flag." />
					<mx:Label text="points" />
				</mx:FormItem>
				<mx:FormItem label="Flag capture" direction="horizontal">
					<mx:NumericStepper id="pointsOnCapture" minimum="-1000" maximum="1000" width="150"
						toolTip="Points awarded to team (and player) for capturing the flag." />
					<mx:Label text="points" />
				</mx:FormItem>
				<mx:FormItem label="" direction="horizontal">
					<mx:CheckBox id="mustHoldOwnFlags" label="Team must hold own flags to capture"
						toolTip="Whether the player's team flags are required to be at base in order to capture an enemy flag."/>
				</mx:FormItem>
				<mx:FormItem label="Shooting an enemy" direction="horizontal">
					<mx:NumericStepper id="pointsOnShoot" minimum="-1000" maximum="1000" width="150"
						toolTip="Points awarded to team (and player) for shooting an enemy." />
					<mx:Label text="points" />
				</mx:FormItem>
				<mx:FormItem label="Getting shot" direction="horizontal">
					<mx:NumericStepper id="pointsOnShot" minimum="-1000" maximum="1000" width="150"
						toolTip="Points deducted from team (and player) for getting shot." />
					<mx:Label text="points" />
				</mx:FormItem>
			</mx:Form>
			
			<mx:Form width="100%" height="100%">
				<mx:Label fontWeight="bold" text="Item Restriction Settings" />
				<mx:FormItem label="Restricted tags">
					<mx:SelfLabelingTextInput id="gameRestrictedActionTags" width="350" 
						label="Restricted action tags..." />
				</mx:FormItem>
				<mx:FormItem label="Required tags">
					<mx:SelfLabelingTextInput id="gameRequiredActionTags" width="350" 
						label="Required action tags..." />
				</mx:FormItem>
				<mx:FormItem label="Restricted names">
					<mx:SelfLabelingTextInput id="gameRestrictedModelNames" width="350" 
						label="Restricted item names..." />
				</mx:FormItem>
				<mx:FormItem label="Required names">
					<mx:SelfLabelingTextInput id="gameRequiredModelNames" width="350" 
						label="Required item names..." />
				</mx:FormItem>
				<mx:FormItem label="XP level range" direction="horizontal" width="350">
					<mx:NumericStepper id="itemXPLevelMin" minimum="0" maximum="1000" width="100%" />
					<mx:Label text="to"/>
					<mx:NumericStepper id="itemXPLevelMax" minimum="0" maximum="1000" width="100%" />
				</mx:FormItem>
				<mx:FormItem label="CP level range" direction="horizontal" width="350">
					<mx:NumericStepper id="itemCPLevelMin" minimum="0" maximum="1000" width="100%" />
					<mx:Label text="to"/>
					<mx:NumericStepper id="itemCPLevelMax" minimum="0" maximum="1000" width="100%" />
				</mx:FormItem>
				<mx:FormItem label="Primary attributes" direction="horizontal" width="350">
					<mx:NumericStepper id="attribLevelMin" minimum="-1000" maximum="1000" width="100%" />
					<mx:Label text="to"/>
					<mx:NumericStepper id="attribLevelMax" minimum="0" maximum="1000" width="100%" />
				</mx:FormItem>
				<mx:FormItem label="Secondary attributes" direction="horizontal" width="350">
					<mx:NumericStepper id="attribSecondaryLevelMin" minimum="-1000" maximum="1000" width="100%" />
					<mx:Label text="to"/>
					<mx:NumericStepper id="attribSecondaryLevelMax" minimum="0" maximum="1000" width="100%" />
				</mx:FormItem>
			</mx:Form>
			
			<mx:Form width="100%" height="100%">
				<mx:Label fontWeight="bold" text="Shooting Settings" />
				<mx:FormItem label="General">
					<mx:CheckBox id="gameFriendlyFire" label="Allow friendly fire"
						toolTip="Whether friendly fire is enabled - that is, whether players on the same team can shoot eachother."/>
					<mx:CheckBox id="playerCanBeShot" label="Use specific weapons to detect shooting"
						toolTip="Whether weapon ids (in team settings) are used to determine if a player has been shot."/>
				</mx:FormItem>
				<mx:FormItem>
					<mx:CheckBox id="playerCanBeKilled" label="Use attributes to detect shooting"
						toolTip="Whether to check attributes to determine if a player has been shot."/>
				</mx:FormItem>
				<mx:FormItem label="Attribute" direction="horizontal">
					<mx:SelfLabelingTextInput id="playerKillAttribute" width="150" 
						label="Attribute name..."
						toolTip="The attribute used to determine when a player is shot." />
					<mx:Label text="less than" />
					<mx:NumericStepper id="playerKillValue" minimum="-1000" maximum="1000"
						toolTip="The attribute value threshold, below which the player is considered to have been shot." />
				</mx:FormItem>
				<mx:FormItem label="Attribute bar" direction="horizontal">
					<mx:SelfLabelingTextInput id="gameAttributeBarProperty" width="150" 
						label="Attribute name..."
						toolTip="The attribute displayed above the players' heads." />
					<mx:NumericStepper id="gameAttributeBarLow" minimum="-1000" maximum="1000"
						toolTip="The attribute bar's minimum value." />
					<mx:NumericStepper id="gameAttributeBarHigh" minimum="-1000" maximum="1000"
						toolTip="The attribute bar's maximum value." />
				</mx:FormItem>
			</mx:Form>
			
			<mx:Form width="100%" height="100%">
				<mx:Label fontWeight="bold" text="Team A Settings" />
				<mx:FormItem label="Identity" direction="horizontal">
					<mx:SelfLabelingTextInput id="teamAId" width="150" label="Team ID" />
					<mx:SelfLabelingTextInput id="teamAName" width="150" label="Team Name" />
					<mx:ColorPicker id="teamAColor" />
				</mx:FormItem>
				<mx:FormItem label="Starting Angle" direction="horizontal">
					<mx:ComboBox id="teamAAngle" width="150" labelField="@label"/>
					<mx:Label text="degrees" />
				</mx:FormItem>
				<mx:FormItem label="Uniform">
					<mx:SelfLabelingTextInput id="teamAUniformId" width="150" label="Uniform ID" />
				</mx:FormItem>
				<mx:FormItem label="Weapons" direction="horizontal">
					<mx:SelfLabelingTextInput id="teamAShootIds" width="150" label="Weapon Model IDs" />
					<mx:SelfLabelingTextInput id="teamAShootTags" width="150" label="Weapon Model Tags" />
				</mx:FormItem>
				<mx:FormItem label="Flags" width="100%">
					<mx:NumericStepper id="teamAFlagCount" minimum="1" maximum="10" width="150"
						toolTip="The number of flags that this team has"
						change="onTeamAFlagCountChange()" />
				</mx:FormItem>
				<mx:DataGrid id="teamAFlags" width="100%" height="100%" editable="true"/>
			</mx:Form>
			
			<mx:Form width="100%" height="100%">
				<mx:Label fontWeight="bold" text="Team B Settings" />
				<mx:FormItem label="Identity" direction="horizontal">
					<mx:SelfLabelingTextInput id="teamBId" width="150" label="Team ID" />
					<mx:SelfLabelingTextInput id="teamBName" width="150" label="Team Name" />
					<mx:ColorPicker id="teamBColor" />
				</mx:FormItem>
				<mx:FormItem label="Starting Angle" direction="horizontal">
					<mx:ComboBox id="teamBAngle" width="150" labelField="@label"/>
					<mx:Label text="degrees" />
				</mx:FormItem>
				<mx:FormItem label="Uniform">
					<mx:SelfLabelingTextInput id="teamBUniformId" width="150" label="Uniform ID" />
				</mx:FormItem>
				<mx:FormItem label="Weapons" direction="horizontal">
					<mx:SelfLabelingTextInput id="teamBShootIds" width="150" label="Weapon Model IDs" />
					<mx:SelfLabelingTextInput id="teamBShootTags" width="150" label="Weapon Model Tags" />
				</mx:FormItem>
				<mx:FormItem label="Flags" width="100%">
					<mx:NumericStepper id="teamBFlagCount" minimum="1" maximum="10" width="150"
						toolTip="The number of flags that this team has"
						change="onTeamBFlagCountChange()" />
				</mx:FormItem>
				<mx:DataGrid id="teamBFlags" width="100%" height="100%" editable="true"/>
			</mx:Form>
			
			<mx:Form width="100%" height="100%">
				<mx:Label fontWeight="bold" text="Rules and Description Settings" />
				<mx:RichTextEditor 
					id="rules" width="100%" height="100%"
					borderStyle="none"
					borderThickness="0"
					paddingLeft="0"
					paddingRight="0" 
					paddingTop="0"
					paddingBottom="50" 
					horizontalScrollPolicy="off"
					verticalScrollPolicy="off"
					/>
			</mx:Form>
			
			<mx:Form width="100%" height="100%">
				<mx:Label fontWeight="bold" text="Tweak Settings" />
				<mx:FormItem label="Target tolerance" width="100%" direction="horizontal">
					<mx:NumericStepper id="gameTargetToleranceMin" minimum="0" maximum="1000" width="70"
						toolTip="How close a player must click to a target to select it, in pixels." />
					<mx:Label text="to" />
					<mx:NumericStepper id="gameTargetToleranceMax" minimum="0" maximum="1000" width="70"
						toolTip="How close a player must click to a target to select it, in pixels." />
					<mx:Label text="pixels" />
				</mx:FormItem>
				<mx:FormItem label="Click tolerance" width="100%" direction="horizontal">
					<mx:NumericStepper id="gameTargetClickToleranceMin" minimum="0" maximum="1000" width="70"
						toolTip="When targetting, how much a player's mouse can move between mouse down and up, in pixels." />
					<mx:Label text="to" />
					<mx:NumericStepper id="gameTargetClickToleranceMax" minimum="0" maximum="1000" width="70"
						toolTip="When targetting, how much a player's mouse can move between mouse down and up, in pixels." />
					<mx:Label text="pixels" />
				</mx:FormItem>
				<mx:FormItem label="Pan tolerance" width="100%" direction="horizontal">
					<mx:NumericStepper id="gameTargetPanToleranceMin" minimum="0" maximum="1000" width="70"
						toolTip="When targetting, how much a player's mouse moves before panning begins." />
					<mx:Label text="to" />
					<mx:NumericStepper id="gameTargetPanToleranceMax" minimum="0" maximum="1000" width="70"
						toolTip="When targetting, how much a player's mouse moves before panning begins." />
					<mx:Label text="pixels" />
					<mx:CheckBox id="gameLimitCamera" label="Keep in view"
						toolTip="Whether the player is always kept in view."/>
				</mx:FormItem>
				<mx:FormItem label="Damage scale" width="100%" direction="horizontal">
					<mx:NumericStepper id="gameDamageScale" minimum="0" maximum="20" stepSize="0.01" width="150"
						toolTip="Scale factor for adjusting item damages." />
					<mx:Label text="x" />
				</mx:FormItem>
				<mx:FormItem label="Duration scale" width="100%" direction="horizontal">
					<mx:NumericStepper id="gameDurationScale" minimum="0" maximum="20" stepSize="0.01" width="150"
						toolTip="Scale factor for adjusting the duration of item effects." />
					<mx:Label text="x" />
				</mx:FormItem>
				<mx:FormItem label="Range scale" width="100%" direction="horizontal">
					<mx:NumericStepper id="gameRangeScale" minimum="0" maximum="20" stepSize="0.01" width="150"
						toolTip="Scale factor for adjusting item ranges." />
					<mx:Label text="x" />
				</mx:FormItem>
				<mx:FormItem label="Speed scale" width="100%" direction="horizontal">
					<mx:NumericStepper id="gameSpeedScale" minimum="0" maximum="20" stepSize="0.01" width="150"
						toolTip="Scale factor for adjusting differences in player speed." />
					<mx:Label text="x" />
				</mx:FormItem>
				<mx:FormItem label="CP Bonus cap" width="100%" direction="horizontal">
					<mx:NumericStepper id="gameCPBonusCap" minimum="-1" maximum="100" width="150"
						toolTip="Cap placed on player CP attribute bonuses (-1 for no capping)" />
					<mx:Label text="points" />
				</mx:FormItem>
				
			</mx:Form>
		</mx:ViewStack>
		
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
		configDefault:configDefault, 
		themes:themes,
		angles:angles
	});