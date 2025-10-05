extends Node
class_name LevelsDBClass


var forest := LevelData.new();


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
		"placeholder": 100.0,
	}
