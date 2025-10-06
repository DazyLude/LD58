extends Node
class_name GameStateClass


var inventory := InventoryManager.new();
var player_stats := PlayerStats.new();

var cash : float = 0.0;
var level : LevelData = null;
var progress : int = 0;

var ending_seen : bool = false;


func full_reset() -> void:
	player_stats = PlayerStats.new();
	inventory = InventoryManager.new();
	cash = 0.0;
	level = LevelsDB.forest;
	progress = 0;
	ending_seen = false;
	
	inventory.add_item_by_name("sword3", 1);
	inventory.add_item_by_name("helmet3", 1);


func death_reset() -> void:
	inventory.contents.clear();
