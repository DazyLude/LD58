extends Control
class_name LevelInventoryDisplay


var item_icon_pckd : PackedScene = preload("res://scenes/level/item_icon.tscn");


@onready
var item_container := $HBoxContainer;
var item_icons : Array[ItemIcon] = [];


func update() -> void:
	var idx = 0;
	
	for item in GameState.inventory.contents:
		var item_count = GameState.inventory.contents[item];
		get_ith_item_icon(idx).set_item(item, item_count);
		idx += 1;
	
	if item_icons.size() > idx:
		for i in range(idx, item_icons.size()):
			item_icons[i].hide();


func get_ith_item_icon(i: int) -> ItemIcon:
	if i < item_icons.size():
		item_icons[i].show();
		return item_icons[i];
	else:
		var new_icon : ItemIcon = item_icon_pckd.instantiate();
		item_container.add_child(new_icon);
		item_icons.push_back(new_icon);
		return new_icon;
