extends Control


func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/town/town.tscn");


func _on_mainmenu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn");


func _ready() -> void:
	$Buttons/Continue.pressed.connect(_on_continue_button_pressed);
	$Buttons/MainMenu.pressed.connect(_on_mainmenu_button_pressed);
