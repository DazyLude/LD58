extends Control


func _on_mainmenu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn");


func _ready() -> void:
	$MainMenu.pressed.connect(_on_mainmenu_button_pressed);
