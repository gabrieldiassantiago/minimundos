import com.smallworlds.entity.item.Item;

var item:Item = entity as Item;

// Make the sound item visible to owners/administrators.
if (item.spriteNode)
	item.spriteNode.alpha = ((space.displaySpecialItems && item.canAdmin) || item.forSale) ? 1 : 0;

