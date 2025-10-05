extends Node
class_name LevelsDBClass


var forest := LevelData.new();
var ruins := LevelData.new();


func _init() -> void:
	forest.item_weights = {
		"sword1": 50.0,
		"sword2": 5.0,
		"helmet1": 50.0,
		"helmet2": 5.0,
		"crystal_ball": 3.0,
		"holy_book": 3.0,
		"bomb": 3.0,
	}
	forest.enemy_weights = {
		"slime1": 100.0,
	}
	
	ruins.parallax_horizon = preload("res://assets/graphics/ruins/back.png")
	ruins.parallax_horizon_width = 2844.0;
	ruins.parallax_back = null;
	ruins.parallax_main = preload("res://assets/graphics/ruins/main.png")
	ruins.parallax_main_width = 2844.0;
	ruins.parallax_front = preload("res://assets/graphics/ruins/front.png")
	ruins.parallax_front_width = 2844.0;
