import com.smallworlds.entity.item.Item;
import com.smallworlds.player.context.model.entity.item.ItemMainMenu;
import com.smallworlds.player.context.model.entity.item.ItemScriptMenuAction;

// Set up the menu model for this item.
var item:Item = entity as Item;
var m:ItemMainMenu = new ItemMainMenu(item);
m.addScriptAction("action", "itemPlayInstrument", 
	"context/item/action/icon_play_deluxedrums.png");
m.addDefaultChildren();

application.player.contextualMenu.open(m);