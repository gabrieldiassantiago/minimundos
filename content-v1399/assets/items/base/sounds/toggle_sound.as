import com.smallworlds.entity.item.Item;

// Get the item.
var item:Item = entity as Item;

// Switch the button to the on state.
if(item)
{
	// Check if the sequence is 0 or 1 based.
	var zeroBased:Boolean = item.getDataValue("00") != null;

	// Get the current animation and separate the state and symbol.
	var animation:String = item.animation ? item.animation : (zeroBased ? "Off_00" : "Off_01");
	var symbol:String = animation.substring(animation.length - 2);
	var state:String = animation.substring(0, animation.length - 3);

	// Toggle the state.
	if (state == "On")
		state = "Off";
	else if (state == "Off")
		state = "On"
	else
	{ 
		state = "On";
		symbol = (zeroBased ? "00" : "01");
	}

	// Recompose the animation.
	animation = state + "_" + symbol;
		
	// Apply the animation.
	item.animation = animation;
	item.animationState = "started";

	// Dispatch the symbol action event.
	var action:String = item.getDataValue(symbol);

	if(action)
		item.dispatchActionTrigger(action + " " + state);
}