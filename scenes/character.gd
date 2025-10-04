extends Node2D
class_name Character


signal encounter


func _ready() -> void:
	$Area2D.area_entered.connect(encounter.emit);
	
