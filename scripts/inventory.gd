extends RefCounted
class_name InventoryManager


var contents : Dictionary[String, int] = {};


func get_item_count_by_name(item: String) -> int:
	return contents.get(item, 0);


func add_item(item: Item, count: int = 1) -> void:
	add_item_by_name(item.item_name, count);


func add_item_by_name(item: String, count: int = 1) -> void:
	contents[item] = contents.get_or_add(item, 0) + count;


func remove_item(item: Item, count: int = 1) -> void:
	remove_item_by_name(item.item_name, count);


func remove_item_by_name(item: String, count: int = 1) -> void:
	contents[item] = contents.get_or_add(item, 0) - count;
	if contents[item] <= 0:
		contents.erase(item);
