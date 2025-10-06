extends Control


func _ready() -> void:
	$HBoxContainer/prev.pressed.connect(back_to_menu)
	$HBoxContainer/next.pressed.connect(continue_playing)


func continue_playing() -> void:
	get_tree().change_scene_to_file("res://scenes/town/town.tscn");


func back_to_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn");
