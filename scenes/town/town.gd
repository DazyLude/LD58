extends Node2D


@onready
var shop : Shop = $UI/Panel/MarginContainer/Shop;

@onready
var goto_forest : Button = $UI/MissionSelect/Panel/VBoxContainer/HBoxContainer/Forest;


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action(&"Pause"):
		get_tree().paused = true
		$UI/PauseMenu.show();


func _ready() -> void:
	BgmPlayer.change_track(BgmPlayer.SoundID.Music3);
	show_shop();
	
	$UI/MissionSelect/Panel/VBoxContainer/ToShop.pressed.connect(show_shop);
	$UI/Panel/ToMissionSelect.pressed.connect(show_mission_select);
	
	goto_forest.pressed.connect(start_level.bind(LevelsDB.forest));
	
	shop.update_all();


func show_shop() -> void:
	$UI/Panel.show();
	$UI/MissionSelect.hide()


func show_mission_select() -> void:
	$UI/Panel.hide();
	$UI/MissionSelect.show()


func start_level(level_data: LevelData) -> void:
	GameState.level = level_data;
	get_tree().change_scene_to_file("res://scenes/level/level.tscn");
