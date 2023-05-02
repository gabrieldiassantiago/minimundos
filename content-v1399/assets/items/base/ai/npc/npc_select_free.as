import com.smallworlds.entity.item.ai.npc.NPCItem;
import com.smallworlds.player.context.model.entity.EntityMenuModel;
import com.smallworlds.player.context.model.entity.avatar.ai.npc.NPCMainMenu;

// Set up the menu model for this item.
var item:NPCItem = entity as NPCItem;
var m:EntityMenuModel = new NPCMainMenu(item.avatar);
application.player.contextualMenu.open(m);
