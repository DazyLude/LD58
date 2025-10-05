extends RefCounted
class_name LevelData

static var rng = RandomNumberGenerator.new();

var item_weights : Dictionary[String, float] = {};
var item_distance := 300.0;
var item_start_margin := 600.0;
var item_end_margin := 600.0;


var enemy_weights : Dictionary[String, float] = {};

var enemy_start_margin := 800.0;
var enemy_end_margin := 1200.0;
var enemy_distance := 1000.0;

var boss_distance := 4000.0;
var boss := "frogbert";


func select_random_item() -> String:
	var wghts = PackedFloat32Array(item_weights.values());
	var items = item_weights.keys();
	var idx = rng.rand_weighted(wghts);
	return items[idx];


func select_random_enemy() -> String:
	var wghts = PackedFloat32Array(enemy_weights.values());
	var items = enemy_weights.keys();
	var idx = rng.rand_weighted(wghts);
	return items[idx];
