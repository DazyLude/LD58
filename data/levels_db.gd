extends Node
class_name LevelsDBClass


var forest := LevelData.new();
var ruins := LevelData.new();


func _init() -> void:
	forest.item_weights = {
		"bone": 50.0,
		"sword1": 20.0,
		"sword2": 1.0,
		"helmet1": 20.0,
		"helmet2": 1.0,
		"crystal_ball": 3.0,
		"holy_book": 3.0,
		"bomb": 3.0,
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
		"bone": 10.0,
		"sword2": 20.0,
		"sword3": 2.0,
		"helmet2": 20.0,
		"helmet3": 2.0,
		"crystal_ball": 4.0,
		"holy_book": 4.0,
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
