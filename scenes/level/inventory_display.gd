extends Control
class_name LevelInventoryDisplay


var item_icon_pckd : PackedScene = preload("res://scenes/level/item_icon.tscn");


@onready
var item_container := $MarginContainer/HBoxContainer;
@onready
var label := $MarginContainer/HBoxContainer/Label;

var item_icons : Array[ItemIcon] = [];
var shake_tweens : Array[Tween] = [];
var shaking : bool = false;


func update() -> void:
	var idx = 0;
	
	for item in GameState.inventory.contents:
		var item_count = GameState.inventory.contents[item];
		get_ith_item_icon(idx).set_item(item, item_count);
		idx += 1;
	
	if item_icons.size() > idx:
		for i in range(idx, item_icons.size()):
			item_icons[i].hide();
	
	label.text = "weight: %d / %d" % [GameState.inventory.current_weight, GameState.player_stats.weight_capacity];


func get_ith_item_icon(i: int) -> ItemIcon:
	if i < item_icons.size():
		item_icons[i].show();
		return item_icons[i];
	else:
		var new_icon : ItemIcon = item_icon_pckd.instantiate();
		item_container.add_child(new_icon);
		item_icons.push_back(new_icon);
		return new_icon;


func start_shake() -> void:
	if shaking:
		return;
	
	shake_tweens.resize(item_icons.size())
	for idx in item_icons.size():
		if shake_tweens[idx] != null:
			shake_tweens[idx].kill();
		shake_tweens[idx] = create_tween();
		shake_tweens[idx].set_loops();
		shake_tweens[idx].tween_callback(item_icons[idx].shake)
		shake_tweens[idx].tween_interval(0.1);
	
	shaking = true;


func stop_shake() -> void:
	shaking = false;
	
	for idx in shake_tweens.size():
		if shake_tweens[idx] != null:
			shake_tweens[idx].kill();
	
	for icon in item_icons:
		icon.reset_shake();
	
	shake_tweens.clear();
