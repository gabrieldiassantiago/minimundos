import com.smallworlds.entity.item.Item;

// Hide the control UI.
hud.hideControlUI();

// Get the item.
var item:Item = entity as Item;

// Toggle the animation on or off if the user has access rights.
if (item.canUse)
	item.executeScriptedEvent("toggle");
