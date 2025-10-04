extends RefCounted
class_name InventoryManager


static var item_weight_table : Dictionary[String, float] = {};
static var item_cost_table : Dictionary[String, float] = {};
static var droppable : Dictionary[String, RefCounted] = {};


var contents : Dictionary[String, int] = {};


var current_weight : float:
	get:
		var sum := 0.0; 
		for item in contents:
			sum += contents[item] * item_weight_table[item];
		return sum;


func get_item_count(item: String) -> int:
	return contents.get(item, 0);


func get_item_cost(item: String) -> int:
	return item_cost_table.get(item, 0);


func add_item(item: Item, count: int = 1) -> void:
	var item_name := item.item_name;
	
	if not item_name in item_weight_table:
		item_weight_table[item_name] = item.weight;
		item_cost_table[item_name] = item.cost;
		
		if item.can_be_dropped:
			droppable[item_name] = null;
	
	add_item_by_name(item_name, count);


func add_item_by_name(item: String, count: int = 1) -> void:
	if not item in item_weight_table:
		var instance : Item = ItemsDB.get_item(item).instantiate();
		item_weight_table[item] = instance.weight;
		item_cost_table[item] = instance.cost;
		if instance.can_be_dropped:
			droppable[item] = null;
	
	contents[item] = contents.get_or_add(item, 0) + count;


func remove_item(item: Item, count: int = 1) -> void:
	remove_item_by_name(item.item_name, count);


func remove_item_by_name(item: String, count: int = 1) -> void:
	contents[item] = contents.get_or_add(item, 0) - count;
	if contents[item] <= 0:
		contents.erase(item);


func drop_random_item() -> String:
	var droppable_existing := contents.keys().filter(func(i): return i in droppable);
	var item = droppable_existing.pick_random();
	
	remove_item_by_name(item, 1);
	
	return item;
	
