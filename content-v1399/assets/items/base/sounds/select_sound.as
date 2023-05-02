import com.smallworlds.entity.item.Item;
import com.smallworlds.player.context.model.entity.item.ItemMainMenu;
import com.smallworlds.player.context.model.entity.item.ItemScriptMenuAction;

// Set up the menu model for this item.
var item:Item = entity as Item;
var isOff:Boolean = (item.animation ? item.animation.indexOf("Off") >= 0 : false);

var m:ItemMainMenu = new ItemMainMenu(item);
if (isOff)
	m.addScriptAction("toggle", "itemTurnOn", 
		"context/item/action/icon_light_on.png");
else
	m.addScriptAction("toggle", "itemTurnOff", 
		"context/item/action/icon_light_off.png");

m.addScriptAction("action", "itemConfigureSounds", 
	"context/item/action/icon_sounds.png");

m.addDefaultChildren();

application.player.contextualMenu.open(m);