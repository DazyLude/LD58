extends RefCounted
class_name LevelData

static var rng = RandomNumberGenerator.new();

var item_weights : Dictionary[String, float] = {};
var item_distance := 600.0;
var item_start_margin := 1200.0;
var item_end_margin := 600.0;

var enemy_weights : Dictionary[String, float] = {};
var enemy_start_margin := 800.0;
var enemy_end_margin := 1200.0;
var enemy_distance := 1500.0;

var boss_distance := 6000.0;
var boss := "frogbert";

var required_progress : int = 0;
var on_completion_progress : int = 1;

var on_completion_reward : float = 20.0;

var parallax_horizon : Texture2D = preload("res://assets/graphics/locations/1back.png");
var parallax_horizon_width := 1896.0;
var parallax_back : Texture2D = preload("res://assets/graphics/locations/2grass.png");
var parallax_back_width := 1896.0;
var parallax_main : Texture2D = preload("res://assets/graphics/locations/3main.png");
var parallax_main_width := 1896.0;
var parallax_front : Texture2D = preload("res://assets/graphics/locations/4front.png");
var parallax_front_width := 1896.0;


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
