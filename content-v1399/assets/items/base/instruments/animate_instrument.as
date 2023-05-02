import com.smallworlds.entity.item.Item;

// Get the item.
var item:Item = entity as Item;

// Start the animation specified on the parameters for this scope.
if (item && params && params.length > 0)
{
  // Get the the new animation.
  var newAnimation:String = params[0];

  // Return no change if the animation is the same.
  if (newAnimation == "Idle")
    item.animation = newAnimation;
  else if (newAnimation.indexOf("Loop") == 0)
    item.animation = newAnimation;
  else if (item.animation == newAnimation + "_01")
    item.animation = newAnimation + "_02"
  else
    item.animation = newAnimation + "_01";
  
  // Set and start the animation.
  item.animationState = "started";

  return "ok";
}