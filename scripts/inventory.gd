extends RefCounted
class_name InventoryManager


static var item_weight_table : Dictionary[String, float] = {};
static var item_cost_table : Dictionary[String, float] = {};
static var item_description_table : Dictionary[String, String] = {};
static var item_shop_name_table : Dictionary[String, String] = {};
static var droppable : Dictionary[String, RefCounted] = {};



var contents : Dictionary[String, int] = {};


var current_weight : float:
	get:
		var sum := 0.0; 
		for item in contents:
			sum += contents[item] * item_weight_table.get(item, 0.0);
		return sum;


func get_item_official_name(item: String) -> String:
	if not has_item_data_cached(item):
		save_items_data_by_name(item);
	
	return item_shop_name_table.get(item, "");


func get_item_desc(item: String) -> String:
	if not has_item_data_cached(item):
		save_items_data_by_name(item);
	
	return item_description_table.get(item, "");


func get_item_count(item: String) -> int:
	if not has_item_data_cached(item):
		save_items_data_by_name(item);
	
	return contents.get(item, 0);


func get_item_cost(item: String) -> int:
	if not has_item_data_cached(item):
		save_items_data_by_name(item);
	
	return item_cost_table.get(item, 0);


func add_item(item: Item, count: int = 1) -> void:
	if not has_item_data_cached(item.item_name):
		save_items_data(item);
	
	add_item_by_name(item.item_name, count);


func add_item_by_name(item: String, count: int = 1) -> void:
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



func save_items_data_by_name(item: String) -> void:
	var instance : Item = ItemsDB.get_item(item).instantiate();
	save_items_data(instance);
	instance.queue_free();


func save_items_data(item: Item) -> void:
	item_weight_table[item.item_name] = item.weight;
	item_cost_table[item.item_name] = item.cost;
	item_description_table[item.item_name] = item.description;
	item_shop_name_table[item.item_name] = item.item_official_name;
	
	if item.can_be_dropped:
		droppable[item.item_name] = null;


func has_item_data_cached(item: String) -> bool:
	return item_weight_table.has(item)
