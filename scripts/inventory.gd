extends RefCounted
class_name InventoryManager


var contents : Dictionary[String, int] = {};


func add_item(item: Item) -> void:
	contents[item.item_name] = contents.get_or_add(item.item_name, 0) + 1;


func remove_item(item: Item) -> void:
	contents[item.item_name] = contents.get_or_add(item.item_name, 0) - 1;
	if contents[item.item_name] <= 0:
		contents.erase(item.item_name);
