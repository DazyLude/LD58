extends Node
class_name LevelsDBClass


var forest := LevelData.new();


func _init() -> void:
	forest.item_weights = {
		"sword1": 50.0,
		"sword2": 5.0,
	}
	forest.enemy_weights = {
		"placeholder": 100.0,
	}
