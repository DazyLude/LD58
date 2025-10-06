extends Node
class_name LevelsDBClass


var forest := LevelData.new();
var ruins := LevelData.new();


func _init() -> void:
	forest.item_weights = {
		"sword1": 18.0,
		"sword2": 2.0,
		"helmet1": 18.0,
		"helmet2": 2.0,
		"bone": 45.0,
		"crystal_ball": 3.0,
		"holy_book": 3.0,
		"bomb": 2.0,
	}
	forest.enemy_weights = {
		"slime1": 60.0,
		"slime2": 20.0,
	}
	forest.boss = "slime3";
	forest.on_completion_progress = 1;
	
	
	ruins.parallax_horizon = preload("res://assets/graphics/ruins/back.png")
	ruins.parallax_horizon_width = 2844.0;
	ruins.parallax_back = null;
	ruins.parallax_main = preload("res://assets/graphics/ruins/main.png")
	ruins.parallax_main_width = 2844.0;
	ruins.parallax_front = preload("res://assets/graphics/ruins/front.png")
	ruins.parallax_front_width = 2844.0;
	ruins.item_weights = {
		"sword2": 18.0,
		"sword3": 2.0,
		"helmet2": 18.0,
		"helmet3": 2.0,
		"bone": 35.0,
		"crystal_ball": 8.0,
		"holy_book": 8.0,
		"bomb": 6.0,
	}
	ruins.item_distance = 800.0;
	
	ruins.enemy_weights = {
		"slime2": 60.0,
		"slime3": 20.0,
	}
	ruins.boss = "jabich";
	ruins.required_progress = 1;
	ruins.on_completion_progress = 2;
	ruins.on_completion_reward = 100;
	ruins.is_final_level = true;
