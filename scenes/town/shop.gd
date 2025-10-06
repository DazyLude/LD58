extends VBoxContainer
class_name Shop


var shop_row_pckd = preload("res://scenes/town/shop_item_row.tscn");

@onready
var your_container := $YourItems/VBoxContainer;
var your_item_rows : Dictionary[String, ShopItemRow] = {};

@onready
var shopkeep_container := $ShopkeeperItems/VBoxContainer;
var shopkeep_item_rows : Dictionary[String, ShopItemRow] = {};
var shopkeep_inventory := InventoryManager.new();


var sfxplayer : PolyphonicSfxPlayer = null;


func _ready() -> void:
	sfxplayer = PolyphonicSfxPlayer.new();
	add_child(sfxplayer);
	
	shopkeep_inventory.add_item_by_name("shield", 1);
	shopkeep_inventory.add_item_by_name("potion_red", 1);
	shopkeep_inventory.add_item_by_name("bomb", 1);
	
	match GameState.progress:
		0:
			shopkeep_inventory.add_item_by_name("sword1", 1);
			shopkeep_inventory.add_item_by_name("helmet1", 1);
		1:
			shopkeep_inventory.add_item_by_name("sword2", 1);
			shopkeep_inventory.add_item_by_name("helmet2", 1);
			shopkeep_inventory.add_item_by_name(["potion_grey", "potion_green"].pick_random(), 1);
		2:
			shopkeep_inventory.add_item_by_name("helmet3", 1);
			shopkeep_inventory.add_item_by_name("sword3", 1);
			shopkeep_inventory.add_item_by_name("bomb", 1);
			shopkeep_inventory.add_item_by_name("potion_grey", 1);
			shopkeep_inventory.add_item_by_name("potion_green", 1);
			shopkeep_inventory.add_item_by_name("potion_red", 1);


func update_all() -> void:
	for item in GameState.inventory.contents:
		var item_row := get_your_item_row(item);
		item_row.set_item(
			item,
			GameState.inventory.get_item_official_name(item),
			GameState.inventory.get_item_desc(item),
			GameState.inventory.get_item_count(item),
			GameState.inventory.get_item_cost(item),
		);
	
	for item in shopkeep_inventory.contents:
		var item_row := get_shopkeeps_item_row(item);
		item_row.set_item(
			item,
			shopkeep_inventory.get_item_official_name(item),
			shopkeep_inventory.get_item_desc(item),
			shopkeep_inventory.get_item_count(item),
			shopkeep_inventory.get_item_cost(item),
		);
	
	update_cash();


func update_item(item: String) -> void:
	var item_row := get_your_item_row(item);
	item_row.set_item(
		item,
		GameState.inventory.get_item_official_name(item),
		GameState.inventory.get_item_desc(item),
		GameState.inventory.get_item_count(item),
		GameState.inventory.get_item_cost(item),
	);
	
	var his_item_row := get_shopkeeps_item_row(item);
	his_item_row.set_item(
		item,
		shopkeep_inventory.get_item_official_name(item),
		shopkeep_inventory.get_item_desc(item),
		shopkeep_inventory.get_item_count(item),
		shopkeep_inventory.get_item_cost(item),
	);


func get_new_item_row(parent: Control) -> ShopItemRow:
	var row : ShopItemRow = shop_row_pckd.instantiate();
	parent.add_child(row);
	return row;


func get_your_item_row(item: String) -> ShopItemRow:
	var item_row : ShopItemRow = your_item_rows.get(item, null);
	if item_row == null:
		item_row = get_new_item_row(your_container);
		your_item_rows[item] = item_row;
		item_row.pressed.connect(sell.bind(item));
	return item_row;


func get_shopkeeps_item_row(item: String) -> ShopItemRow:
	var item_row : ShopItemRow = shopkeep_item_rows.get(item, null);
	if item_row == null:
		item_row = get_new_item_row(shopkeep_container);
		shopkeep_item_rows[item] = item_row;
		item_row.pressed.connect(buy.bind(item));
	return item_row;


func sell(item: String) -> void:
	shopkeep_inventory.add_item_by_name(item, 1);
	GameState.inventory.remove_item_by_name(item, 1);
	GameState.cash += GameState.inventory.get_item_cost(item);
	update_item(item);
	update_cash();
	sfxplayer.play_sound(preload("res://assets/sounds/sfx/payment.wav"))


func buy(item: String) -> void:
	if GameState.cash >= GameState.inventory.get_item_cost(item):
		shopkeep_inventory.remove_item_by_name(item, 1);
		GameState.inventory.add_item_by_name(item, 1);
		GameState.cash -= GameState.inventory.get_item_cost(item);
		update_item(item);
		update_cash();
		sfxplayer.play_sound(preload("res://assets/sounds/sfx/payment.wav"))


func update_cash() -> void:
	$HBoxContainer/Label.text = "%d" % GameState.cash;
