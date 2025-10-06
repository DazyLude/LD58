extends Node2D


@onready
var shop : Shop = $UI/Panel/MarginContainer/Shop;

@onready
var goto_forest : Button = $UI/MissionSelect/Panel/VBoxContainer/HBoxContainer/Forest;
@onready
var goto_ruins : Button = $UI/MissionSelect/Panel/VBoxContainer/HBoxContainer/Ruins;

var warning_tween : Tween;


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action(&"Pause"):
		get_tree().paused = true
		$UI/PauseMenu.show();


func _ready() -> void:
	BgmPlayer.change_track(BgmPlayer.SoundID.Music3);
	show_shop();
	
	$UI/MissionSelect/Panel/VBoxContainer/ToShop.pressed.connect(show_shop);
	$UI/Panel/ToMissionSelect.pressed.connect(show_mission_select);
	
	$UI/MissionSelect/Panel/VBoxContainer/Warning.self_modulate.a = 0.0;
	
	goto_forest.pressed.connect(start_level.bind(LevelsDB.forest));
	goto_ruins.pressed.connect(start_level.bind(LevelsDB.ruins));
	
	shop.update_all();


func show_warning() -> void:
	$UI/MissionSelect/Panel/VBoxContainer/Warning.self_modulate.a = 1.0;
	if warning_tween != null:
		warning_tween.kill();
	warning_tween = create_tween();
	
	warning_tween.tween_interval(3.0);
	warning_tween.tween_property($UI/MissionSelect/Panel/VBoxContainer/Warning, ^"self_modulate:a", 0.0, 5.0);


func show_shop() -> void:
	$UI/Panel.show();
	$UI/MissionSelect.hide()


func show_mission_select() -> void:
	$UI/Panel.hide();
	$UI/MissionSelect.show()


func start_level(level_data: LevelData) -> void:
	if level_data.required_progress > GameState.progress:
		show_warning();
	else:
		GameState.level = level_data;
		get_tree().change_scene_to_file("res://scenes/level/level.tscn");
