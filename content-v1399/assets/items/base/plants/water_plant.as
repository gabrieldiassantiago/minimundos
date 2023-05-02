import com.smallworlds.entity.item.WidgetItem;

// Ask plant widget UI to handle the watering process.
var widgetItem:WidgetItem = entity as WidgetItem;

if (widgetItem.widget)
	if (widgetItem.widget.panelUI)
		widgetItem.widget.panelUI.waterPlant();