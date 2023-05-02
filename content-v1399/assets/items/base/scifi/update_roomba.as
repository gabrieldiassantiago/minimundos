import com.smallworlds.entity.item.Item;

var item:Item = entity as Item;

// Make the roomba spawn item visible to owners/administrators only.
item.visible = item.canAdmin;