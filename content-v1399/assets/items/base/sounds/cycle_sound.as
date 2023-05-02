import com.smallworlds.entity.item.Item;

// Get the item.
var item:Item = entity as Item;

// Switch the button to the on state.
if(item)
{
	// Find how many sounds there are in total.
	var count:int = item.getDataValue("count");

	// Check if the sequence is 0 or 1 based.
	var zeroBased:Boolean = item.getDataValue("00") != null;

	// Get the current animation and separate the state and symbol.
	var animation:String = item.animation ? item.animation : (zeroBased ? "Off_00" : "Off_01");
	var symbol:String = animation.substring(animation.length - 2);
	var state:String = animation.substring(0, animation.length - 3);

	// Increment the symbol index.
	var index:int = int(symbol);

	if(isNaN(index))
		return;

	index++;

	// Wrap the index to the total symbol count.
	if(zeroBased)
	{
		if(index >= count)
			index = 0;
	}
	else
	{
		if(index > count)
			index = 1;
	}

	// Set the symbol to the new index and pad if necessary.
	symbol = String(index);

	if(symbol.length < 2)
		symbol = "0" + symbol;

	// Recompose the animation.
	animation = state + "_" + symbol;

	// Apply the animation.
	item.animation = animation;
	item.animationState = "started";

	// Dispatch the action event.
	var action:String = item.getDataValue(symbol);

	if(action)
		item.dispatchActionTrigger(action + " " + state);
}