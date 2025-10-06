extends Control
class_name VictoryScreen


var continue_action := Callable();


@warning_ignore("shadowed_variable")
func setup(title: String, continue_action := Callable()) -> void:
	self.continue_action = continue_action;
	$Panel/Header.text = title;


func _on_continue_button_pressed() -> void:
	if not continue_action.is_null():
		continue_action.call();
	
	get_tree().change_scene_to_file("res://scenes/town/town.tscn");


func _on_mainmenu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn");


func _ready() -> void:
	$Panel/Buttons/Continue.pressed.connect(_on_continue_button_pressed);
	$Panel/Buttons/VBoxContainer/MainMenu.pressed.connect(_on_mainmenu_button_pressed);
